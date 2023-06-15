<<<<<<< HEAD
import QtQuick 2.0
import Felgo 3.0

GameWindow {
    id: window
    screenWidth: 960
    screenHeight: 640
    activeScene: scene

    // You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://felgo.com/licenseKey>"

    // for creating and destroying entities at runtime (rockets)
=======

//2023.6.14
import Felgo 3.0
import QtQuick 2.0
import "level"
GameWindow {
    screenHeight: 960
    screenWidth: 640
    activeScene: scene

    property bool splashFinished: false
    onSplashScreenFinished: { splashFinished = true}


    property bool gameWon

    property int monstersDestroyed
    onMonstersDestroyedChanged: {
        if(monstersDestroyed > 5) {
            // you won the game, shot at 5 monsters
            changeToGameOverScene(true)
        }
    }

>>>>>>> e65a8f7 (version 1: a basic game)
    EntityManager {
        id: entityManager
        entityContainer: level
    }

    PlayScene {
        id: scene
<<<<<<< HEAD
        width: 640
        height: 640
=======
        // the "logical size" - the scene content is auto-scaled to match the GameWindow size
        //width: 640
        //height: 960
        //Image {source:"../assets/bg.jpeg"; anchors.fill:parent}
        PhysicsWorld {debugDrawVisible: false} // put it anywhere in the Scene, so the collision detection between monsters and projectiles can be done
>>>>>>> e65a8f7 (version 1: a basic game)

        // background image
        Image {
            id: background
            source: "../assets/img/asphalt_background.png"
            // since we are using a simple Image element to define our background, we stretch it to avoid any kind of black borders on any device
            width: parent.width*1.8
            height: parent.height*1.8
            anchors.centerIn: parent
        }

<<<<<<< HEAD
        // use a physics world because we need collision detection
        PhysicsWorld {
            id: world
            updatesPerSecondForPhysics: 60
        }

        Level {
            // this gets accessed by its id from JoystickControllerHUD below
            id: level

        }

        focus: true
        // forward the input keys to both players
        Keys.forwardTo: [level.player_red.controller, level.player_blue.controller]
=======

        Component {
            id: monster
            Enemy{id:monsters}

        }// Component

        Component {
            id: projectile
            Projectile{id:projectiles}

        }// Component

        MouseArea {
            anchors.fill: parent
            onReleased: {

                var offset = Qt.point(
                            mouseX - player.x,
                            mouseY - player.y
                            );

                var realX = scene.gameWindowAnchorItem.width
                var ratio = offset.y / offset.x
                var realY = (realX * ratio) + player.y
                var destination = Qt.point(realX, realY)

                var offReal = Qt.point(realX - player.x, realY - player.y)
                var length = Math.sqrt(offReal.x*offReal.x + offReal.y*offReal.y)
                var velocity = 480 // speed of the projectile should be 480pt per second
                var realMoveDuration = length / velocity * 1000 // multiply by 1000 because duration of projectile is in milliseconds

                entityManager.createEntityFromComponentWithProperties(projectile, {"destination": destination, "moveDuration": realMoveDuration})

                projectileCreationSound.play()
            }
        }
    }

    MenuScene {
        id: menuScene
        startMenuElement.mouseArea.onClicked: { scene.visible = true; menuScene.visible = false }
        exitMenuElement.mouseArea.onClicked: { Qt.quit() }
    }


    Timer {
        running: scene.visible == true && splashFinished // only enable the creation timer, when the gameScene is visible
        repeat: true
        interval: 1000 // a new target(=monster) is spawned every second
        onTriggered: addTarget()
>>>>>>> e65a8f7 (version 1: a basic game)
    }


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
    }
<<<<<<< HEAD
=======

>>>>>>> e65a8f7 (version 1: a basic game)
}

