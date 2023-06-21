/*
function: the menuElement
author: zouyujie
date: 2023.6.14
*/
import QtQuick 2.12
import Felgo 3.0
import QtQuick.Controls 2.5

Rectangle {
    id: menuElement
    property alias label: m_label
    ///property alias mouseArea: m_area
    property alias mouse: mouse
    property alias tapHandler: tapHandler
    property alias threeBird: m_threeBird

    //anchors.horizontalCenter: parent.horizontalCenter
    x: parent.width * 0.3 / 2
    width: parent.width * 0.7; height: 60
    color: "lightyellow"
    opacity: mouse.hovered ? 0.6 : 0.8
    radius: 12
//    border.color: "red"
//    border.width: 2
    //focus: false
    border.color: focus ? "skyblue" : "white"
    border.width: focus ? 2 : 1

    Label {
        id: m_label
        anchors.centerIn: parent
        font.bold: true
        font.pixelSize: mouse.hovered ? 18 : 20
    }

    //add ThreeBird
    ThreeBird {
        id: m_threeBird
    }

    //add hover property
    HoverHandler {
        id: mouse
    }

    TapHandler {
        id: tapHandler
    }

//    MouseArea {
//        id: m_area
//        anchors.fill: parent

//        hoverEnabled: true
//        onEntered: { menuElement.opacity = 0.6; m_label.font.pixelSize = 18 }
//        onExited: { menuElement.opacity = 0.8; m_label.font.pixelSize = 20 }
//        //onPressed: { menuElement.opacity = 0.6; m_label.font.pixelSize = 18 }
//        //onReleased: { menuElement.opacity = 0.8; m_label.font.pixelSize = 20 }
//    }
}
