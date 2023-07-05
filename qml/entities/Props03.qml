import QtQuick 2.0
import Felgo 3.0

Props {
    id: damageprop
    entityType:"MuchProp"
    Image{
         id:damageImage
         source: "../../assets/img/mine.png"
         anchors.fill: parent
    }
    Image {
        id: image
        source: "../../assets/img/superBomb.png"
        anchors.fill: parent
        z: -1
        SequentialAnimation on opacity {
            loops: Animation.Infinite
            PropertyAnimation {
                to: 0.5
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
            target: image
            property: "rotation"
            from: 0
            to: 360 // 旋转到的角度
            duration: 1000 // 动画持续时间（毫秒）
            loops: Animation.Infinite // 控制动画是否循环
        }
}
