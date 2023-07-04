/*
fuction: scroll and switch of the map
author: zouyujie
date: 2023.6.14
*/
import QtQuick 2.0
import Felgo 3.0

Item {
    id: map
    width: picture.width
    height: picture.height

    //anchors.fill: parent

    //the position of the map
    property string mapSource: "../../assets/img/sceen01.png"

    //a picture
    property var picture: bg1

    //set position (project: overlap)
    property int to_up_Position: -(2*bg1.height -365 -5 -5)
    property int to_down_Position: bg1.height + 360

    Image {
        source: "../../assets/img/reflect.png"
        //source: "../../assets/img/reflect-blend.png"
        //anchors.fill: parent
        width: picture.width
        height: picture.height
        anchors.centerIn: parent
    }

    //operator: switch the map
    function switch_map(option) {
        switch (option) {
        case 1:
            mapSource = "../../assets/img/sceen01.png"
            break
        case 2:
            mapSource = "../../assets/img/sceen02.png"
            break
        case 3:
            mapSource = "../../assets/img/sceen03.png"
            break
        case 4:
            mapSource = "../../assets/img/img_bg_level_2.jpg"
            break
        case 5:
            mapSource = "../../assets/img/img_bg_level_3.jpg"
            break
        }
    }

    //solve the problem: it starts with a black line
    Component.onCompleted: { timer.start() }
    Timer {
        id: timer
        interval: 300
        onTriggered: { bg1.temp1.running = true; bg2.temp2.running = true; bg3.temp3.running = true }
    }

    //bg1
    MultiResolutionImage {
        id: bg1
        source: mapSource
        anchors.horizontalCenter: parent.horizontalCenter
        y: 360 +5

        property var temp1: m_temp1
        PropertyAnimation on y {
            id: m_temp1
            to: to_down_Position
            duration: 3500
            running: false
            onStopped: {
                bg1.y = to_up_Position
                switch1.running = true
            }
        }
    }
    //bg2
    MultiResolutionImage {
        id: bg2
        source: mapSource
        anchors.horizontalCenter: parent.horizontalCenter
        y: -(bg1.height -365 -5)


        property var temp2: m_temp2
        PropertyAnimation on y {
            id: m_temp2
            to: to_down_Position
            duration: 7000
            running: false
            onStopped: {
                bg2.y = to_up_Position
                switch2.running = true
            }
        }
    }
    //bg3
    MultiResolutionImage {
        id: bg3
        source: mapSource
        anchors.horizontalCenter: parent.horizontalCenter
        y: to_up_Position

        property var temp3: m_temp3
        PropertyAnimation on y {
            id: m_temp3
            to: to_down_Position
            duration: 10500
            running: false
            onStopped: {
                bg3.y = to_up_Position
                switch3.running = true
            }
        }
    }
    //bg1 Animation
    PropertyAnimation {
        id: switch1
        target: bg1
        property: "y"
        to: to_down_Position
        duration: 10500
        running: false
        onStopped: {
            bg1.y = to_up_Position
            switch1.running = true
        }
    }
    //bg2 Animation
    PropertyAnimation {
        id: switch2
        target: bg2
        property: "y"
        to: to_down_Position
        duration: 10500
        running: false
        onStopped: {
            bg2.y = to_up_Position
            switch2.running = true
        }
    }
    //bg3 Animation
    PropertyAnimation {
        id: switch3
        target: bg3
        property: "y"
        to: to_down_Position
        duration: 10500
        running: false
        onStopped: {
            bg3.y = to_up_Position
            switch3.running = true
        }
    }
}
