---
title: "Cln"
sidebar_position: 4
---


# CLN

- In this section we install and sync `lightningd` (aka [Core Lightning](https://github.com/ElementsProject/lightning), aka CLN) on our NixOS box!
- This will build and install `lightningd` v23.05.2 via the `nix-bitcoin` `bitcoind` NixOS module, using a Nix flake.
- It will also configure `lightningd` as a system service and sync it with your mutinynet bitcoind node. You should wait until bitcoind is finished syncing before starting CLN, otherwise it might take a while to sync. If you accidentally do this, there are steps below to speed things up.
- Shoutout to the `nix-bitcoin` team for maintaining this software for anyone to use!

# Exercise: Add signet lightningd nix-bitcoin module to your system config

While our bitcoin node is syncing to mutinynet, let's add a mutinynet CLN node!

Add this after `nix-bitcoin.operator.name` in `/etc/nixos/configuration.nix` (make sure to edit the file with `sudo`)

```nix
  services.clightning = {
    enable = true;
    address = "0.0.0.0";
    plugins.summary.enable = true;

    # enable some cool CLN features
    extraConfig = ''
      experimental-offers
      experimental-dual-fund
      experimental-splicing
    '';
  };
```

Make sure to add your user to the `clightning` group:

```nix
extraGroups = [ "wheel" "bitcoin" "clightning" ];
```

Finally, open port 9735 to your firewall so othernodes can connect to you:

Change this line:
```nix
networking.firewall.allowedTCPPorts = [ 8333 ];
```

to look like:

```nix
networking.firewall.allowedTCPPorts = [ 8333 9735 ];
```

switch again!

```
sudo nixos-rebuild switch --flake /etc/nixos/#btcpp-berlin-mutinynet
```

Now logout and log back in to reflect the new user changes.

Once back in, check your lightning node:

```
lightning-cli getinfo
```

If you started your lightning node before your bitcoin node was done syncing, this can result in a slow CLN initial sync. If this happens, you may want to just nuke it and start over, (once bitcoind is finished syncing):

```
sudo rm -rf /var/lib/clightning/signet/ && sudo systemctl restart clightning
```

This should allow CLN to sync instantly.

Obviously don't do this if you already have money and channels on your node, as these will be lost. Of course, this is just signet, so the money isn't real anyway.

Now open some channels and send some sats!

- [ ] Create flake
- [ ] Add bitcoind to system config
- [ ] Add `nix-bitcoin` `operator` and `generate-secrets` to config
- [ ] Switch to the new config
- [ ] Log out and log back in to update your user's groups
- [ ] Test new bitcoind by running `bitcoin-cli -getinfo`
