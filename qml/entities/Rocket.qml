import QtQuick 2.0

import Felgo 3.0

EntityBase {
    id: entity
    entityType: "rocket"

    Component.onCompleted: {
        //console.debug("Rocket.onCompleted, width:", width);
        applyForwardImpulse();
    }

    property real angleDeg
    property int boom: 1

    property alias image:image.source
    property alias box: boxCollider

    property int power: 1000

    rotation: angleDeg

    BoxCollider {
        id: boxCollider

        // the image and the physics will use this size; this is important as it specifies the mass of the body! it is in respect to the world size
        width: 40
        height: 5

        anchors.centerIn: parent

        density: 0.003
        friction: 0.4
        restitution: 0.5
        body.bullet: true
        collidesWith: Plane
        groupIndex: -1
        //collisionTestingOnlyMode: true
        // we prevent the physics engine from applying rotation to the rocket, because we will do it ourselves
        body.fixedRotation: true

        fixture.onBeginContact: {
            var fixture = other;
            var body = other.getBody();
            var otherEntity = body.target
            //collisionSound.play()

            // get the entityType of the colliding entity
            var collidingType = otherEntity.entityType

            if(collidingType === "wall") {
                entity.removeEntity()
                return
            }
        }

    }

    Image {
        id: image
        source: "../../assets/img/rocket2.png"
        anchors.centerIn: parent
        width: boxCollider.width
        height: boxCollider.height
    }

    function applyForwardImpulse() {

        var rad = entity.rotation / 180 * Math.PI

        //can't use body.toWorldVector() because the rotation is not instantly
        var localForward = Qt.point(power * Math.cos(rad), power * Math.sin(rad))

        boxCollider.body.applyLinearImpulse(localForward, boxCollider.body.getWorldCenter())
    }
}
