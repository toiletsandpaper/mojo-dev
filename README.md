# Installing Mojo in Container (podman/docker) for development

I'm a Fedora user and installing and updating Mojo outside Ubuntu is a mess. 
Of course, I can create VM in Boxes or anything similiar, but this is also a mess and uses too much resources.

So, I've decided to use [VS Code Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.emote-containers)
in container. And I've wrote a Containerfile that will install Mojo automatically
