import QtQuick 2.0
import Felgo 3.0
import QtQuick.Particles 2.12
import "../scene"


EntityBase {
    id: plane
    // the enityId should be set by the level file!
    entityType: "plane"

    property alias inputActionsToKeyCode: twoAxisController.inputActionsToKeyCode
    property alias image: image

    property int health: 100
    property int defenses: 50

    property bool test1: false

    property bool test2: false

    signal gameOver()


    // gets accessed to insert the input when touching the HUDController
    property alias controller: twoAxisController

    readonly property real forwardForce: 20000 * world.pixelsPerMeter

    Component.onCompleted: {
        //console.debug("car.onCompleted()")
        //console.debug("car.x:", x)
        var mapped = mapToItem(world.debugDraw, x, y)
        //time2.running=true
        //console.debug("car.x world:", mapped.x)
    }

    Image {
        id: image
        source: "../../assets/img/hero.png"

        anchors.centerIn: parent
        width: boxCollider.width
        height: boxCollider.height

        property list<Item> imagePoints: [
            // this imagePoint can be used for creation of the rocket
            // it must be far enough in front of the car that they don't collide upon creation
            // the +30 might have to be adapted if the size of the rocket is changed
            Item {x: image.width/2+30}
        ]

    }

    Image {
        id: image2
        source: "../../assets/img/heroSuper.png"
        visible: false

        anchors.centerIn: parent
        width: 100//boxCollider.width*1.5
        height: 100

    }
    Rectangle {
        color: "yellow"
        width: 95
        height: 95
        radius: 50
        visible: defenses!=0
        anchors.centerIn: parent
        z: 999
        Image {
            id: name
            source: "../../assets/img/heroSuper.png"
            anchors.fill: parent
        }
        SequentialAnimation on opacity {
            loops: Animation.Infinite
            PropertyAnimation {
                to: 0.15
                duration: 800 // 1 second for fade out
            }
            PropertyAnimation {
                to: 0.48
                duration: 800 // 1 second for fade in
            }
        }

        ParticleSystem {
            id: particleSystem
        }

        ImageParticle {
            groups: ["B"]
            //anchors.fill: parent
            source: "qrc:///particleresources/star.png"
            //color:"#10FF10"
            color: "gold"
            greenVariation: 0.8
            system: particleSystem
        }

        Emitter {
            group: "B"
            emitRate: 800
            lifeSpan: 450
            size: 32
            sizeVariation: 8
            //velocity: PointDirection{ x: 240; xVariation: 60 }
            velocity: PointDirection { x: -240; xVariation: 60 }
            y: 0
            x: 45
            width: 20
            height: 10
            system: particleSystem
        }

        Emitter {
            group: "B"
            emitRate: 800
            lifeSpan: 450
            size: 32
            sizeVariation: 8
            //velocity: PointDirection{ x: 240; xVariation: 60 }
            velocity: PointDirection { x: -240; xVariation: 60 }
            y: 85
            x: 45
            width: 20
            height: 10
            system: particleSystem
        }
    }

    /*
    RotationAnimation {
            id: rotationAnimation
            running: true
            target: image2
            property: "rotation"
            to: 360 // 旋转到的角度
            duration: 1000 // 动画持续时间（毫秒）
            loops: Animation.Infinite // 控制动画是否循环
        }*/


    // this is used as input for the BoxCollider force & torque properties
    TwoAxisController {
        id: twoAxisController

        // call the logic function when an input press (possibly the fire event) is received
        onInputActionPressed: handleInputAction(actionName)
    }

    BoxCollider {
        id: boxCollider

        // the image and the physics will use this size; this is important as it specifies the mass of the body! it is in respect to the world size
        width: 75
        height: 70
        groupIndex: -1

        anchors.centerIn: parent

        density: 0.02
        friction: 0.1
        restitution: 0.5
        body.bullet: true
        body.linearDamping: 10
        body.angularDamping: 15
        fixedRotation: true

        // this is applied every physics update tick
        force: Qt.point(twoAxisController.yAxis*forwardForce, twoAxisController.xAxis*forwardForce)
        //torque: twoAxisController.xAxis*2000 * world.pixelsPerMeter * world.pixelsPerMeter

        Component.onCompleted: {
            //console.debug("car.physics.x:", x)
            var mapped = mapToItem(world.debugDraw, x, y)
            //console.debug("car.physics.x world:", mapped.x)
        }

        fixture.onBeginContact: {
            var fixture = other
            var body = other.getBody()
            var component = other.getBody().target
            var collidingType = component.entityType

            if(collidingType==="monster"){
                hitted(component.boom)
            }
            if(component.entityType === "rocket2") {

                hitted(2)

                component.removeEntity()
            }
            if(component.entityType === "rocket1") {

                hitted(2)

                component.removeEntity()
            }
            if(component.entityType === "bullet") {

                hitted(component.boom)
                component.removeEntity()
            }
            if(component.entityType === "DamageProp") {

                test1=true
            }
            if(component.entityType === "MuchProp") {
                test2=true
            }

            if(component.entityType === "BloodProp") {

                health=100
            }
            if(component.entityType === "ShieldProp") {

                defenses=20
            }
            if(defenses<0){
                defenses=0
            }

            if(health<0){
                health=0
            }

        }
    }
    Timer {
        id: timeOver
        running: false//scene.visible == true && splashFinished // only enable the creation timer, when the gameScene is visible
        interval: 1080 // a new target(=monster) is spawned every second
        onTriggered: {
            gameOver()
            plane.visible=false

        }
    }

    Timer {
        id: willOver
        running: false
        interval: 450
        repeat: true
        onTriggered: {
            fireDo()
        }
    }

    onHealthChanged: {
        if(health==1||health==2){
            collisionSound.play()
        }
        if(health<=45){
           // willOver.running=true
        }

        if(health==0){
            image.visible=false
            bombEffect.visible=true
            timeOver.running=true
        }
    }


    Timer {
        id: test1Change
        running:test1
        interval: 7500
        onTriggered: {
            test1=false
        }
    }
    Timer {
        //id: test1Change
        running:test2
        interval: 8000
        onTriggered: {
            test2=false
        }
    }

    function handleInputAction(action) {
        if( action === "fire") {
            // x&y of this component are 0..

            // this is the point that we defined in Car.qml for the rocket to spawn
            var imagePointInWorldCoordinates = mapToItem(level,image.imagePoints[0].x, image.imagePoints[0].y)
            //console.debug("imagePointInWorldCoordinates x", imagePointInWorldCoordinates.x, " y:", imagePointInWorldCoordinates.y)

            // create the rocket at the specified position with the rotation of the car that fires it
            entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket.qml"), {"x": imagePointInWorldCoordinates.x-15, "y": imagePointInWorldCoordinates.y+45, "rotation": plane.rotation})

            entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket.qml"), {"x": imagePointInWorldCoordinates.x+15, "y": imagePointInWorldCoordinates.y+45, "rotation": plane.rotation})
            if(test1) {
                entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocketnew.qml"), {"x": imagePointInWorldCoordinates.x, "y": imagePointInWorldCoordinates.y, "rotation": plane.rotation})
            }
            if(test2) {
                entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("HeroAmmo02.qml"), {"x": imagePointInWorldCoordinates.x-35, "y": imagePointInWorldCoordinates.y+80, "rotation": plane.rotation})
                entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("HeroAmmo02.qml"), {"x": imagePointInWorldCoordinates.x+35, "y": imagePointInWorldCoordinates.y+80, "rotation": plane.rotation})
            }
        }
    }
    function fireDo() {
        var imagePointInWorldCoordinates = mapToItem(level,image.imagePoints[0].x, image.imagePoints[0].y)
        console.debug("imagePointInWorldCoordinates x", imagePointInWorldCoordinates.x, " y:", imagePointInWorldCoordinates.y)
        //collisionSound.play()
        // create the rocket at the specified position with the rotation of the car that fires it
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket.qml"), {"x": imagePointInWorldCoordinates.x-25, "y": imagePointInWorldCoordinates.y, "rotation": plane.rotation})
        //entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket.qml"), {"x": imagePointInWorldCoordinates.x, "y": imagePointInWorldCoordinates.y, "rotation": plane.rotation})
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket.qml"), {"x": imagePointInWorldCoordinates.x+25, "y": imagePointInWorldCoordinates.y, "rotation": plane.rotation})
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocketnew.qml"), {"x": imagePointInWorldCoordinates.x, "y": imagePointInWorldCoordinates.y, "rotation": plane.rotation})

    }
    function hitted(amout){
        if(defenses>0){
            defenses-=amout
        }else{
            health-=amout
        }
    }

    BombEffect {
        id: bombEffect
        visible: false
        anchors.centerIn: parent
        width: 250
        height: 250
    }

    SoundEffect {
      id: collisionSound
      //source: "../../assets/img/snd/boxCollision.wav"
      source: "../../assets/wav/life_lose.wav"
    }
}

