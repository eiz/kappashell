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
import org.e7m.kappa.core.ui 1.0

ListView {
    id: view

    signal navigateLeft()
    signal navigateRight()
    signal navigateDown()
    signal navigateUp()

    QtObject {
        id: d

        function left() {
            if (view.orientation == ListView.Vertical ||
                currentIndex == 0) {

                view.navigateLeft();
            } else {
                view.decrementCurrentIndex();
            }
        }

        function right() {
            if (view.orientation == ListView.Vertical ||
                currentIndex == count - 1) {

                navigateRight();
            } else {
                incrementCurrentIndex();
            }
        }

        function down() {
            if (view.orientation == ListView.Horizontal ||
                currentIndex == count - 1) {

                navigateDown();
            } else {
                incrementCurrentIndex();
            }
        }

        function up() {
            if (view.orientation == ListView.Horizontal ||
                currentIndex == 0) {

                navigateUp();
            } else {
                decrementCurrentIndex();
            }
        }
    }

    spacing: 5

    onActiveFocusChanged: {
        if (!activeFocus) {
            ControllerRepeat.stop(this);
        } else {
            var dir = Controller.lastDpadDirection;

            switch (dir) {
            case ControllerEventDirection.N:
                ControllerRepeat.continueAction(
                    dir, this, function() { d.up(); });
                break;
            case ControllerEventDirection.S:
                ControllerRepeat.continueAction(
                    dir, this, function() { d.down(); });
                break;
            case ControllerEventDirection.E:
                ControllerRepeat.continueAction(
                    dir, this, function() { d.right(); });
                break;
            case ControllerEventDirection.W:
                ControllerRepeat.continueAction(
                    dir, this, function() { d.left(); });
                break;
            }
        }
    }

    Controller.simulatedDpad: ControllerEventType.LeftThumbstick
    Controller.onDpadCenterPressed: ControllerRepeat.stop(this);

    Controller.onDpadLeftPressed: {
        ControllerRepeat.action(
            event.direction, this, function() { d.left(); });
    }

    Controller.onDpadRightPressed: {
        ControllerRepeat.action(
            event.direction, this, function() { d.right(); });
    }

    Controller.onDpadDownPressed: {
        ControllerRepeat.action(
            event.direction, this, function() { d.down(); });
    }

    Controller.onDpadUpPressed: {
        ControllerRepeat.action(
            event.direction, this, function() { d.up(); });
    }
}
