# Root finding: Overview

Root finding is the process of finding one or more, or possibly all, solutions to a set of one or more equations of the form $f(x)=0$.

In calculus, we frequently want to find roots as part of the optimization process. Roots identify critical points and allow us to categorize these points as maxima, minima, or neither.

In linear algebra, the roots of the characteristic polynomial equation are the eigenvalues of a matrix.

In differential equations, roots are used to identify equilibrium points of a dynamical system.

Root finding is valuable in many application areas as well. For example, in physics (mechanics) for finding collisions between two objects along separate trajectories. Or in chemistry for making predictions about chemical reactions.

Symbolic manipulation of expressions with software can be used to find roots mimicking pencil and paper methods, but in numerical analysis we will generally assume the function is a “black box” that we can’t see inside. We will assume some properties of the system we are solving, such as continuity or differentiability, but we will not be performing algebraic transformations to find solutions.

They key theorems we rely on are the intermediate value theorem and the mean value theorem. The intermediate value theorem tells us that a continuous function which changes sign on an interval has a root bracketed between the places where it changes sign. The mean value theorem says that, for a differentiable function, the average slope over an interval is exactly equal to the derivative at at least one location on that interval.

## Resources

Wikipedia: [IVT](https://en.wikipedia.org/wiki/Intermediate_value_theorem), [MVT](https://en.wikipedia.org/wiki/Mean_value_theorem), [Root-finding algorithms](https://en.wikipedia.org/wiki/Root-finding_algorithms)

Mathworld: [Roots](https://mathworld.wolfram.com/Root.html), [IVT](https://mathworld.wolfram.com/IntermediateValueTheorem.html), [MVT](https://mathworld.wolfram.com/Mean-ValueTheorem.html)

Texts: Burden & Faires Chapter X.

