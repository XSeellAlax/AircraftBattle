import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Particles 2.0

Item {
    anchors.fill: parent
    Rectangle {
        anchors.centerIn: parent
        width: 300
        height: 300
        color: "yellow"
        radius: 300
        Image {
            id: name
            source: "qrc:/img/heroSuper.png"
            anchors.fill: parent
        }

        SequentialAnimation on opacity {
            loops: Animation.Infinite
            PropertyAnimation {
                to: 0.15
                duration: 800 // 1 second for fade out
            }
            PropertyAnimation {
                to: 0.48
                duration: 800 // 1 second for fade in
            }
        }

        ParticleSystem {
            id: particleSystem
        }

        ImageParticle {
            groups: ["B"]
            //anchors.fill: parent
            source: "qrc:///particleresources/star.png"
            //color:"#10FF10"
            color: "gold"
            greenVariation: 0.8
            system: particleSystem
        }

        Emitter {
            group: "B"
            emitRate: 200
            lifeSpan: 1000
            size: 32
            sizeVariation: 8
            //velocity: PointDirection{ x: 240; xVariation: 60 }
            velocity: PointDirection { y: 240; yVariation: 60 }
            y: 150
            x: 0
            width: 20
            height: 10
            system: particleSystem
        }

        Emitter {
            group: "B"
            emitRate: 200
            lifeSpan: 1000
            size: 32
            sizeVariation: 8
            //velocity: PointDirection{ x: 240; xVariation: 60 }
            velocity: PointDirection { y: 240; yVariation: 60 }
            y: 150
            x: 280
            width: 20
            height: 10
            system: particleSystem
        }

//        Affector {
//            groups: ["B"]
//            y: 250
//            x: -5
//            width: 80
//            height: 80
//            once: true
//            //velocity: AngleDirection { angleVariation:20; magnitude: 72 }
//            system: particleSystem
//        }

//        Affector {
//            groups: ["B"]
//            y: 250
//            x: 295
//            width: 80
//            height: 80
//            once: true
//            velocity: AngleDirection { angleVariation:360; magnitude: 72 }
//            system: particleSystem
//        }
    }

}


