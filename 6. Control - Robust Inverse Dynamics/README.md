### Quick README

**Robust Inverse Dynamics (RID) — “Computed Torque + Robust Outer Loop”**

| Symbol                                                                                                                                          | Meaning                                |
| ----------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------- |
| $q\in\mathbb{R}^n$                                                                                                                              | joint positions                        |
| $\dot q,\ddot q$                                                                                                                                | velocities, accelerations              |
| $q_d(t)$                                                                                                                                        | desired trajectory                     |
| $\tilde q=q-q_d,\ \dot{\tilde q}=\dot q-\dot q_d$                                                                                               | tracking errors                        |
| $B(q),C(q,\dot q)\dot q,g(q)$                                                                                                               | inertia, Coriolis/centrifugal, gravity nominal terms|
| $\hat B(q),\hat C(q,\dot q),\hat g(q)$                                                                                                                          | calculated/estimated terms                    |
| $a_q$                                                                                                                                           | commanded joint acceleration           |
| $\delta_a$                                                                                                                                      | robust term                            |

Also, 

$$ e=\begin{bmatrix}
\tilde q       \\ 
\dot{\tilde q} \\
\end{bmatrix}, 
𝒜=\begin{bmatrix}
0&I\\
-K_p&-K_d\\
\end{bmatrix},
ℬ=\begin{bmatrix}
0\\
I\\
\end{bmatrix} $$


represents error and state matrices respectively.

---

#### 1) Robot dynamics

$$
B(q)\ddot q + C(q,\dot q)\dot q + g(q)=u.
$$

---

#### 2) Control law (inverse dynamics with robustifying term)

$$
\boxed{u=\hat B(q)a_q+\hat C(q,\dot q)\dot q+\hat g(q)}
$$

with

$$
a_q=\ddot q_d-K_p\tilde q-K_d\dot{\tilde q}+\delta_a,
$$

where $K_p,K_d\succ0$.&#x20;

---

#### 3) Robust design of $\delta_a$

Model mismatch enters as

$$
\ddot q = a_q+\eta,\quad 
\eta=Ea_q + B^{-1}\big(\tilde C\dot q+\tilde g\big),\quad
E=B^{-1}\tilde B,
$$

and is bounded by

$$
\|\eta\|\le \alpha\|\delta_a\|+r_1\|e\|+r_2\|e\|^2+r_3,\quad
\alpha:=\|E\|<1.
$$

Choose

$$
\boxed{\ \rho(e,t)\ \ge\ \dfrac{r_1\|e\|+r_2\|e\|^2+r_3}{1-\alpha}\ }
$$

and set

$$
\boxed{\ 
\delta_a=
-\rho\frac{ℬ^{\top}Pe}{\|ℬ^{\top}Pe\|}\quad(\|ℬ^{\top}Pe\|>\varepsilon),\qquad
\delta_a=
-\frac{\rho}{\varepsilon}ℬ^{\top}Pe\quad(\|ℬ^{\top}Pe\|\le\varepsilon)
\ }
$$

where $P\succ0$ solves $𝒜^{\top}P+P𝒜=-Q,\ Q\succ0$ and $\varepsilon>0$ defines a boundary layer (reduces chattering). With these choices the closed loop is uniformly ultimately bounded (UUB).&#x20;

---

#### 4) Key take-away

Inverse dynamics shapes nominal second-order error dynamics; the discontinuous outer term $\delta_a$ (scaled by $\rho$) guarantees robustness to bounded model errors without requiring exact cancellation.&#x20;
