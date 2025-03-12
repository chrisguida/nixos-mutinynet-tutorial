---
title: "Bonus Fulcrum"
sidebar_position: 7
---


# BONUS: Fulcrum

- In this section we will install and use Fulcrum.
- Fulcrum is a high-performance full-index personal electrum server.
- You can use it as the backend for many wallet, including Sparrow and Electrum.
- We'll try it with Sparrow in this section.

# Exercise: Install and run Fulcrum

## Add Fulcrum to your config

```nix
  services.fulcrum = {
    enable = true;
  };
```

## Switch to the new config

```
sudo nixos-rebuild switch --flake /etc/nixos/#btcpp-berlin-mutinynet
```

## Start an SSH tunnel
Then, open a terminal window and start a new SSH session like this:

```sh
ssh -L 50001:127.0.0.1:50001 bitcoiner@<VPS IP address>
```

If you want to use the same SSH session for both RTL and Fulcrum, you can instead do:
```sh
ssh -L 3000:127.0.0.1:3000 -L 50001:127.0.0.1:50001 bitcoiner@<VPS IP address>
```

- This will open an SSH tunnel from `localhost` on your VPS (where Fulcrum is exposed on port 50001) to localhost on your local machine.
- If you're having trouble connecting, try deactivating any VPNs and restarting the tunnel.
- Make sure you don't have two tunnels open to the same port.

You can now use your Fulcrum server as a backend for any desktop wallet, such as Sparrow.

## Install Sparrow
Go to https://sparrowwallet.com/download/ and install Sparrow for your machine.

## Run Sparrow
The exact method will vary depending on your OS.

## Connect Sparrow to your Fulcrum instance
- Go to File->Preferences->Server->Edit Existing Connection
- In "URL" put `127.0.0.1` and `50001` for the port
- Make sure `SSL` is off
- Make sure `Use Proxy` is off
- Click `Test Connection`. This should say "Connected to Fulcrum"

## Restart in Testnet Mode

- Go to Tools->Restart in Testnet to be able to interact with Mutinynet wallets.

## Create a wallet and send some transactions
 
- Your CLN node can be used as a second on-chain mutinynet wallet
- You can also send to your fellow mutinynet users
<br></br>
- [ ] Install Fulcrum
- [ ] Create an SSH tunnel to your Fulcrum instance
- [ ] Connect Sparrow Desktop to your Fulcrum instance

