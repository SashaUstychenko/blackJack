cmake_minimum_required(VERSION 3.16)

project(blackjack VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appblackjack
    main.cpp
)

qt_add_qml_module(appblackjack
    URI blackjack
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES Background.qml
        SOURCES card.h card.cpp
        SOURCES participant.h participant.cpp
        SOURCES player.h player.cpp
        SOURCES dealer.h dealer.cpp
        SOURCES deck.h deck.cpp
        SOURCES game.h game.cpp
        SOURCES skin.h skin.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appblackjack PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appblackjack
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appblackjack
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appblackjack
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
