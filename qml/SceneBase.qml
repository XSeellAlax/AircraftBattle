/*
fuction: Scene Base
author: zouyujie
date: 2023.6.16
*/
import QtQuick 2.0
import Felgo 3.0

// EMPTY SCENE

Scene {
    id: sceneBase

    opacity: 0
    // NOTE: in qt5, an opaque element is not invisible by default and would handle the mouse and keyboard input!
    // thus to disable also keyboard focus and mouse handling and make an item invisible, set visible and enabled property depending on opacity
    visible: opacity === 0 ? false : true
    enabled: visible
    //transition
    Behavior on opacity { NumberAnimation{duration: 250} }

    signal enterPressed
    signal upPressed
    signal downPressed

    signal enterReleased
    signal upReleased
    signal downReleased

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
    }

//    //ditto
//    Keys.onReturnPressed: {
//        enterPressed()
//    }
}
