---
layout: post
title:  "zkLogin: Zero-Knowledge Authentication with Web2 Credentials on Cardano"
image: "assets/img/entries_covers/zkLogin.png"
author: Bruno Weisz
introduction: "Managing a crypto wallet has always required users to either safeguard a seed phrase or trust a third party to do it for them. The first option can easily lead to permanently lost funds, while the second means giving up control to an external service that could be compromised or corrupted. But what if you could access your Cardano wallet with your Google account, the same way you log into your favorite app,, without ever giving up control of your funds or even exposing your identity? That’s exactly what zkLogin protocol is for."
---

### OpenId: the key to web2 authentication

Before getting into zkLogin itself, is useful to understand one of the most widely used authentication protocols on the internet today: OpenID Connect. Chances are you have used it without even knowing it. It’s the technology behind that familiar “Sign in with Google” button that pops up when you try to log into a new app or website. Instead of creating yet another username and password, OpenID lets a trusted provider like Google confirm your identity to a third party application. Conveniently, it's something most internet users interact with daily, and the base over which we implemented the zkLogin protocol in Cardano.
### The zkLogin protocol

The core idea is simple: instead of managing a private key or trusting a third party with your funds, you authenticate with your Google account and your wallet is unlocked. But making this work on a blockchain, securely and privately, is far from trivial. Let’s break down how it actually works.

At this point you might be wondering: if your Google account is used to access your wallet, doesn’t that mean anyone watching the blockchain can link your Google identity to your Cardano address? This is exactly the problem that zero-knowledge proofs solve. A zero-knowledge proof is a cryptographic technique that allows someone to prove they know something without revealing what that something is. In the context of zkLogin, it allows the protocol to prove that a valid Google login was used to authorize a transaction, without putting any of your Google credentials on the blockchain. Nobody watching the chain can tell which Google account controls a given address.

Note that when we say “your wallet is unlocked” is an abstraction of what actually happens. There’s a lot of detail that you can find in the technical report, if the reader wants to dig deeper.
### How is zkLogin secure?

One of the most important aspects of zkLogin is how it handles trust. The protocol is designed in a way that no single external party ever has enough information to act on your behalf. Think of it as a puzzle where each piece is held by a different actor, and no single actor holds enough pieces to complete it.

Google knows your identity but has no knowledge of your salt or your Cardano address. The salt is a private value that creates an extra layer of separation between your Google identity and your on-chain address. It needs to be stored somewhere, and zkLogin is flexible about this: it can be managed by the user directly, like stored securely on their device, or delegated to an external salt service, a server that stores your salt and retrieves it when needed. Crucially, the salt service only ever sees the salt and nothing else, so even if it were compromised, an attacker would still be missing all the other pieces. And vice versa: even if someone had access to your Google credentials, without the salt they could not derive your wallet address.

The proof generation service, which does the heavy cryptographic operations, never sees the private key used to sign your transactions. Besides, the user has the option to perform those operations locally. The session credentials live exclusively on the user’s device and expire automatically: the protocol doesn’t enforce the wallet to have a backend server that could be compromised, everything can happen in the user’s device.


This means that even in a worst case scenario where one of these services is compromised, an attacker still cannot take control of your funds. This is a fundamentally different security model from both traditional self-custody wallets, where losing your private key means losing everything, and custodial wallets, where a compromised third party means the same.
### Where does zkLogin come from?

zkLogin was originally designed and deployed on the SUI blockchain, where it is embedded directly into the core protocol. This means SUI nodes natively understand and verify zkLogin proofs as part of the transaction validation process. Cardano, on the other hand, does not have this kind of native support, and changing the core protocol to add it was not the direction we wanted to take.

Instead, we found a way to implement zkLogin entirely on top of Cardano’s existing infrastructure. The key insight was to embed the user’s identity into a smart contract, called a validator in Cardano, and use that contract’s address as the user’s wallet address. The zero-knowledge proof verification happens inside this validator, requiring no changes to the Cardano protocol itself, which makes it significantly more practical to deploy and adopt.
### What should we do next?

The current implementation of zkLogin for Cardano covers the full end-to-end authentication flow and sending and receiving transactions with zkLogin addresses, but there is a lot of room to grow. One natural next step is supporting additional OpenID providers beyond Google, such as Apple, Microsoft or GitHub, which would make zkLogin accessible to a much broader audience, and more importantly, let each person choose the provider they already trust.

Another important future contribution is making zkLogin addresses wallet-independent. In the current design, the user’s address is tied to the specific wallet or application they used to create it. Slight modifications in the protocol could decouple the address from the wallet, so that users can access their funds from any compatible application without being locked into a single provider.

There is also the question of staking. Cardano allows ADA holders to delegate their funds to stake pools and earn rewards, but the current zkLogin address structure makes this complicated. Future versions of the protocol aim to solve this, allowing zkLogin users to participate in staking just like any other Cardano user, without giving up the privacy and security guarantees that zkLogin provides.

Finally, OpenID providers periodically rotate their public keys for security reasons. The protocol needs to handle these rotations gracefully so that long-lived wallets remain functional without requiring any action from the user.
### Conclusion

zkLogin represents a meaningful step forward for the Cardano ecosystem. By combining the familiarity of Web2 authentication with the security and privacy guarantees of zero-knowledge cryptography, it opens the door to a new kind of user experience.

The barrier to entry for Web3 has always been high. Seed phrases, private keys and custodial trade-offs have kept many potential users on the sidelines. zkLogin doesn’t eliminate all of those challenges overnight, but it offers a concrete and privacy-preserving alternative that feels familiar from day one.