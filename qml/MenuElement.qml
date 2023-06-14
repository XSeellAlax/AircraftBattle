/*
function: the menuElement
author: zouyujie
date: 2023.6.14
*/
import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 2.0

Rectangle {
    id: menuElement
    property alias label: m_label
    property alias mouseArea: m_area

    anchors.horizontalCenter: parent.horizontalCenter
    width: parent.width * 0.7; height: 60
    color: "lightyellow"
    opacity: 0.8
    radius: 12

    Label {
        id: m_label
        anchors.centerIn: parent
        font.bold: true
        font.pixelSize: 20
    }

    //add click property
    MouseArea {
        id: m_area
        anchors.fill: parent
        onPressed: { menuElement.opacity = 0.6 }
        onReleased: { menuElement.opacity = 0.8 }
    }
}
