FROM ubuntu:18.04

ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8

COPY ssh /root/.ssh

RUN apt-get update
RUN apt install -y software-properties-common
RUN apt-add-repository ppa:neovim-ppa/stable
RUN apt install -y \
    curl \
    direnv \
    git \
    python3 \
    python3-dev \
    tmux \
    zsh \ 
    && echo 1

RUN mkdir -p $HOME/dotfiles
RUN git clone git@github.com:kriwil/oh-my-zsh.git $HOME/dotfiles
