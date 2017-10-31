
<a id='EAGOBranchBound.jl-1'></a>

# EAGOBranchBound.jl

- [EAGOBranchBound.jl](index.md#EAGOBranchBound.jl-1)
    - [Branch and Bound Types](index.md#Branch-and-Bound-Types-1)
    - [Branch and Bound Functions](index.md#Branch-and-Bound-Functions-1)
    - [Index](index.md#Index-1)


<a id='Branch-and-Bound-Types-1'></a>

## Branch and Bound Types

<a id='EAGOBranchBound.BnB' href='#EAGOBranchBound.BnB'>#</a>
**`EAGOBranchBound.BnB`** &mdash; *Type*.



BnB contains all relevant options and functions required to solve a branch-and-bound problem. The fields in this type are:

  * Init_Box:    Contains the initial box (interval box) used to setup the problem.
  * Lower_Prob:  <p> Stores the function containing the lower bounding problem. This function must return a tuple (val::Float64, sol::Array, feas::Bool). <p>
  * Upper_Prob:  <p> Stores the function containing the upper bounding problem. This function must return a tuple (val::Float64, sol::Array, feas::Bool). <p>
  * Term_Check:  Stores a function used to check for termination.
  * Branch_Sto:  Stores a function that to store nodes on the stack of a BNBObject.
  * Node_Select: Stores a function which selects a node from the BNBObject stack.
  * Bisect_Func: Stores a function for bisecting nodes.
  * Verbosity:   <p> A string that sets the verbosity of the output. The setting "None" prevents any output from appearing in the console. The setting "Normal" results in the iteration number, number of nodes remaining,              the current LBD, global LBD/UBD, the absolute gap and ratio. The "Full" setting prints current node information in addition to the normal information. <p>
  * max_iter:    Maximum iteration number when the default termination check.
  * iter_lim:    A boolean flag that indicates a maximum iteration limit termination condition is used.
  * max_nodes:   The maximum number of nodes that can be stored on the stack prior to the problem terminating.
  * BnB_tol:     The absolute convergence tolerance for the B&B routine.
  * UBDg:        An array of Float64 objects storing the upper bounds at each iteration of the problem.
  * LBGg:        An array of Float64 objects storing the lower bounds at each iteration of the problem.
  * LBDgtime:    An array of Float64 objects storing the lower bounds at each iteration of the problem.
  * UBDgtime:    An array of Float64 objects storing the upper bounds at each iteration of the problem.
  * pstar:       IntervalBox corresponding to the optimal point.
  * soln:        Optimal solution found.
  * soln_val:    Optimal solution value.
  * first_fnd:   Node id of first solution found.
  * feas_fnd:    Boolean flag indicating a feasible solution has been found.
  * first_num:   Number of the first node found.
  * max_id:      Maximum node id number.
  * itr_intv:    Number of iterations to skip between printing iteration information.
  * hdr_intv:    Number of iterations to skip between printing console header.
  * converged:   Convergence check for the algorithm.
  * BnB_rtol:    Relative tolerance for convergence check.
  * BnB_digits:  Number of digits to be displayed in the console output.
  * hist_return: <p> If set to false, it returns a solution value, a solution, and a feasibility flag. If set to false, the array of UBDs, LBDs, and solution times are found. <p>
  * opt:         A generic option array passed to each lower & upper bounding problem.

The 'BnB(X::IntervalBox)' constructor initializes the 'BnB' type using an IntervalBox X:

  * Init_Box:    Contains the initial box (interval box) used to setup the problem.
  * Lower_Prob:  []
  * Upper_Prob:  []
  * Term_Check:  <p> Default termination check: checks iteration number, relative/absolute tolerance, & number of nodes. <p>
  * Branch_Sto:  Defaults to best-first search.
  * Node_Select: Defaults to best-first search.
  * Bisect_Func: Defaults to relative midpoint bisection.
  * Verbosity:   Defaults to printing iterations.
  * iter_lim:    A boolean flag that indicates a maximum iteration limit termination condition is used.
  * max_nodes:   The maximum number of nodes that can be stored on the stack prior to the problem terminating.
  * BnB_tol:     Default tolerance is 1E-6.
  * UBDg:        Initialized to array containg Inf.
  * LBGg:        Initialized to array containing -Inf.
  * feas_fnd:    false
  * first_num:   0
  * max_id:      1
  * itr_intv:    1
  * hdr_intv:    20
  * converged:   Checks for absolute and relative tolerance.
  * BnB_rtol:    Default tolerance is 1E-4.
  * BnB_digits:  Number of digits to be displayed in the console output.
  * hist_return: false

<a id='EAGOBranchBound.BnBObject' href='#EAGOBranchBound.BnBObject'>#</a>
**`EAGOBranchBound.BnBObject`** &mdash; *Type*.



BnBObject{N} is used to store the working stack for a Branch and Bound problem. This type consists of four fields:

  * box: An array of IntervalBox{N,Float64} objects containing the remaining nodes.
  * LBD: An array of Float64 values containing lower bounds corresponding to each remaining node in box.
  * UBD: An array of Float64 values containing upper bounds corresponding to each remaining node in box.
  * id: An array containing the indexes of all nodes on the stack.


<a id='Branch-and-Bound-Functions-1'></a>

## Branch and Bound Functions


<a id='Setting-up-standard-B-and-B-options-1'></a>

### Setting up standard B&B options

<a id='EAGOBranchBound.set_Branch_Scheme!' href='#EAGOBranchBound.set_Branch_Scheme!'>#</a>
**`EAGOBranchBound.set_Branch_Scheme!`** &mdash; *Function*.



set_Branch_Scheme! specifies the bisection method: "best", "breadth", or "depth".

<a id='EAGOBranchBound.set_Bisect_Func!' href='#EAGOBranchBound.set_Bisect_Func!'>#</a>
**`EAGOBranchBound.set_Bisect_Func!`** &mdash; *Function*.



set_Bisect_Func! specifies the bisection method: "relative midpoint", or "absolute midpoint".

<a id='EAGOBranchBound.set_Verbosity!' href='#EAGOBranchBound.set_Verbosity!'>#</a>
**`EAGOBranchBound.set_Verbosity!`** &mdash; *Function*.



set_Verbosity! specifies the verbosity of the console return: "None","Normal","Full".

<a id='EAGOBranchBound.set_to_default!' href='#EAGOBranchBound.set_to_default!'>#</a>
**`EAGOBranchBound.set_to_default!`** &mdash; *Function*.



set_to_default!

The 'set_to_default!(x::BnB)' function restores the 'x::BnB' object to it's default parameters.


<a id='Solving-B-and-B-problems-1'></a>

### Solving B&B problems

<a id='EAGOBranchBound.solve' href='#EAGOBranchBound.solve'>#</a>
**`EAGOBranchBound.solve`** &mdash; *Function*.



solve runs the branch-and-bound problem defined by the BnB type x and the BnBObject type y.


<a id='Index-1'></a>

## Index

- [`EAGOBranchBound.BnB`](index.md#EAGOBranchBound.BnB)
- [`EAGOBranchBound.BnBObject`](index.md#EAGOBranchBound.BnBObject)
- [`EAGOBranchBound.set_Bisect_Func!`](index.md#EAGOBranchBound.set_Bisect_Func!)
- [`EAGOBranchBound.set_Branch_Scheme!`](index.md#EAGOBranchBound.set_Branch_Scheme!)
- [`EAGOBranchBound.set_Verbosity!`](index.md#EAGOBranchBound.set_Verbosity!)
- [`EAGOBranchBound.set_to_default!`](index.md#EAGOBranchBound.set_to_default!)
- [`EAGOBranchBound.solve`](index.md#EAGOBranchBound.solve)

