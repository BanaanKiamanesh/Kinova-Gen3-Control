### Quick README

**Inverse-Dynamics Compensation (Feed-Forward) + PD / Variable-Gain PD**

| Symbol                                                   | Meaning                                            |
| -------------------------------------------------------- | -------------------------------------------------- |
| $q\in\mathbb{R}^{n}$                                     | joint positions                                    |
| $\dot{q},\,\ddot{q}$                                     | joint velocities, accelerations                    |
| $q_{d}(t)$                                               | desired joint trajectory                           |
| $\tilde q = q_{d}-q,\; \dot{\tilde q}=\dot q_{d}-\dot q$ | position / velocity errors                         |
| $\hat B(q),\,\hat C(q,\dot q)\dot q,\,\hat g(q)$         | **nominal** inertia, Coriolis/centrifugal, gravity |
| $u$                                                      | commanded joint torques                            |

---

#### 1. Robot dynamics

$$
B(q)\,\ddot q + C(q,\dot q)\,\dot q + g(q) = u
$$

---

#### 2. Control laws

| Variant                  | Control input                                                                                                                                                                                                    |
| ------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **(a) Fixed-gain PD**    | $\displaystyle u = \underbrace{\hat B(q_{d})\,\ddot q_{d} \;+\; \hat C(q_{d},\dot q_{d})\,\dot q_{d} \;+\; \hat g(q_{d})}_{\hat u_{d}\ \text{(feed-forward)}} \;+\; K_{P}\,\tilde q \;+\; K_{D}\,\dot{\tilde q}$ |
| **(b) Variable-gain PD** | $\displaystyle u = \hat u_{d} \;+\; \hat B(q_{d})\bigl[\,K_{P}\,\tilde q + K_{D}\,\dot{\tilde q}\bigr]$                                                                                                          |

* $K_{P}, K_{D}\in\mathbb{R}^{n\times n}$ are symmetric positive-definite (often diagonal).
* Variant (b) scales the PD effort by the nominal inertia at the desired posture, yielding a *state-dependent* gain that improves decoupling without performing full feedback linearisation.

---

#### 3. When to use

* Trajectory tracking tasks where a reasonable model is available, yet exact feedback linearisation (“computed torque”) is deemed unnecessary or too sensitive to modelling errors.
* Variant (a): simplest implementation, offers **local** error stabilisation.
* Variant (b): better axis-to-axis decoupling and more uniform transient behaviour along the path, still without cancelling the **actual** nonlinearities.

---

#### 4. Key take-away

Add the nominal inverse-dynamics torque of the desired trajectory as a feed-forward term, then stabilise the tracking error with either fixed or state-scaled PD gains.  This improves accuracy over pure PD while relaxing the model-accuracy demands of full computed-torque control.
