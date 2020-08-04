# Root finding by bisection


## Objectives

* Describe the bisection method for root finding
* Analyze the method, including predicting the rate at which the average error decreases
* Write an implementation in Julia

Consider a continuous function $f$ of one real variable defined on a closed interval $[a,b]$ with $f(a) f(b) < 0$. (The function can be defined on a larger interval, of course, and can have discontinuities outside this interval.) This means we have two values $a$ and $b$ chosen such that the sign of $f$ changes on this interval. By the intermediate value theorem we know there is at least one value $c$ with $a<c<b$ such that $f(c)=0$. Our goal is to approximate that value. (We can't necessarily find it, since it might not be representable as a floating point number; for example $c$ could be irrational.)

The interval $[a,b]$ is said to bracket the root $c$. Our goal is to rapidly shrink the size of the interval while maintaining the bracket. An easy method is to bisect the interval (cut it in half) by evaluating the function at the midpoint $m = (a+b)/2$. While it is possible that $f(m)=0$, in general $f(m)$ will be either positive or negative. We then choose the interval $[a,m]$ or $[m,b]$ which brackets a root. (There could be additional roots in the other interval, but we will discard these.) We repeat this process, shrinking the size of the interval by a factor of 2 as many times as desired, until the size of the interval is sufficiently small, or until the value $f(m)$ is sufficiently close to 0.

Here's our algorithm, written in words first, then in Julia:

Input: a function $f$, a bracket $[a,b]$, and an absolute tolerance $\epsilon$ on both the width of the interval and the value of the function at the midpoint.
Output: A bracket $[a,b]$.

* Check if $|f(a)|$ or $|f(b)|$ is less than $\epsilon$. If any satisfy this inequality, return a small bracket containing the root.
* Check that $f(a)f(b)<0$. Return an error if this is not true.
* Check that $\epsilon>eps(a+b)$. Set $\epsilon = 2*eps(a+b)$ and give a warning if the inequality is not satisfied.
* Loop while $|a-b|>\epsilon$
  * Compute $m=(a+b)/2$
  * Check if $f(m) < \epsilon$ and return a small bracket if we found a root.
  * Select the appropriate interval.
* Return the interval

```@example 1
function myBisection(f, a, b, epsilon)
  fa = f(a)
  fb = f(b)
    if (abs(fa) < epsilon) return([a - eps(a), a+eps(a)]) end
    if (abs(fb) < epsilon) return([b - eps(b), b+eps(b)]) end 
    if sign(fa) * sign(fb) > 0 
      error("You didn't start with a bracket.")
    end
    if epsilon < 2*eps(a+b)
      @warn "Epsilon too small. Increasing it."
      epsilon = 2*eps(a+b)
    end
      
  while abs(a-b) > epsilon
	  m = (a+b)/2
  	fm = f(m)
        if (abs(fm) < epsilon) return([m - eps(m), m + eps(m)]) end
	  if sign(fa) * sign(fm) < 0
	    b = m
	    fb = fm
    elseif sign(fb) * sign(fm) < 0
  	  a = m
	    fa = fm
  	else # error
	    @error "This shouldn't happen."
	  end  
  end
  return([a,b])
end
```

Having written this function, we should test it. Develop a test for each way you think the calculation could go wrong, and for each error you think you have tested for.

But first, have some fun and find the square root of 2, or solve $xe^x = 1$.

```@example 1
f(x) = x^2 - 2
myBisection(f, 0, 2.0, 1e-12)
myBisection(x -> x*exp(x) - 1, 0, 10.0, 1e-10)
```

Known problems with this function: a+b must be a floating point number not an integer.

Tests.

```@repl 1
myBisection(x -> x - 2, 0.0, 2.0, 1e-5)
myBisection(x -> x - 2, 0.0, 4.0, 1e-5) # There is a third test to accompany these; write it.
```

Generate an error and a warning.

```@repl 1
myBisection(x -> x - 2, 4.0, 5.0, 1e-5)
myBisection(x -> x - 2, 0.0, 4.0, 1e-52)
```

Ultimately the goal with writing tests is to ensure that you have enough examples that all the code eventually gets "used" and that the correct results are found. For example, to be sure that I am testing the code that selects both the left and right sides of a bracket, construct examples that are guaranteed to to that on the first iteration.

```@example 1
myBisection(x -> x - 2, 1.9, 5.0, 1e-5)
myBisection(x -> x - 2, 0.0, 2.1, 1e-5)

```

Modify the function to return the midpoint of the best interval instead of an interval.

Besides arithmetic, we used the following techniques in these examples:

* [function](https://docs.julialang.org/en/v1/base/base/#function) definition
* [anonymous functions](https://docs.julialang.org/en/v1/manual/functions/#man-anonymous-functions-1)
* [if elseif end](https://docs.julialang.org/en/v1/base/base/#if) control flow
* [while end](https://docs.julialang.org/en/v1/base/base/#while) control flow
* [@error and @warn](https://docs.julialang.org/en/v1/stdlib/Logging/#Logging.@logmsg) for writing messages and [error](https://docs.julialang.org/en/v1/base/base/#Errors-1) for throwing exceptions.
* [return](https://docs.julialang.org/en/v1/base/base/#return)

Read the documentation and examples linked above for any parts of this code that you are unsure of.

Check your understanding by making some changes to the code:

* Change `return([a,b])` to `[a,b]` on the last line of the function (before end)
* What happens if you make the same change to other `return` statements?
* Change an `@warn` to `@error` or `error()`.


More advanced checks.

* What happens if you use Float16 or BigFloat types for `a` and `b`?

```@example 1
myBisection(x -> x*exp(x) - 1, Float16(0.0), Float16(10.0), 1e-80)
myBisection(x -> x*exp(x) - 1, BigFloat(0.0), BigFloat(10.0), 1e-80)
```

The pause before you get the result for each of those calculations is Julia compiling new code for these data types. Repeat the same calculation and notice how much faster it is.

Modifications.

Count the number of times through the while loop. Return a bracket as the first entry of a vector and the number of times through the loop as the second element. Return 0 for the count if you never enter the loop.

Modify the function to return a sequence of estimates of the root. You can create a vector and then add to it using `append!` as in the following example. The append function is different from other functions we've used so far -- it modifies its first argument. The convention in Julia is to put an exclamation mark in the name of functions that do this.

```@example
result = [1.2]
append!(result, 2)
```


## References

* Bisection method: [Wikipedia](https://en.wikipedia.org/wiki/Bisection_method), [MathWorld](https://mathworld.wolfram.com/Bisection.html)


# Root finding by fixed point methods

# Root finding  - other methods

Secant method
	