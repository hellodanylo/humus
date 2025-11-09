#!/usr/bin/env sh

export DEBIAN_FRONTEND=noninteractive
apt-get -qy update >/dev/null \
    &&  \
        apt-get -qy install \
        apt-file \
        btop \
        build-essential \
        clang \
        cmake \
        curl \
        dnsutils \
        eza \
        fd-find \
        fish \
        fzf \
        gettext \
        git \
        gnupg \
        htop \
        locales \
        man \
        ninja-build \
        ripgrep \
        software-properties-common \
        sudo \
        tmux \
        tree \
        tzdata \
        wget \
        zip \
        zsh \
        2>&1 >/dev/null

