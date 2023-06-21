import QtQuick 2.0
import Felgo 3.0
import "../"
Enemy {
    id: enemy01
    monsterImage.source: "../../assets/img/enemy01.png"
    width: 70
    height: 70
    //exploreH: 130
    //exploreW: 130

    boom: 2

    health: 4
    //newX:utils.generateRandomValueBetween(monsterImage.width, scene.width - monsterImage.width-20)+10

    /*
    MovementAnimation {
        id: temp
        running: true
        target: enemy01
        property: "pos"
        velocity: Qt.point((m_myPlane.x-x)/2, (m_myPlane.y-height/2)/2)

    }*/

    Rectangle {
        color: "red"//"#FF00FF"
        width: 65
        height: 65
        //opacity: 0.8
        visible: health>0
        anchors.centerIn: parent
        radius: 40
        z:-10
        SequentialAnimation on opacity {
            loops: Animation.Infinite
            PropertyAnimation {
                to: 0.25
                duration: 650 // 1 second for fade out
            }
            PropertyAnimation {
                to: 1
                duration: 650 // 1 second for fade in
            }
        }
    }

    Timer {
        id: timer
        running: enemy01.visible//scene.visible == true && splashFinished // only enable the creation timer, when the gameScene is visible
        interval: 650 // a new target(=monster) is spawned every second
        repeat: true
        onTriggered: {
            console.log("fire")
            fireDo()

        }
    }
    NumberAnimation on y {
        //from: -monsterImage.height // move the monster to the left side of the screen
        id: move
        from: 0
        to: scene.height // start at the right side

        duration: utils.generateRandomValueBetween(4000, 6000) // vary animation duration between 2-4 seconds for the 480 px scene width
        onStopped: {
            console.debug("monster reached base - change to gameover scene because the player lost")
            // changeToGameOverScene(false)
        }
    }


    function fireDo(){
        var imagePointInWorldCoordinates = mapToItem(level,monsterImage.imagePoints[0].x, monsterImage.imagePoints[0].y)

        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Bullet01.qml"), {"x": imagePointInWorldCoordinates.x, "y": imagePointInWorldCoordinates.y+170, "rotation": 90})
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Bullet01.qml"), {"x": imagePointInWorldCoordinates.x, "y": imagePointInWorldCoordinates.y+120, "rotation": 90})
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Bullet01.qml"), {"x": imagePointInWorldCoordinates.x, "y": imagePointInWorldCoordinates.y+70, "rotation": 90})
        //entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket2.qml"), {"x": imagePointInWorldCoordinates.x-40, "y": imagePointInWorldCoordinates.y, "rotation": boss.rotation})
        //entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket2.qml"), {"x": imagePointInWorldCoordinates.x, "y": imagePointInWorldCoordinates.y, "rotation": boss.rotation,"power":4500})
        //entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket2.qml"), {"x": imagePointInWorldCoordinates.x+40, "y": imagePointInWorldCoordinates.y, "rotation": boss.rotation})
        //entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket2.qml"), {"x": imagePointInWorldCoordinates.x+75, "y": imagePointInWorldCoordinates.y, "rotation": boss.rotation,"power":3900})
        //entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket2.qml"), {"x": imagePointInWorldCoordinates.x+105, "y": imagePointInWorldCoordinates.y, "rotation": boss.rotation,"power":3600})

        //entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket2.qml"), {"x": imagePointInWorldCoordinates.x, "y": imagePointInWorldCoordinates.y+100, "rotation": 90})
    }
}

