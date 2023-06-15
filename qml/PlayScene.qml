/*
fuction: the scene of the game
author: zouyujie
date: 2023.6.13
*/
import QtQuick 2.0
import Felgo 3.0
import "common"

// EMPTY SCENE

Scene {
    id: scene
    property alias myPlane: m_myPlane
    property alias myPlaneAnimation1: m_myPlaneAnimation1
    property alias myPlaneAnimation2: m_myPlaneAnimation2

    width: map.picture.width
    height: map.picture.height
    clip: true

    //background
    Map { id: map; anchors.horizontalCenter: parent.horizontalCenter; Component.onCompleted: { switch_map(5) } }

    //myPlane
    MultiResolutionImage { id: m_myPlane; source: "../assets/img/hero2.png"; anchors.horizontalCenter: parent.horizontalCenter; y: parent.height+100 }

    //Animation myPlane
    //situation 1: not fullscreen
    NumberAnimation { id: m_myPlaneAnimation1; property: "y"; easing.type: Easing.InOutBack; target: myPlane; to: parent.height/2+200; duration: 1800; running: false }
    //situation 2: is fullscreen
    NumberAnimation { id: m_myPlaneAnimation2; property: "y"; easing.type: Easing.InOutBack; target: myPlane; to: parent.height/2+108; duration: 1800; running: false }
}
