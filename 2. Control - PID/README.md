### Quick README

**PID + Gravity Compensation (Joint-Space Posture Regulation)**

| Symbol                | Meaning                          |
| --------------------- | -------------------------------- |
| $q\in\mathbb{R}^{n}$  | joint positions                  |
| $\dot{q},\ \ddot{q}$  | joint velocities, accelerations  |
| $q_{d}$               | **constant** desired posture     |
| $\tilde{q}=q_{d}-q$   | position error                   |
| $B(q)$                | positive-definite inertia matrix |
| $C(q,\dot{q})\dot{q}$ | Coriolis/centrifugal terms       |
| $g(q)$                | gravity vector                   |
| $\tau$                | commanded joint torques          |

---

#### 1. Robot dynamics

$$
B(q)\ddot{q}+C(q,\dot{q})\dot{q}+g(q)=\tau
$$

---

#### 2. Control law

$$
u(t)=g(q)+K_{P} \tilde{q}+K_{I}\int_{0}^{t}\tilde{q}(\tau)d\tau-K_{D}\dot{q}
$$

$K_{P},K_{I},K_{D}$ are symmetric positive-definite gain matrices.

* Integral action removes steady-state error due to unmodelled disturbances.
* To prevent wind-up, the integrand can be passed through a saturation function
  $\Phi(\tilde{q})$ such as $\tanh(\tilde{q})$.

---

#### 3. When to use

* Tasks needing zero steady-state joint error under constant disturbances or modelling bias.
* Applications where simple gain tuning is preferred over full inverse-dynamics control.

---

#### 4. Key point

Gravity cancellation plus properly tuned PID gains achieves exact set-point tracking with straightforward implementation.
