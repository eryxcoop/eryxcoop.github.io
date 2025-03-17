---
layout: post
title:  "Montgomery's Trick"
image: "assets/img/entries_covers/team_players.png"
author: Julian Arnesino
introduction: "We present an efficient way of inverting many field elements at once."
---

# Montgomery's trick

*Note: This is extracted from [our article on the power of GPU parallelization](https://blog.eryx.co/2024/11/27/The-Power-of-GPU-Parallelization-Applied-to-Cryptography-Primitives.html).*

The objective is to invert a batch or array of field elements.
In a naïve approach, one would invert each element in the array.
This would mean applying the extended Euclidean algorithm for each element to compute its inverse.
However, since field inversion is an expensive operation, we will use something called _Montgomery’s trick_.

It starts with an array of elements to invert.

<p style="text-align: center">

$$a_1, a_2, a_3, a_4 \in \mathbb{F}_p$$
</p>

It then computes the accumulated products up to each element.

<p style="text-align: center">

$$\beta_1 = a_1$$

$$\beta_2 = a_1 \times a_2$$

$$\beta_3 = a_1 \times a_2 \times a_3$$

$$\beta_4 = a_1 \times a_2 \times a_3 \times a_4$$
</p>

This could be done with as many products as there are elements in the array.

<p style="text-align: center">

$$\beta_1 = a_1$$

$$\beta_2 = \beta_1 \times a_2$$

$$\beta_3 = \beta_2 \times a_3$$

$$\beta_4 = \beta_3 \times a_4$$
</p>

In the next step, we compute the field inversion for the final accumulated product, using the extended Euclidean algorithm.

<p style="text-align: center">

$$\beta_4^{-1} \leftarrow eea(\beta_4)$$
</p>

This will be the only time we use this expensive operation.

Now, we want to calculate the inversion of each element from the inversion of the final accumulated product.
The trick uses the previously accumulated products for this, as follows.

<p style="text-align: center">

$$a_4^{-1} = \beta_4^{-1} \times \beta_3$$
</p>

How does that work? Well, we could explain it by imagining the field inversion as a division.
This is an intuitive representation only, since there is no such thing as division in $\mathbb{F}_p$.

<p style="text-align: center">

$$a_4^{-1} = \beta_4^{-1} \times \beta_3$$

$$\approx \frac{1}{a_1 \times a_2 \times a_3 \times a_4} \times a_1 \times a_2 \times a_3$$

$$= \frac{1}{a_4}$$
</p>

The inversion of the accumulated product is equal to the product of all the individual inverses.
By multiplying it with the elements we don't want, those inversions are canceled out, and only the element we want remains.

Now it can calculate the inversion of the previous accumulated product.

<p style="text-align: center">

$$\beta_3^{-1} = \beta_4^{-1} \times a_4$$
</p>

The same idea applies.

<p style="text-align: center">

$$\beta_3^{-1} = \beta_4^{-1} \times a_4$$

$$\approx \frac{1}{a_1 \times a_2 \times a_3 \times a_4} \times a_4$$

$$= \frac{1}{a_1 \times a_2 \times a_3}$$
</p>

This idea would now be sequentially repeated for the remaining elements in the array.

| Element |   Inversion of the accumulated product   |         Inversion of the element         |
|:-------:|:----------------------------------------:|:----------------------------------------:|
|  $a_4$  |  $\beta_4^{-1} \leftarrow eea(\beta_4)$  | $a_4^{-1} = \beta_4^{-1} \times \beta_3$ |
|  $a_3$  | $\beta_3^{-1} = \beta_4^{-1} \times a_4$ | $a_3^{-1} = \beta_3^{-1} \times \beta_2$ |
|  $a_2$  | $\beta_2^{-1} = \beta_3^{-1} \times a_3$ | $a_2^{-1} = \beta_2^{-1} \times \beta_1$ |
|  $a_2$  | $\beta_1^{-1} = \beta_2^{-1} \times a_2$ |       $a_1^{-1} = \beta_1^{-1}$          |

Which leaves us with every element's inversion.

But why have we done all this?
Well, for an array with $n$ elements:
- A naïve implementation would need $n$ field inversions.
- Montgomery's trick needs $3 (n - 1)$ field multiplications and only one field inversion.
    - Needs $n - 1$ multiplications to compute the accumulated products.
    - Needs one field inversion for the final accumulated product.
    - Needs $2 (n - 1)$ multiplications to invert each element.

Knowing how expensive the extended Euclidean algorithm is, we will gladly take the trade.
