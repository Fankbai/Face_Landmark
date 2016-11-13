# Install Dlib on PC with Qt and MingW 

time:11/12/2016 U.S Pacific time  By: Cypress McCarthy

## Usage



​     **In** this article, I will show you guys how to install Dlib (C++ library) on your PC, using QT and MingW compiler. Before start, you should download [Dlib](dlib.net), [Qt](https://www.qt.io/download/), [cmake](https://cmake.org/) and MingW( Qt has already been included).

​     

## What is Dlib



​	**Your** may know this before you install Dlib on your PC. Dlib is a C++ library, containing machine learning algorithms and tools for creating complex software in C++ to solve real world problems. It is used in both industry and academia in a wide range of domains including robotics, embedded devices, mobile phones, and large high performance computing environments. Dlib's [open source licensing](http://dlib.net/license.html) allows you to use it in any application, free of charge(from Dlib.net).

​	Such many features it has: **Documents**，**High Quality Portable Code**，**Machine Learning Algorithms**，**Image Processing**...



## How to install

There are few of materials to us how to install Dlib on your PC with Qt and MingW instead of Visual Studio(what a big software, ha), even though the Dlib.net provides an article: [How to compile](http://dlib.net/compile.html).

- **decomposition the Dlib file**

  ![50,70](1.jpg)

- **using cmake **

   1th: Browse the source file and **mkdir** a build file![](2016-11-12_175007.jpg)

  2th:press **Configure** button, choose the MinGW Makefiles.

  ![](2016-11-12_175027.jpg)

  3th:

  ![](2016-11-12_175052.jpg)

  4th:click **Generate** button

  ![](2016-11-12_175124.jpg)

- mingw32-make

  ![](2016-11-12_191059.jpg)

  ![](2016-11-12_191134.jpg)

  waiting...

  ![](2016-11-12_192020.jpg)

- Qt create a new project

-  the file of .pro should looks like that:  (It also should include opencv library for what the demo is needed)

  ```.Pro file
  QT += core
  QT -= gui

  CONFIG += c++11

  TARGET = FaceL_LandMark
  CONFIG += console
  CONFIG -= app_bundle

  TEMPLATE = app

  SOURCES += main.cpp \

  INCLUDEPATH +=D:\opencv2.4.13\build\install\include

  LIBS +=-L"D:\opencv2.4.13\build\install\x86\mingw\bin"
  LIBS += -lopencv_core2413 -lopencv_highgui2413 -lopencv_imgproc2413

  QMAKE_CXXFLAGS_RELEASE += -mavx           //NOTE it can speed the Dlib!!

  INCLUDEPATH+=E:\dlib-19.2\dlib
  LIBS +=-L"E:\dlib-19.2\build"
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

  ```

  ​


DEMO;

```demo
#include <QCoreApplication>
#include <dlib/opencv.h>
#include <opencv2/highgui/highgui.hpp>
#include <dlib/image_processing/frontal_face_detector.h>
#include <dlib/image_processing/render_face_detections.h>
#include <dlib/image_processing.h>
#include <dlib/gui_widgets.h>

#include <dlib/image_processing/frontal_face_detector.h>
#include <dlib/gui_widgets.h>
#include <dlib/image_io.h>
#include <iostream>

#include<opencv2/opencv.hpp>
#include<opencv2/opencv_modules.hpp>

#define FACE_DOWNSAMPLE_RATIO 4
#define SKIP_FRAMES 2
#define DLIB_PNG_SUPPORT
#define DLIB_JPEG_SUPPORT
using namespace cv;
using namespace std;
using namespace dlib;

int main(int argc, char** argv)
{
    QCoreApplication a(argc, argv);
    try
    {
        cv::VideoCapture cap(1);   //**NOTE: if you have one camera,(0) instad of (1)**
        						//i have two camera,(1) is the front one.
        if (!cap.isOpened())
        {
            cerr << "Unable to connect to camera" << endl;
            return 1;
        }

        image_window win;

        // Load face detection and pose estimation models.
        frontal_face_detector detector = get_frontal_face_detector();
        shape_predictor pose_model;
        deserialize("shape_predictor_68_face_landmarks.dat") >> pose_model;

        // Grab and process frames until the main window is closed by the user.
        while(!win.is_closed())
        {
            // Grab a frame
            cv::Mat temp;
            cap >> temp;
            // Turn OpenCV's Mat into something dlib can deal with.  Note that this just
            // wraps the Mat object, it doesn't copy anything.  So cimg is only valid as
            // long as temp is valid.  Also don't do anything to temp that would cause it
            // to reallocate the memory which stores the image as that will make cimg
            // contain dangling pointers.  This basically means you shouldn't modify temp
            // while using cimg.
            cv_image<bgr_pixel> cimg(temp);

            // Detect faces
            std::vector<dlib::rectangle> faces = detector(cimg);
            // Find the pose of each face.
            std::vector<full_object_detection> shapes;
            for (unsigned long i = 0; i < faces.size(); ++i)
                shapes.push_back(pose_model(cimg, faces[i]));

            // Display it all on the screen
            win.clear_overlay();
            win.set_image(cimg);
            win.add_overlay(render_face_detections(shapes));
        }
    }
    catch(serialization_error& e)
    {
        cout << "You need dlib's default face landmarking model file to run this example." << endl;
        cout << "You can get it from the following URL: " << endl;
        cout << "   http://dlib.net/files/shape_predictor_68_face_landmarks.dat.bz2" << endl;
        cout << endl << e.what() << endl;
    }
    catch(exception& e)
    {
        cout << e.what() << endl;
    }
}

```



**NOTE:using release instead of debug model can accelerate the detection speed**

## Result

 You should download  it from the following URL: //http://dlib.net/files/shape_predictor_68_face_landmarks.dat.bz2 as the detector . 

Go to the release file, 

```
projestname.exe shape_predictor_68_face_landmarks.dat  
```

that's it!

![](2016-11-12_193259.jpg)







