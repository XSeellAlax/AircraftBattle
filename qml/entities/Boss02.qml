import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 2.0
import "../scene"
EntityBase {
    id: boss02
    entityType: "boss" // required for removing all of these entities when the game is lost
    property alias monsterImage: monsterImage
    property int health: 200
    //rotation: 270
    property int boom: 10
    x: scene.width/2 - width/2
    y: 50

    Rectangle {
        color:"red"
        //color:"blue"
        width: 60
        height: 45
        visible: t3.running&& health>0
        //opacity: 0.8
        anchors.centerIn: parent
        radius: 40
        z:999
        SequentialAnimation on opacity {
            loops: Animation.Infinite
            PropertyAnimation {
                to: 0.05
                duration: 1000 // 1 second for fade out
            }
            PropertyAnimation {
                to: 0.5
                duration: 1000 // 1 second for fade in
            }
        }
    }

    Rectangle {
        color: "#ADD8E6FF"
        width: 30
        height: 10
        visible: false
        //opacity: 0.8
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.centerIn: parent
        //anchors.bottom: parent

        //y: -50
        radius: 40
        z:999
        SequentialAnimation on opacity {
            loops: Animation.Infinite
            PropertyAnimation {
                to: 0
                duration: 1000 // 1 second for fade out
            }
            PropertyAnimation {
                to: 1
                duration: 1000 // 1 second for fade in
            }
        }
    }

    Rectangle {
        color: monsterImage.visible?"#FF00FF":"#8B0000"
        width: 45
        height: 32
        visible: health>0
        x:-5
        y:22
        //opacity: 0.75
        radius: 18
        z:999
        SequentialAnimation on opacity {
            running: monsterImage.visible
            loops: Animation.Infinite
            PropertyAnimation {
                to: 0
                duration: 800 // 1 second for fade out
            }
            PropertyAnimation {
                to: 0.25//monsterImage.visible? 0.3 : 1
                duration: 800 // 1 second for fade in
            }
        }

    }
    Rectangle {
        color: monsterImage.visible?"#FF00FF":"#8B0000"
        width: 45
        height: 32
        visible: health>0
        x:-5
        y:-62
        //opacity: 0.65
        radius: 18
        z:999
        SequentialAnimation on opacity {
            running: monsterImage.visible
            loops: Animation.Infinite
            PropertyAnimation {
                to: 0.05
                duration: 800 // 1 second for fade out
            }
            PropertyAnimation {
                to:0.3//monsterImage.visible?0.3:1
                duration: 800 // 1 second for fade in
            }
        }

    }


    Rectangle {
        id:b1
        color: "black"
        width: 300
        height: 300
        anchors.centerIn: parent
        z:999
        radius: 200
        /*
        Image {
            id: name
            source: "../../assets/img/heidong2.png"
            anchors.fill: parent
        }*/
        SequentialAnimation on opacity {
            loops: Animation.Infinite
            PropertyAnimation {
                to: 0
                duration: 1000 // 1 second for fade out
            }
            PropertyAnimation {
                to: 1
                duration: 1000 // 1 second for fade in
            }
        }
    }


    MultiResolutionImage {
        id: monsterImage
        source: "../../assets/img/boss.png"
        width: 200
        height: 250
        anchors.centerIn: parent
        visible: false

        property list<Item> imagePoints: [
            // this imagePoint can be used for creation of the rocket
            // it must be far enough in front of the car that they don't collide upon creation
            // the +30 might have to be adapted if the size of the rocket is changed
            Item {x: monsterImage.width/2+10}
        ]
    }
    Timer {
        id: t0
        running: b1.visible//scene.visible == true && splashFinished // only enable the creation timer, when the gameScene is visible
        interval: 3500 // a new target(=monster) is spawned every second
        repeat: true
        onTriggered: {
            monsterImage.visible=true
            b1.visible=false
        }

    }

    SequentialAnimation on x {
        id: xMove
        running: false//boss.visible
        loops: Animation.Infinite
        PropertyAnimation {
            to: 100
            duration: 1500 // 1 second for fade out
        }
        PropertyAnimation {
            to: scene.width-100
            duration: 1500 // 1 second for fade in
        }
    }
    SequentialAnimation on y {
        id: yMove
        running: false//boss.visible
        loops: Animation.Infinite
        PropertyAnimation {
            to: 50
            duration: 2500 // 1 second for fade out
        }
        PropertyAnimation {
            to: 400
            duration: 2500 // 1 second for fade in
        }
    }



    Timer {
        id: timer
        running: monsterImage.visible//scene.visible == true && splashFinished // only enable the creation timer, when the gameScene is visible
        interval: 500 // a new target(=monster) is spawned every second
        repeat: true
        onTriggered: fireDo()
    }

    Timer {
        id: t2
        running: monsterImage.visible
        interval: 800
        repeat: true
        onTriggered: {
            fireDo2()
        }
    }

    Timer {
        id: t3
        running: false
        interval: 50
        repeat: true
        onTriggered: {
            fireDo3()
        }
    }

    function fireDo(){
        var imagePointInWorldCoordinates = mapToItem(level,monsterImage.imagePoints[0].x, monsterImage.imagePoints[0].y)
        //console.debug("imagePointInWorldCoordinates x", imagePointInWorldCoordinates.x, " y:", imagePointInWorldCoordinates.y)

        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket2.qml"), {"x": imagePointInWorldCoordinates.x-105, "y": imagePointInWorldCoordinates.y, "rotation": boss.rotation,"power":3600})
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket2.qml"), {"x": imagePointInWorldCoordinates.x-90, "y": imagePointInWorldCoordinates.y, "rotation": boss.rotation,"power":3800})
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket2.qml"), {"x": imagePointInWorldCoordinates.x-75, "y": imagePointInWorldCoordinates.y, "rotation": boss.rotation,"power":3900})
        //entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Bullet02.qml"), {"x": imagePointInWorldCoordinates.x-40, "y": imagePointInWorldCoordinates.y, "rotation": boss.rotation,"power":8900})
        //entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket2.qml"), {"x": imagePointInWorldCoordinates.x, "y": imagePointInWorldCoordinates.y, "rotation": boss.rotation,"power":4500})
        //entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Bullet02.qml"), {"x": imagePointInWorldCoordinates.x+40, "y": imagePointInWorldCoordinates.y, "rotation": boss.rotation,"power":8900})
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket2.qml"), {"x": imagePointInWorldCoordinates.x+75, "y": imagePointInWorldCoordinates.y, "rotation": boss.rotation,"power":3900})
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket2.qml"), {"x": imagePointInWorldCoordinates.x+90, "y": imagePointInWorldCoordinates.y, "rotation": boss.rotation,"power":3800})
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket2.qml"), {"x": imagePointInWorldCoordinates.x+105, "y": imagePointInWorldCoordinates.y, "rotation": boss.rotation,"power":3600})

        //entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket2.qml"), {"x": imagePointInWorldCoordinates.x, "y": imagePointInWorldCoordinates.y, "rotation": boss.rotation})
    }
    function fireDo2(){
         var imagePointInWorldCoordinates = mapToItem(level,monsterImage.imagePoints[0].x, monsterImage.imagePoints[0].y)
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket1.qml"), {"x": imagePointInWorldCoordinates.x-40, "y": imagePointInWorldCoordinates.y-75, "rotation": boss.rotation,"power":5900})
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket1.qml"), {"x": imagePointInWorldCoordinates.x+40, "y": imagePointInWorldCoordinates.y-75, "rotation": boss.rotation,"power":5900})
    }

    function fireDo3(){
         var imagePointInWorldCoordinates = mapToItem(level,monsterImage.imagePoints[0].x, monsterImage.imagePoints[0].y)
        //entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Bullet02.qml"), {"x": imagePointInWorldCoordinates.x-40, "y": imagePointInWorldCoordinates.y, "rotation": boss.rotation,"power":10900})
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Bullet02.qml"), {"x": imagePointInWorldCoordinates.x, "y": imagePointInWorldCoordinates.y, "rotation": boss.rotation,"power":10900})
    }

    //x: utils.generateRandomValueBetween(monsterImage.width, scene.width - monsterImage.width-20)
    //anchors.horizontalCenter: parent.horizontalCenter


    BoxCollider {
        id:boxCollider

        anchors.fill: monsterImage // make the collider as big as the image
        collisionTestingOnlyMode: true // use Box2D only for collision detection, move the entity with the NumberAnimation above
        fixture.onBeginContact: {

            // if the collided type was a projectile, both can be destroyed and the player gets a point
            var collidedEntity = other.getBody().target
            console.debug("collided with entity", collidedEntity.entityType)
            // monsters could also collide with other monsters because they have a random speed - alternatively, collider categories could be used
            if(collidedEntity.entityType === "rocket") {

                if(monsterImage.visible){
                    health-=collidedEntity.boom
                }

                //monstersDestroyed++
                // remove the projectile entity
                collisionParticleEffect.start()
                collidedEntity.removeEntity()
            }
            if(collidedEntity.entityType === "plane") {

                collisionSound.play()
                collisionParticleEffect.start()
                if(monsterImage.visible){
                    health-=10
                }
            }
        }
        SoundEffect {
          id: collisionSound
          //source: "../../assets/img/snd/boxCollision.wav"
          source: "../../assets/wav/exploPop.wav"
        }

        Particle {
          id: collisionParticleEffect
          // make the particles float independent from the entity position - this would be the default setting, but for making it clear it is added explicitly here as well
          positionType: 0
          //fileName: "../../assets/particle/j1.json"
          fileName: "../../assets/particle/SmokeParticle.json"//fileName: "../../assets/particle/SmokeParticle.json"
          //fileName: "../assets/snd/boxCollision.wav"
        }

    }

    onHealthChanged: {
        if(health<100){
            //timer.interval=320
            t3.running=true
            timer.running=false
        }
        if(health<=80){
            timer.interval=80
            xMove.running=true
            yMove.running=true
        }
        if(health<=50){
            timer.running=true
            timer.interval=120
        }

        if(health<=0){
            collisionSound.play()

            monsterImage.visible=false
            boxCollider.visible=false
            sprites.visible=true
            hitted.start()
        }
    }

    Timer {
        id: hitted
        interval: 500 // a new target(=monster) is spawned every second
        onTriggered: {
            boss.removeEntity()
        }
    }


    SpriteSequence {
        id: sprites
        width: 560
        height: 560
        anchors.centerIn: monsterImage
        visible: false
        /*
        Component.onCompleted: {
            timer.start()
        }*/

        Sprite {
            name: "bomb1"
            source: "../../assets/img/enemyAmmoExplo00.png"
            to: { "bomb2": 1 }
            frameDuration: 200
        }
        Sprite {
            name: "bomb2"
            source: "../../assets/img/enemyAmmoExplo01.png"
            to: { "bomb3": 1 }
            frameDuration: 200
        }
        Sprite {
            name: "bomb3"
            source: "../../assets/img/enemyAmmoExplo02.png"
            to: { "bomb4": 1 }
            frameDuration: 200
        }
        Sprite {
            name: "bomb4"
            source: "../../assets/img/enemyAmmoExplo03.png"
            to: { "bomb5": 1 }
            frameDuration: 200
        }
        Sprite {
            name: "bomb5"
            source: "../../assets/img/enemyAmmoExplo04.png"
            to: { "bomb1": 1 }
            frameDuration: 200
        }

    }

}

