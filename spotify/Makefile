#!/usr/bin/env make -f
REPONAME := brkcmd
APPNAME := spotify
TAG := latest
HOMEDIR := /home/spotify
X11DOCKER := x11docker
EXE := /usr/bin/spotify
ICON := /usr/share/spotify/icons/spotify-linux-512.png
NO_CACHE := false

.PHONY: build
build:
	docker build --no-cache=$(NO_CACHE) -f Dockerfile -t $(REPONAME)/$(APPNAME):$(TAG) .

.PHONY: force-rebuild
force-rebuild:
	make NO_CACHE=true build

.PHONY: install
install: build
	docker volume create x11docker-home-$(REPONAME)-$(APPNAME)-$(TAG)
	mkdir -p ~/.local/share/{icons,applications} ~/.local/bin
	./extract-icon.sh $(REPONAME)/$(APPNAME):$(TAG) $(ICON) > x11docker-$(REPONAME)-$(APPNAME)-$(TAG).png
	mv -i x11docker-$(REPONAME)-$(APPNAME)-$(TAG).png ~/.local/share/icons/
	sed -e 's#%%X11DOCKER%%#$(X11DOCKER)#g' \
	    -e 's#%%REPONAME%%#$(REPONAME)#g' \
	    -e 's#%%APPNAME%%#$(APPNAME)#g' \
	    -e 's#%%TAG%%#$(TAG)#g' \
	    -e 's#%%HOMEDIR%%#$(HOMEDIR)#g' \
	    -e 's#%%EXE%%#$(EXE)#g' \
	    wrapper.sh > wrapper
	chmod +x wrapper
	mv -i wrapper ~/.local/bin/$(REPONAME)-$(APPNAME)-$(TAG)
	ln -sf $(REPONAME)-$(APPNAME)-$(TAG) ~/.local/bin/$(APPNAME)
	sed -e 's#%%X11DOCKER%%#$(X11DOCKER)#g' \
	    -e 's#%%REPONAME%%#$(REPONAME)#g' \
	    -e 's#%%APPNAME%%#$(APPNAME)#g' \
	    -e 's#%%TAG%%#$(TAG)#g' \
	    -e 's#%%HOMEDIR%%#$(HOMEDIR)#g' \
	    -e 's#%%EXE%%#$(EXE)#g' \
	    template.desktop > x11docker-$(REPONAME)-$(APPNAME)-$(TAG).desktop
	mv -i x11docker-$(REPONAME)-$(APPNAME)-$(TAG).desktop ~/.local/share/applications/
	update-desktop-database -q ~/.local/share/applications/

.PHONY: uninstall
uninstall:
	-docker volume rm x11docker-home-$(REPONAME)-$(APPNAME)-$(TAG)
	-rm -f ~/.local/share/icons/x11docker-$(REPONAME)-$(APPNAME)-$(TAG).png
	-rm -f ~/.local/share/applications/x11docker-$(REPONAME)-$(APPNAME)-$(TAG).desktop
	-rm -f ~/.local/bin/$(REPONAME)-$(APPNAME)-$(TAG)
	-rm -f ~/.local/bin/$(APPNAME)
	-update-desktop-database -q ~/.local/share/applications/
