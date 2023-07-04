import QtQuick 2.0
 import QtQuick.Controls 2.15
import Felgo 3.0
import "entities"

Item {
    id: level
    width: parent.width
    height: parent.height

    property alias timeControl: timer.running
    property int  score: 0
    property alias myPlane: m_myPlane

    property list<Component> comPoints: [
        // this imagePoint can be used for creation of the rocket
        // it must be far enough in front of the car that they don't collide upon creation
        // the +30 might have to be adapted if the size of the rocket is changed
        Component{ id:pro00;Props00{}},Component{ id:pro01;Props01{}},Component{ id:pro02;Props02{}},Component{ id:pro03;Props03{}}
    ]


    // use this to insert the input action (which car should fire and which to steer) to the right car
    //property alias player_red: car_red
    //property alias player_blue: plane_main

    // background of the level

    Component.onCompleted: {
        //Sleep(100)

        //timer.running=true
        //timer.start()
    }

    Plane {
        id: m_myPlane
        objectName: "plane_main"
        variationType: "mainplane"
        // rotation in degrees clockwise
        rotation: 270
        x: parent.width/2-width/2; y: parent.height+360;
        inputActionsToKeyCode: {
            "up": Qt.Key_W,
            "down": Qt.Key_S,
            "left": Qt.Key_A,
            "right": Qt.Key_D,
            "fire": Qt.Key_Space
        }
        onGameOver: {
            gameFail()

        }
    }
    /*
    Image {
        id: playgroundImage
        source: "../assets/img/playground.jpg"
        //source: "../assets/img/playbg.jpeg"
        anchors.fill: parent
    }*/

    /*
    Car {
        id: car_red
        objectName: "car_red"
        variationType: "carRed"
        x: 90
        y: 200
        // rotation in degrees clockwise
        rotation: 90

    }*/

    /*
    Plane {
        id: plane_main
        objectName: "plane_main"
        variationType: "mainplane"
        x: 320
        y: 920
        // rotation in degrees clockwise
        rotation: 270

        //image.source: "../assets/img/car_blue.png"

        inputActionsToKeyCode: {
            "up": Qt.Key_W,
            "down": Qt.Key_S,
            "left": Qt.Key_A,
            "right": Qt.Key_D,
            "fire": Qt.Key_Space
        }
    }*/

    //
    //create Enemy aircraft
    Component {
        id: enemyComponent
        Enemy00 {
            id: monsters
        }
    }
    Component {
        id: enemyComponent01
        Enemy01{
            id: monster01s
        }
    }
    Component {
        id: enemyComponent02
        Enemy02{
            id: monster02s
        }
    }
    Boss02 {
        id: boss
        y:90
        visible: false
        rotation: 90
        onEntityDestroyed: gameWon()
    }

    Image {
        id: name
        source: "../assets/img/heidong.png"
        anchors.centerIn: parent
        visible: boss.visible
        z:-1
        SequentialAnimation on opacity {
            loops: Animation.Infinite
            PropertyAnimation {
                to: 0.35
                duration: 3000 // 1 second for fade out
            }
            PropertyAnimation {
                to: 1.0
                duration: 3000 // 1 second for fade in
            }
        }
    }
    /*
    Component {
        id: bossCompent

    }*/

    Timer {
        id: timer
        running: false//scene.visible == true && splashFinished // only enable the creation timer, when the gameScene is visible
        repeat: false
        interval: 1500 // a new target(=monster) is spawned every second
        onTriggered: {
            t0.running=true
            t1.running=true
            t2.running=true
            //b3.running=true
            //entityManager.createEntityFromComponent(boss3Component)
        }
    }
    Timer {
        id: t0
        running: false//scene.visible == true && splashFinished // only enable the creation timer, when the gameScene is visible
        repeat: true
        interval: 2500 // a new target(=monster) is spawned every second
        onTriggered: addTarget()
    }


    Timer {
        id: t1
        running: false
        repeat: true
        interval: 2500
        onTriggered: {
            entityManager.createEntityFromComponent(enemyComponent01)
        }

    }
    Timer {
        id: t2
        running: false
        repeat: true
        interval: 10000
        onTriggered: {
            entityManager.createEntityFromComponent(enemyComponent02)
        }

    }/*
    Timer {
        id: b3
        running: false
        //repeat: true
        interval: 1000
        onTriggered: {
            entityManager.createEntityFromComponent(boss3Component)
        }

    }*/


    function addTarget() {
        //console.debug("create a new monster")
        score++

        entityManager.createEntityFromComponent(enemyComponent)
    }


    /*
    Rectangle {
        id: gameWon
        Image {
            id: won
            source: "../assets/img/gameWon.png"
            anchors.fill: parent
        }
        width: 650
        height: 450
        visible: false
        //opacity: 0.5
        anchors.centerIn: parent

    }*/


    Wall {
        id: border_bottom

        height: 10
        anchors {
            left: parent.left
            right: parent.right
            top:  parent.bottom
        }
    }



    Wall {
        id: border_top

        height: 10
        anchors {
            //top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.top
            bottomMargin: 50
        }
    }

    /*
    Rectangle {
        Text {
            id: scoreText
            text: qsTr("Score: "+ score)
            anchors.centerIn: parent
            //Font.pixelSize: 20

        }
        anchors.horizontalCenter: parent.horizontalCenter
        anchors{
            top: parent.top

        }
        color: "#ff0773"
        opacity: 0.5
        width: 80
        height:50
        //radius: 20
    }*/

    Text {
        id: scoreText
        text: qsTr("Score: "+ score)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:parent.top
        color: "white"
        opacity: 0.7
        font.pixelSize: 20
        //Font.pixelSize: 20

    }

    Text {
        id: wonText
        text: qsTr("游戏胜利")
        color: "gold"
        //Font.pixelSize: 50
        font.pixelSize: 100
        visible: false
        opacity: 0.8
        anchors.centerIn: parent

    }

    Text {
        id: failText
        text: qsTr("游戏失败")
        color: "gray"
        font.pixelSize: 100
        //visible: false
        opacity: 0.5
        visible: false
        anchors.centerIn: parent
        font.family: "Arial" // 设置字体系列为 Arial
        font.bold: true // 设置为粗体
    }

    Text {
        id: bossComing
        text: qsTr("BOSS来临")
        //警告:
        color: "red"
        //Font.pixelSize: 50
        font.pixelSize: 60
        visible: false
        //opacity: 0.8
        anchors.centerIn: parent
        SequentialAnimation on opacity {
            loops: Animation.Infinite
            PropertyAnimation {
                to: 0
                duration: 1000 // 1 second for fade out
            }
            PropertyAnimation {
                to: 1
                duration: 1000 // 1 second for fade in
            }
        }
    }
    Rectangle {
        id: bossRec
        //text: qsTr("BOSS来临")
        //警告:
        color: "red"
        //Font.pixelSize: 50

        visible: false
        //opacity: 0.8
        anchors.fill:parent
        SequentialAnimation on opacity {
            loops: Animation.Infinite
            PropertyAnimation {
                to: 0
                duration: 500 // 1 second for fade out
            }
            PropertyAnimation {
                to: 0.2
                duration: 500 // 1 second for fade in
            }
        }
    }
    Rectangle {
        id: bossHealthSplide
        visible: boss.visible
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 25
        height: 15
        width: 450
        opacity: 0.6
        //radius: 200
        Rectangle{
            id: bossHealth
            color: "red"
            height: 10
            radius: 200
            anchors.verticalCenter: parent.verticalCenter
            width: boss.health/200 * 450
            SequentialAnimation on width {
                //id: yMove
                running: boss.visible//boss.visible
                //loops: Animation.Infinite
                PropertyAnimation {
                    from:0
                    to: 450
                    duration: 2500 // 1 second for fade in
                }
            }
        }
    }
    Rectangle {
        id: planeHealthSplide
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.right: parent.right
        //visible: score>0
        //anchors.rightMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        height: 350
        width: 50
        Image {
            source: "../assets/img/darken.png"
            anchors.fill: parent
        }
        //radius: 200
        Rectangle{
            id: planeHealth
            color: "green"
            width: 45
            //radius: 200
            opacity: 0.4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            height:  m_myPlane.health/100 * 350/*
            SequentialAnimation on height {
                //id: yMove
                running: score>=1//boss.visible
                //loops: Animation.Infinite
                PropertyAnimation {
                    from:0
                    to: 200
                    duration: 2500 // 1 second for fade in
                }
            }*/
            onHeightChanged: {
                if(height<=80){
                    color="yellow"
                }else {
                    color="green"
                }

                if(height<=30){
                    color="red"
                }
            }
        }
    }
    Rectangle {
        id: planeDefensesSplide
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.left: parent.left
        //visible: score>=0
        //anchors.leftMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        height: 350
        width: 50

        Image {
            source: "../assets/img/darken.png"
            anchors.fill: parent
        }
        //radius: 200
        Rectangle{
            id: planedefenses
            color: "blue"
            width: 45
            opacity: 0.4
            //radius: 200
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            height:  m_myPlane.defenses/50 * 350/*
            SequentialAnimation on height {
                //id: yMove
                running: score>=1
                //loops: Animation.Infinite
                PropertyAnimation {
                    from:0
                    to: 200
                    duration: 2500 // 1 second for fade in
                }
            }*/
        }
    }
    Timer {
        id: proTime
        running: true
        repeat: true
        interval: 5200
        onTriggered: {
            var num = Math.floor(utils.generateRandomValueBetween(0,4))
            console.log(num)
            entityManager.createEntityFromComponent(comPoints[num])

        }
    }


    Timer {
        id: bossControl
        running: false//scene.visible == true && splashFinished // only enable the creation timer, when the gameScene is visible
        interval: 5000 // a new target(=monster) is spawned every second
        onTriggered: {
            bossComing.visible=false
            bossRec.visible=false
        }
    }

    Timer {
        id: gameOverTime
        running: false
        interval: 8000
        onTriggered: {/*
            playSceneLoader.active = false
            menuScene.opacity = 1
            gameWindow.activeScene = menuScene
            //restore posititon by animation
            menuScene.sequence_restore.running = true*/
            playSceneLoader.active = false
            menuScene.visible = true
            gameWindow.activeScene = menuScene
            //restore posititon by animation
            menuScene.sequence_restore.running = true
        }
    }

    Timer {
        id: gameWonTime
        running: false
        interval: 5000
        onTriggered: {
            playSceneLoader.active = false
            menuScene.visible = true
            gameWindow.activeScene = menuScene
            //restore posititon by animation
            menuScene.sequence_restore.running = true
        }
    }


    onScoreChanged: {
        if(score>=200){
            t0.running=false
            t1.running=false
            t2.running=false
            //entityManager.createEntityFromComponent(bossCompent)
            boss.visible=true
            //bossRec.visible=true
            bossComing.visible=true
            bossControl.running=true
        }
    }

    function gameFail() {
        failText.visible=true
        gameOverTime.running=true
    }

    function gameWon() {
        wonText.visible=true
        gameWonTime.running=true
    }

    Wall {
        id: border_left
        width: 20
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }
    }

    Wall {
        id: border_right
        width: 20
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
        }
    }
}
