import QtQuick 2.0
import Felgo 3.0

EntityBase {
    entityType: "projectile"

    MultiResolutionImage {
        id: monsterImage
        source: "../assets/heroAmmoFlash02.png"
    }

    // these values can then be set when a new projectile is created in the MouseArea below
    property point destination
    property int moveDuration

    PropertyAnimation on x {
        from: player.x
        to: destination.x
        duration: moveDuration
    }

    PropertyAnimation on y {
        from: player.y
        to: destination.y
        duration: moveDuration
    }

    BoxCollider {
        anchors.fill: monsterImage
        collisionTestingOnlyMode: true
    }
}// EntityBase
