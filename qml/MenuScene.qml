/*
fuction: menu interface
author: zouyujie
date: 2023.6.14
*/
import QtQuick 2.0
import Felgo 3.0
import QtQml.Models 2.15
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

// EMPTY SCENE

Scene {
    id: scene
    property alias startMenuElement: column.m_startMenuElement
    property alias settingMenuElement: column.m_settingMenuElement
    property alias exitMenuElement: column.m_exitMenuElement
    property alias title: m_title
    property alias sequence: m_sequence
    property alias myPlane: m_myPlane

    width: map.picture.width
    height: map.picture.height
    //limit visual range
    clip: true

    //background
    Map { id: map; anchors.horizontalCenter: parent.horizontalCenter }
    //title
    MultiResolutionImage { id: m_title; source: "../assets/img/title.png"; anchors.horizontalCenter: parent.horizontalCenter }
    //menu option
    Column {
        id: column
        width: parent.width
        y: 350
        spacing: 10
        property alias m_startMenuElement: mm_startMenuElement
        property alias m_settingMenuElement: mm_settingMenuElement
        property alias m_exitMenuElement: mm_exitMenuElement
        MenuElement { id: mm_startMenuElement; width: parent.width*0.7; label.text: "Start New Game" }
        MenuElement { id: mm_settingMenuElement; width: parent.width*0.7; label.text: "Setting" }
        MenuElement { id: mm_exitMenuElement; width: parent.width*0.7; label.text: "Exit" }
    }
    //myPlane
    MultiResolutionImage { id: m_myPlane; source: "../assets/img/hero2.png"; anchors.horizontalCenter: parent.horizontalCenter; y: parent.height - 85 }

    //Animation after starting
    SequentialAnimation {
        id: m_sequence
        running: false
        ParallelAnimation {
            id: m_parallel

            NumberAnimation { property: "y"; easing.type: Easing.InOutBack; target: title; to: -500; duration: 800 }
            NumberAnimation { property: "x"; easing.type: Easing.InExpo; target: startMenuElement; to: 550; duration: 800 }
            NumberAnimation { property: "x"; easing.type: Easing.InExpo; target: settingMenuElement; to: -400; duration: 800 }
            NumberAnimation { property: "x"; easing.type: Easing.InExpo; target: exitMenuElement; to: 550; duration: 800 }
        }
        NumberAnimation { property: "y"; easing.type: Easing.InExpo; target: myPlane; to: -500; duration: 800 }
    }
}
