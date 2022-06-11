FROM ubuntu:20.04 as core

SHELL ["/bin/bash", "-c"]

RUN apt-get -y update >/dev/null \
    && DEBIAN_FRONTEND=noninteractive \
        apt-get -y install \
        curl \
        fzf \
        git \
        gnupg \
        htop \
        locales \
        man \
        ripgrep \
        silversearcher-ag \
        software-properties-common \
        sudo \
        tmux \
        tree \
        vim \
        wget \
        zip \
        zsh \
        >/dev/null

RUN yes | unminimize

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN locale-gen

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" \
   >/dev/null
RUN apt-get update -y >/dev/null && apt-get install -y docker-ce-cli >/dev/null

RUN git config --global advice.detachedHead false

ENV HUMUS_PATH=/opt/humus
RUN mkdir -p $HUMUS_PATH
RUN ln -s /root/.humus $HUMUS_PATH

COPY zsh $HUMUS_PATH/zsh
RUN $HUMUS_PATH/zsh/install.sh
ENV ZSH=$HUMUS_PATH/zsh/ohmyzsh
RUN chsh root -s /bin/zsh

COPY vim $HUMUS_PATH/vim
RUN $HUMUS_PATH/vim/install.sh

COPY tmux.conf $HUMUS_PATH/tmux.conf

COPY symlink.sh $HUMUS_PATH/symlink.sh
RUN $HUMUS_PATH/symlink.sh $HUMUS_PATH

COPY create_user.sh $HUMUS_PATH/create_user.sh

WORKDIR /root
ENTRYPOINT ["/usr/bin/zsh", "-c", "exec $0 \"$@\""]
CMD ["zsh", "-l"]

FROM core as user

ARG user
ARG user_id
ARG group
ARG group_id

RUN $HUMUS_PATH/create_user.sh $user_id $user $group_id $group
USER $user

WORKDIR /home/$user
