/*
function: sprite animation of three bird
author: zouyujie
date: 2023.6.18
*/
import QtQuick 2.0
import Felgo 3.0

Item {
    id: threeBird
    anchors.fill: parent
    clip: true
    visible: false

    property int toPosition: parent.width

    //just running the function
    property var method: restart

    //restart the bird animation
    function restart() { visible = true; spriteSequence1.x = -122; spriteSequence2.x = -78; spriteSequence3.x = -34; m_parallel.restart() }
    function setVisible() { visible = false }

    ParallelAnimation {
        id: m_parallel
        running: true

        NumberAnimation {
            target: spriteSequence1
            property: "x"
            to: toPosition
            duration: 5000
        }
        NumberAnimation {
            target: spriteSequence2
            property: "x"
            to: toPosition + 44
            duration: 5000
        }
        NumberAnimation {
            target: spriteSequence3
            property: "x"
            to: toPosition + 88
            duration: 5000
        }

        onStopped: {
            spriteSequence1.x = -122
            spriteSequence2.x = -78
            spriteSequence3.x = -34
            m_parallel.restart()
        }
    }

    SpriteSequence {
        id: spriteSequence1
        height: 24
        width: 34
        x: -122

        Sprite {
            name: "bird"
            source: "../../assets/img/birdSprite.png"
            frameCount: 3
            frameRate: 6
            frameWidth: 34
            frameHeight: 24
            //to: {  "land": 1 }
        }
    }

    SpriteSequence {
        id: spriteSequence2
        height: 24
        width: 34
        x: -78

        Sprite {
            name: "bird"
            source: "../../assets/img/birdSprite.png"
            frameCount: 3
            frameRate: 6
            frameWidth: 34
            frameHeight: 24
            //to: {  "land": 1 }
        }
    }

    SpriteSequence {
        id: spriteSequence3
        height: 24
        width: 34
        x: -34

        Sprite {
            name: "bird"
            source: "../../assets/img/birdSprite.png"
            frameCount: 3
            frameRate: 6
            frameWidth: 34
            frameHeight: 24
            //to: {  "land": 1 }
        }
    }
}
