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
            id: level
        }

        Component {
            id: monster1Component
            Enemy {
                id: monsters
            }
        }

        focus: true
        // forward the input keys to both players
        Keys.forwardTo: [ level.player_blue.controller]
    }

    Timer {
        running: true//scene.visible == true && splashFinished // only enable the creation timer, when the gameScene is visible
        repeat: true
        interval: 1000 // a new target(=monster) is spawned every second
        onTriggered: addTarget()
    }

    function addTarget() {
        //console.debug("create a new monster")

        entityManager.createEntityFromComponent(monster1Component)
    }

    /*
    JoystickControllerHUD {
        anchors.bottom: parent.bottom

        // the joystick width is the space from the left to the start of the logical scene, so the radius is its half
        joystickRadius: scene.x/2


        // this allows setting custom images for the JoystickControllerHUD component
        source: "../assets/img/joystick_background.png"
        thumbSource: "../assets/img/joystick_thumb.png"


        // this is the mapping between the output of the JoystickControllerHUD to the input of the player's TwoAxisController
        // this is a performance improvement, to not have to bind every time the position changes
        property variant playerTwoxisController: level.player_red.getComponent("TwoAxisController")
        onControllerXPositionChanged: playerTwoxisController.xAxis = controllerXPosition;
        onControllerYPositionChanged: playerTwoxisController.yAxis = controllerYPosition;
    }*/
}

