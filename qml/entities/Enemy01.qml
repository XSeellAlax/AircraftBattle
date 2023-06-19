import QtQuick 2.0
import Felgo 3.0
import "../"
Enemy {
    id: enemyNew1
    monsterImage.source: "../../assets/img/enemy04.png"
    width: 60
    height: 60

    health: 4
    //newX:utils.generateRandomValueBetween(monsterImage.width, scene.width - monsterImage.width-20)+10

    MovementAnimation {
        id: temp
        running: true
        target: enemyNew1
        property: "pos"
        velocity: Qt.point((m_myPlane.x-x)/2, (m_myPlane.y-height/2)/2)

    }
}

