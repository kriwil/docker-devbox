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

RUN curl -o ~/oh-my-zsh.tar.gz https://codeload.github.com/kriwil/oh-my-zsh/tar.gz/master
RUN curl -o ~/.zshrc https://raw.githubusercontent.com/kriwil/dotfiles/master/zshrc.linux
RUN tar zxvf ~/oh-my-zsh.tar.gz -C ~/ && mv ~/oh-my-zsh-master ~/.oh-my-zsh
RUN rm ~/oh-my-zsh.tar.gz

RUN curl -o ~/.tmux.conf https://raw.githubusercontent.com/kriwil/dotfiles/master/tmux.conf

RUN curl -fLo ~/.config/nvim/init.vim --create-dirs https://raw.githubusercontent.com/kriwil/dotfiles/master/vimrc
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN vim +'PlugInstall --sync' +qa

RUN chsh -s /bin/zsh 
ENV TERM xterm-256color

CMD ["tmux", "new", "-s", "default", "-d"]
