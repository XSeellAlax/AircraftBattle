/*
fuction: scroll and switch of the map
author: zouyujie
date: 2023.6.14
*/
import QtQuick 2.0
import Felgo 3.0

Item {
    id: map

    //the position of the map
    property string mapSource: "../assets/img/img_bg_level_3.jpg"

    //a picture
    property var picture: bg1

    //set position (project: overlap)
    property int toPosition: bg1.height - 5

    //operator: switch the map
    function switch_map(option) {
        switch (option) {
        case 1:
            mapSource = "../assets/img/img_bg_level_1.jpg"
            break
        case 2:
            mapSource = "../assets/img/img_bg_level_2.jpg"
            break
        case 3:
            mapSource = "../assets/img/img_bg_level_3.jpg"
            break
        case 4:
            mapSource = "../assets/img/img_bg_level_4.jpg"
            break
        case 5:
            mapSource = "../assets/img/img_bg_level_5.jpg"
            break
        }
    }

    //solve the problem: it starts with a black line
    Component.onCompleted: { timer.start() }
    Timer {
        id: timer
        interval: 300
        onTriggered: { bg1.temp1.running = true; bg2.temp2.running = true }
    }

    //bg1
    MultiResolutionImage {
        id: bg1
        source: mapSource
        anchors.horizontalCenter: parent.horizontalCenter

        property var temp1: m_temp1
        PropertyAnimation on y {
            id: m_temp1
            to: toPosition
            duration: 3500
            running: false
            onStopped: {
                bg1.y = -toPosition
                switch1.running = true
            }
        }
    }
    //bg2
    MultiResolutionImage {
        id: bg2
        source: mapSource
        anchors.horizontalCenter: parent.horizontalCenter
        y: -toPosition

        property var temp2: m_temp2
        PropertyAnimation on y {
            id: m_temp2
            to: toPosition
            duration: 7000
            running: false
            onStopped: {
                bg2.y = -toPosition
                switch2.running = true
            }
        }
    }
    //bg1 Animation
    PropertyAnimation {
        id: switch1
        target: bg1
        property: "y"
        to: toPosition
        duration: 7000
        running: false
        onStopped: {
            bg1.y = -toPosition
            switch1.running = true
        }
    }
    //bg2 Animation
    PropertyAnimation {
        id: switch2
        target: bg2
        property: "y"
        to: toPosition
        duration: 7000
        running: false
        onStopped: {
            bg2.y = -toPosition
            switch2.running = true
        }
    }
}
