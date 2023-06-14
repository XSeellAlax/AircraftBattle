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

    //bg1
    MultiResolutionImage {
        id: bg1
        source: mapSource
        anchors.horizontalCenter: parent.horizontalCenter

        PropertyAnimation on y {
            to: 767
            duration: 3500
            onStopped: {
                bg1.y = -755
                switch1.running = true
            }
        }
    }
    //bg2
    MultiResolutionImage {
        id: bg2
        source: mapSource
        anchors.horizontalCenter: parent.horizontalCenter
        y: -755

        PropertyAnimation on y {
            to: 767
            duration: 7000
            onStopped: {
                bg2.y = -755
                switch2.running = true
            }
        }
    }
    //bg1 Animation
    PropertyAnimation {
        id: switch1
        target: bg1
        property: "y"
        to: 767
        duration: 7000
        running: false
        onStopped: {
            bg1.y = -755
            switch1.running = true
        }
    }
    //bg2 Animation
    PropertyAnimation {
        id: switch2
        target: bg2
        property: "y"
        to: 767
        duration: 7000
        running: false
        onStopped: {
            bg2.y = -755
            switch2.running = true
        }
    }
}
