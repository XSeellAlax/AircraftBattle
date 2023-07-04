import QtQuick 2.0
import Felgo 3.0
import "../scene"
EntityBase {
    id: monster
    entityType: "monster" // required for removing all of these entities when the game is lost
    property alias monsterImage: monsterImage
    property alias collider: boxCollider
    property alias exploreW: sprites.width
    property alias exploreH: sprites.height
    property alias hitted: hitted // be hitted
    property int health: 6
    property int score: 1
    property int boom: 1
    //rotation: 90

    MultiResolutionImage {
        id: monsterImage
        source: "../../assets/img/enemy.png"
        anchors.fill: parent

        property list<Item> imagePoints: [
            // this imagePoint can be used for creation of the rocket
            // it must be far enough in front of the car that they don't collide upon creation
            // the +30 might have to be adapted if the size of the rocket is changed
            Item {x:monsterImage.width/2-width/2}
        ]
    }

    x: utils.generateRandomValueBetween(monsterImage.width, scene.width - monsterImage.width-20)



    BoxCollider {
        id:boxCollider

        anchors.fill: monsterImage // make the collider as big as the image
        collisionTestingOnlyMode: true // use Box2D only for collision detection, move the entity with the NumberAnimation above

        fixture.onBeginContact: {

            // if the collided type was a projectile, both can be destroyed and the player gets a point
            var collidedEntity = other.getBody().target
            // monsters could also collide with other monsters because they have a random speed - alternatively, collider categories could be used
            if(collidedEntity.entityType === "rocket") {

                health-=collidedEntity.boom
                //monstersDestroyed++
                // remove the projectile entity
                collisionParticleEffect.start()
                collidedEntity.removeEntity()
            }
            if(collidedEntity.entityType === "plane") {

                collisionSound.play()
                collisionParticleEffect.start()
                health=0
                // remove the monster
                //monster.removeEntity()
            }
            if(collidedEntity.entityType === "wall") {
                // remove the monster
                monster.removeEntity()
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
        if(health<=0){
            collisionSound.play()

            monsterImage.visible=false
            boxCollider.visible=false
            sprites.visible=true
            level.score+=score
            hitted.start()
        }
    }

    Timer {
        id: hitted
        interval: 300 // a new target(=monster) is spawned every second
        onTriggered: {
            monster.removeEntity()
        }
    }


    SpriteSequence {
        id: sprites
        width: 100
        height: 100
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
