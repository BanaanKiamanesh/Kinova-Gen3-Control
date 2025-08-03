### Quick README

**Feedback Linearization**

| Symbol                                                      | Meaning                          |
| ----------------------------------------------------------- | -------------------------------- |
| $q\in\mathbb{R}^{n}$                                        | joint positions                  |
| $\dot{q},\ \ddot{q}$                                        | joint velocities, accelerations  |
| $q_{d}(t)$                                                  | desired joint trajectory         |
| $\tilde q = q_{d}-q,\;\;\dot{\tilde q} = \dot q_{d}-\dot q$ | position / velocity errors       |
| $B(q)$                                                      | positive-definite inertia matrix |
| $C(q,\dot q)\dot q$                                         | Coriolis & centrifugal terms     |
| $g(q)$                                                      | gravity vector                   |
| $u$                                                         | commanded joint torques          |

---

#### 1. Robot dynamics

$$
B(q)\,\ddot q + C(q,\dot q)\,\dot q + g(q)=u
$$

---

#### 2. Control law (exact feedback linearisation)

$$
\boxed{\,u = B(q)\!\left[\,\ddot q_{d}+K_{D}\,\dot{\tilde q}+K_{P}\,\tilde q\,\right] + C(q,\dot q)\,\dot q + g(q)\,}
$$

* $K_{P},K_{D}\in\mathbb{R}^{n\times n}$: symmetric positive-definite (often diagonal).
* The bracketed term is a **virtual acceleration** that shapes the closed-loop error as

$$
\ddot{\tilde q}+K_{D}\,\dot{\tilde q}+K_{P}\,\tilde q = 0,
$$

i.e. $n$ uncoupled, critically damped second-order systems.

---

#### 3. When to use

* High-performance joint-space **trajectory tracking** (industrial manipulators, force-controlled arms).
* Situations where the full rigid-body model is known accurately and real-time torque commands are available.

---

#### 4. Key take-away

By cancelling inertia, Coriolis and gravity exactly, feedback linearization makes the robot behave like $n$ independent unit-mass actuators; PD gains then govern error convergence with familiar second-order dynamics. Accurate model knowledge is essential—any mismatch directly degrades performance.
