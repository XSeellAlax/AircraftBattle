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
    /*
    Image {
        id: image
        source: "../../assets/img/heroSuper.png"
        anchors.fill: parent
        z: -1
        SequentialAnimation on opacity {
            loops: Animation.Infinite
            PropertyAnimation {
                to: 0.3
                duration: 100 // 1 second for fade out
            }
            PropertyAnimation {
                to: 1
                duration: 100 // 1 second for fade in
            }
        }
    }*/
    Rectangle {
        id: image
        //source: "../../assets/img/heroSuper.png"
        anchors.centerIn: parent
        width: 60
        height: 60
        color: "gold"
        radius: 400
        z: 999
        SequentialAnimation on opacity {
            loops: Animation.Infinite
            PropertyAnimation {
                to: 0.1
                duration: 1000 // 1 second for fade out
            }
            PropertyAnimation {
                to: 0.4
                duration: 1000 // 1 second for fade in
            }
        }
    }


    /*
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
        */
}
