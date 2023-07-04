import QtQuick 2.0
import Felgo 3.0

Props {
    id: damageprop
    entityType:"DamageProp"
    Image{
         id:damageImage
         source: "../../assets/img/damage.png"
         anchors.fill: parent
    }
    RotationAnimation {
            id: rotationAnimation
            running: true
            target: damageImage
            property: "rotation"
            from: 0
            to: 360 // 旋转到的角度
            duration: 1000 // 动画持续时间（毫秒）
            loops: Animation.Infinite // 控制动画是否循环
        }
}

