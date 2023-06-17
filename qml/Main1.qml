import QtQuick 2.0
import Felgo 3.0
import "entities"
GameWindow {
    id: window
    screenWidth: 640
    screenHeight: 960
    activeScene: scene

    EntityManager {
        id: entityManager
        entityContainer: level
    }

    Scene {
        id: scene
        width: 640
        height: 960

        // background image
        Image {
            id: background
            source: "../assets/img/asphalt_background.png"
            // since we are using a simple Image element to define our background, we stretch it to avoid any kind of black borders on any device
            width: parent.width*1.8
            height: parent.height*1.8
            anchors.centerIn: parent
        }

        // use a physics world because we need collision detection
        PhysicsWorld {
            id: world
            updatesPerSecondForPhysics: 60
        }

        Level {
            // this gets accessed by its id from JoystickControllerHUD below
            //visible: false
            id: level
        }
        /*
        Component {
            id: createLevel
            Level {
                // this gets accessed by its id from JoystickControllerHUD below
                //visible: false
                id: level
            }
        }*/



        focus: true
        // forward the input keys to both players
        Keys.forwardTo: [ level.player_blue.controller]
    }




}

