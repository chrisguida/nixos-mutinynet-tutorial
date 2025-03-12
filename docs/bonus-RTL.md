---
title: "Bonus Rtl"
sidebar_position: 6
---


# BONUS: Ride The Lightning

- In this section we will install and use Ride The Lightning (RTL)!
- RTL is a webapp GUI for lightning nodes.
- It is compatible with LND, CLN, and Eclair.
- We're using it with CLN, of course.

# Exercise: Install and use RTL

## Add RTL to your config
Copy this into your config:

```nix
  services.rtl = {
    enable = true;
    nodes.clightning.enable = true;
  };
```

## Switch to the new config

```
sudo nixos-rebuild switch --flake /etc/nixos/#btcpp-berlin-mutinynet
```

## Start an SSH tunnel
- SSH tunnels are the best way to access admin interfaces like RTL which really are not meant to be exposed publicly.
- This guarantees that only someone with SSH access to our machine can control our Lightning node.

Open a terminal window and start a new SSH session like this:

```sh
ssh -L 3000:127.0.0.1:3000 bitcoiner@<VPS IP address>
```

This will open an SSH tunnel from `localhost` on your VPS (where RTL is  on port 3000) to `localhost` on your local machine.
- The tunnel will continue to work as long as you keep the SSH session open.
- If you're having trouble connecting, try deactivating any VPNs and restarting the tunnel.
- Make sure you don't have two tunnels open to the same port.

## Use RTL in your browser
You can now open a browser to `localhost:3000` and this should open RTL.

Go back to your SSH session and grab your RTL password:
```sh
sudo cat /etc/nix-bitcoin-secrets/rtl-password
```

Paste your RTL password into your browser window and you're in!

You can now control your CLN node from a user-friendly UI.

- [ ] Install RTL
- [ ] Create an SSH tunnel to your RTL instance
- [ ] Use RTL for great glory
