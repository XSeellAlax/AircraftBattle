import QtQuick 2.0
import Felgo 3.0

Props {
    id: damageprop
    entityType:"DamageProp"
    Image{
         id:damageImage
         source: "../../assets/img/mine.png"
         anchors.fill: parent
    }
    Rectangle {
        id: tangle
        color: "#89cff0"
        width: 55
        height: 55
        radius: 500
        z: -1
        anchors.centerIn: parent
        SequentialAnimation on opacity {
            loops: Animation.Infinite
            PropertyAnimation {
                to: 0.6
                duration: 1000 // 1 second for fade out
            }
            PropertyAnimation {
                to: 1
                duration: 1000 // 1 second for fade in
            }
        }
    }

    RotationAnimation {
            id: rotationAnimation
            running: true
            target: tangle
            property: "rotation"
            from: 0
            to: 360 // 旋转到的角度
            duration: 1000 // 动画持续时间（毫秒）
            loops: Animation.Infinite // 控制动画是否循环
        }
}

