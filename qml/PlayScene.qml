import QtQuick 2.0
import Felgo 3.0
import "common"

// EMPTY SCENE

Scene {
    id: scene
    width: 512
    height: 767

    //sceneAlignmentY: "top"

    MultiResolutionImage {
        id: bg1
        source: "../assets/img/img_bg_level_3.jpg"
        anchors.horizontalCenter: parent.horizontalCenter

        PropertyAnimation on y {
            to: 767
            duration: 3000
            onStopped: {
                bg1.y = -755
                switch1.running = true
            }
        }
    }

    MultiResolutionImage {
        id: bg2
        source: "../assets/img/img_bg_level_3.jpg"
        anchors.horizontalCenter: parent.horizontalCenter
        y: -755

        PropertyAnimation on y {
            to: 767
            duration: 6000
            onStopped: {
                bg2.y = -755
                switch2.running = true
            }
        }
    }

    PropertyAnimation {
        id: switch1
        target: bg1
        property: "y"
        to: 767
        duration: 6000
        running: false
        onStopped: {
            bg1.y = -755
            switch1.running = true
        }
    }

    PropertyAnimation {
        id: switch2
        target: bg2
        property: "y"
        to: 767
        duration: 6000
        running: false
        onStopped: {
            bg2.y = -755
            switch2.running = true
        }
    }

}
