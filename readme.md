
## first install nixos or nix

## use in nixos
```sh
sudo nixos-rebuild switch --flake .#
```

## use in mac
```sh
sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --flake .#macmini
```

## use in home-manager(linux)
```sh
home-manager switch --flake .#linux
```

## use in home-manager(mac)
```sh
home-manager switch --flake .#mac
```
