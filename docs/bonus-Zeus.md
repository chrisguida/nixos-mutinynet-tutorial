---
title: "Bonus Zeus"
sidebar_position: 9
---


# BONUS: Zeus Wallet

- In this section we will install and use the [Zeus mobile wallet](https://zeusln.com/) to access and control our CLN node.

# Exercise: Install and connect Zeus Wallet to CLN via Tor
## Install Zeus on your phone

First things first, make sure you download and install [Zeus](https://zeusln.com/). We'll need it again in a few steps.

## Add c-lightning-REST to your config


- [c-lightning-REST](https://github.com/Ride-The-Lightning/c-lightning-REST) is a service from the RTL team that exposes an LND-like REST interface. It is the recommended way to connect a mobile client like Zeus.
- You can see nix-bitcoin's documentation for Zeus [here](https://github.com/fort-nix/nix-bitcoin/blob/24bc983363aab940ac42b1954335d3d57a63a00c/docs/services.md#use-zeus-mobile-lightning-wallet-via-tor)

```nix
  services.clightning-rest = {
    enable = true;
    # lndconnect is a binary the nix-bitcoin team created
    # to display connection information for remote wallets
    lndconnect = {
      enable = true;

      # additionally show tor hidden service for rest API
      onion = true;
    };
  };
```

## Switch to the new config

```
sudo nixos-rebuild switch --flake /etc/nixos/#btcpp-berlin-mutinynet
```

## Access via Tor (see below for connecting via Tailscale)

Tor can be a bit slow, but it's easier to set up than the other methods.

Run the following command on your node to create a QR code with address and authentication information:

```sh
lndconnect-clightning
```

### Configure Zeus

- Add a new node and scan the QR code
- Name it something meaningful like "Mutinynet Tor" Click `SAVE NODE CONFIG`
- Congrats, now you can control your node on the go!

## Access via Tailscale (optional)
Tailscale uses Wireguard under the hood and is similar to the [Wireguard method detailed in the nix-bitcoin docs](https://github.com/fort-nix/nix-bitcoin/blob/24bc983363aab940ac42b1954335d3d57a63a00c/docs/services.md#use-zeus-mobile-lightning-wallet-via-wireguard), except you are slightly trusting Tailscale the company as a rendezvous point between your phone and server. Your traffic is still encrypted using SSL however, so as long as you verify the SSL cert the first time you connect, it's impossible for Tailscale to read your traffic.

If you would like to use your node on mainnet, please consider using Wireguard as described in the link above, or use a [headscale](https://headscale.net) server instead.

### Create Tailscale.com account and connect your phone

For the purposes of this section, Tailscale is fine. Go ahead and [create an account](https://tailscale.com/), then install the Tailscale app on your phone and register your phone to your account.

### Install tailscale on your server and connect it too

- Add the following to your config:

```nix
  services.tailscale.enable = true;
```

- Now open port 3001 in your firewall so you can connect to your REST API over Tailscale:

    Change this line:
    ```nix
    networking.firewall.allowedTCPPorts = [ 8333 9735 ];
    ```

    to look like:

    ```nix
    networking.firewall.allowedTCPPorts = [ 3001 8333 9735 ];
    ```

... and switch again!

- Now run:
  ```sh
  sudo tailscale up
  ```

- This will display a link that you can click to register your server on your tailnet, allowing your phone and your server to communicate as though they are on the same LAN, but from anywhere in the world.

### Configure Zeus

- Go to your Tor node's connection settings page by clicking on the gear next to its icon.
- Scroll to the bottom and click `DUPLICATE NODE CONFIG`. This will allow us to reuse the macaroon, which is the same regardless of our connection method.
- In the `Host` field, erase the .onion URL and put your server's Tailscale IP address (you can find this with `tailscale status`)
- Click Save node config
- Congrats, now you can control your node on the go, without having to deal with Tor's latency and reliability issues!

<br></br>

- [ ] Install Zeus and Tailscale
- [ ] Create two node connections in Zeus, one for Tor and one for Tailscale
- [ ] Control your Lightning node from anywhere like a god
