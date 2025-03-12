---
title: "Chans Invoices"
sidebar_position: 5
---


# Fun with opening channels and paying invoices

- In this section we open channels with our fellow mutinynet lightning node operators and send each other off-chain mutinysats!

# Exercise: Open channels and pay invoices

## Grab some free sats from the faucet
- First, generate a new wallet address so you can deposit some sats on your node:

```
lightning-cli newaddr
```

Copy your deposit address and paste it into https://faucet.mutinynet.com to receive some free mutinynet sats!
## Get your node URI and announce it to your peers

To get your node URI, first enter:
```
lightning-cli getinfo
```
- Your node URI looks like `<pubkey or node ID>@<IP or hostname>:<port>` (the port is usually optional, though you'll want to include it for this exercise).
- Share this URI with your peers!

## Connect to some peers
- Once you've announced your URI to everyone, anyone can connect to your node (and you to them) by entering:
```
lightning-cli connect <URI>
```
(a.k.a. `lightning-cli connect <pubkey>@<IP>:9735`)

- Connect to a handful of peers. You will be transacting with them shortly.

## Open some channels
- See all the peers you have by running `lightning-cli listpeers | jq -r '.peers[] | .id, .netaddr[0]'`
- Once you have some peers, you can open channels to them with `lightning-cli fundchannel <pubkey> <amount>`. The `amount` field can be specified as a number of sats by appending `sat` to the end of the sat amount you want to open the channel for. So, for example `lightning-cli fundchannel 260a95d3d46afbca770cff6890 1000000sat` (to open a 1-million-sat channel).
- Once you have some channels, now the real fun begins!

## Creating and paying invoices
- Make an invoice for 1,000 sats and send it to anyone!
```
lightning-cli invoice 1000sat test test
```

then copy and paste the `bolt11` field to the payer.

- Pay invoices with:

```
lightning-cli pay <their bolt11>
```

## Keep it rolling
- Keep creating payments and sending them until you're satisfied.
- Keep track of your on-chain and channel balances with `lightning-cli bkpr-listbalances`
- You can also use `lightning-cli summary` to see a nice little ASCII depiction of your node

If there's still time left in the workshop, let's do some bonus stuff!

- [ ] Grab some free sats from the mutinynet faucet
- [ ] Connect to some peers
- [ ] Open some channels
- [ ] Make some invoices
- [ ] Pay some invoices
- [ ] Look at your node's bookkeeper balance and summary
