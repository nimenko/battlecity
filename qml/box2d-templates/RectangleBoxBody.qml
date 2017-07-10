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

Rectangle {
    id: rectangle

    property alias body: boxBody
    property alias fixture: box

    // Body properties
    property alias world: boxBody.world
    property alias linearDamping: boxBody.linearDamping
    property alias angularDamping: boxBody.angularDamping
    property alias bodyType: boxBody.bodyType
    property alias bullet: boxBody.bullet
    property alias sleepingAllowed: boxBody.sleepingAllowed
    property alias fixedRotation: boxBody.fixedRotation
    property alias active: boxBody.active
    property alias awake: boxBody.awake
    property alias linearVelocity: boxBody.linearVelocity
    property alias angularVelocity: boxBody.angularVelocity
    property alias fixtures: boxBody.fixtures
    property alias gravityScale: boxBody.gravityScale

    // Box properties
    property alias density: box.density
    property alias friction: box.friction
    property alias restitution: box.restitution
    property alias sensor: box.sensor
    property alias categories: box.categories
    property alias collidesWith: box.collidesWith
    property alias groupIndex: box.groupIndex

    Body {
        id: boxBody

        target: rectangle

        Box {
            id: box

            width: rectangle.width
            height: rectangle.height
        }
    }
}
