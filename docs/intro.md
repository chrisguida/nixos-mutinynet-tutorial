---
title: "Intro"
sidebar_position: 1
slug: /
---


#  Deploying Your First NixOS Machine

Speaker: [Chris Guida](https://github.com/chrisguida) <br></br>
Twitter: [@cguida6](https://x.com/cguida6)

Welcome! 

In this tutorial, you'll set up a [Mutinynet](https://mutinynet.com) bitcoin and lightning node, and you'll open some channels and send some sats!

- If you're doing this tutorial at the [btc++ conference in Berlin](https://btcplusplus.dev/berlin23/talks#cguida) on Friday, October 6, 2023, I've already set up a VPS for you to use in this workshop.
- If you're doing this tutorial sometime later, you can use any NixOS machine. The config will be a bit different since the tutorial uses a config tailored to DigitalOcean. Reach out to me and I'll be happy to help you set it up :)

So all you need to do is read through each section and follow the examples, and at the end you'll have a working mutinynet bitcoin and lightning node, which you can then deploy anywhere and customize to fit any bitcoin use case!

## Nix-bitcoin
- Nix-bitcoin is a collection of NixOS modules that allow users to easily configure a large number of interconnected bitcoin-related services on a NixOS system.
- We're using [a fork of] it today to show off how easy it makes working with bitcoin and lightning.
- Nix-bitcoin is designed with security in mind, but the system we're building today is a toy system for demo and testing purposes only.
  - If you want to build a secure production system, make sure you read and understand the documentation on [nixbitcoin.org](https://nixbitcoin.org).

## Mutinynet
- [Mutinynet](https://mutinynet.com) is a custom signet based on a [fork of bitcoind](https://github.com/benthecarman/bitcoin/tree/configure-signet-blockitme), built by the [Mutiny Wallet](https://mutinywallet.com) team.
  - This allows Mutinynet to have a very fast and predictable 30-second block time, which makes it ideal for testing, especially for L2 stuff like Lightning.

## Session Agenda:
- Build a mutinynet lightning node
  - bitcoind
  - CLN
- Bonus exercises
  - RTL
  - Fulcrum / Sparrow
  - Mempool

## Chris's Hackathon Plugin Ideas He Could Help You With:

1. (Easy) Use nix-bitcoin to install additional services
2. (Medium) Make a nix devShell
3. (Hard) Nixify CLN
