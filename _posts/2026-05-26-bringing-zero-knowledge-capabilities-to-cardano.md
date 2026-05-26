---
layout: post
title:  "Bringing Zero-Knowledge Capabilities To Cardano"
image: "assets/img/entries_covers/zk-capabilities.png"
author: Eryx Team
introduction: "In the last years, Zero-Knowledge proofs have been revolutionizing how people think about blockchains. From L2s to simple applications, these protocols bring a layer of privacy and delegation to a widely used stack of technologies. Today, we'll talk about how we pretend to further include Cardano in this growing movement."
---

# **Bringing Zero-Knowledge Capabilities to Cardano**

At Eryx, we believe zero-knowledge technology is becoming a foundational layer for the future of blockchain — and Cardano should be part of that future.

Today, building ZK applications on Cardano is still harder than it should be. Experienced ZK teams often face missing infrastructure that must be built from scratch. And for developers who are not ZK specialists, the barrier is much higher: the tools are complex, the workflows are unfamiliar, and there are not enough reusable components to make ZK feel accessible.

But it should not be that way.

If Cardano wants to support private voting, anonymous credentials, ZK-based DeFi, verifiable off-chain computation, and other next-generation applications, builders need reusable open-source tools they can rely on.

ZK should become accessible infrastructure: powerful enough for cryptographers, but simple enough for Cardano builders to use.

That is what we want to help build for Cardano. Open, practical ZK capabilities that lower the barrier for developers and make it possible for better, more private, and more useful applications to reach real users.

## **Key infrastructure**

The proposal includes four open-source components:

**A PLONK verifier in Aiken**  
PLONK is a widely used zero-knowledge proving system. By implementing a SnarkJS-compatible verifier in Aiken, Cardano smart contracts will be able to verify proofs generated with common ZK tools like Circom and SnarkJS.

This makes it possible to move sensitive or expensive logic off-chain and prove the result on Cardano. Developers could use it for anonymous credentials, ZK-based DeFi, compliance proofs, or applications where users need to prove something without revealing everything behind it.

**RISC Zero integration for Cardano**  
RISC Zero is a zkVM: a tool that lets developers prove that a program was executed correctly, without running the whole program on-chain. In practice, this means complex logic can happen off-chain, while Cardano only verifies a small proof of the result. It also adds privacy: the computation itself can remain hidden, while only the final result and its validity are revealed.

This would make it easier to build scalable and private applications on Cardano, from verifiable computation and complex DeFi logic to privacy-preserving workflows and cross-chain systems — using regular programming languages instead of requiring every team to manually design specialized cryptographic proofs.

It could also make existing RISC Zero-based tools relevant to Cardano. For example, Zeth uses RISC Zero to prove that Ethereum blocks were executed correctly. If Cardano can verify RISC Zero proofs, Cardano applications could eventually read and trust Ethereum activity through proofs instead of relying on third parties. In simple terms, this could help Cardano become more interoperable with Ethereum, enabling cross-chain state verification and future zk-powered bridge infrastructure. 

**Aiken-ZK library extensions**  
We have already developed *aiken-zk*, a tool that helps Aiken developers integrate ZK proof verification into validators without needing to be ZK experts.

This proposal will make it production-ready: easier to install, easier to use, better documented, more reliable, and friendlier to **AI-assisted development workflows**. The goal is to make ZK feel less like specialized cryptography work and more like a practical tool that regular Cardano developers can use.

**Semaphore V4 for Cardano**  
Semaphore is a private signaling protocol: it lets users prove group membership and send a valid signal without revealing their identity.

This primitive has already been used in large-scale identity systems such as Worldcoin / World ID, where zero-knowledge proofs help users prove uniqueness or eligibility without linking each action back to their identity.

Bringing Semaphore to Cardano would make similar privacy-preserving patterns available to Cardano applications: private voting, anonymous feedback, membership proofs, sybil-resistant coordination, and governance tools.

We will adapt Semaphore to Cardano and implement the Aiken validators needed so developers can use it as a reusable privacy building block.

## **Unlock new capabilities**

With these components, Cardano developers will be able to build applications that are currently difficult or impossible to implement: private governance, ZK-based DeFi, anonymous identity systems, verifiable off-chain computation, and privacy-preserving user flows.

For users, this means more privacy and better applications.  
For developers, it means better tools and fewer barriers.  
For Cardano, it means a stronger foundation for the next generation of decentralized applications.

## **The future**

The goal is simple: make zero-knowledge technology practical, reusable, and accessible for the Cardano ecosystem. ZK should not remain a distant research promise — it should become part of the everyday toolkit for building on Cardano.