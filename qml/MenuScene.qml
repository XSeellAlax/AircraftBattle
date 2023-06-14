/*
fuction: menu interface
author: zouyujie
date: 2023.6.14
*/
import QtQuick 2.0
import Felgo 3.0
import QtQml.Models 2.15
import QtQuick.Controls 2.0

// EMPTY SCENE

Scene {
    id: scene
    property alias startMenuElement: column.m_startMenuElement
    property alias exitMenuElement: column.m_exitMenuElement

    width: map.picture.width
    height: map.picture.height

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
        property alias m_exitMenuElement: mm_exitMenuElement
        MenuElement { id: mm_startMenuElement; width: parent.width*0.7; label.text: "Start New Game" }
        MenuElement { id: mm_exitMenuElement; width: parent.width*0.7; label.text: "Exit" }
    }

}
