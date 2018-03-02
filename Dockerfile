FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
    direnv \
	git \
	python3 \
	python3-pip \
	software-properties-common \
	tmux \
	zsh
RUN add-apt-repository ppa:neovim-ppa/stable
RUN apt-get update
RUN apt-get install -y neovim
RUN apt-get clean -y

RUN pip3 install --upgrade pip
RUN pip3 install --user neovim jedi

# zsh
RUN curl -o ~/oh-my-zsh.tar.gz https://codeload.github.com/kriwil/oh-my-zsh/tar.gz/master
RUN curl -o ~/.zshrc https://raw.githubusercontent.com/kriwil/dotfiles/master/zshrc.linux
RUN curl -o ~/.gitconfig https://raw.githubusercontent.com/kriwil/dotfiles/master/gitconfig
RUN tar zxvf ~/oh-my-zsh.tar.gz -C ~/ && mv ~/oh-my-zsh-master ~/.oh-my-zsh
RUN rm ~/oh-my-zsh.tar.gz

RUN curl -o ~/.tmux.conf https://raw.githubusercontent.com/kriwil/dotfiles/master/tmux.conf

# vim
RUN curl -fLo ~/.config/nvim/init.vim --create-dirs https://raw.githubusercontent.com/kriwil/dotfiles/master/vimrc
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN vim +'PlugInstall --sync' +qa

# docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install -y docker-ce

# python related
RUN apt install -y \
    build-essential \
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
    tk-dev \
    zlib1g-dev
RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
RUN ~/.pyenv/bin/pyenv install 3.6.4
RUN ~/.pyenv/bin/pyenv global 3.6.4 \
    && curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python
RUN pipsi install pew
RUN pipsi install pipenv

RUN chsh -s /bin/zsh 
ENV TERM xterm-256color

CMD ["tmux", "-2"]
