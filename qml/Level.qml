import QtQuick 2.0
 import QtQuick.Controls 2.15
import Felgo 3.0
import "entities"

Item {
    id: level
    width: parent.width
    height: parent.height

    // use this to insert the input action (which car should fire and which to steer) to the right car
    //property alias player_red: car_red
    //property alias player_blue: plane_main

    // background of the level

    Component.onCompleted: {
        //Sleep(100)

        timer.running=true
        //timer.start()
    }
    /*
    Image {
        id: playgroundImage
        source: "../assets/img/playground.jpg"
        //source: "../assets/img/playbg.jpeg"
        anchors.fill: parent
    }*/

    /*
    Car {
        id: car_red
        objectName: "car_red"
        variationType: "carRed"
        x: 90
        y: 200
        // rotation in degrees clockwise
        rotation: 90

    }*/

    /*
    Plane {
        id: plane_main
        objectName: "plane_main"
        variationType: "mainplane"
        x: 320
        y: 920
        // rotation in degrees clockwise
        rotation: 270

        //image.source: "../assets/img/car_blue.png"

        inputActionsToKeyCode: {
            "up": Qt.Key_W,
            "down": Qt.Key_S,
            "left": Qt.Key_A,
            "right": Qt.Key_D,
            "fire": Qt.Key_Space
        }
    }*/

    //
    //create Enemy aircraft
    Component {
        id: enemyComponent
        Enemy {
            id: monsters
        }
    }

    Timer {
        id: timer
        running: false//scene.visible == true && splashFinished // only enable the creation timer, when the gameScene is visible
        repeat: true
        interval: 1000 // a new target(=monster) is spawned every second
        onTriggered: addTarget()
    }

    function addTarget() {
        //console.debug("create a new monster")

        entityManager.createEntityFromComponent(enemyComponent)
    }


    Wall {
        id: border_bottom

        height: 10
        anchors {
            left: parent.left
            right: parent.right
            top:  parent.bottom
        }
    }



    Wall {
        id: border_top

        height: 10
        anchors {
            //top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.top
            bottomMargin: 50
        }
    }


    Wall {
        id: border_left
        width: 20
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }
    }

    Wall {
        id: border_right
        width: 20
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
        }
    }
}
