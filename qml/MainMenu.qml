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

Item {
    id: mainMenu
    opacity: 0.0

    NumberAnimation on opacity { to: 1.0; duration: 2000 }

    property url logoImage: "qrc:/images/logo.png"
    property url cursorTankImage: "qrc:/images/player1_tank.png"

    property int menuChoice: 0

    property int onePlayerMode: 0
    property int twoPlayerMode: 1
    property int controlsMenu: 2

    signal onePlayerModeChosen()
    signal twoPlayerModeChosen()

    Keys.onPressed: {
        if (event.key === Qt.Key_Up || event.key === Qt.Key_W) {
            if (menuChoice !== onePlayerMode) {
                --menuChoice;
            }
            event.accepted = true;
        }

        if (event.key === Qt.Key_Down || event.key === Qt.Key_S) {
            if (menuChoice !== controlsMenu) {
                ++menuChoice;
            }
            event.accepted = true;
        }

        if (event.key === Qt.Key_Return) {
            if (menuChoice === onePlayerMode) {
                mainMenu.onePlayerModeChosen();
                event.accepted = true;
            }
            else if (menuChoice === twoPlayerMode) {
                mainMenu.twoPlayerModeChosen();
                event.accepted = true;
            }
            else if (menuChoice === controlsMenu) {
                controlsPopup.open();
                menuItems.visible = false;
                event.accepted = true;
            }
        }

        // Quit the game.
        if (event.key === Qt.Key_Escape) {
            window.close();
            event.accepted = true;
        }
    }

    Image {
        id: logo
        source: logoImage
        sourceSize.width: parent.width / 1.5
        sourceSize.height: parent.height / 1.5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
    }

    // Main menu items.
    GridLayout {
        id: menuItems
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: logo.bottom
        anchors.topMargin: parent.height / 4
        columns: 2
        rowSpacing: 30
        columnSpacing: 20

        Image {
            id: cursorImage1
            visible: menuChoice === onePlayerMode ? true : false
            source: cursorTankImage
            rotation: 90
            Layout.row: 0
            Layout.column: 0
        }

        Image {
            id: cursorImage2
            visible: menuChoice === twoPlayerMode ? true : false
            source: cursorTankImage
            rotation: 90
            Layout.row: 1
            Layout.column: 0
        }

        Image {
            id: cursorImage3
            visible: menuChoice === controlsMenu ? true : false
            source: cursorTankImage
            rotation: 90
            Layout.row: 2
            Layout.column: 0
        }

        Text {
            text: "1 PLAYER"
            font.family: "DejaVu Serif"
            font.bold: true
            font.pointSize: 40
            color: "white"
            Layout.row: 0
            Layout.column: 1
        }

        Text {
            text: "2 PLAYERS"
            font.family: "DejaVu Serif"
            font.bold: true
            font.pointSize: 40
            color: "white"
            Layout.row: 1
            Layout.column: 1
        }

        Text {
            text: "CONTROLS"
            font.family: "DejaVu Serif"
            font.bold: true
            font.pointSize: 40
            color: "white"
            Layout.row: 2
            Layout.column: 1
        }
    }

    // Game controls popup.
    Popup {
        id: controlsPopup
        x: (parent.width / 2) - (controlsPopup.height / 2.5)
        y: logo.height + 50
        background: Item { }
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape

        onClosed: {
            menuItems.visible = true
        }

        contentItem: ColumnLayout {
            id: controlsColumn
            spacing: 10

            Text {
                text: "1st PLAYER"
                font.family: "DejaVu Serif"
                font.bold: true
                font.underline: true
                font.pointSize: 18
                color: "white"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "MOVE UP - W"
                font.family: "DejaVu Serif"
                font.bold: true
                font.pointSize: 18
                color: "white"
            }

            Text {
                text: "MOVE DOWN - S"
                font.family: "DejaVu Serif"
                font.bold: true
                font.pointSize: 18
                color: "white"
            }

            Text {
                text: "MOVE LEFT - A"
                font.family: "DejaVu Serif"
                font.bold: true
                font.pointSize: 18
                color: "white"
            }

            Text {
                text: "MOVE RIGHT - D"
                font.family: "DejaVu Serif"
                font.bold: true
                font.pointSize: 18
                color: "white"
            }

            Text {
                text: "FIRE - SPACE"
                font.family: "DejaVu Serif"
                font.bold: true
                font.pointSize: 18
                color: "white"
            }

            Text {
                text: "2nd PLAYER"
                font.family: "DejaVu Serif"
                font.bold: true
                font.underline: true
                font.pointSize: 18
                color: "white"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "MOVE UP - UP ARROW"
                font.family: "DejaVu Serif"
                font.bold: true
                font.pointSize: 18
                color: "white"
            }

            Text {
                text: "MOVE DOWN - DOWN ARROW"
                font.family: "DejaVu Serif"
                font.bold: true
                font.pointSize: 18
                color: "white"
            }

            Text {
                text: "MOVE LEFT - LEFT ARROW"
                font.family: "DejaVu Serif"
                font.bold: true
                font.pointSize: 18
                color: "white"
            }

            Text {
                text: "MOVE RIGHT - RIGHT ARROW"
                font.family: "DejaVu Serif"
                font.bold: true
                font.pointSize: 18
                color: "white"
            }

            Text {
                text: "FIRE - CONTROL"
                font.family: "DejaVu Serif"
                font.bold: true
                font.pointSize: 18
                color: "white"
            }

            Text {
                text: "press ESC to exit"
                font.family: "DejaVu Serif"
                font.bold: true
                font.pointSize: 18
                color: "green"
                Layout.topMargin: 30
            }
        }
    }
}
