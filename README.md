# kivy-build
A dockerfile for building a handy image for building kivy apps

Image available on Docker Hub as gomyar/kivy-build

The build will download the android SDK, the NDK, build-tools (missing in the SDK but expected by p4a) and perform an initial build with main.py test app to download the rest of the dependencies.

See notes on Docker Hub for using the image.
