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

import Box2D 2.0

Body {
    id: body

    property alias fixture: box

    property alias density: box.density
    property alias friction: box.friction
    property alias restitution: box.restitution
    property alias sensor: box.sensor
    property alias categories: box.categories
    property alias collidesWith: box.collidesWith
    property alias groupIndex: box.groupIndex

    property alias x: box.x
    property alias y: box.y
    property alias width: box.width
    property alias height: box.height

    signal beginContact(Fixture other)
    signal endContact(Fixture other)

    Box {
        id: box

        onBeginContact: body.beginContact(other)
        onEndContact: body.endContact(other)
    }
}
