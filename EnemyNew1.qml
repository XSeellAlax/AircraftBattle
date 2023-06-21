import QtQuick 2.0
import Felgo 3.0

Enemy {
    id: enemyNew1

    monsterImage.source: "../../assets/img/enemy01.png"

    MovementAnimation {
        id: temp
        running: true
        target: enemyNew1
        property: "pos"
        velocity: Qt.point((m_myPlane.x-getRandomX)/2, (m_myPlane.y-height/2)/2)
    }
}
