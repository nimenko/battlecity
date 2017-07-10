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

    property alias fixture: polygon

    property alias density: polygon.density
    property alias friction: polygon.friction
    property alias restitution: polygon.restitution
    property alias sensor: polygon.sensor
    property alias categories: polygon.categories
    property alias collidesWith: polygon.collidesWith
    property alias groupIndex: polygon.groupIndex

    property alias vertices: polygon.vertices

    signal beginContact(Fixture other)
    signal endContact(Fixture other)

    Polygon {
        id: polygon

        onBeginContact: body.beginContact(other)
        onEndContact: body.endContact(other)
    }
}
