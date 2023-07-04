import QtQuick 2.0
import Felgo 3.0

Props {
    id: shieldprop
    entityType:"ShieldProp"
    Image{
    id:shieldImage
    source: "../../assets/img/powerUpShield.png"
    anchors.fill: parent
}
    Image {
        id: image
        source: "../../assets/img/heroSuper.png"
        anchors.fill: parent
        z: -1
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
