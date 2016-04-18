import QtQuick 2.0
import org.e7m.steamlink 1.0

ListView {
    ControllerRepeat { id: repeat }

    onFocusChanged: {
        if (!focus) {
            repeat.stop();
        }
    }

    Controller.simulatedDpad: ControllerEventType.LeftThumbstick

    Controller.onDpad: repeat.stop()

    Controller.onDpadDownPressed: {
        repeat.action(function() { incrementCurrentIndex(); });
    }

    Controller.onDpadUpPressed: {
        repeat.action(function() { decrementCurrentIndex(); });
    }
}
