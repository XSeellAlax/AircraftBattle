import Felgo 3.0
import QtQuick 2.0

GameWindow {
    id: gameWindow
    screenHeight: 767
    screenWidth: 512
    activeScene: playScene


    PlayScene {
        id: playScene
    }
}
