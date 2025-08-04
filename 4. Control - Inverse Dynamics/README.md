### Quick README

**Inverse-Dynamics Compensation (Feed-Forward) + PD / Variable-Gain PD**

| Symbol                                                          | Meaning                                            |
| --------------------------------------------------------------- | -------------------------------------------------- |
| \$q\in\mathbb{R}^{n}\$                                          | joint positions                                    |
| \$\dot{q}, \ddot{q}\$                                           | joint velocities, accelerations                    |
| \$q\_{d}(t)\$                                                   | desired joint trajectory                           |
| \$\tilde q = q\_{d}-q,\quad \dot{\tilde q}=\dot q\_{d}-\dot q\$ | position / velocity errors                         |
| \$\hat B(q), \hat C(q,\dot q)\dot q, \hat g(q)\$                | **nominal** inertia, Coriolis/centrifugal, gravity |
| \$u\$                                                           | commanded joint torques                            |

---

#### 1. Robot dynamics

$$
B(q) \ddot q + C(q,\dot q) \dot q + g(q) = u
$$

---

#### 2. Control laws

| Variant                  | Control input                                                                              |
| ------------------------ | ------------------------------------------------------------------------------------------ |
| **(a) Fixed-gain PD**    | `u = [B̂(q_d) q̈_d + Ĉ(q_d, q̇_d) q̇_d + ĝ(q_d)] + K_P(q_d - q) + K_D(q̇_d - q̇)`          |
| **(b) Variable-gain PD** | `u = [B̂(q_d) q̈_d + Ĉ(q_d, q̇_d) q̇_d + ĝ(q_d)] + B̂(q_d)[K_P(q_d - q) + K_D(q̇_d - q̇)]` |

* \$K\_{P}, K\_{D}\in\mathbb{R}^{n\times n}\$ are symmetric positive-definite (often diagonal).
* Variant (b) scales the PD effort by the nominal inertia at the desired posture, yielding a *state-dependent* gain that improves decoupling without performing full feedback linearisation.

---

#### 3. When to use

* Trajectory tracking tasks where a reasonable model is available, yet exact feedback linearisation (“computed torque”) is deemed unnecessary or too sensitive to modelling errors.
* Variant (a): simplest implementation, offers **local** error stabilisation.
* Variant (b): better axis-to-axis decoupling and more uniform transient behaviour along the path, still without cancelling the **actual** nonlinearities.

---

#### 4. Key take-away

Add the nominal inverse-dynamics torque of the desired trajectory as a feed-forward term, then stabilise the tracking error with either fixed or state-scaled PD gains. This improves accuracy over pure PD while relaxing the model-accuracy demands of full computed-torque control.
