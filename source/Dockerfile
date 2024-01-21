ARG BASE_IMAGE=ubuntu:22.04
FROM $BASE_IMAGE as core
ARG ARCH=amd64

SHELL ["/bin/bash", "-c"]

RUN yes | unminimize 2>&1 >/dev/null

RUN apt-get -qy update >/dev/null \
    && DEBIAN_FRONTEND=noninteractive \
        apt-get -qy install \
        apt-file \
        btop \
        build-essential \
        clang \
        cmake \
        ctop \
        curl \
        dnsutils \
        exa \
        fd-find \
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

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN locale-gen

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

RUN mkdir -m 0755 -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    | tee /etc/apt/sources.list.d/docker.list >/dev/null

RUN apt-get update >/dev/null && \
    apt-get install -y \
    docker-ce-cli \
    docker-compose-plugin

# The docker group allows access to Docker daemon socket.
# The group ID might be different on some distributions.
RUN addgroup --gid 999 docker

RUN git config --global advice.detachedHead false

ENV HUMUS_PATH=/opt/humus
RUN mkdir -p $HUMUS_PATH
RUN ln -s /root/.humus $HUMUS_PATH

COPY zsh $HUMUS_PATH/zsh
RUN $HUMUS_PATH/zsh/install.sh
ENV ZSH=$HUMUS_PATH/zsh/ohmyzsh
RUN chsh root -s /bin/zsh

COPY symlink.sh $HUMUS_PATH/symlink.sh
RUN $HUMUS_PATH/symlink.sh $HUMUS_PATH

RUN mkdir $HUMUS_PATH/vim
WORKDIR $HUMUS_PATH/vim
COPY vim/install.sh ./
RUN $HUMUS_PATH/vim/install.sh
COPY vim/install_lsp_python.sh ./
COPY vim/install_lsp_rust.sh ./
COPY vim/lua ./lua
COPY vim/init.lua ./

COPY tmux.conf $HUMUS_PATH/tmux.conf

COPY create_user.sh $HUMUS_PATH/create_user.sh

WORKDIR /root
ENTRYPOINT ["/usr/bin/zsh", "-c", "exec $0 \"$@\""]
CMD ["zsh", "-l"]

FROM core as user

ARG user_name
ARG user_id
ARG group_name
ARG group_id

ENV user_id=${user_id}
ENV user_name=${user_name}
ENV group_id=${group_id}
ENV group_name=${group_name}

RUN $HUMUS_PATH/create_user.sh $user_id $user_name $group_id $group_name
ENV HUMUS_PATH="/home/$user_name/opt/humus"
USER $user_name

WORKDIR /home/$user_name
