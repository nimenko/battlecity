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

ApplicationWindow {
    id: window
    visible: true
    width: 896
    height: 832
    maximumWidth: width
    maximumHeight: height
    minimumWidth: width
    minimumHeight: height
    title: "BattleCity"

    background: Rectangle {
        width: parent.width
        height: parent.height

        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#000000";
            }
            GradientStop {
                position: 1.00;
                color: "#363636";
            }
        }
    }

    Component {
        id: mainMenu

        MainMenu {
            onOnePlayerModeChosen: {
                stackView.push(onePlayerModeGame);
            }

            onTwoPlayerModeChosen: {
                stackView.push(twoPlayerModeGame);
            }
        }
    }

    Component {
        id: onePlayerModeGame

        GameScreen {
            isTwoPlayerMode: false

            onCloseGameScreen: {
                stackView.pop();
            }
        }
    }

    Component {
        id: twoPlayerModeGame

        GameScreen {
            isTwoPlayerMode: true

            onCloseGameScreen: {
                stackView.pop();
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        focus: true

        initialItem: mainMenu

        onCurrentItemChanged: {
            if (currentItem !== undefined) {
                currentItem.focus = true;
            }
        }
    }
}
