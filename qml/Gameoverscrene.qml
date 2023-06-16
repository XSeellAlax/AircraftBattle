import QtQuick 2.0
import Felgo 3.0
//switch to this scene, after the game was lost or won and it switches back to the gameScene after 3 seconds
Scene {
    id: gameOverScene
    visible: false
    Text {
        anchors.centerIn: parent
        text: gameWon ? "You won :)" : "You lost"
    }

    onVisibleChanged: {
        if(visible) {
            returnToGameSceneTimer.start()  // make the scene invisible after 3 seconds, after it got visible
        }
    }

    Timer {
        id: returnToGameSceneTimer
        interval: 3000
        onTriggered: {
            scene.visible = true
            gameOverScene.visible = false
        }
    }
}// GameOverScene
