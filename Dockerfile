FROM ubuntu:16.04

ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8

RUN apt-get update
RUN apt-get install -y locales && locale-gen en_US.UTF-8
RUN apt-get install -y \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    direnv \
    git \
    libbz2-dev \
    libdb5.3-dev \
    libexpat1-dev \
    libgdbm-dev \
    liblzma-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    python3 \
    python3-pip \
    software-properties-common \
    tk-dev \
    tmux \
    zlib1g-dev \
    zsh
RUN add-apt-repository ppa:neovim-ppa/stable
RUN apt-get update
RUN apt-get install -y neovim
RUN apt-get clean -y

RUN pip3 install --upgrade pip
RUN pip3 install --user neovim jedi

# python related
# RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
# RUN ~/.pyenv/bin/pyenv install 3.6.4
# RUN ~/.pyenv/bin/pyenv global 3.6.4 \
#     && curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | ~/.pyenv/shims/python

# RUN ~/.local/bin/pipsi install pew
# RUN ~/.local/bin/pipsi install pipenv

# docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install -y docker-ce

# compose
RUN curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

# tmux
RUN curl -o ~/.tmux.conf https://raw.githubusercontent.com/kriwil/dotfiles/master/tmux.conf

# vim
RUN curl -fLo ~/.config/nvim/init.vim --create-dirs https://raw.githubusercontent.com/kriwil/dotfiles/master/vimrc
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN vim +'PlugInstall --sync' +qa

# zsh
RUN curl -o ~/oh-my-zsh.tar.gz https://codeload.github.com/kriwil/oh-my-zsh/tar.gz/master
RUN curl -o ~/.zshrc https://raw.githubusercontent.com/kriwil/dotfiles/master/zshrc.linux
RUN curl -o ~/.gitconfig https://raw.githubusercontent.com/kriwil/dotfiles/master/gitconfig
RUN tar zxvf ~/oh-my-zsh.tar.gz -C ~/ && mv ~/oh-my-zsh-master ~/.oh-my-zsh
RUN rm ~/oh-my-zsh.tar.gz

# shell
RUN chsh -s /bin/zsh 
ENV TERM xterm-256color

CMD ["tmux", "-2"]
