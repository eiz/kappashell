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

pragma Singleton
import QtQuick 2.0
import org.e7m.steamlink 1.0

Item {
    property alias debounceInterval: debounce.interval
    property alias maxRepeatInterval: repeat.maxInterval
    property alias minRepeatInterval: repeat.minInterval
    property alias repeatIntervalStep: repeat.intervalStep
    property variant initiator;

    Timer {
        id: debounce
        property bool isTriggered: false
        interval: 100

        function run(fn) {
            if (!isTriggered) {
                isTriggered = true;
                debounce.start();
                fn();
            }
        }

        onTriggered: isTriggered = false
    }

    Timer {
        id: repeat
        repeat: true
        property int maxInterval: 400
        property int minInterval: 150
        property double intervalStep: 0.75
        property var action
        property int direction

        function startAction(dir, a, resetInterval) {
            action = a;

            if (direction !== dir) {
                interval = maxInterval;
                direction = dir;
            }

            if (!running) {
                if (resetInterval !== false) {
                    interval = maxInterval;
                }

                start();
            }
        }

        function stopAction() {
            stop();
            direction = ControllerEventDirection.Center
        }

        onTriggered: {
            if (action) {
                action();
                interval = Math.max(minInterval, interval * intervalStep);
            }
        }
    }

    function continueAction(dir, newInitiator, fn) {
        initiator = newInitiator;
        repeat.startAction(dir, fn, false);
    }

    function action(dir, newInitiator, fn) {
        initiator = newInitiator;
        repeat.startAction(dir, fn);
        debounce.run(function() {
            fn();
        });
    }

    function stop(oldInitiator) {
        if (initiator !== oldInitiator) {
            return;
        }

        repeat.stopAction();
    }
}
