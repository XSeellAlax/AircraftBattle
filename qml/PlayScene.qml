/*
fuction: the scene of the game
author: zouyujie
date: 2023.6.13
*/
import QtQuick 2.0
import Felgo 3.0
import "common"

// EMPTY SCENE

Scene {
    id: scene
    width: map.picture.width
    height: map.picture.height

    //background
    Map { id: map; anchors.horizontalCenter: parent.horizontalCenter; Component.onCompleted: { switch_map(5) } }
}
