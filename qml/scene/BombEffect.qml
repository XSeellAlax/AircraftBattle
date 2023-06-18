/*
fuction: explosion effect
author: zouyujie
date: 2023.6.18
*/
import QtQuick 2.0
import Felgo 3.0

Item {
    id: bomb
    anchors.fill: parent
    visible: false

    //for just play 1 time
    Timer {
        id: timer
        interval: 1000
        onTriggered: {
            sprites.visible = false
        }
    }

    SpriteSequence {
        id: sprites
        width: 30
        height: 30
        Component.onCompleted: {
            timer.start()
        }

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
