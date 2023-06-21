import QtQuick 2.0
import Felgo 3.0
import "../scene"


EntityBase {
    id: plane
    // the enityId should be set by the level file!
    entityType: "plane"

    property alias inputActionsToKeyCode: twoAxisController.inputActionsToKeyCode
    property alias image: image

    property int health: 10

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
        height: 55

        anchors.centerIn: parent

        density: 0.02
        friction: 0.4
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

            if(collidingType === "monster" ||
                    collidingType === "rocket"){
                    health --;
            }
            //var
            /*
            console.debug("car contact with: ", other, body, component)
            console.debug("car collided entity type:", collidingType)

            console.debug("car contactNormal:", contactNormal, "x:", contactNormal.x, "y:", contactNormal.y)
            */
        }
    }
    Timer {
        id: timeOver
        running: false//scene.visible == true && splashFinished // only enable the creation timer, when the gameScene is visible
        interval: 580 // a new target(=monster) is spawned every second
        onTriggered: gameOver()
    }

    onHealthChanged: {
        if(health==1||health==2){
            collisionSound.play()
        }
        if(health==0){
            image.visible=false
            bombEffect.visible=true
            timeOver.running=true
        }
    }

    function handleInputAction(action) {
        if( action === "fire") {
            // x&y of this component are 0..
            console.debug("creating weapon at current position x", plane.x, "y", plane.y)
            console.debug("image.imagePoints[0].x:", image.imagePoints[0].x, ", image.imagePoints[0].y:", image.imagePoints[0].y)
            //collisionSound.play()
            // this is the point that we defined in Car.qml for the rocket to spawn
            var imagePointInWorldCoordinates = mapToItem(level,image.imagePoints[0].x, image.imagePoints[0].y)
            console.debug("imagePointInWorldCoordinates x", imagePointInWorldCoordinates.x, " y:", imagePointInWorldCoordinates.y)

            // create the rocket at the specified position with the rotation of the car that fires it
            entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket.qml"), {"x": imagePointInWorldCoordinates.x-15, "y": imagePointInWorldCoordinates.y, "rotation": plane.rotation})

            entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket.qml"), {"x": imagePointInWorldCoordinates.x+15, "y": imagePointInWorldCoordinates.y, "rotation": plane.rotation})
        }
    }
    function fireDo() {
        var imagePointInWorldCoordinates = mapToItem(level,image.imagePoints[0].x, image.imagePoints[0].y)
        console.debug("imagePointInWorldCoordinates x", imagePointInWorldCoordinates.x, " y:", imagePointInWorldCoordinates.y)
        collisionSound.play()
        // create the rocket at the specified position with the rotation of the car that fires it
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket.qml"), {"x": imagePointInWorldCoordinates.x-15, "y": imagePointInWorldCoordinates.y, "rotation": plane.rotation})

        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("Rocket.qml"), {"x": imagePointInWorldCoordinates.x+15, "y": imagePointInWorldCoordinates.y, "rotation": plane.rotation})

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

    /*
    onStateChanged: {
        if(health<=0){
            console.log("you are failed !")
            car.removeEntity();
        }
    }*/
}
