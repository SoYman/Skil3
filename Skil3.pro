QT += qml quick
QT += sql

CONFIG += c++11

SOURCES += main.cpp \
    sqlcomputermodel.cpp \
    sqlinterfacemodel.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    sqlcomputermodel.h \
    sqlinterfacemodel.h
