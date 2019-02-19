
FROM ubuntu:16.04

RUN dpkg --add-architecture i386

RUN apt-get update && \
    apt-get install -y \
    cython \
    python-pip \
    libsdl-dev \
    wget \
    unzip \
    zip \
    build-essential \
    ccache \
    git \
    zlib1g-dev \
    python2.7 \
    python2.7-dev \
    libncurses5:i386 \
    libstdc++6:i386 \
    zlib1g:i386 \
    openjdk-8-jdk \
    unzip \
    ant \
    ccache \
    autoconf \
    libtool \
  && pip install virtualenv \
  && rm -rf /var/cache/apk/*

RUN mkdir /jdk && cd /jdk && wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && cd /jdk && unzip *.zip && rm *.zip
RUN cd /jdk/tools/bin && echo "y" | ./sdkmanager "platforms;android-26"

RUN mkdir /ndk && cd /ndk && wget https://dl.google.com/android/repository/android-ndk-r17c-linux-x86_64.zip && cd /ndk && unzip *.zip && rm *.zip

RUN pip install python-for-android==0.7.0

RUN cd /jdk && mkdir build-tools && cd build-tools && wget https://dl.google.com/android/repository/build-tools_r28.0.3-linux.zip && unzip build-tools_r28.0.3-linux.zip && mv android-9 28.0.3 && rm build-tools_r28.0.3-linux.zip

RUN mkdir /initial
COPY main.py /initial/
RUN cd /initial && p4a apk --private . --package=com.initial.test --name "Initial Test App To Download Dependencies" --version 0.1 --bootstrap=sdl2 --requirements=python2,android,kivy --release --sdk-dir /jdk --ndk-dir /ndk/android-ndk-r17c --android-api 26 --ndk-api 21 --dist_name kivy-build

CMD ['/bin/sh']
