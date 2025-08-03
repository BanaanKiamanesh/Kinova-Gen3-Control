    ****### Quick README

**PD + Gravity Compensation (Joint-Space Posture Regulation)**

| Symbol               | Meaning                           |
| -------------------- | --------------------------------- |
| $q\in\mathbb R^{n}$  | joint positions                   |
| $\dot q,\;\ddot q$   | joint velocities, accelerations   |
| $q_{d}$              | *constant* desired posture        |
| $\tilde q = q_{d}-q$ | position error                    |
| $B(q)$               | positive-definite inertia matrix  |
| $C(q,\dot q)\dot q$  | Coriolis/centrifugal terms        |
| $g(q)$               | gravity vector                    |
| $u$                  | vector of commanded joint torques |

---

#### 1. Robot dynamics

$$
B(q)\,\ddot q \;+\; C(q,\dot q)\,\dot q \;+\; g(q)\;=\;u
$$

(Viscous & Coulomb friction omitted for clarity.)

---

#### 2. Control law

$$
\boxed{\,u \;=\; g(q)\;+\;K_{P}\,\tilde q \;-\; K_{D}\,\dot q\,}
$$

* $K_{P}, K_{D}\in\mathbb R^{n\times n}$ symmetric positive-definite (often chosen diagonal).
* The term $g(q)$ **cancels gravity exactly**; the remaining PD action behaves as a virtual spring-damper that pulls each joint toward $q_{d}$.&#x20;

---

#### 3. Lyapunov stability sketch

1. **Candidate function** (generalised energy)

   $$
   V(\dot q,\tilde q)=\frac12\dot q^{\!\top}B(q)\dot q+\frac12\tilde q^{\!\top}K_{P}\tilde q
   $$

   is positive-definite.

2. **Time derivative** (use skew-symmetry $\dot q^{\!\top}( \dot B -2C)\dot q = 0$)

   $$
   \dot V = -\,\dot q^{\!\top}K_{D}\dot q \;\le 0
   $$

3. $\dot V$ is negative-definite in $\dot q$; the largest invariant set where $\dot V=0$ is
   $\{\dot q=0\}$.  In this set, closed-loop statics give $K_{P}\tilde q=0\Rightarrow\tilde q=0$.
   By LaSalle, the equilibrium $(\tilde q,\dot q)=(0,0)$ is **globally asymptotically stable**.&#x20;

---

#### 4. When to use

* Posture regulation or slow end-point moves where coupling and velocity-dependent forces are moderate.
* Starting point for more advanced schemes (computed-torque / inverse dynamics, adaptive control, etc.).

---

#### 4. Key take-away

With exact gravity cancellation and positive-definite PD gains, the closed loop is **provably globally asymptotically stable** for *any* manipulator configuration. Implementation is straightforward—only the gravity vector must be evaluated online.
