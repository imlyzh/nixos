
## first install nixos or nix

## use in nixos
```sh
sudo nixos-rebuild switch --flake .#
```

## use in mac

### first bootload

```sh
sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin/nix-darwin-25.05#darwin-rebuild -- switch --flake .#macmini
```

```sh
sudo darwin-rebuild switch --flake .#macbook
```

## use in home-manager(linux)
```sh
home-manager switch --flake .#linux
```

## use in home-manager(mac)
```sh
home-manager switch --flake .#mac
```

## remote push and build

```sh
nix run .#deploy .#lyzh-nixos-laptop -- --remote-build
```