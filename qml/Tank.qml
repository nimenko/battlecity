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
import QtMultimedia 5.5
import Box2D 2.0

import "qrc:/qml/box2d-templates"

ImageBoxBody {
    id: tank
    world: physicsWorld
    rotation: 0
    fixedRotation: true
    fillMode: Image.Stretch
    sleepingAllowed: false
    bullet: true
    bodyType: Body.Dynamic
    z: 1

    density: 1
    friction: 0
    restitution: 0.2

    property int livesCounter: 0

    property int spawnPointX: 0
    property int spawnPointY: 0

    property int tankSpeed: 8
    property int bulletSpeed: 50

    property int cannonDelayTime: 1000
    property bool isCannonReady: true

    property int tankBulletproofTime: 2000
    property bool isTankBulletproof: false

    signal tankIsSpawned()

    signal tankIsHit()

    onTankIsSpawned: {
        isTankBulletproof = true;

        bulletproofTimer.start();
        bulletproofAnimation.start();
    }

    Timer {
        id: cannonDelayer
        interval: cannonDelayTime
        repeat: false

        onTriggered: {
            isCannonReady = true;
        }
    }

    Timer {
        id: bulletproofTimer
        interval: tankBulletproofTime
        repeat: false

        onTriggered: {
            isTankBulletproof = false;

            bulletproofAnimation.stop();
        }
    }

    SequentialAnimation {
        id: bulletproofAnimation
        running: false

        NumberAnimation {
            target: tank
            property: "opacity"
            to: 0
            duration: 500
        }

        NumberAnimation {
            target: tank
            property: "opacity"
            to: 1
            duration: 500
        }

        NumberAnimation {
            target: tank
            property: "opacity"
            to: 0
            duration: 500
        }

        NumberAnimation {
            target: tank
            property: "opacity"
            to: 1
            duration: 500
        }
    }

    Component {
        id: bulletComponent

        Bullet {
            onBeginContact: {
                var target = other.getBody().target;

                if (target.body !== tank.body) {
                    switch (target.categories) {
                      case Box.Category1 :  // Player1.
                      case Box.Category2 :  // Player2.
                      case Box.Category3 :  // Enemies.
                        destroy();
                        target.tankIsHit();
                        break;

                      case Box.Category4 :  // Walls.
                        destroy();
                        break;

                      case Box.Category5 :  // Bullets.
                        destroy();
                        break;

                      default :
                        destroy();
                        break;
                    }
                }
            }
        }
    }

    SoundEffect {
        id: shotSound;
        source: "qrc:/sounds/cannon.wav"
        volume: 0.1
        muted: false
    }

    function moveForward() {
        body.linearVelocity.y = -tankSpeed;
        body.linearVelocity.x = 0;
        rotation = 0;
    }

    function moveBackward() {
        body.linearVelocity.y = tankSpeed;
        body.linearVelocity.x = 0;
        rotation = 180;
    }

    function moveLeft() {
        body.linearVelocity.x = -tankSpeed;
        body.linearVelocity.y = 0;
        rotation = 270;
    }

    function moveRight() {
        body.linearVelocity.x = tankSpeed;
        body.linearVelocity.y = 0;
        rotation = 90;
    }

    function fire() {
        if (isCannonReady) {
            var bulletObject = bulletComponent.createObject(battlefield);
            var bulletCorrectionOnX = 3;
            var bulletCorrectionOnY = 4;

            switch(rotation) {
              case 0 :
                bulletObject.rotation = 0;
                bulletObject.x = x + (width / 2) - bulletCorrectionOnX;
                bulletObject.y = y + (height / 2);
                bulletObject.body.linearVelocity.x = 0;
                bulletObject.body.linearVelocity.y = -bulletSpeed;
                break;

              case 90 :
                bulletObject.rotation = 90;
                bulletObject.x = x + (width / 2);
                bulletObject.y = y + (height / 2) - bulletCorrectionOnY;
                bulletObject.body.linearVelocity.x = bulletSpeed;
                bulletObject.body.linearVelocity.y = 0;
                break;

              case 180 :
                bulletObject.rotation = 180;
                bulletObject.x = x + (width / 2) - bulletCorrectionOnX;
                bulletObject.y = y + (height / 2);
                bulletObject.body.linearVelocity.x = 0;
                bulletObject.body.linearVelocity.y = bulletSpeed;
                break;

              case 270 :
                bulletObject.rotation = 270;
                bulletObject.x = x + (width / 2);
                bulletObject.y = y + (height / 2) - bulletCorrectionOnY;
                bulletObject.body.linearVelocity.x = -bulletSpeed;
                bulletObject.body.linearVelocity.y = 0;
                break;

              default :
                break;
            }

            shotSound.play();
            isCannonReady = false;
            cannonDelayer.start();
        }
    }

    function stopMoving() {
        body.linearVelocity.x = 0;
        body.linearVelocity.y = 0;
    }
}
