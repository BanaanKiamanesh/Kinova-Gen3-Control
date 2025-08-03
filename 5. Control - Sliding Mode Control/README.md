### Quick README

**Sliding-Mode Control (SMC) with Disturbance Compensation**

| Symbol                                                    | Meaning                                                                        |
| --------------------------------------------------------- | ------------------------------------------------------------------------------ |
| $q\in\mathbb{R}^{n}$                                      | joint positions                                                                |
| $\dot q,\,\ddot q$                                        | joint velocities, accelerations                                                |
| $q_{d}(t)$                                                | desired joint trajectory                                                       |
| $\tilde q = q_{d}-q,\;\;\dot{\tilde q}=\dot q_{d}-\dot q$ | position / velocity errors                                                     |
| $B(q)$                                                    | positive-definite inertia matrix                                               |
| $C(q,\dot q)\dot q$                                       | Coriolis & centrifugal terms                                                   |
| $g(q)$                                                    | gravity vector                                                                 |
| $d(t)$                                                    | lumped matched disturbance, bounded: $d_{\text{low}}\le d(t)\le d_{\text{up}}$ |
| $u$                                                       | commanded joint torques                                                        |
| $s=\dot{\tilde q}+\lambda\tilde q$                        | sliding variable ($\lambda>0$)                                                 |

---

#### 1. Robot dynamics with disturbance

$$
B(q)\,\ddot q + C(q,\dot q)\,\dot q + g(q) \;=\; u \;+\; d(t)
$$

---

#### 2. Control law (second-order SMC)

$$
\boxed{%
u \;=\; B(q)\!\bigl[\ddot q_{d} + \lambda\,\dot{\tilde q} + \eta\,\mathrm{sgn}(s)\bigr]
      \;-\; d_{c}
      \;+\; C(q,\dot q)\,\dot q
      \;+\; g(q)}
$$

* $\lambda,\eta>0$ set the slope of the sliding surface and the reaching speed.
* The term $B(\,)\bigl[\cdot\bigr] + C + g$ acts as inverse-dynamics feed-forward; the discontinuous $\eta\,\mathrm{sgn}(s)$ injects robustness.

---

#### 3. Robust choice of $d_{c}$

Assume the disturbance bound is known:

$$
d_{\text{low}}\;\le\;d(t)\;\le\;d_{\text{up}} .
$$

Define

$$
d_1 = \tfrac{d_{\text{up}}-d_{\text{low}}}{2},\qquad
d_2 = \tfrac{d_{\text{up}}+d_{\text{low}}}{2}.
$$

Then choose

$$
\boxed{\,d_{c} = d_{2} - d_{1}\,\mathrm{sgn}(s)\,}
$$

so that, independently of the sign of $s$, the net term $-d_{c}+d(t)$ always helps satisfy the reaching condition $s\,\dot s \le -\eta\,|s|$.

---

#### 4. Key take-away

Sliding-mode control adds a discontinuous term that forces the tracking error to a first-order surface $s=0$ and keeps it there despite matched, bounded disturbances. Selecting $d_{c}$ as above guarantees robustness while preserving the simple, inverse-dynamics-like structure familiar from computed-torque control.
