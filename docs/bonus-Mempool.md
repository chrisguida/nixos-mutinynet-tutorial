---
title: "Bonus Mempool"
sidebar_position: 8
---


# BONUS: Mempool

- In this section we will install and use Mempool.space (Mempool).
- Mempool is a pretty and functional block explorer

# Exercise: Install and run Mempool

## Add Mempool and Tor to your config

```nix
  # enable Tor hidden services, and tor client
  services.tor = {
    enable = true;
    client.enable = true;
  };

  # enable mempool service, use Fulcrum as backend for address lookups,
  # and enable Tor hidden service for mempool
  services.mempool = {
    enable = true;
    electrumServer = "fulcrum";
    tor = {
      proxy = true;
      enforce = true;
    };
  };
  nix-bitcoin.onionServices.mempool-frontend.enable = true;
```

## Switch to the new config

```
sudo nixos-rebuild switch --flake /etc/nixos/#btcpp-berlin-mutinynet
```

## Access via Tor-enabled browser (can also use an SSH tunnel, see below)
### (If you don't already have a Tor-enabled browser, I recommend skipping to the SSH tunnel method)
If you have Tor Browser (or some other Tor-enabled browser), you can access your mempool frontend via your .onion URL
Here's are some [decent guides for enabling Tor in Firefox on various OSes](https://docs.start9.com/latest/guides/device-guides/).
Tor can be a bit slow, but the hidden service will be accessible to anyone who knows the .onion URL.

### Get your onion URL
```sh
sudo cat /var/lib/tor/onion/mempool-frontend/hostname
```

### Visit your mempool's onion address
Paste the .onion address into your browser and enjoy!

## Access via SSH tunnel
Open a terminal window and start a new SSH session like this:

```sh
ssh -L 60845:127.0.0.1:60845 bitcoiner@<VPS IP address>
```

If you want to use the same SSH session for RTL, Fulcrum, and Mempool you can instead do:
```sh
ssh -L 3000:127.0.0.1:3000 -L 50001:127.0.0.1:50001 -L 60845:127.0.0.1:60845 bitcoiner@<VPS IP address>
```

- This will open an SSH tunnel from `localhost` on your VPS (where Mempool is exposed on port 60845) to localhost on your local machine.
- If you're having trouble connecting, try deactivating any VPNs and restarting the tunnel.
- Make sure you don't have two tunnels open to the same port.

You can now visit `localhost:60845` in a browser and enjoy!

- [ ] Install Mempool and Tor
- [ ] Create an SSH tunnel to your RTL instance or grab your .onion URL
- [ ] Use Mempool for great glory
