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

import "qrc:/qml/box2d-templates"

Item {
    property Item area: undefined
    property World physicsWorld: undefined
    property int wallsThickness: 32

    // Top boundary.
    BoxBody {
        world: physicsWorld
        x: area.x
        y: area.y - wallsThickness
        width: area.width
        height: wallsThickness
        bodyType: Body.Static
        categories: Box.Category4  // Walls.
        sleepingAllowed: true
        fixedRotation: true

        density: 1
        friction: 0
        restitution: 0
    }

    // Bottom boundary.
    BoxBody {
        world: physicsWorld
        x: area.x
        y: area.height
        width: area.width
        height: wallsThickness
        bodyType: Body.Static
        categories: Box.Category4  // Walls.
        sleepingAllowed: true
        fixedRotation: true

        density: 1
        friction: 0
        restitution: 0
    }

    // Left boundary.
    BoxBody {
        world: physicsWorld
        x: area.x - wallsThickness
        y: area.y
        width: wallsThickness
        height: area.height
        bodyType: Body.Static
        categories: Box.Category4  // Walls.
        sleepingAllowed: true
        fixedRotation: true

        density: 1
        friction: 0
        restitution: 0
    }

    // Right boundary.
    BoxBody {
        world: physicsWorld
        x: area.width
        y: area.y
        width: wallsThickness
        height: area.height
        bodyType: Body.Static
        categories: Box.Category4  // Walls.
        sleepingAllowed: true
        fixedRotation: true

        density: 1
        friction: 0
        restitution: 0
    }
}
