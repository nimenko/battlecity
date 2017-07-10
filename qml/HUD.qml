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
import QtQuick.Layouts 1.3

Rectangle {
    x: parent.width
    y: 0
    width: cellSize
    height: parent.height
    color: "grey"

    property url player1TankImage: "qrc:/images/player1_tank.png"
    property url player2TankImage: "qrc:/images/player2_tank.png"
    property url enemyTankImage: "qrc:/images/enemy_tank.png"

    property int player1Lives: 3
    property int player2Lives: 3
    property int enemyLives: 20

    property bool showPlayer2Info: false

    // Enemy emblem.
    Image {
        id: enemyImage
        source: enemyTankImage
        rotation: 180
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
    }

    // Enemy lives counter.
    Label {
        text: enemyLives
        font.bold: true
        font.pointSize: 18
        font.family: "DejaVu Serif"
        color: "black"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: enemyImage.bottom
        anchors.topMargin: 10
    }

    // Players info.
    ColumnLayout {
        anchors.centerIn: parent
        spacing: -5

        Label {
            text: "1P"
            font.family: "DejaVu Serif"
            font.bold: true
            font.pointSize: 18
            color: "black"
            anchors.horizontalCenter: parent.horizontalCenter
        }


        // Player1 emblem.
        Image {
            source: player1TankImage
            rotation: 0
            scale: 0.7
        }

        // Player1 lives counter.
        Label {
            text: player1Lives
            font.family: "DejaVu Serif"
            font.bold: true
            font.pointSize: 18
            color: "black"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Label {
            text: "2P"
            font.family: "DejaVu Serif"
            font.bold: true
            font.pointSize: 18
            color: "black"
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.topMargin: 30
            visible: showPlayer2Info
        }

        // Player2 emblem.
        Image {
            source: player2TankImage
            rotation: 0
            scale: 0.7
            visible: showPlayer2Info
        }

        // Player2 lives counter.
        Label {
            text: player2Lives
            font.family: "DejaVu Serif"
            font.bold: true
            font.pointSize: 18
            color: "black"
            anchors.horizontalCenter: parent.horizontalCenter
            visible: showPlayer2Info
        }
    }

    // Level number.
    Label {
        text: "L1"
        font.family: "DejaVu Serif"
        font.bold: true
        font.pointSize: 18
        color: "black"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
    }
}
