import QtQuick 2.0

import Felgo 3.0

EntityBase {
    id: entity
    entityType: "rocket1"

    Component.onCompleted: {
        //console.debug("Rocket.onCompleted, width:", width);
        applyForwardImpulse();
    }

    property real angleDeg
    property int power: 7200

    property int dv: 1

    rotation: angleDeg

    BoxCollider {
        id: boxCollider

        width: 35
        height: 35

        groupIndex: -2

        anchors.centerIn: parent

        density: 0.003
        friction: 0.4
        restitution: 0.5

        body.fixedRotation: true

        //property var lastWall: null

        fixture.onBeginContact: {
            var fixture = other;
            var body = other.getBody();
            var otherEntity = body.target

            var collidingType = otherEntity.entityType

            if(collidingType==="rocket"){
                otherEntity.removeEntity()
                dv--;
                if(dv==0){
                    entity.removeEntity()
                }
            }

            if(collidingType === "wall") {
                entity.removeEntity()
                return
            }
        }

    }

    Image {
        id: image
        //source: "../../assets/img/rocket_cyan.png"
        source: "../../assets/img/rocket02.png"
        anchors.centerIn: parent
        width: boxCollider.width
        height: boxCollider.height
    }

    function applyForwardImpulse() {
        //var power = 4200
        var rad = entity.rotation / 180 * Math.PI

        //can't use body.toWorldVector() because the rotation is not instantly
        var localForward = Qt.point(power * Math.cos(rad), power * Math.sin(rad))

        boxCollider.body.applyLinearImpulse(localForward, boxCollider.body.getWorldCenter())
    }
}
