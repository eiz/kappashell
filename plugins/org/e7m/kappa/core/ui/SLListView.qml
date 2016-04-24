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
    signal navigateLeft()
    signal navigateRight()
    signal navigateDown()
    signal navigateUp()

    spacing: 5

    onActiveFocusChanged: {
        if (!activeFocus) {
            ControllerRepeat.stop();
        }
    }

    Controller.simulatedDpad: ControllerEventType.LeftThumbstick
    Controller.onDpadCenterPressed: ControllerRepeat.stop();

    Controller.onDpadLeftPressed: {
        if (orientation == ListView.Vertical) {
            ControllerRepeat.action(function() {
                navigateLeft();
            });

            return;
        }

        ControllerRepeat.action(function() {
            if (currentIndex == 0) {
                navigateLeft();
            } else {
                decrementCurrentIndex();
            }
        });
    }

    Controller.onDpadRightPressed: {
        if (orientation == ListView.Vertical) {
            ControllerRepeat.action(function() {
                navigateRight();
            });

            return;
        }

        ControllerRepeat.action(function() {
            if (currentIndex == count - 1) {
                navigateRight();
            } else {
                incrementCurrentIndex();
            }
        });
    }

    Controller.onDpadDownPressed: {
        if (orientation == ListView.Horizontal) {
            ControllerRepeat.action(function() {
                navigateDown();
            });

            return;
        }

        ControllerRepeat.action(function() {
            if (currentIndex == count - 1) {
                navigateDown();
            } else {
                incrementCurrentIndex();
            }
        });
    }

    Controller.onDpadUpPressed: {
        if (orientation == ListView.Horizontal) {
            ControllerRepeat.action(function() {
                navigateUp();
            });

            return;
        }

        ControllerRepeat.action(function() {
            if (currentIndex == 0) {
                navigateUp();
            } else {
                decrementCurrentIndex();
            }
        });
    }
}
