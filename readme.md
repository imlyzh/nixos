
## first install nixos or nix

## use in nixos
```sh
sudo nixos-rebuild switch --flake .#lyzh-nixos
```

## use in mac
```sh
sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --flake .#lyzhdeMac
```

## use in home-manager(linux)
```sh
home-manager switch --flake .#lyzh-nix-machine
```

## use in home-manager(mac)
```sh
home-manager switch --flake .#lyzhdeMac
```
