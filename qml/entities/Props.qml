import QtQuick 2.0
import Felgo 3.0
import "../scene"
EntityBase {
    id: props
    entityType: "props" // required for removing all of these entities when the game is lost
    //property alias monsterImage: propsImage
    //property int health: 6
    //rotation: 270
    property alias propsImage: propsImage
    MultiResolutionImage {
        id: propsImage
        source: "../../assets/img/blood.png"
        /*
        property list<Item> imagePoints: [
            // this imagePoint can be used for creation of the rocket
            // it must be far enough in front of the car that they don't collide upon creation
            // the +30 might have to be adapted if the size of the rocket is changed
            Item {x: monsterImage.width/2+30}
        ]*/
    }

    x: utils.generateRandomValueBetween(propsImage.width, scene.width - propsImage.width-20)

    NumberAnimation on y {
        //from: -monsterImage.height // move the monster to the left side of the screen
        from: 0
        to: scene.height // start at the right side

        duration: utils.generateRandomValueBetween(3000, 5000) // vary animation duration between 2-4 seconds for the 480 px scene width
        onStopped: {
            console.debug("props reached base - change to gameover scene because the player lost")
            // changeToGameOverScene(false)
        }
    }



    BoxCollider {//
        id:boxCollider

        anchors.fill: propsImage // make the collider as big as the image
        collisionTestingOnlyMode: true // use Box2D only for collision detection, move the entity with the NumberAnimation above
        fixture.onBeginContact: {

            // if the collided type was a projectile, both can be destroyed and the player gets a point
            var collidedEntity = other.getBody().target
            console.debug("collided with entity", collidedEntity.entityType)
            // monsters could also collide with other monsters because they have a random speed - alternatively, collider categories could be used

            if(collidedEntity.entityType === "plane") {

                collisionSound.play()

               // collisionParticleEffect.start()
                // remove the props
                props.removeEntity()
            }
            if(collidedEntity.entityType === "wall") {
                // remove the props
                props.removeEntity()
            }
        }
        SoundEffect {
          id: collisionSound
          //source: "../../assets/img/snd/boxCollision.wav"
          source: "../../assets/wav/props.wav"
        }

//        Particle {
//          id: collisionParticleEffect
//          // make the particles float independent from the entity position - this would be the default setting, but for making it clear it is added explicitly here as well
//          positionType: 0
//          //fileName: "../../assets/particle/j1.json"
//          fileName: "../../assets/particle/FireParticle.json"//fileName: "../../assets/particle/SmokeParticle.json"
//          //fileName: "../assets/snd/boxCollision.wav"
//        }

    }


    SpriteSequence {
        id: sprites
        width: 90
        height: 90
        anchors.centerIn: propsImage
        visible: false
        /*
        Component.onCompleted: {
            timer.start()
        }*/

        Sprite {
            name: "bomb1"
            source: "../../assets/img/powerUpTex.png"
            to: { "bomb2": 1 }
            frameDuration: 200
        }
//        Sprite {
//            name: "bomb2"
//            source: "../../assets/img/enemyAmmoExplo01.png"
//            to: { "bomb3": 1 }
//            frameDuration: 200
//        }
//        Sprite {
//            name: "bomb3"
//            source: "../../assets/img/enemyAmmoExplo02.png"
//            to: { "bomb4": 1 }
//            frameDuration: 200
//        }
//        Sprite {
//            name: "bomb4"
//            source: "../../assets/img/enemyAmmoExplo03.png"
//            to: { "bomb5": 1 }
//            frameDuration: 200
//        }
//        Sprite {
//            name: "bomb5"
//            source: "../../assets/img/enemyAmmoExplo04.png"
//            to: { "bomb1": 1 }
//            frameDuration: 200
//        }

    }




}
