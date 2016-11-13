QT += core
QT -= gui

CONFIG += c++11

TARGET = Dlib_test
CONFIG += console
CONFIG -= app_bundle

TEMPLATE = app

SOURCES += main.cpp

INCLUDEPATH +=D:\opencv2.4.13\build\install\include

LIBS +=-L"D:\opencv2.4.13\build\install\x86\mingw\bin"
LIBS += -lopencv_core2413 -lopencv_highgui2413 -lopencv_imgproc2413

QMAKE_CXXFLAGS_RELEASE += -mavx

INCLUDEPATH+=E:\dlib-19.2\include
LIBS +=-L"E:\dlib-19.2\lib"
LIBS+=-ldlib
LIBS += -lmingw32
LIBS+=-lOle32
LIBS+=-lOleaut32
LIBS+=-lm
LIBS+= -ldinput8
LIBS+=-lcomctl32

LIBS+=-ldxguid
LIBS+= -ldxerr8
LIBS+=-luser32
LIBS+=-lgdi32
LIBS+=-lwinmm
LIBS+= -limm32
LIBS+= -lole32
LIBS+=-loleaut32
LIBS+=-lshell32
LIBS+= -lversion
LIBS+= -luuid

LIBS+=-lglut32
LIBS+=-lopengl32
LIBS+=-lglu32
LIBS+=-lgdi32
LIBS+=-lwinmm
LIBS += -lws2_32
