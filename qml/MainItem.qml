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
            if (startMenuElement.focus) sequence.running = true
            else { startMenuElement.focus = true }
        }
        sequence.onStopped: {
            mainItem.state = "play"
            playScene.myPlaneAnimation.running = true
        }
        //click setting
        settingMenuElement.mouseArea.onClicked: {
            if (settingMenuElement.focus) ;
            else { settingMenuElement.focus = true; }
        }
        //click exit
        exitMenuElement.mouseArea.onClicked: {
            if(exitMenuElement.focus) Qt.quit()
            else { exitMenuElement.focus = true }
        }
        //release event ->tip: can't if if if
        onEnterReleased: {
            if (startMenuElement.focus) { startMenuElement.opacity = 0.8; startMenuElement.label.font.pixelSize = 20; sequence.running = true }
            else if(settingMenuElement.focus) { settingMenuElement.opacity = 0.8; settingMenuElement.label.font.pixelSize = 20; }
            else if(exitMenuElement.focus) { exitMenuElement.opacity = 0.8; exitMenuElement.label.font.pixelSize = 20; Qt.quit() }
            else startMenuElement.focus = true
        }
        onUpReleased: {
            if (startMenuElement.focus) exitMenuElement.focus = true
            else if(settingMenuElement.focus) startMenuElement.focus = true
            else if(exitMenuElement.focus) settingMenuElement.focus = true
        }
        onDownReleased: {
            if (startMenuElement.focus) settingMenuElement.focus = true
            else if(settingMenuElement.focus) exitMenuElement.focus = true
            else if(exitMenuElement.focus) startMenuElement.focus = true
        }
        //press event for Animation
        onEnterPressed: {
            if (startMenuElement.focus) { startMenuElement.opacity = 0.6; startMenuElement.label.font.pixelSize = 18 }
            else if(settingMenuElement.focus) { settingMenuElement.opacity = 0.6; settingMenuElement.label.font.pixelSize = 18 }
            else if(exitMenuElement.focus) { exitMenuElement.opacity = 0.6; exitMenuElement.label.font.pixelSize = 18 }
        }
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
