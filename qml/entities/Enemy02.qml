import QtQuick 2.0
import Felgo 3.0

Enemy {
    id: enemy02
    monsterImage.source: "../../assets/img/enemy02.png"
    width: 120
    height: 105
    exploreH: 160
    exploreW: 160
    boom: 5
    score: 10

    SequentialAnimation on x {
        running: enemy02.visible
        loops: Animation.Infinite
        PropertyAnimation {
            to: 100
            duration: 3000 // 1 second for fade out
        }
        PropertyAnimation {
            to: scene.width-150
            duration: 3000 // 1 second for fade in
        }
    }/*
    SequentialAnimation on y {
        running: enemy02.visible
        loops: Animation.Infinite
        PropertyAnimation {
            to: 0
            duration: 5000 // 1 second for fade out
        }
        PropertyAnimation {
            to: scene.height-150
            duration: 5000 // 1 second for fade in
        }
    }
    */
    NumberAnimation on y {
        //from: -monsterImage.height // move the monster to the left side of the screen
        id: move
        from: 0
        to: scene.height // start at the right side

        duration: utils.generateRandomValueBetween(12000, 15000) // vary animation duration between 2-4 seconds for the 480 px scene width
        onStopped: {
            console.debug("monster reached base - change to gameover scene because the player lost")
            // changeToGameOverScene(false)
        }
    }



    Timer {
        id: timer
        running: enemy02.visible//scene.visible == true && splashFinished // only enable the creation timer, when the gameScene is visible
        interval: 20 // a new target(=monster) is spawned every second
        repeat: true
        onTriggered: {
            fireDo()

        }
    }
    property int num: 0
    function fireDo(){
        var imagePointInWorldCoordinates = mapToItem(level,monsterImage.imagePoints[0].x, monsterImage.imagePoints[0].y)
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Bullet02.qml"), {"entityId":"e1"+num,"x": imagePointInWorldCoordinates.x, "y": imagePointInWorldCoordinates.y+100, "rotation": 90})
        num++

    }


    health: 12
}
