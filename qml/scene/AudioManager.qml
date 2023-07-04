import QtQuick 2.0
import Felgo 3.0
import QtMultimedia 5.0

Item {
    id: audioManager
    property alias backgroundPlayer: m_backgroundPlayer

    MediaPlayer {
        id: m_backgroundPlayer
        source: "../../assets/audio/music_game.wav"
        loops: MediaPlayer.Infinite
    }
}
