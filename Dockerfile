
FROM ubuntu:20.04

ENV TZ=Europe/Dublin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN dpkg --add-architecture i386

RUN apt-get update && \
    apt-get install -y \
    python3-pip \
    libsdl-dev \
    wget \
    unzip \
    zip \
    build-essential \
    ccache \
    git \
    openjdk-8-jdk \
    zlib1g-dev \
    python3 \
    python3-dev \
    libncurses5:i386 \
    libstdc++6:i386 \
    zlib1g:i386 \
    unzip \
    ccache \
    autoconf \
    libtool \
  && pip install virtualenv \
  && rm -rf /var/cache/apk/*

RUN pip install cython==0.29.28 kivy==2.1.0 buildozer==1.3.0
WORKDIR /buildozer
RUN useradd -ms /bin/bash buildozer
RUN chown buildozer:buildozer /buildozer
USER buildozer
RUN buildozer init

COPY main.py /buildozer/
RUN yes | buildozer android debug 

CMD '/bin/bash'
