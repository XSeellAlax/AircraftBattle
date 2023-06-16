/*
function: switch screen
ahthor: zouyjie
date: 2023.6.16
*/
import QtQuick 2.0
import Felgo 3.0

Item {
    id: mainItem

    MenuScene {
        id: menuScene
        //click start
        startMenuElement.mouseArea.onClicked: {
            sequence.running = true
        }
        sequence.onStopped: {
            mainItem.state = "play"
            playScene.myPlaneAnimation.running = true
        }
        //click exit
        exitMenuElement.mouseArea.onClicked: { Qt.quit() }
    }

    PlayScene {
        id: playScene
        myPlaneAnimation.onStopped: {
            //very important! It solve the problem: the full screen position is different
            myPlane.y = playScene.height-88
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                mainItem.state = "menu"
                //restore posititon by animation
                menuScene.sequence_restore.running = true
            }
        }
    }

    state: "menu"

    states: [
        State {
            name: "menu"
            PropertyChanges { target: menuScene; opacity: 1 }
            PropertyChanges { target: gameWindow; activeScene: menuScene }
            StateChangeScript {
                script: {
                    //audio
                }
            }
        },
        State {
            name: "play"
            PropertyChanges { target: playScene; opacity: 1 }
            PropertyChanges { target: gameWindow; activeScene: playScene }
            StateChangeScript {
                script: {
                    //
                }
            }
        }
    ]

}
