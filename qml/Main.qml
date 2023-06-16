//2021051615323zhanglang
//2023.6.14
import Felgo 3.0
import QtQuick 2.0

GameWindow {
    id:mainscene

    // the size of the Window can be changed at runtime by pressing the number keys 1-7
    // the content of the logical scene size (480x320 by default) gets scaled to the window size based on the scaleMode
    screenWidth: 640
    screenHeight: 960
    activeScene: scene
    // create a licenseKey to hide the splash screen
    //property alias playerImage: playerImage
    property bool splashFinished: false
    onSplashScreenFinished: { splashFinished = true}

    // this gets set from Monster, after it reached the player and is read by the GameOverScene to display if the player has won or lost
    property bool gameWon

    property int monstersDestroyed
    onMonstersDestroyedChanged: {
        if(monstersDestroyed > 5) {
            // you won the game, shot at 5 monsters
            changeToGameOverScene(true)
        }
    }

    // for creating entities (monsters and projectiles) at runtime dynamically
    EntityManager {
        id: entityManager
        entityContainer: scene

    }

    //    BackgroundMusic {
    //        source: "../assets/snd/background-music-aac.wav" // will start playing automatically after loading
    //    }

    Rectangle {
        anchors.fill: parent
        color: "black" // make a white background for the window
    }

    Scene {
        id: scene
        // the "logical size" - the scene content is auto-scaled to match the GameWindow size
        width: 640
        height: 960
        Image {source:"../assets/mainbg.png";
            anchors.centerIn: parent
            width: parent.width*2.6
            height: parent.height
        }
        PhysicsWorld {debugDrawVisible: false} // put it anywhere in the Scene, so the collision detection between monsters and projectiles can be done

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

        Player{id:player
            anchors.bottom: scene.bottom
            anchors.bottomMargin: 80 // 距离底部 10 像素
            anchors.horizontalCenter: scene.horizontalCenter
          //  }
        }
        // the elements of a component don't get created immediately, but in addTarget()
        // the EntityBase could also be put into an own qml file (e.g. Monster.qml)
        //        Component {
        //            id: monster
        //            Enemy{id:monsters}

        //        }// Component

        Component {
            id: projectile
            Projectile{id:projectiles}

        }// Component

//        SoundEffect {
//            id: projectileCreationSound
//            source: "../assets/snd/pew-pew-lei.wav" // gets played when a projectile is created below
//        }

        MouseArea {
            anchors.fill: parent
            onReleased: {

                // see here for an explanation of this code: http://www.raywenderlich.com/25736/how-to-make-a-simple-iphone-game-with-cocos2d-2-x-tutorial

                // Determinie offset of player to touch location
                var offset = Qt.point(
                            mouseX - player.x,
                            mouseY - player.y
                            );

                // Bail out if we are shooting down or backwards


                // Determine where we wish to shoot the projectile to
                var realX = scene.gameWindowAnchorItem.width
                //if(offset.y <= 0)
                var ratio = -offset.y / offset.x
//                else
//                ratio = offset.y / offset.x
                var realY = (realX * ratio) + player.y
                var destination = Qt.point(realX, realY)


                // Determine the length of how far we're shooting
                var offReal = Qt.point(realX - player.x, realY - player.y)
                var length = Math.sqrt(offReal.x*offReal.x + offReal.y*offReal.y)
                var velocity = 480 // speed of the projectile should be 480pt per second
                var realMoveDuration = length / velocity * 1000 // multiply by 1000 because duration of projectile is in milliseconds

                entityManager.createEntityFromComponentWithProperties(projectile, {"destination": destination, "moveDuration": realMoveDuration})

               // projectileCreationSound.play()
            }
        }// onReleased
    }// MouseArea



    Timer {
        running: scene.visible == true && splashFinished // only enable the creation timer, when the gameScene is visible
        repeat: true
        interval: 1000 // a new target(=monster) is spawned every second
        onTriggered: addTarget()
    }

    function addTarget() {
        console.debug("create a new monster")
        entityManager.createEntityFromComponent(monster1Component)
    }

    //    function changeToGameOverScene(won) {

    //        gameWon = won

    //        gameOverScene.visible = true
    //        scene.visible = false

    //        // reset the game variables and remove all projectiles and monsters
    //        monstersDestroyed = 0
    //        entityManager.removeEntitiesByFilter(["projectile", "monster"])
    //    }
}
//![0]
