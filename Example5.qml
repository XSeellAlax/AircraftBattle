import QtQuick
import QtQuick.Particles 2.12

Item {
    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    ParticleSystem {
        id: particleSystem
    }

    ImageParticle {
        system: particleSystem
        source: "qrc:/img/bullet_11.png"
    }

    Emitter {
        system: particleSystem
        //width: 20; height: 20
        emitRate: 8
        size: 20

        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        lifeSpan: 3000

        velocity: AngleDirection {
            angle: -90
            magnitude: 400
        }

    }
}
