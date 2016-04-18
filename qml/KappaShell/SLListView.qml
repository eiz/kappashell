import QtQuick 2.0
import org.e7m.steamlink 1.0

ListView {
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

        function startAction(a) {
            action = a;
            interval = maxInterval
            start();
        }

        function stopAction() {
            stop();
        }

        onTriggered: {
            if (action) {
                action();
                interval = Math.max(minInterval, interval * intervalStep);
            }
        }
    }

    Controller.simulatedDpad: ControllerEventType.LeftThumbstick

    Controller.onDpadCenterPressed: repeat.stopAction()

    Controller.onDpadDownPressed: {
        debounce.run(function() {
            repeat.startAction(function() { incrementCurrentIndex(); });
            incrementCurrentIndex();
        });
    }

    Controller.onDpadUpPressed: {
        debounce.run(function() {
            repeat.startAction(function() { decrementCurrentIndex(); });
            decrementCurrentIndex();
        });
    }
}
