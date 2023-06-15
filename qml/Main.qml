
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

    EntityManager {
        id: entityManager
        entityContainer: scene
    }

    BackgroundMusic {
        source: "../assets/snd/background-music-aac.wav" // will start playing automatically after loading
    }

    Rectangle {
        anchors.fill: parent
        color: "black" // make a white background for the window
    }

    PlayScene {
        id: scene
        // the "logical size" - the scene content is auto-scaled to match the GameWindow size
        //width: 640
        //height: 960
        //Image {source:"../assets/bg.jpeg"; anchors.fill:parent}
        PhysicsWorld {debugDrawVisible: false} // put it anywhere in the Scene, so the collision detection between monsters and projectiles can be done

        MultiResolutionImage {
            id: player
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50 // 距离底部 10 像素
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../assets/hero.png" // the correct image version is used, based on the GameWindow size
        }


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
    }

    function addTarget() {
        console.debug("create a new monster")
        entityManager.createEntityFromComponent(monster)
    }

}

