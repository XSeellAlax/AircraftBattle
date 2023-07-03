/*
fuction: flame
author: zouyujie
date: 2023.7.3
*/
import QtQuick
import QtQuick.Particles

Rectangle {
    anchors.fill: parent
    color: "#222222"

    ParticleSystem {
        id: particleSystem
    }

    ImageParticle {
        groups: ["flame"]
        source: "qrc:///particleresources/glowdot.png"
        color: "#11ff400f"
        colorVariation: 0.1
        system: particleSystem
    }

    Emitter {
        x: 50
        group: "flame"

        emitRate: 120
        lifeSpan: 1200
        size: 20
        endSize: 10
        sizeVariation: 10
        acceleration: PointDirection { y: 40 }
        velocity: AngleDirection { angle: 90; magnitude: 20; angleVariation: 22; magnitudeVariation: 5 }
        system: particleSystem
    }

    Emitter {
        x: 100
        group: "flame"

        emitRate: 120
        lifeSpan: 1200
        size: 20
        endSize: 10
        sizeVariation: 10
        acceleration: PointDirection { y: 40 }
        velocity: AngleDirection { angle: 90; magnitude: 20; angleVariation: 22; magnitudeVariation: 5 }
        system: particleSystem
    }

}
