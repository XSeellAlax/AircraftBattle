import QtQuick 2.0
import Felgo 3.0

Enemy {
    id: enemy03
    monsterImage.source: "../../assets/img/enemy03.png"
    width: 200
    height: 225

    health: 50
    exploreH: 220
    exploreW: 220
    //exploreH: 130
    //exploreW: 130

    score: 25
    boom: 10

    anchors.horizontalCenter: parent.horizontalCenter

    RotationAnimation {
            id: rotationAnimation
            running: true
            target: rotImage
            property: "rotation"
            from: 0
            to: 360 // 旋转到的角度
            duration: 1000 // 动画持续时间（毫秒）
            loops: Animation.Infinite // 控制动画是否循环
        }


    Timer {
        id: timer
        running: enemy03.visible//scene.visible == true && splashFinished // only enable the creation timer, when the gameScene is visible
        interval: 650 // a new target(=monster) is spawned every second
        repeat: true
        onTriggered: {
            //console.log("fire")
            fireDo()
        }
    }
    Timer {
        id: timer2
        running: enemy03.visible//scene.visible == true && splashFinished // only enable the creation timer, when the gameScene is visible
        interval: 45 // a new target(=monster) is spawned every second
        repeat: true
        onTriggered: {
            //console.log("fire")
            fireDo2()

        }
    }
    Timer {
        id: timer3
        running: enemy03.visible//scene.visible == true && splashFinished // only enable the creation timer, when the gameScene is visible
        interval: 200 // a new target(=monster) is spawned every second
        repeat: true
        onTriggered: {
            //console.log("fire")
            fireDo3()

        }
    }
    NumberAnimation on y {
        //from: -monsterImage.height // move the monster to the left side of the screen
        id: move
        from: 0
        to: scene.height // start at the right side

        duration: utils.generateRandomValueBetween(32000, 40000) // vary animation duration between 2-4 seconds for the 480 px scene width
        onStopped: {
            console.debug("monster reached base - change to gameover scene because the player lost")
            // changeToGameOverScene(false)
        }
    }
    property int num: 0 //
    function fireDo(){
        var imagePointInWorldCoordinates = mapToItem(level,monsterImage.imagePoints[0].x, monsterImage.imagePoints[0].y)
        var test = imagePointInWorldCoordinates
        var dection = Math.atan((test.x-myPlane.x)/(myPlane.y-test.y))*180
        console.log("----------------"+dection)

        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Bullet01.qml"), {"entityId:":"t1"+num,"x": imagePointInWorldCoordinates.x-78, "y": imagePointInWorldCoordinates.y+270, "rotation": 90})
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Bullet01.qml"), {"entityId:":"t2"+num,"x": imagePointInWorldCoordinates.x-78, "y": imagePointInWorldCoordinates.y+250, "rotation": 90})
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Bullet01.qml"), {"entityId:":"t3"+num,"x": imagePointInWorldCoordinates.x-78, "y": imagePointInWorldCoordinates.y+220, "rotation": 90})

        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Bullet01.qml"), {"entityId:":"t1"+num,"x": imagePointInWorldCoordinates.x+78, "y": imagePointInWorldCoordinates.y+270, "rotation": 90})
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Bullet01.qml"), {"entityId:":"t2"+num,"x": imagePointInWorldCoordinates.x+78, "y": imagePointInWorldCoordinates.y+250, "rotation": 90})
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Bullet01.qml"), {"entityId:":"t3"+num,"x": imagePointInWorldCoordinates.x+78, "y": imagePointInWorldCoordinates.y+220, "rotation": 90})
        //console.log("------------------------------------------------------")
        num++

    }
    property int rot: 0
    function fireDo2(){
         var imagePointInWorldCoordinates = mapToItem(level,monsterImage.imagePoints[0].x, monsterImage.imagePoints[0].y)
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Bullet03.qml"), {"x": imagePointInWorldCoordinates.x, "y": imagePointInWorldCoordinates.y+140, "rotation": 90+rot})

        //entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket1.qml"), {"x": imagePointInWorldCoordinates.x+40, "y": imagePointInWorldCoordinates.y-75, "rotation": boss.rotation+rot,"power":5900})
        rot+=30
        if(rot==360){
            rot=0
        }
    }
    property int rot2: 0
    function fireDo3(){
        var imagePointInWorldCoordinates = mapToItem(level,monsterImage.imagePoints[0].x, monsterImage.imagePoints[0].y)
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Bullet04.qml"), {"entityId:":"xt1"+num,"x": imagePointInWorldCoordinates.x-60, "y": imagePointInWorldCoordinates.y+200, "rotation": 90+rot2,"power":12900})
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Bullet04.qml"), {"entityId:":"xt2"+num,"x": imagePointInWorldCoordinates.x+60, "y": imagePointInWorldCoordinates.y+200, "rotation": 90+rot2,"power":12900})
        rot2+=20
        if(rot2==360){
            rot2=0
        }
    }
}



