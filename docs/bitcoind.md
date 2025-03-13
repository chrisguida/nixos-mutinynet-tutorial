---
title: "Bitcoind"
sidebar_position: 3
---


# Bitcoind

- In this section we install and sync `bitcoind` on our NixOS box!
- This will build the [mutinynet fork of bitcoind](https://github.com/benthecarman/bitcoin/tree/configure-signet-blockitme) from source, and install via a [modified version](https://github.com/fort-nix/nix-bitcoin/commit/e177c2eb4895c152df7baabb892a9a401daa582c) of the `nix-bitcoin` `bitcoind` NixOS module, using a Nix flake.
- It will also configure `bitcoind` as a system service and start the initial block download. Syncing Mutinynet should be fairly quick; it should be done in just a few minutes.
- Shoutout to [@benthecarman](https://github.com/benthecarman/) and the Mutiny Wallet team for maintaining this fork of bitcoin and making life super easy for developers!
- Shoutout to [@erikarvstedt](https://github.com/erikarvstedt/) for modifying `nix-bitcoin` so we could run Mutinynet!

# Exercise: Add mutinynet bitcoind `nix-bitcoin` module to your system config

First, create a new file, `/etc/nixos/flake.nix`:

```sh
sudo vim /etc/nixos/flake.nix
```

Activate insert mode (`i`) and copy this in:

```nix
{
  description = "btcpp-berlin-mutinynet machine configuration";

  # pull in the modified `nix-bitcoin` flake into our flake
  inputs.nix-bitcoin.url = "github:chrisguida/nix-bitcoin/mempool-and-fix-no-feerate";
  
  # for a mainnet node, you would just do:
  # inputs.nix-bitcoin.url = "github:fort-nix/nix-bitcoin";

  # However, the main branch of nix-bitcoin does not have bitcoind-mutinynet, nor mempool,
  # so it will not work with this tutorial.
  # Stay tuned, though. Mempool is close :) https://github.com/fort-nix/nix-bitcoin/pull/505
  
  outputs = { self, nix-bitcoin  }: {
    nixosConfigurations = {

      # Our machine config
      btcpp-berlin-mutinynet = nix-bitcoin.inputs.nixpkgs.lib.nixosSystem {
        modules = [

          # import the default NixOS modules from nix-bitcoin
          nix-bitcoin.nixosModules.default

          # import configuration.nix into our flake
          ./configuration.nix
        ];
      };
    };
  };
}
```

Exit out of insert (ESCAPE) and hit `ZZ` again to save and exit.

Now let's edit `configuration.nix` again:

```sh
sudo vim /etc/nixos/configuration.nix
```
(I recommend pasting this after the services.openssh section):

```nix
  services.bitcoind = {

    # enable the bitcoind service from our flake
    enable = true;

    # enable the transaction index (optional) (needed for 
    # block explorers and some address indexers)
    txindex = true;

    # listen for peer connections
    address = "0.0.0.0";
    listen = true;

    # set fallback fee (required for mutinynet because fee estimate is always 0)
    # enable block filters (optional)
    extraConfig = ''
      fallbackfee=0.00000253
      blockfilterindex=1
      peerblockfilters=1
    '';
  };
```

Make sure to have nix-bitcoin generate your secrets, and set an operator (this can go immediately after the above):

```nix
  nix-bitcoin.generateSecrets = true;
  nix-bitcoin.operator.name = "bitcoiner";
```

Also make sure to add your user to the `bitcoin` group:

Change the `users.users.bitcoiner.extraGroups` line from

```nix
extraGroups = [ "wheel" ];
```

to


```nix
extraGroups = [ "wheel" "bitcoin" ];
```

Finally, open port 8333 in your firewall so your node is contributing to the network:
```nix
networking.firewall.allowedTCPPorts = [ 8333 ];
```

then switch your system to use your new flake:

```
sudo nixos-rebuild switch --flake /etc/nixos/#btcpp-berlin-mutinynet
```

log out of SSH and log back in to pick up the changes to your user.

make sure the bitcoin node is running and track IBD progress (mutinynet's entire blockchain is under 500MB at the time of writing and IBD should take just a few minutes):

```sh
bitcoin-cli -getinfo
```

- [ ] Create flake
- [ ] Add bitcoind to system config
- [ ] Add `nix-bitcoin` `operator` and `generate-secrets` to config
- [ ] Switch to the new config
- [ ] Log out and log back in to update your user's groups
- [ ] Test new bitcoind by running `bitcoin-cli -getinfo`
