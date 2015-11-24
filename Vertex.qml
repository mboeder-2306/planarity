import QtQuick 2.0
import Ubuntu.Components 1.1


Item {
    id: vertex

    property double size: units.gu(3)
    property var edges: []
    property double originalX
    property double originalY

    width: size
    height: size
    z: 2
    scale: 1 / board.scale
    transform: Translate {
        x: -size / 2
        y: -size / 2
    }

    function reset() {
        x = originalX
        y = originalY
    }

    Component.onCompleted: {
        originalX = x
        originalY = y
    }

    MouseArea {
        id: mouseArea
        anchors.fill: vertex
        drag {
            target: vertex
            minimumX: vertex.size / 2
            minimumY: vertex.size / 2
            maximumX: board.width - vertex.size / 2
            maximumY: board.height - vertex.size / 2
            threshold: 0
        }

        drag.onActiveChanged: {
            if (!drag.active)
                board.onVertexDragEnd()
        }
    }

    Rectangle {
        id: rect

        property double size: units.gu(2)

        width: size
        height: size
        radius: size/2
        x: (vertex.size - size) / 2
        y: (vertex.size - size) / 2
        color: "blue"
        border.color: "black"
        border.width: units.dp(1)
    }

    states: [
        State {
            name: "Selected"
            when: mouseArea.pressed
            PropertyChanges {
                target: rect
                color: "white"
            }
        },
        State {
            name: "Neighbor"
            PropertyChanges {
                target: rect
                color: "red"
            }
        }
    ]

    transitions: [
        Transition {
            from: "Neighbor"
            to: ""
            ColorAnimation {
                duration: 1000
            }
        }
    ]
}
