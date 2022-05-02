# kivy-build
A dockerfile for building a handy image for building kivy apps

Image available on Docker Hub as gomyar/kivy-build

The build will download the android SDK, the NDK, build-tools (missing in the SDK but expected by p4a) and perform an initial build with main.py test app to download the rest of the dependencies.

---------

# Image notes:

It's got the following installed:

 - Latest version (as of this writing) of Android SDK command line tools : 3.3.1
 - NDK version: r17c
 - Android build-tools: r28.0.3
 - python-for-android: 0.7.0
 - android platform 2.6


To build, you'll need to mount your project dir as a volumne, and either run a p4a build command directly, or enter the console in the container:

Run the container, and start a bash session:

    #docker run -v ${PWD}:/src -it gomyar/kivy-build /bin/bash
    docker run -u $UID -v $PWD:/buildozer -it gomyar/kivy-build:1.11.1

Go to your mounted project directory in the container:

    cd /src

Build your project:

    p4a apk --private . --package=com.YOURPACKAGENAME --name "YOUR APP NAME" --version 0.1 --bootstrap=sdl2 --requirements=python2,android,kivy --release --sdk-dir /jdk --ndk-dir /ndk/android-ndk-r17c --android-api 26 --ndk-api 21 --dist-name kivy-build


After building, it will show a file called kivy-build-0.1-release-unsigned.apk in the current directory.
To sign this for uploading to the Android Play Store, you will need a keystore with your certificate in it (outside the scope of this):

    jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore ./YOURKEYSTORE.keystore kivy-build-0.1-release-unsigned.apk KEYNAME

    /jdk/build-tools/28.0.3/zipalign -v 4 kivy-build-0.1-release-unsigned.apk YOURRELEASEDAPP.apk

Provided all the stars have aligned, you should be able to upload YOURRELEASEDAPP.apk to the Google Play Store
