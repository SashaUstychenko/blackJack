// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls
Drawer {
        id: myDrawer
        width: parent.width * 0.7  // Ширина Drawer (70% від ширини вікна)
        edge: Qt.LeftEdge          // Drawer відкривається при свайпі з лівого краю
        modal: true                // Робить Drawer модальним, перекриваючи основний вміст

        // Вміст Drawer
        Column {
            spacing: 10
            padding: 20

            Label {
                text: "Menu"
                font.bold: true
                font.pixelSize: 24
            }

            Button {
                text: "Home"
                onClicked: {
                    myDrawer.close()  // Закриває Drawer при натисканні кнопки
                }
            }

            Button {
                text: "Settings"
                onClicked: {
                    myDrawer.close()  // Закриває Drawer при натисканні кнопки
                }
            }

            Button {
                text: "About"
                onClicked: {
                    myDrawer.close()  // Закриває Drawer при натисканні кнопки
                }
            }
        }
    }

