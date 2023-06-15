/*
function: main window
author: zouyujie
date: 2023.6.14
*/
import Felgo 3.0
import QtQuick 2.0
import QtQml.Models 2.15
import QtQuick.Controls 2.0

GameWindow {
    id: gameWindow
    screenHeight: 960
    screenWidth: 640
    //activeScene: playScene

    PlayScene {
        id: playScene
        visible: false
    }

    MenuScene {
        id: menuScene
        //click start
        startMenuElement.mouseArea.onClicked: {
            title.anchors.horizontalCenter = undefined
            startMenuElement.anchors.horizontalCenter = undefined
            settingMenuElement.anchors.horizontalCenter = undefined
            exitMenuElement.anchors.horizontalCenter = undefined
            sequence.running = true
        }
        sequence.onStopped: { playScene.visible = true; menuScene.visible = false }
        //click exit
        exitMenuElement.mouseArea.onClicked: { Qt.quit() }
    }
}
