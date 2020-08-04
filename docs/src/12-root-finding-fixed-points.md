# Fixed point iteration


Define a sequence $x_{n+1} = f(x_n)$. If the sequence converges for some initial $x_0$ to $x_*$ so that $x_* = f(x_*)$ then we say that $x_*$ is a fixed point of $f$. An example of such a function is $f(x)=\cos(x)$. 

```@repl 1
f(x) = cos(x)
xSeq = zeros(20)
xSeq[1] = 1.0
for i in 2:20
    xSeq[i] = f(xSeq[i-1])
end
```

Plot this sequence.

```@example 1
# using Pkg; Pkg.add("Plots")  # Uncomment this line and use it once on your computer to install Plots
using Plots
scatter(xSeq,  title="Sequence x(n+1) = cos x(n)")
```



```@example 1
xx = range(0, pi/2.0, length=100)
plot(xx, cos.(xx), ylims=(0,1.1), label="y = cos x")
plot!(xx, xx, label="y = x")
scatter!((xSeq[end], xSeq[end]), label=["solution"])
```

Exercise: Repeat these calculations for other funtions f. Find an example that gives a convergent sequence and an example that gives a divergent sequence.

Hint: Try $f(x) = sqrt(x)-x$. Graph $y=\sqrt{x}$ and $y=x$ and see if you can figure out what is going on. Then try $f(x) = x^2 - x$. Now that I've given you those functions, find different ones.


## Newton's method
Newton's method is a modified fixed point iteration, like the sequence defined by $\cos x$ above. To solve $f(x)=0$ for a non-linear function $f$, write a linear approximation: $f(x_1) \approx f(x_0) + f'(x_0)(x_1-x_0)$. If $x_0$ is known, and we want $f(x_1)=0$, solve for $x_1$ to obtain $$ x_1 = x_0 - \frac{f(x_0)}{f'(x_0)}.$$ Since we used a linear approximation, $x_1$ will not be a solution, but under some circumstances this process will define a sequence that converges to a solution.



```@example 2
function myNewton(f, df, x0, n)
  tol = 10 * eps()
  f0 = f(x0)
  while n > 0 && abs(f0) > tol
    n -= 1
    df0 = df(x0)
	if abs(df0) > tol 
  	  x1 = x0 - f0/df0
	  x0 = x1
	  f0 = f(x1)
	end
  end
  x0
end
```


We need to provide $f$, $f'$ and a starting value.

```@example 2
root2 = myNewton(x -> x .^ 2 - 2.0, x -> 2.0*x, 0.1, 20)
```

Compare that to the answer.

```@example 2
root2 - sqrt(2.0)
```

Suppose the function is not differentiable somewhere near the root you care about. You could approximate the derivative using a simple approximation (the Newton-quotient from introductory calculus) and then we only need to specify $f$ and a starting value $x_0$.


```@example 2
function myNewtonD(f, x0, n)
  h = 1.0e-4
  tol = 10 * eps()
  f0 = f(x0)
  while n > 0 && abs(f0) > tol
    n -= 1
    df = (f(x0+h)-f0)/h
	if abs(df) > tol 
  	  x1 = x0 - f0/df
	  x0 = x1
	  f0 = f(x1)
	end
  end
  x0
end

myNewtonD(f, 0.1, 20)
myNewtonD(x -> abs(x) - 2, 0.0, 4.0)
```


## Belongs elsewhere

## Secant method
These ideas can also be combined to perform a secant method search. Starting with two values, use successive secant slopes to approximate the root and form a convergent sequence.

```@example 1
function mySecant(f, x0, x1, n)
  tol = 10 * eps()
  f0 = f(x0)
  f1 = f(x1)
  while n > 0
    n -= 1
    dx = x1-x0
    df = f1-f0
	if df/dx != 0 && abs(dx) > tol
  	  x2 = x0 - f0/(df/dx)
	  x0, x1 = x1, x2
	  f0, f1 = f1, f(x2)
	end
  end
  x1
end

mySecant(f, 0.0, 2.0, 20)
```


## Plotting convergence
Each of these methods can be modified to output the full sequence instead of just the last term. We can then plot the sequence and the difference between the sequence and the true solution. Here's an example using Newton's method.

```@example 1
function myNewton2(f, df, x0, n)
  tol = 10 * eps()
  x = fill(NaN, n+1)
  fx = fill(NaN, n+1)
  dfx = fill(NaN, n+1)
  i = 1
  x[i] = x0
  fx[i] = f(x[i])
  dfx[i] = df(x[i])
  while n > i && abs(fx[i]) > tol
    i += 1
	if abs(dfx[i-1]) > tol 
  	  x[i] = x[i-1] - fx[i-1]/dfx[i-1]
	  fx[i] = f(x[i])
      dfx[i] = df(x[i])
	end
  end
  x[1:i]
  # [(x[j], fx[j], dfx[j]) for j in 1:i] # an array of triples of (x, f(x), f'(x))
end

root2Seq = myNewton2(x -> x .^ 2.0 - 2.0, x -> 2.0 * x, 0.1, 10)
```

Plot

```@example 1
scatter(root2Seq)
```

It's always a good idea to add labels to the axes and to the legend if more than one graph is shown. In fact, a graph is not complete until it is labeled.

```@example 1
scatter(log10.(abs.(root2Seq .- sqrt(2.0))), ylab = "log 10 absolute error", xlab="iteration", legend=false)
```


More material

```@example 1
using Roots
fzero(x -> x^3+x-4, 1.0)
(x -> x^3+x-4)(1.378796700129551)
(x -> x^3+x-4)(1.37939)
s(t) = 300.0 - 0.25 * 32.17 / 0.1 * t + (0.25)^2*32.17/(0.1)^2*(1-exp(-0.1*t/0.25))
g(t) = (300.0  + (0.25)^2*32.17/(0.1)^2*(1-exp(-0.1*t/0.25)))/( 0.25 * 32.17 / 0.1 )
tt = 0:0.1:7
using Plots
plot(tt, s.(tt)) # looks like it hits the ground at t = 6 seconds
g(6.01) # close to 0, but the slope of g is quite steep at the root, so this is not a good function to use for fixed point iteration
g(g(g(g(6.0))))
seq = fill(NaN, 10)
seq[1] = 6.0
for i in 2:10
    seq[i] = g(seq[i-1])
end
seq
```


