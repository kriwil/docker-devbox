
FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	python3 \
	python3-pip \
	software-properties-common \
	tmux \
	zsh
RUN add-apt-repository ppa:neovim-ppa/stable
RUN apt-get update
RUN apt-get install -y neovim
RUN pip3 install --upgrade pip
RUN pip3 install --user neovim jedi

CMD ["/usr/bin/zsh"]
