/*
function: main window
author: zouyujie
date: 2023.6.14
*/
import Felgo 3.0
import QtQuick 2.0

GameWindow {
    id: gameWindow
    screenHeight: 767
    screenWidth: 512
    //activeScene: playScene

    PlayScene {
        id: playScene
        visible: false
    }

    MenuScene {
        id: menuScene
        startMenuElement.mouseArea.onClicked: { playScene.visible = true; menuScene.visible = false }
        exitMenuElement.mouseArea.onClicked: { Qt.quit() }
    }
}
