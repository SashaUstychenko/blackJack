cmake_minimum_required(VERSION 3.16)

project(blackjack VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)


find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)
find_package(PkgConfig REQUIRED)


# Знаходимо бібліотеки VAAPI
pkg_check_modules(LIBVA REQUIRED libva)
pkg_check_modules(LIBVA_X11 REQUIRED libva-x11)
pkg_check_modules(LIBVA_DRM REQUIRED libva-drm)

qt_standard_project_setup()

qt_add_executable(appblackjack
    main.cpp
    resources.qrc
)


qt_add_qml_module(appblackjack
    URI blackjack
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES Initial.qml
        SOURCES card.h card.cpp
        SOURCES deck.h deck.cpp
        QML_FILES
        RESOURCES resources.qrc
        QML_FILES Test1.qml
        SOURCES participant.h participant.cpp
        SOURCES sound.h sound.cpp
        SOURCES player.h player.cpp
        SOURCES dealer.h dealer.cpp
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
find_package(Qt6 REQUIRED COMPONENTS Multimedia)

target_include_directories(appblackjack PRIVATE ${LIBVA_INCLUDE_DIRS} ${LIBVA_X11_INCLUDE_DIRS} ${LIBVA_DRM_INCLUDE_DIRS})
target_link_libraries(appblackjack
    PRIVATE Qt6::Quick
    PRIVATE Qt6::Multimedia
    ${LIBVA_LIBRARIES} ${LIBVA_X11_LIBRARIES} ${LIBVA_DRM_LIBRARIES}
)

include(GNUInstallDirs)
install(TARGETS appblackjack
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
