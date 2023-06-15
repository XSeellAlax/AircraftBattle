import QtQuick 2.0
import Felgo 3.0

EntityBase {
    entityType: "monster" // required for removing all of these entities when the game is lost

    MultiResolutionImage {
        id: monsterImage
        source: "../assets/enemy.png"
    }

    x: utils.generateRandomValueBetween(monsterImage.width, scene.width - monsterImage.implicitWidth)

    NumberAnimation on y {
        from: -monsterImage.height // move the monster to the left side of the screen
        to: scene.height // start at the right side

        duration: utils.generateRandomValueBetween(2000, 4000) // vary animation duration between 2-4 seconds for the 480 px scene width
        onStopped: {
            console.debug("monster reached base - change to gameover scene because the player lost")
           // changeToGameOverScene(false)
        }
    }

    BoxCollider {
        anchors.fill: monsterImage // make the collider as big as the image
        collisionTestingOnlyMode: true // use Box2D only for collision detection, move the entity with the NumberAnimation above
        fixture.onBeginContact: {

            // if the collided type was a projectile, both can be destroyed and the player gets a point
            var collidedEntity = other.getBody().target
            console.debug("collided with entity", collidedEntity.entityType)
            // monsters could also collide with other monsters because they have a random speed - alternatively, collider categories could be used
            if(collidedEntity.entityType === "projectile") {
                monstersDestroyed++
                // remove the projectile entity
                collidedEntity.removeEntity()
                // remove the monster
                removeEntity()
            }
        }
    }// BoxCollider
}// EntityBase
