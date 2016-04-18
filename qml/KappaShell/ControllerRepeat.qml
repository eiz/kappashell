import QtQuick 2.0

Item {
    property alias debounceInterval: debounce.interval
    property alias maxRepeatInterval: repeat.maxInterval
    property alias minRepeatInterval: repeat.minInterval
    property alias repeatIntervalStep: repeat.intervalStep

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

            if (!running) {
                interval = maxInterval
                start();
            }
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

    function action(fn) {
        debounce.run(function() {
            repeat.startAction(fn);
            fn();
        });
    }

    function stop() {
        repeat.stopAction();
    }
}
