import QtQuick 2.0
import Felgo 3.0

EntityBase {
    property alias playerImage: playerImage

    entityType: "player"
    MultiResolutionImage {
        id: playerImage
        anchors.centerIn: parent
        anchors.bottom: scene.bottom
        anchors.bottomMargin: 40 // 距离底部 10 像素
        anchors.horizontalCenter: scene.horizontalCenter
        source: "../assets/hero.png"
    }


}
