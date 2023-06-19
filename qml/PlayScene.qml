/*
fuction: the scene of the game
author: zouyujie
date: 2023.6.13
*/
import QtQuick 2.0
import Felgo 3.0
import "entities"
import "scene"
//the following causes Android to not run
//import "common"

// EMPTY SCENE

SceneBase {
    id: scene
    property alias myPlane: m_myPlane
    property alias myPlaneAnimation: m_myPlaneAnimation
    property alias levelContral: level

    EntityManager {
        id: entityManager
        entityContainer: level
    }

    width: map.picture.width
    height: map.picture.height
    //clip: true

    //background
    Map { id: map; anchors.fill: scene.gameWindowAnchorItem; Component.onCompleted: { switch_map(5) } }

    //myPlane
    //MultiResolutionImage { id: m_myPlane; source: "../assets/img/hero2.png"; anchors.horizontalCenter: parent.horizontalCenter; y: parent.height+360 }

    Plane {
        id: m_myPlane
        objectName: "plane_main"
        variationType: "mainplane"
        // rotation in degrees clockwise
        rotation: 270
        x: parent.width/2-width/2; y: parent.height+360;
        inputActionsToKeyCode: {
            "up": Qt.Key_W,
            "down": Qt.Key_S,
            "left": Qt.Key_A,
            "right": Qt.Key_D,
            "fire": Qt.Key_Space
        }
        onGameOver: {
            playSceneLoader.active = false
            menuScene.opacity = 1
            gameWindow.activeScene = menuScene
            //restore posititon by animation
            menuScene.sequence_restore.running = true
        }
    }
    //Animation myPlane
    NumberAnimation { id: m_myPlaneAnimation; property: "y"; easing.type: Easing.InOutBack; target: myPlane; to: map.picture.height - 88; duration: 1800; running: false }

    PhysicsWorld {
        id: world
        updatesPerSecondForPhysics: 60
    }

    Level {
        id:level
    }
    focus: true
    // forward the input keys to both players
    Keys.forwardTo: [ m_myPlane.controller]
}
