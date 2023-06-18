import QtQuick 2.0
import Felgo 3.0

EntityBase {
    entityType: "projectile"
   // property alias projectileCreationSound:  projectileCreationSound
    MultiResolutionImage {
        id: monsterImage
        source: "../assets/heroAmmoFlash02.png"
    }

    // these values can then be set when a new projectile is created in the MouseArea below
    property point destination
    property int moveDuration

    x:player.x

    PropertyAnimation on y {
        from: player.y
        to:0
        //to: destination.y
        duration: 1000
        //duration: moveDuration
    }


    SpriteSequence {
          id: explosion
          x: 0
          y: 0
          running: false
          visible: false

          Sprite {
            source: "glitter.png"
            frameCount: 1
            duration:300
          }

          Sprite {
            source: "explo.png"
            frameCount: 1
            duration:300
          }

          Sprite {
            source: "enemyExplo.png"
            frameCount: 1
            duration:300
          }
        }
    BoxCollider {
        anchors.fill: monsterImage
        collisionTestingOnlyMode: true

        fixture.onBeginContact: {
            var fixture = other
            var body = other.getBody()
            var component = other.getBody().target
            var collidingType = component.entityType


            if(collidingType === "monster1" ||
                    collidingType === "rocket"){

            }

            //                    if(health==0){
            //                        car.destroy()
            //                        //car.removeEntity()
            //                    }
        }
    }

}// EntityBase
