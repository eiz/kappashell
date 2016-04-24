// KappaShell
// Copyright (C) 2016 Mackenzie Straight
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with KappaShell.  If not, see <http://www.gnu.org/licenses/>.

import QtQuick 2.0
import org.e7m.steamlink 1.0

ListView {
    spacing: 5
    keyNavigationWraps: true

    ControllerRepeat { id: repeat }

    onFocusChanged: {
        if (!focus) {
            repeat.stop();
        }
    }

    Controller.simulatedDpad: ControllerEventType.LeftThumbstick

    Controller.onDpad: repeat.stop()

    Controller.onDpadLeftPressed: {
        if (orientation == ListView.Vertical) {
            event.accepted = false;
            return;
        }

        repeat.action(function() { decrementCurrentIndex(); });
    }

    Controller.onDpadRightPressed: {
        if (orientation == ListView.Vertical) {
            event.accepted = false;
            return;
        }

        repeat.action(function() { incrementCurrentIndex(); });
    }

    Controller.onDpadDownPressed: {
        if (orientation == ListView.Horizontal) {
            event.accepted = false;
            return;
        }

        repeat.action(function() { incrementCurrentIndex(); });
    }

    Controller.onDpadUpPressed: {
        if (orientation == ListView.Horizontal) {
            event.accepted = false;
            return;
        }

        repeat.action(function() { decrementCurrentIndex(); });
    }
}
