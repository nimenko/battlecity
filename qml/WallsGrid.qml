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
import QtQuick.Layouts 1.3

GridLayout {
    x: 0
    y: 0
    rows: 6
    columns: 5
    columnSpacing: cellSize * 2
    rowSpacing: 0

    Repeater {
        model: 15

        Wall {}
    }

    Repeater {
        model: 3

        Wall {
            Layout.row: 4 + index
            Layout.column: 2 - index
        }
    }

    Repeater {
        model: 2

        Wall {
            Layout.row: 5 + index
            Layout.column: 3 + index
        }
    }

    Repeater {
        model: 3

        Wall {
            Layout.row: 7 + index
            Layout.column: 2 - index
        }
    }

    Repeater {
        model: 2

        Wall {
            Layout.row: 8 + index
            Layout.column: 3 + index
        }
    }

    Repeater {
        model: 4

        Wall {
            Layout.row: 10 + index
            Layout.column: 2
        }
    }

    Repeater {
        model: 2

        Wall {
            Layout.row: 11
            Layout.column: index
        }
    }

    Repeater {
        model: 2

        Wall {
            Layout.row: 11
            Layout.column: 3 + index
        }
    }

    Repeater {
        model: 2

        Wall {
            Layout.row: 12
            Layout.column: index
        }
    }

    Repeater {
        model: 2

        Wall {
            Layout.row: 12
            Layout.column: 3 + index
        }
    }
}
