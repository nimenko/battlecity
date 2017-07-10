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
import QtQuick.Controls 2.1
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import Box2D 2.0

Item {
    id: gameScreen
    visible: true

    property int cellSize: 64  // Size of one battlefield cell.

    property bool isTwoPlayerMode: false  // Two player mode status.

    property bool isGameWon: true  // Game result.

    signal gameIsWon()
    signal gameIsLost()

    signal closeGameScreen()

    onGameIsWon: {
        isGameWon = true;
        gameOverPopup.open();
    }

    onGameIsLost: {
        isGameWon = false;
        gameOverPopup.open();
    }

    property bool isPlayer1UpKeyPressed: false
    property bool isPlayer1DownKeyPressed: false
    property bool isPlayer1LeftKeyPressed: false
    property bool isPlayer1RightKeyPressed: false
    property bool isPlayer1FireKeyPressed: false

    property bool isPlayer2UpKeyPressed: false
    property bool isPlayer2DownKeyPressed: false
    property bool isPlayer2LeftKeyPressed: false
    property bool isPlayer2RightKeyPressed: false
    property bool isPlayer2FireKeyPressed: false

    // KEYS ON PRESSED handler.
    Keys.onPressed: {
        // Player1 KEYS ON PRESSED handler.
        switch (event.key) {
          case Qt.Key_W :
            isPlayer1UpKeyPressed = true;
            event.accepted = true;
            break;

          case Qt.Key_S :
            isPlayer1DownKeyPressed = true;
            event.accepted = true;
            break;

          case Qt.Key_A :
            isPlayer1LeftKeyPressed = true;
            event.accepted = true;
            break;

          case Qt.Key_D :
            isPlayer1RightKeyPressed = true;
            event.accepted = true;
            break;

          case Qt.Key_Space :
            isPlayer1FireKeyPressed = true;
            event.accepted = true;
            break;

          default :
            break;
        }

        // Player2 KEYS ON PRESSED handler.
        switch (event.key) {
          case Qt.Key_Up :
            isPlayer2UpKeyPressed = true;
            event.accepted = true;
            break;

          case Qt.Key_Down :
            isPlayer2DownKeyPressed = true;
            event.accepted = true;
            break;

          case Qt.Key_Left :
            isPlayer2LeftKeyPressed = true;
            event.accepted = true;
            break;

          case Qt.Key_Right :
            isPlayer2RightKeyPressed = true;
            event.accepted = true;
            break;

          case Qt.Key_Control :
            isPlayer2FireKeyPressed = true;
            event.accepted = true;
            break;

          default :
            break;
        }

        // Quit to the main menu.
        if (event.key === Qt.Key_Escape) {
            closeGameScreen();
            event.accepted = true;
        }
    }

    // KEYS ON RELEASED handler.
    Keys.onReleased: {
        // Player1 KEYS ON RELEASED handler.
        switch (event.key) {
          case Qt.Key_W :
            isPlayer1UpKeyPressed = false;
            event.accepted = true;
            break;

          case Qt.Key_S :
            isPlayer1DownKeyPressed = false;
            event.accepted = true;
            break;

          case Qt.Key_A :
            isPlayer1LeftKeyPressed = false;
            event.accepted = true;
            break;

          case Qt.Key_D :
            isPlayer1RightKeyPressed = false;
            event.accepted = true;
            break;

          case Qt.Key_Space :
            isPlayer1FireKeyPressed = false;
            event.accepted = true;
            break;

          default :
            break;
        }

        // Player2 KEYS ON RELEASED handler.
        switch (event.key) {
          case Qt.Key_Up :
            isPlayer2UpKeyPressed = false;
            event.accepted = true;
            break;

          case Qt.Key_Down :
            isPlayer2DownKeyPressed = false;
            event.accepted = true;
            break;

          case Qt.Key_Left :
            isPlayer2LeftKeyPressed = false;
            event.accepted = true;
            break;

          case Qt.Key_Right :
            isPlayer2RightKeyPressed = false;
            event.accepted = true;
            break;

          case Qt.Key_Control :
            isPlayer2FireKeyPressed = false;
            event.accepted = true;
            break;

          default :
            break;
        }
    }

    // Game loop timer.
    Timer {
        id: gameLoop
        interval: 1000 / 50
        running: true
        repeat: true

        onTriggered: {
            // Enemy1 action handler.
            if (battlefield.isEnemy1TankAlive) {
                battlefield.enemy1Tank.moveMode();
                battlefield.enemy1Tank.attackMode();
            }

            // Enemy2 action handler.
            if (battlefield.isEnemy2TankAlive) {
                battlefield.enemy2Tank.moveMode();
                battlefield.enemy2Tank.attackMode();
            }

            // Player1 action handler.
            if (battlefield.isPlayer1TankAlive) {
                if (parent.isPlayer1UpKeyPressed) {
                    battlefield.player1Tank.moveForward();
                }
                else if (parent.isPlayer1DownKeyPressed) {
                    battlefield.player1Tank.moveBackward();
                }
                else if (parent.isPlayer1LeftKeyPressed) {
                    battlefield.player1Tank.moveLeft();
                }
                else if (parent.isPlayer1RightKeyPressed) {
                    battlefield.player1Tank.moveRight();
                }
                else {
                    battlefield.player1Tank.stopMoving();
                }

                if (parent.isPlayer1FireKeyPressed) {
                    battlefield.player1Tank.fire();
                }
            }

            // Player2 action handler.
            if (battlefield.isPlayer2TankAlive) {
                if (parent.isPlayer2UpKeyPressed) {
                    battlefield.player2Tank.moveForward();
                }
                else if (parent.isPlayer2DownKeyPressed) {
                    battlefield.player2Tank.moveBackward();
                }
                else if (parent.isPlayer2LeftKeyPressed) {
                    battlefield.player2Tank.moveLeft();
                }
                else if (parent.isPlayer2RightKeyPressed) {
                    battlefield.player2Tank.moveRight();
                }
                else {
                    battlefield.player2Tank.stopMoving();
                }

                if (parent.isPlayer2FireKeyPressed) {
                    battlefield.player2Tank.fire();
                }
            }

            // Game over handler.
            if (battlefield.isEnemy1OutOfTheGame && battlefield.isEnemy2OutOfTheGame) {
                gameLoop.stop();
                gameIsWon();
            }
            else if (battlefield.isPlayer1OutOfTheGame && battlefield.isPlayer2OutOfTheGame) {
                gameLoop.stop();
                gameIsLost();
            }
        }
    }

    // Background.
    Rectangle {
        width: parent.width
        height: parent.height
        color: "black"
    }

    // "GAME OVER" popup with result.
    Popup {
        id: gameOverPopup
        x: (parent.width / 2) - (contentWidth / 2)
        y: (parent.height / 2) - contentHeight
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape

        background: Rectangle {
            color: "black"
            opacity: 0.8
            radius: 20
        }

        onClosed: {
            closeGameScreen();
        }

        contentItem: ColumnLayout {
            spacing: 10

            Text {
                text: "GAME OVER"
                font.family: "DejaVu Serif"
                font.bold: true
                font.pointSize: 40
                color: "white"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: gameScreen.isGameWon ? "You win! :)" : "You lose! :("
                font.family: "DejaVu Serif"
                font.bold: true
                font.pointSize: 40
                color: gameScreen.isGameWon ? "green" : "red"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "press ESC to exit"
                font.family: "DejaVu Serif"
                font.bold: true
                font.pointSize: 18
                color: "orange"
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }

    // Battlefield area.
    Item {
        id: battlefield
        x: 0
        y: 0
        width: 832
        height: 832

        // Lives counters.
        property int player1Lives: 3
        property int player2Lives: 3
        property int enemyLives: 20

        // Player tank status.
        property bool isPlayer1TankAlive: true
        property bool isPlayer2TankAlive: false

        // Enemy tanks status.
        property bool isEnemy1TankAlive: true
        property bool isEnemy2TankAlive: true

        // Player is out of the game.
        property bool isPlayer1OutOfTheGame: true
        property bool isPlayer2OutOfTheGame: true

        // Enemy is out of the game.
        property bool isEnemy1OutOfTheGame: true
        property bool isEnemy2OutOfTheGame: true

        // Player1 tank spawn points.
        property int player1SpawnPointX: 0
        property int player1SpawnPointY: height - cellSize

        // Player2 tank spawn points.
        property int player2SpawnPointX: width - cellSize
        property int player2SpawnPointY: height - cellSize

        // Enemy1 tank spawn points.
        property int enemy1SpawnPointX: cellSize * 3
        property int enemy1SpawnPointY: cellSize * 3

        // Enemy2 tank spawn points.
        property int enemy2SpawnPointX: cellSize * 9
        property int enemy2SpawnPointY: cellSize * 3

        // Aliases for tanks.
        property alias player1Tank: player1TankLoader.item
        property alias player2Tank: player2TankLoader.item
        property alias enemy1Tank: enemy1TankLoader.item
        property alias enemy2Tank: enemy2TankLoader.item

        // Background.
        Rectangle {
            anchors.fill: parent
            color: "black"
        }

        // On-screen battle info.
        HUD {
            id: hud
            player1Lives: parent.player1Lives
            player2Lives: parent.player2Lives
            enemyLives: parent.enemyLives
        }

        // Battlefield walls.
        WallsGrid { }

        // Box2D physics world.
        World {
            id: physicsWorld

            gravity.x: 0
            gravity.y: 0
        }

        // Box2D physics items highlighting.
        DebugDraw {
            world: physicsWorld
            opacity: 0.7
            visible: false
        }

        // Battlefield boundaries.
        ScreenBoundaries {
            area: battlefield
            physicsWorld: physicsWorld
        }

        Component {
            id: player1TankComponent

            Player1Tank {
                x: battlefield.player1SpawnPointX
                y: battlefield.player1SpawnPointY

                spawnPointX: battlefield.player1SpawnPointX
                spawnPointY: battlefield.player1SpawnPointY

                livesCounter: battlefield.player1Lives

                onLivesCounterChanged: {
                    battlefield.player1Lives = livesCounter;
                }

                onTankIsHit: {
                    if (livesCounter > 1 && battlefield.isPlayer1TankAlive && !isTankBulletproof) {
                        player1TankLoader.despawn();
                        --livesCounter;
                        player1TankLoader.spawn();
                    }
                    else if (battlefield.isPlayer1TankAlive && !isTankBulletproof) {
                        player1TankLoader.despawn();
                        livesCounter = 0;
                        battlefield.isPlayer1OutOfTheGame = true;
                    }
                }
            }
        }

        Component {
            id: player2TankComponent

            Player2Tank {
                x: battlefield.player2SpawnPointX
                y: battlefield.player2SpawnPointY

                spawnPointX: battlefield.player2SpawnPointX
                spawnPointY: battlefield.player2SpawnPointY

                livesCounter: battlefield.player2Lives

                onLivesCounterChanged: {
                    battlefield.player2Lives = livesCounter;
                }

                onTankIsHit: {
                    if (livesCounter > 1 && battlefield.isPlayer2TankAlive && !isTankBulletproof) {
                        player2TankLoader.despawn();
                        --livesCounter;
                        player2TankLoader.spawn();
                    }
                    else if (battlefield.isPlayer2TankAlive && !isTankBulletproof) {
                        player2TankLoader.despawn();
                        livesCounter = 0;
                        battlefield.isPlayer2OutOfTheGame = true;
                    }
                }
            }
        }

        Component {
            id: enemy1TankComponent

            EnemyTank {
                x: battlefield.enemy1SpawnPointX
                y: battlefield.enemy1SpawnPointY

                spawnPointX: battlefield.enemy1SpawnPointX
                spawnPointY: battlefield.enemy1SpawnPointY

                onTankIsHit: {
                    if (battlefield.enemyLives > 1 && battlefield.isEnemy1TankAlive && !isTankBulletproof) {
                        enemy1TankLoader.despawn();
                        --battlefield.enemyLives;
                        enemy1TankLoader.spawn();
                    }
                    else if (battlefield.isEnemy1TankAlive && !isTankBulletproof) {
                        enemy1TankLoader.despawn();
                        battlefield.enemyLives = 0;
                        battlefield.isEnemy1OutOfTheGame = true;
                    }
                }
            }
        }

        Component {
            id: enemy2TankComponent

            EnemyTank {
                x: battlefield.enemy2SpawnPointX
                y: battlefield.enemy2SpawnPointY

                spawnPointX: battlefield.enemy2SpawnPointX
                spawnPointY: battlefield.enemy2SpawnPointY

                onTankIsHit: {
                    if (battlefield.enemyLives > 1 && battlefield.isEnemy2TankAlive && !isTankBulletproof) {
                        enemy2TankLoader.despawn();
                        --battlefield.enemyLives;
                        enemy2TankLoader.spawn();
                    }
                    else if (battlefield.isEnemy2TankAlive && !isTankBulletproof) {
                        enemy2TankLoader.despawn();
                        battlefield.enemyLives = 0;
                        battlefield.isEnemy2OutOfTheGame = true;
                    }
                }
            }
        }

        Loader {
            id: player1TankLoader
            sourceComponent: player1TankComponent

            property int spawnDelayTime: 1000

            onLoaded: {
                parent.isPlayer1OutOfTheGame = false;
                item.tankIsSpawned();
                parent.isPlayer1TankAlive = true;
            }

            Timer {
                id: player1TankSpawnTimer
                interval: parent.spawnDelayTime
                repeat: false

                onTriggered: {
                    parent.sourceComponent = player1TankComponent;
                }
            }

            function spawn() {
                player1TankSpawnTimer.start();
            }

            function despawn() {
                sourceComponent = undefined;
                parent.isPlayer1TankAlive = false;
            }
        }

        Loader {
            id: player2TankLoader
            sourceComponent: isTwoPlayerMode ? player2TankComponent : undefined

            property int spawnDelayTime: 1000

            onLoaded: {
                parent.isPlayer2OutOfTheGame = false;
                item.tankIsSpawned();
                parent.isPlayer2TankAlive = true;
                hud.showPlayer2Info = true;
            }

            Timer {
                id: player2TankSpawnTimer
                interval: parent.spawnDelayTime
                repeat: false

                onTriggered: {
                    parent.sourceComponent = player2TankComponent;
                }
            }

            function spawn() {
                player2TankSpawnTimer.start();
            }

            function despawn() {
                sourceComponent = undefined;
                parent.isPlayer2TankAlive = false;
            }
        }

        Loader {
            id: enemy1TankLoader
            sourceComponent: enemy1TankComponent

            property int spawnDelayTime: 1000

            onLoaded: {
                parent.isEnemy1OutOfTheGame = false;
                item.tankIsSpawned();
                parent.isEnemy1TankAlive = true;
            }

            Timer {
                id: enemy1TankSpawnTimer
                interval: parent.spawnDelayTime
                repeat: false

                onTriggered: {
                    parent.sourceComponent = enemy1TankComponent;
                }
            }

            function spawn() {
                enemy1TankSpawnTimer.start();
            }

            function despawn() {
                sourceComponent = undefined;
                parent.isEnemy1TankAlive = false;
            }
        }

        Loader {
            id: enemy2TankLoader
            sourceComponent: enemy2TankComponent

            property int spawnDelayTime: 1000

            onLoaded: {
                parent.isEnemy2OutOfTheGame = false;
                item.tankIsSpawned();
                parent.isEnemy2TankAlive = true;
            }

            Timer {
                id: enemy2TankSpawnTimer
                interval: parent.spawnDelayTime
                repeat: false

                onTriggered: {
                    parent.sourceComponent = enemy2TankComponent;
                }
            }

            function spawn() {
                enemy2TankSpawnTimer.start();
            }

            function despawn() {
                sourceComponent = undefined;
                parent.isEnemy2TankAlive = false;
            }
        }
    }
}
