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
    width: map.picture.width
    height: map.picture.height

    //background
    Map { id: map; anchors.horizontalCenter: parent.horizontalCenter }
    //title
    MultiResolutionImage { id: m_title; source: "../assets/img/title.png"; anchors.horizontalCenter: parent.horizontalCenter }

    //
    Rectangle {
        width: parent.width
        height: 300
        opacity: 0.7
        y: 300
        ListView {
            anchors.fill: parent
            model: listModel
            spacing: 5
            delegate: temp
        }
    }

    Component {
        id: temp
        Rectangle {
            width: parent.width; height: 60
            color: "lightyellow"
            opacity: 1
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: name
                text: m_text
                anchors.centerIn: parent
            }
            radius: 0
        }
    }

    ListModel {
        id: listModel
        ListElement { m_text: qsTr("Start New Game") }
        ListElement { m_text: qsTr("Exit") }
    }

}
