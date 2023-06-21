/*
function: switch screen
ahthor: zouyjie
date: 2023.6.16
*/
import QtQuick 2.0
import Felgo 3.0
import "../"
Item {
    id: mainItem

    MenuScene {
        id: menuScene
        //click start
        startMenuElement.mouseArea.onEntered: { startMenuElement.focus = true; startMenuElement.threeBird.restart() }
        startMenuElement.mouseArea.onExited: { startMenuElement.threeBird.visible = false }
        startMenuElement.mouseArea.onClicked: { if (startMenuElement.focus) sequence.running = true; playSceneLoader.sourceComponent = playSceneComponent }
        sequence.onStopped: {
            visible = false
            playSceneLoader.active = true
            playSceneLoader.visible = true
            playSceneLoader.item.myPlaneAnimation.running = true
            gameWindow.activeScene = playSceneLoader.item
        }
        //click setting
        settingMenuElement.mouseArea.onEntered: { settingMenuElement.focus = true; settingMenuElement.threeBird.restart() }
        settingMenuElement.mouseArea.onExited: { settingMenuElement.threeBird.visible = false }
        settingMenuElement.mouseArea.onClicked: { if (settingMenuElement.focus) mainItem.state = "setting"; }
        //click exit
        exitMenuElement.mouseArea.onEntered: { exitMenuElement.focus = true; exitMenuElement.threeBird.restart() }
        exitMenuElement.mouseArea.onExited: { exitMenuElement.threeBird.visible = false }
        exitMenuElement.mouseArea.onClicked: { if(exitMenuElement.focus) Qt.quit() }
        //release event ->tip: can't if if if
        onEnterReleased: {
            if (startMenuElement.focus) { startMenuElement.opacity = 0.8; startMenuElement.label.font.pixelSize = 20; sequence.running = true; startMenuElement.threeBird.visible = false }
            else if(settingMenuElement.focus) { settingMenuElement.opacity = 0.8; settingMenuElement.label.font.pixelSize = 20; settingMenuElement.threeBird.visible = false }
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
            if (startMenuElement.focus) { startMenuElement.opacity = 0.6; startMenuElement.label.font.pixelSize = 18; startMenuElement.threeBird.restart() }
            else if(settingMenuElement.focus) { settingMenuElement.opacity = 0.6; settingMenuElement.label.font.pixelSize = 18; settingMenuElement.threeBird.restart() }
            else if(exitMenuElement.focus) { exitMenuElement.opacity = 0.6; exitMenuElement.label.font.pixelSize = 18; exitMenuElement.threeBird.restart() }
        }
    }

    //dynamic loading
    Loader {
        id: playSceneLoader
        visible: false
        //sourceComponent: playSceneComponent
    }
    Component {
        id: playSceneComponent
        PlayScene {
            id: playScene
            visible: true
            Component.onCompleted: { map.switch_map(settingScene.selectMap) }
            myPlaneAnimation.onStopped: {
                //very important! It solve the problem: the full screen position is different
                levelContral.timeControl=true
                myPlane.y = playScene.height-88
            }
            onBackspaceReleased: {
                //mainItem.state = "menu"
                playSceneLoader.active = false
                menuScene.visible = true
                gameWindow.activeScene = menuScene
                //restore posititon by animation
                menuScene.sequence_restore.running = true
            }
        }
    }

    SettingScene {
        id: settingScene
        backImageMouseArea.onClicked: { mainItem.state = "menu" }
    }

    state: "menu"

    states: [
        State {
            name: "menu"
            PropertyChanges { target: menuScene; visible: true }
            PropertyChanges { target: gameWindow; activeScene: menuScene }
            StateChangeScript {
                script: {
                    //audio
                }
            }
        },
        State {
            name: "setting"
            PropertyChanges { target: settingScene; visible: true }
            PropertyChanges { target: gameWindow; activeScene: settingScene }
            StateChangeScript {
                script: {
                    //audio
                }
            }
        }
    ]
}
