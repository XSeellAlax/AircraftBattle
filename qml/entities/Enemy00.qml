import QtQuick 2.0
import Felgo 3.0
import "../scene"

Enemy {
    id: enemy00
    monsterImage.source: "../../assets/img/enemy00.png" //enemy picture
    width: 75
    height: 100
    //exploreH: 155
    //exploreW: 155
    score: 2
    boom:1

    //enemy health
    health: 8

    Timer {
        id: timer
        running: enemy00.visible//scene.visible == true && splashFinished // only enable the creation timer, when the gameScene is visible
        interval: 550 // a new target(=monster) is spawned every second
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

        duration: utils.generateRandomValueBetween(7000, 10000) // vary animation duration between 2-4 seconds for the 480 px scene width
        onStopped: {
            console.debug("monster reached base - change to gameover scene because the player lost")
            // changeToGameOverScene(false)
        }
    }

    property int num: 0
    function fireDo(){
        var imagePointInWorldCoordinates = mapToItem(level,monsterImage.imagePoints[0].x, monsterImage.imagePoints[0].y)
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Bullet.qml"), {"entityId:":"num"+num,"x": imagePointInWorldCoordinates.x, "y": imagePointInWorldCoordinates.y+100, "rotation": 90})
        num++;
    }

}
