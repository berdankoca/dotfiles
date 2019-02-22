BACKUP_PATH = ${HOME}/test/old/
#https://github.com/Parth/dotfiles/blob/master/deploy

#Take backup all config files	
backup:
	@echo "========== backup =========="
	mkdir -p $(BACKUP_PATH)
	cp ${HOME}/.zshrc $(BACKUP_PATH)
	cp ${HOME}/.bashrc $(BACKUP_PATH)
	cp ${HOME}/.vimrc $(BACKUP_PATH)
	cp ${HOME}/.tmux.conf $(BACKUP_PATH)
	@echo "========= end of backup =========="

#Install all of packages
install:
	@echo "========== install =========="
	sudo apt-get update -y

	@echo "========== install package =========="
	sudo apt-get install -y jq curl htop httpie pass psmisc vim zsh tmux
	
	@echo "========== install oh-my-zsh and plugins =========="
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting	

	#When launch tmux press pefix + I (capital i) to fetch plugins
	@echo "========== install tmux/tpm =========="
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm	

	@echo "========== install docker/dive =========="
	wget https://github.com/wagoodman/dive/releases/download/v0.6.0/dive_0.6.0_linux_amd64.deb
	sudo apt install ./dive_0.6.0_linux_amd64.deb
	rm ./dive_0.6.0_linux_amd64.deb

	@echo "========== install nvm and node =========="
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
	nvm install node

	@echo "========== install dircolors =========="
	curl https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark --output ${HOME}/.dircolors
	
	#docker-ce docker-compose?
	#if you use wsl, be carefull about docker version of local computer	
	@echo "========== enf of install =========="

#Change config with dotfiles
deploy: install backup
	@echo "========== change the config file =========="
	@echo "source ${HOME}/dotfiles/bash/.bashrc" > ${HOME}/.bashrc
	@echo "source ${HOME}/dotfiles/zsh/.zshrc" > ${HOME}/.zshrc
	@echo "source ${HOME}/dotfiles/vim/vimrc.vm" > ${HOME}/.vimrc
	@echo "source ${HOME}/dotfiles/tmux/.tmux.conf" > ${HOME}/.tmux.conf
	@echo "========== enf of config file ========="

.PHONY: backup install deploy
