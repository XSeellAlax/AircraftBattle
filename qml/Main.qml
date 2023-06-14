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
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            menuScene.visible = false
            playScene.visible = true
        }
    }
}
