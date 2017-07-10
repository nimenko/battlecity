/*

Copyright (C) 2017 Maksym Nimenko.
Contact: nimenko.max@gmail.com

This file is part of BattleCity.

BattleCity is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

BattleCity is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with BattleCity; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

*/

import QtQuick 2.8
import Box2D 2.0

Tank {
    id: enemyTank
    source: "qrc:/images/enemy_tank.png"
    categories: Box.Category3

    property int playerSensorRaysLength: cellSize * 5  // Total length of player sensor rays.

    property bool isObstacleCollision: false

    property bool isPlayerInFront: false
    property bool isPlayerBehind: false
    property bool isPlayerOnTheLeft: false
    property bool isPlayerOnTheRight: false

    // Front obstacle sensor fixture.
    fixtures: Box {
        x: 0
        y: -1
        width: enemyTank.width
        height: 10

        sensor: true

        onBeginContact: {
            isObstacleCollision = true;
        }

        onEndContact: {
            isObstacleCollision = false;
        }
    }

    onTankIsHit: {
        isObstacleCollision = false;

        isPlayerInFront = false;
        isPlayerBehind = false;
        isPlayerOnTheLeft = false;
        isPlayerOnTheRight = false;
    }

    // Front player sensor ray.
    RayCast {
        id: frontPlayerSensorRay
        maxFraction: 1

        property int rayLength: playerSensorRaysLength

        property point fromPoint: Qt.point(enemyTank.x + (enemyTank.width / 2), enemyTank.y)
        property point toPoint: Qt.point(enemyTank.x + (enemyTank.width / 2), enemyTank.y - rayLength)

        onFixtureReported: {
            if (fixture.categories == Box.Category1 || fixture.categories == Box.Category2) {  // Player1 & Player2.
                isPlayerInFront = true;
            }
            else {
                isPlayerInFront = false;
            }
        }
    }

    // Back player sensor ray.
    RayCast {
        id: backPlayerSensorRay
        maxFraction: 1

        property int rayLength: playerSensorRaysLength

        property point fromPoint: Qt.point(enemyTank.x + (enemyTank.width / 2), enemyTank.y + enemyTank.height)
        property point toPoint: Qt.point(enemyTank.x + (enemyTank.width / 2), enemyTank.y + enemyTank.height + rayLength)

        onFixtureReported: {
            if (fixture.categories == Box.Category1 || fixture.categories == Box.Category2) {  // Player1 & Player2.
                isPlayerBehind = true;
            }
            else {
                isPlayerBehind = false;
            }
        }
    }

    // Left player sensor ray.
    RayCast {
        id: leftPlayerSensorRay
        maxFraction: 1

        property int rayLength: playerSensorRaysLength

        property point fromPoint: Qt.point(enemyTank.x, enemyTank.y + (enemyTank.height / 2))
        property point toPoint: Qt.point(enemyTank.x - rayLength, enemyTank.y + (enemyTank.height / 2))

        onFixtureReported: {
            if (fixture.categories == Box.Category1 || fixture.categories == Box.Category2) {  // Player1 & Player2.
                isPlayerOnTheLeft = true;
            }
            else {
                isPlayerOnTheLeft = false;
            }
        }
    }

    // Right player sensor ray.
    RayCast {
        id: rightPlayerSensorRay
        maxFraction: 1

        property int rayLength: playerSensorRaysLength

        property point fromPoint: Qt.point(enemyTank.x + enemyTank.width, enemyTank.y + (enemyTank.height / 2))
        property point toPoint: Qt.point(enemyTank.x + enemyTank.width + rayLength, enemyTank.y + (enemyTank.height / 2))

        onFixtureReported: {
            if (fixture.categories == Box.Category1 || fixture.categories == Box.Category2) {  // Player1 & Player2.
                isPlayerOnTheRight = true;
            }
            else {
                isPlayerOnTheRight = false;
            }
        }
    }

    // Raycasting for players.
    function scanForPlayers() {
        // Front sensor ray.
        physicsWorld.rayCast(frontPlayerSensorRay,
                             frontPlayerSensorRay.fromPoint,
                             frontPlayerSensorRay.toPoint);

        // Back sensor ray.
        physicsWorld.rayCast(backPlayerSensorRay,
                             backPlayerSensorRay.fromPoint,
                             backPlayerSensorRay.toPoint);

        // Left sensor ray.
        physicsWorld.rayCast(leftPlayerSensorRay,
                             leftPlayerSensorRay.fromPoint,
                             leftPlayerSensorRay.toPoint);

        // Right sensor ray.
        physicsWorld.rayCast(rightPlayerSensorRay,
                             rightPlayerSensorRay.fromPoint,
                             rightPlayerSensorRay.toPoint);
    }

    function turnRight() {
        rotation += 90;

        if (rotation >= 360) {
            rotation = 0;
        }
    }

    function turnLeft() {
        rotation -= 90;

        if (rotation <= -90) {
            rotation = 270;
        }
    }

    // Random choice of turning side.
    function randomTurn() {
        var random = Math.random();

        if (random > 0.5) {
            turnLeft();
        }
        else {
            turnRight();
        }
    }

    function moveAboutRotation() {
        switch (rotation) {
          case 0 :
            moveForward();
            break;

          case 90 :
            moveRight();
            break;

          case 180 :
            moveBackward();
            break;

          case 270 :
            moveLeft();
            break;

          default :
            break;
        }
    }

    function moveMode() {
        if (isObstacleCollision) {
            randomTurn();
        }
        else {
            moveAboutRotation();
        }
    }

    function attackMode() {
        var random = Math.random();
        var undetectionProbability = 0.95;  // Probability of being undetected.
        var isPlayerDetected = false;

        scanForPlayers();

        // Random player detection.
        if (random > undetectionProbability) {
            isPlayerDetected = true;
        }
        else {
            isPlayerDetected = false;
        }

        if (isPlayerInFront && isPlayerDetected) {
            rotation = 0;
            fire();
        }
        else if (isPlayerBehind && isPlayerDetected) {
            rotation = 180;
            fire();
        }
        else if (isPlayerOnTheLeft && isPlayerDetected) {
            rotation = 270;
            fire();
        }
        else if (isPlayerOnTheRight && isPlayerDetected) {
            rotation = 90;
            fire();
        }
    }
}
