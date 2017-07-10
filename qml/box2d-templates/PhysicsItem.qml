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

Item {
    id: item

    property alias body: itemBody

    // Body properties
    property alias world: itemBody.world
    property alias linearDamping: itemBody.linearDamping
    property alias angularDamping: itemBody.angularDamping
    property alias bodyType: itemBody.bodyType
    property alias bullet: itemBody.bullet
    property alias sleepingAllowed: itemBody.sleepingAllowed
    property alias fixedRotation: itemBody.fixedRotation
    property alias active: itemBody.active
    property alias awake: itemBody.awake
    property alias linearVelocity: itemBody.linearVelocity
    property alias angularVelocity: itemBody.angularVelocity
    property alias fixtures: itemBody.fixtures
    property alias gravityScale: itemBody.gravityScale

    Body {
        id: itemBody

        target: item
        world: physicsWorld
    }
}
