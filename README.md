# Mojo in Container (podman/docker) for development

I'm a Fedora user and installing and updating Mojo outside Ubuntu is a mess.
Of course, I can create VM in Boxes or anything similiar, but this is also a mess and uses too much resources.

So, I've decided to use [VS Code Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.emote-containers)
in container. And I've wrote a Containerfile that will install Mojo automatically in a container, so you can just pull it from hub and use :)

## Installation

### Note

In all examples below I'm using `podman`, but if you are using `docker` - simply replace app name, so
my `podman run` will be yours `docker run`. `podman` is fully compatible with `docker` cli syntax!

### Stable Mojo

```sh
podman run --name mojo_stable -id ghcr.io/toiletsandpaper/mojo-dev:stable
```

### Nightly Mojo

```sh
podman run --name mojo_nightly -id ghcr.io/toiletsandpaper/mojo-dev:nightly
```

## Using with [VS Code Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.emote-containers)

0. Run Mojo containers in __detached__ mode (`-d` or `-id`)
1. Install the extension from [marketplace](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.emote-containers)
2. In VSCode press `F1`  or press `><` logo in left bottom corner and find `Dev Containers: Attach to Running Container...`
3. Select `mojo_stable` or `mojo_nightly` container
4. Wait until VSCode setup a server inside container
5. Done!

## Contribution

Feel free to open PR or Issue :)
