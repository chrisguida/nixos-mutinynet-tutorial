---
title: "Required Cleanup"
sidebar_position: 10
---


# REQUIRED: Cleanup

- In this section we will withdraw all our play money from our nodes and close all our channels.
- This will help tidy things up on the mutinynet chain once the workshop is over.
- I will destroy all the droplets at the end of the day.

# Close all your channels and withdraw or donate all your money
## Close all your channels:
```sh
lightning-cli listpeers | jq -r '.peers[] | .id' | xargs -I {} lightning-cli close {}
```

## Track the closes on chain and make sure they all succeed
- You can keep track of the closes with `lightning-cli listpeerchannels` and `lightning-cli listfunds`

## Once all your channels are closed, withdraw all your money from the node
- To withdraw to an address you generate in Sparrow:
```
lightning-cli withdraw <your address> all
```

- To donate all your mutinysats to Chris:
```
lightning-cli withdraw tb1qdq6ttfganrlhch5jrv27ewtnnpwphp96hfq7m2 all
```

Let me know when you've finished withdrawing your money so I can shut down your droplet. These things aren't free.

Hope you enjoyed the workshop!

--cguida

- [ ] Close all your channels
- [ ] Withdraw all your sats
- [ ] Notify Chris when this is done so he can destroy your VPS
