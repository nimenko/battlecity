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

    property alias fixture: chain

    property alias density: chain.density
    property alias friction: chain.friction
    property alias restitution: chain.restitution
    property alias sensor: chain.sensor
    property alias categories: chain.categories
    property alias collidesWith: chain.collidesWith
    property alias groupIndex: chain.groupIndex

    property alias vertices: chain.vertices
    property alias loop: chain.loop
    property alias prevVertex: chain.prevVertex
    property alias nextVertex: chain.nextVertex

    signal beginContact(Fixture other)
    signal endContact(Fixture other)

    Chain {
        id: chain

        onBeginContact: body.beginContact(other)
        onEndContact: body.endContact(other)
    }
}
