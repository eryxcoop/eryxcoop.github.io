---
layout: post
title:  "My path through FHE"
image: "assets/img/fhe_header.webp"
---

![FHE_header.webp](/assets/img/fhe_header.webp)


When we hear the term "programmable cryptography," we often think about Zero Knowledge Proofs (ZK) alone. Still, sometimes we forget about other areas like Multi-Party Computation (MPC) or Fully Homomorphic Encryption (FHE). I recently started learning about FHE and wanted to give an overview, not about the subjects targeted by FHE (I will write another post about that) but about my path and all the resources that guided me throughout the process.

First of all, what is FHE? The basic idea is to allow a third party, like a remote server, to perform computations over your data without giving the server access to it. To do so, we provide this third party with an encrypted version of our data so that it can perform encrypted operations. When the server is done with the computation, it returns the encrypted result, which is to be decrypted by the original owner of the data. Learning how this is all done is a challenge. For a slightly deeper overview, read the first paragraphs of this [Wikipedia article](https://en.wikipedia.org/wiki/Homomorphic_encryption) or part 1 of this [blog post](https://mirror.xyz/privacy-scaling-explorations.eth/D8UHFW1t48x2liWb5wuP6LDdCRbgUH_8vOFvA0tNDJA).

### Math and cryptographic concepts
How can we start approaching the world of FHE? First, you need to learn some basic concepts like [algebraic group](https://en.wikipedia.org/wiki/Algebraic_group), [ring](https://en.wikipedia.org/wiki/Ring_(mathematics)), and group and ring [homomorphism](https://en.wikipedia.org/wiki/Homomorphism). These are pure math subjects that will build a solid base for a better understanding of the topics that follow. It will also help to be familiar with [symmetric](https://en.wikipedia.org/wiki/Symmetric-key_algorithm) and [public-key cryptography](https://en.wikipedia.org/wiki/Public-key_cryptography), specifically focusing on [RSA](https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://es.wikipedia.org/wiki/RSA&ved=2ahUKEwibp6-8we2IAxXEppUCHcZbO7IQFnoECAkQAQ&usg=AOvVaw2tLqpeZQIkT5PLDPrOx8TL) for now. There are a lot of resources where you can learn these basic concepts, but [An Introduction to Mathematical Cryptography](https://github.com/isislovecruft/library--/blob/master/cryptography%20%26%20mathematics/An%20Introduction%20to%20Mathematical%20Cryptography%20(2014)%20-%20Hoffstein%2C%20Pipher%2C%20Silverman.pdf) by Jeffrey Hoffstein, Jill Pipher, and Joseph H. Silverman is a great book to start with. You don't have to read every chapter—focus on things you don't know. A non-exhaustive list of sections for these topics is:
* 1.3 Modular Arithmetic
* 1.5 Powers and Primitive Roots in Finite Fields
* 1.7 Symmetric and Asymmetric Ciphers
* 3.2 The RSA Public Key Cryptosystem

For a deeper look at algebra concepts like groups and rings, I recommend the algebra section (chapter 4) of [The MoonMath Manual](https://es.slideshare.net/slideshow/mainmoonmathpdf/255031625).

### Homomorphic Encryption and Noise
The first step to understanding Fully Homomorphic Encryption is to understand Partial Homomorphic Encryption (or just Homomorphic Encryption), a basic form of FHE where the server can perform only one kind of operation over encrypted data (usually addition or multiplication alone). A great example is RSA, where you can perform arbitrary multiplications over encrypted data. But before that, you should learn some basic definitions like Homomorphic Encryption from the book [Homomorphic Encryption and Applications](https://books.google.com.ar/books?id=OgA6BQAAQBAJ&pg=PA27&hl=es&source=gbs_toc_r&cad=2#v=onepage&q&f=false) by Xun Yi, Russell Paulet, and Elisa Bertino, in particular sections:
* 1.3.2 RSA
* 2 Homomorphic Encryption
* 2.1 Homomorphic Encryption Definition

These pages provide a solid base for you to understand what makes a cryptographic system homomorphic, and with that knowledge, I recommend you apply the definition you just learned to RSA encryption and infer that it's effectively homomorphic over multiplication. Moving on, read the definition of Fully Homomorphic Encryption (finally!) from section 3 to section 3.2. At this point, the definition should feel intuitive for you, but remember we're just beginning. Things start to get a bit messy here. Read sections:
* 3.3 Somewhat Homomorphic Encryption Scheme over Integers
* 3.3.1 Secret Key Somewhat Homomorphic Encryption

The important thing you should take from this cryptographic system is the idea of noise, and why you cannot perform an arbitrary number of encrypted multiplications in this scheme. This may take a while and many re-reads to convince yourself, but it's important to grasp this concept because even though noise will take many forms depending on the system, the key idea is always the same.

### Lattices, Learning With Error and modern FHE
At this point, maybe you're tired of reading, but don't worry, we'll continue with some videos. Now we'll move to the field of lattice and Learning With Errors (LWE) cryptography. For an introduction to lattices, watch [this video](https://www.youtube.com/watch?v=QDdOoYdb748&ab_channel=ChalkTalk). It doesn't matter if you don't fully understand it, it's only to gain an intuition of lattices and justify what comes next. The following video is about [Learning With Errors](https://www.youtube.com/watch?v=K026C5YaB3A&t=310s&ab_channel=ChalkTalk), and in this case, I would suggest you watch it as many times as you need because the intuition behind this is really important. You may think it's weird this isn't really related to FHE directly, but the tools this cryptographic system uses are similar to the ones we'll use next when we move to Torus FHE. To start, I recommend watching [this video](https://www.youtube.com/watch?v=umqz7kKWxyw&ab_channel=FHE_org) until the end. Many things will sound familiar, and others won't, but hopefully, it will smooth the ground for the final track.

Here's the really hard part, now I'll let you deep dive into this [series of blog posts by Zama](https://www.zama.ai/post/tfhe-deep-dive-part-1), where they explain Torus FHE (a modern and implemented FHE scheme) in depth, with a special focus on understanding Programmable Bootstrapping.

That's all for now, I hope this was helpful. I don't know if it's the best path to learn FHE, but it was the one I took. You can also start playing with [Concrete](https://github.com/zama-ai/concrete), the FHE framework implemented by Zama. Good Luck!
