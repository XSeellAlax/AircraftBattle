import QtQuick 2.0
import Felgo 3.0

// EMPTY SCENE

Scene {
    id: sceneBase
    visible: false
    enabled: visible

    signal enterPressed()
    signal upPressed()
    signal downPressed()

    signal enterReleased()
    signal upReleased()
    signal downReleased()
    signal backspaceReleased()

    //press event
    Keys.onPressed: {
        if (event.key === Qt.Key_Return) enterPressed()
        if (event.key === Qt.Key_W || event.key === Qt.Key_Up) upPressed()
        if (event.key === Qt.Key_S || event.key === Qt.Key_Down) downPressed()
    }
    //release event
    Keys.onReleased: {
        if (event.key === Qt.Key_Return) enterReleased()
        if (event.key === Qt.Key_W || event.key === Qt.Key_Up) upReleased()
        if (event.key === Qt.Key_S || event.key === Qt.Key_Down) downReleased()
        if (event.key === Qt.Key_Backspace) backspaceReleased()
    }
}
