
<a id='EAGOBranchBound-1'></a>

# EAGOBranchBound


EAGOBranchBound contains a flexible branch and bound library. This package allows the user to specify termination criteria, lower & upper bounding problems, as well as search criteria.


<a id='Introduction-1'></a>

## Introduction


More text

<a id='EAGOBranchBound.BnBModel' href='#EAGOBranchBound.BnBModel'>#</a>
**`EAGOBranchBound.BnBModel`** &mdash; *Type*.



```
BnBModel
```

Stores attributes of stack used to solve BnB problem. Has the following fields:

  * `Init_Box::Vector{Interval{Float64}}`: stores initial interval box used
  * box::Vector{Vector{Interval{Float64}}}     # interval box storage stack
  * Init_Integer::Vector{Vector{Int64}}        # initial integer range
  * integers::Vector{Vector{Vector{Int64}}}    # integer range storage stack
  * LBD::Vector{Float64}                       # lower bounds associated with each stack item
  * UBD::Vector{Float64}                       # Upper bounds associated with each stack item
  * id::Vector{Int64}                          # Node ID for each stack item
  * pos::Vector{Int64}                         # Position in BnB Tree for each stack item
  * LBDg::Float64                              # Global Lower Bound
  * UBDg::Float64                              # Global Upper Bound
  * LBDg_hist::Vector{Float64}                 # Value history LBD problem
  * UBDg_hist::Vector{Float64}                 # Value history UBD problem
  * LBDgtime::Vector{Float64}                  # Run time history LBD problem
  * UBDgtime::Vector{Float64}                  # Run time history UBD problem
  * max_id::Int64                              # Max node used
  * pstar::Vector{Interval{Float64}}           # IntervalBox with solution
  * soln::Vector{Float64}                      # Storage for solution
  * soln_val::Float64                          # Solution value found
  * first_fnd::Bool                            # Has a solution been found
  * feas_fnd::Bool                             # Has a feasible point been found
  * first_num::Int64                           # Iteration at which first solution found
  * lbcnt::Int64                               # number of lower bounding problems solved
  * ubcnt::Int64                               # number of upper bounding problems solved


<a target='_blank' href='https://github.com/MatthewStuber/EAGOBranchBound/blob/d813f791ba2dbe71fcf18727777a2f3316501f5f/src\src\types\BnBModel.jl#L1-L28' class='documenter-source'>source</a><br>

<a id='EAGOBranchBound.BnBSolver' href='#EAGOBranchBound.BnBSolver'>#</a>
**`EAGOBranchBound.BnBSolver`** &mdash; *Type*.



```
BnBSolver
```

Stores solver specific functions used to solve BnB problem. Has the following fields: Lower_Prob::Any        # Stores lower problem function Upper_Prob::Any        # Stores upper problem function Term_Check::Any        # Stores termination check function Branch_Sto::Any        # Stores branching function Node_Select::Any       # Stores node selection function Bisect_Func::Any       # Stores branching function Verbosity::String      # Stores output selection max_iter::Number       # max number of iterations iter_lim::Bool         # determines if iteration limit is checked max_nodes::Int64       # max number of nodes to store in memory BnB_atol::Float64      # absolute tolerance for BnB BnB_rtol::Float64      # relative tolerance for BnB itr_intv::Int64        # number of iterations to skip between printing iteration summary hdr_intv::Int64        # number of iterations to skip between printing header converged::Any         # convergence criterion BnB_digits::Int64      # digits displayed before decimal hist_return::Bool      # returns LBD, UBD array and time vector opt::Any               # optional storage array exhaust::Bool          # exhaustive search: find all solns or find first target_upper::Float64


<a target='_blank' href='https://github.com/MatthewStuber/EAGOBranchBound/blob/d813f791ba2dbe71fcf18727777a2f3316501f5f/src\src\types\BnBSolver.jl#L1-L25' class='documenter-source'>source</a><br>

<a id='EAGOBranchBound.solveBnB!' href='#EAGOBranchBound.solveBnB!'>#</a>
**`EAGOBranchBound.solveBnB!`** &mdash; *Function*.



```
solveBnB!(x::BnBSolver,y::BnBModel)
```

Solves the branch and bound problem with the input model and solver object.


<a target='_blank' href='https://github.com/MatthewStuber/EAGOBranchBound/blob/d813f791ba2dbe71fcf18727777a2f3316501f5f/src\src\solve.jl#L1-L5' class='documenter-source'>source</a><br>

<a id='EAGOBranchBound.Bisect_Abs' href='#EAGOBranchBound.Bisect_Abs'>#</a>
**`EAGOBranchBound.Bisect_Abs`** &mdash; *Function*.



```
Bisect_Abs(S::BnBSolver,B::BnBModel,N::Vector{Interval{Float64}})
```

Returns two interval boxes 'X1,X2' created by bisecting 'N' in the highest width dimension.


<a target='_blank' href='https://github.com/MatthewStuber/EAGOBranchBound/blob/d813f791ba2dbe71fcf18727777a2f3316501f5f/src\src\schemes\Bisect_Method.jl#L1-L5' class='documenter-source'>source</a><br>

<a id='EAGOBranchBound.Bisect_Abs_Imp' href='#EAGOBranchBound.Bisect_Abs_Imp'>#</a>
**`EAGOBranchBound.Bisect_Abs_Imp`** &mdash; *Function*.



```
Bisect_Abs_Imp(S::BnBSolver,B::BnBModel,N::Vector{Interval{Float64}})
```

Returns two interval boxes 'X1,X2' created by bisecting 'N' in the highest width dimension greater than 'nx'.


<a target='_blank' href='https://github.com/MatthewStuber/EAGOBranchBound/blob/d813f791ba2dbe71fcf18727777a2f3316501f5f/src\src\schemes\Bisect_Method.jl#L31-L36' class='documenter-source'>source</a><br>

<a id='EAGOBranchBound.Bisect_Rel' href='#EAGOBranchBound.Bisect_Rel'>#</a>
**`EAGOBranchBound.Bisect_Rel`** &mdash; *Function*.



```
Bisect_Rel(S::BnBSolver,B::BnBModel,N::Vector{Interval{Float64}})
```

Returns two interval boxes 'X1,X2' created by bisecting 'N' in the highest width dimension after scaling by initial box size.


<a target='_blank' href='https://github.com/MatthewStuber/EAGOBranchBound/blob/d813f791ba2dbe71fcf18727777a2f3316501f5f/src\src\schemes\Bisect_Method.jl#L16-L20' class='documenter-source'>source</a><br>

<a id='EAGOBranchBound.Bisect_Rel_Imp' href='#EAGOBranchBound.Bisect_Rel_Imp'>#</a>
**`EAGOBranchBound.Bisect_Rel_Imp`** &mdash; *Function*.



```
Bisect_Rel_Imp(S::BnBSolver,B::BnBModel,N::Vector{Interval{Float64}})
```

Returns two interval boxes 'X1,X2' created by bisecting 'N' in the highest width dimension greater than 'nx' after scaling by initial box size.


<a target='_blank' href='https://github.com/MatthewStuber/EAGOBranchBound/blob/d813f791ba2dbe71fcf18727777a2f3316501f5f/src\src\schemes\Bisect_Method.jl#L47-L52' class='documenter-source'>source</a><br>

<a id='EAGOBranchBound.BM_breadth!' href='#EAGOBranchBound.BM_breadth!'>#</a>
**`EAGOBranchBound.BM_breadth!`** &mdash; *Function*.



```
BM_breadth!(S::BnBSolver,B::BnBModel,tL::Float64,tU::Float64,
            X1::Vector{Interval{Float64}},X2::Vector{Interval{Float64}},
            pos::Int64)
```

Stores two interval boxes 'X1,X2' to the bottom of the stack along with their respective lower, 'tL' and upper bounds, 'tU' and their position number in the BnB tree. Also, assigns node numbers.


<a target='_blank' href='https://github.com/MatthewStuber/EAGOBranchBound/blob/d813f791ba2dbe71fcf18727777a2f3316501f5f/src\src\schemes\Branch_Method.jl#L1-L9' class='documenter-source'>source</a><br>

<a id='EAGOBranchBound.BM_depth_best!' href='#EAGOBranchBound.BM_depth_best!'>#</a>
**`EAGOBranchBound.BM_depth_best!`** &mdash; *Function*.



```
BM_depth_best!(S::BnBSolver,B::BnBModel,tL::Float64,tU::Float64,
            X1::Vector{Interval{Float64}},X2::Vector{Interval{Float64}},
            pos::Int64)
```

Stores two interval boxes 'X1,X2' to the top of the stack along with their respective lower, 'tL' and upper bounds, 'tU' and their position number in the BnB tree. Also, assigns node numbers.


<a target='_blank' href='https://github.com/MatthewStuber/EAGOBranchBound/blob/d813f791ba2dbe71fcf18727777a2f3316501f5f/src\src\schemes\Branch_Method.jl#L21-L29' class='documenter-source'>source</a><br>

<a id='EAGOBranchBound.NS_best' href='#EAGOBranchBound.NS_best'>#</a>
**`EAGOBranchBound.NS_best`** &mdash; *Function*.



```
NS_best(B::BnBModel)
```

Selects node with the lowest upper lower bound. Returns (IntvBox,LBD,UBD,id,pos) where Intv is the intervalbox, LBD is the lower bound of the node, UBD is the upper bound of the node, id is the id number of the node, and pos is the position of the node in the BnB tree.


<a target='_blank' href='https://github.com/MatthewStuber/EAGOBranchBound/blob/d813f791ba2dbe71fcf18727777a2f3316501f5f/src\src\schemes\Node_Select.jl#L1-L8' class='documenter-source'>source</a><br>

<a id='EAGOBranchBound.NS_depth_breadth' href='#EAGOBranchBound.NS_depth_breadth'>#</a>
**`EAGOBranchBound.NS_depth_breadth`** &mdash; *Function*.



```
NS_depth_breadth(B::BnBModel)
```

Selects node on the top of the stack. Returns (IntvBox,LBD,UBD,id,pos) where Intv is the intervalbox, LBD is the lower bound of the node, UBD is the upper bound of the node, id is the id number of the node, and pos is the position of the node in the BnB tree.


<a target='_blank' href='https://github.com/MatthewStuber/EAGOBranchBound/blob/d813f791ba2dbe71fcf18727777a2f3316501f5f/src\src\schemes\Node_Select.jl#L14-L21' class='documenter-source'>source</a><br>

<a id='EAGOBranchBound.getsolution' href='#EAGOBranchBound.getsolution'>#</a>
**`EAGOBranchBound.getsolution`** &mdash; *Function*.



```
getsolution(x::BnBModel)
```

Returns the solution stored in the BnBModel.


<a target='_blank' href='https://github.com/MatthewStuber/EAGOBranchBound/blob/d813f791ba2dbe71fcf18727777a2f3316501f5f/src\src\utils\Access.jl#L1-L5' class='documenter-source'>source</a><br>

<a id='EAGOBranchBound.getobjval' href='#EAGOBranchBound.getobjval'>#</a>
**`EAGOBranchBound.getobjval`** &mdash; *Function*.



```
getobjval(x::BnBModel)
```

Returns the objective value stored in BnBModel (global upper bound).


<a target='_blank' href='https://github.com/MatthewStuber/EAGOBranchBound/blob/d813f791ba2dbe71fcf18727777a2f3316501f5f/src\src\utils\Access.jl#L8-L12' class='documenter-source'>source</a><br>

<a id='EAGOBranchBound.getobjbound' href='#EAGOBranchBound.getobjbound'>#</a>
**`EAGOBranchBound.getobjbound`** &mdash; *Function*.



```
getobjbound(x::BnBModel)
```

Returns the objective value stored in BnBModel (global upper bound).


<a target='_blank' href='https://github.com/MatthewStuber/EAGOBranchBound/blob/d813f791ba2dbe71fcf18727777a2f3316501f5f/src\src\utils\Access.jl#L15-L19' class='documenter-source'>source</a><br>

<a id='EAGOBranchBound.getfeasibility' href='#EAGOBranchBound.getfeasibility'>#</a>
**`EAGOBranchBound.getfeasibility`** &mdash; *Function*.



```
getfeasibility(x::BnBModel)
```

Returns feasibility of problem (feasible point found?).


<a target='_blank' href='https://github.com/MatthewStuber/EAGOBranchBound/blob/d813f791ba2dbe71fcf18727777a2f3316501f5f/src\src\utils\Access.jl#L22-L26' class='documenter-source'>source</a><br>

<a id='EAGOBranchBound.LBDtime' href='#EAGOBranchBound.LBDtime'>#</a>
**`EAGOBranchBound.LBDtime`** &mdash; *Function*.



```
LBDtime(x::BnBModel)
```

Returns time spent solving lower bounding problem.


<a target='_blank' href='https://github.com/MatthewStuber/EAGOBranchBound/blob/d813f791ba2dbe71fcf18727777a2f3316501f5f/src\src\utils\Access.jl#L29-L33' class='documenter-source'>source</a><br>

<a id='EAGOBranchBound.UBDtime' href='#EAGOBranchBound.UBDtime'>#</a>
**`EAGOBranchBound.UBDtime`** &mdash; *Function*.



```
UBDtime(x::BnBModel)
```

Returns time spent solving upper bounding problem.


<a target='_blank' href='https://github.com/MatthewStuber/EAGOBranchBound/blob/d813f791ba2dbe71fcf18727777a2f3316501f5f/src\src\utils\Access.jl#L36-L40' class='documenter-source'>source</a><br>

<a id='EAGOBranchBound.set_Branch_Scheme!' href='#EAGOBranchBound.set_Branch_Scheme!'>#</a>
**`EAGOBranchBound.set_Branch_Scheme!`** &mdash; *Function*.



```
set_Branch_Scheme!(x::BnBSolver,BM::String)
```

Sets the search scheme to "best", "breadth", or "depth" first schemes.


<a target='_blank' href='https://github.com/MatthewStuber/EAGOBranchBound/blob/d813f791ba2dbe71fcf18727777a2f3316501f5f/src\src\utils\Set_Options.jl#L1-L5' class='documenter-source'>source</a><br>

<a id='EAGOBranchBound.set_Bisect_Func!' href='#EAGOBranchBound.set_Bisect_Func!'>#</a>
**`EAGOBranchBound.set_Bisect_Func!`** &mdash; *Function*.



```
set_Bisect_Func!(x::BnBSolver,BF::String,nx::Int64)
```

Sets the bisection function to BF = "relative midpoint" or BF = "absolute midpoint" and disregards the first nx components of the interval box storage.


<a target='_blank' href='https://github.com/MatthewStuber/EAGOBranchBound/blob/d813f791ba2dbe71fcf18727777a2f3316501f5f/src\src\utils\Set_Options.jl#L21-L27' class='documenter-source'>source</a><br>

<a id='EAGOBranchBound.set_Verbosity!' href='#EAGOBranchBound.set_Verbosity!'>#</a>
**`EAGOBranchBound.set_Verbosity!`** &mdash; *Function*.



```
set_Verbosity!(x::BnBSolver,VB::String)
```

Sets the verbosity (console output) to either "None", "Normal", or "Full".


<a target='_blank' href='https://github.com/MatthewStuber/EAGOBranchBound/blob/d813f791ba2dbe71fcf18727777a2f3316501f5f/src\src\utils\Set_Options.jl#L48-L52' class='documenter-source'>source</a><br>

<a id='EAGOBranchBound.set_to_default!' href='#EAGOBranchBound.set_to_default!'>#</a>
**`EAGOBranchBound.set_to_default!`** &mdash; *Function*.



```
set_to_default!(x::BnBSolver)
```

Returns the B&B solver to the default settings.


<a target='_blank' href='https://github.com/MatthewStuber/EAGOBranchBound/blob/d813f791ba2dbe71fcf18727777a2f3316501f5f/src\src\utils\Set_Options.jl#L61-L65' class='documenter-source'>source</a><br>

- [`EAGOBranchBound.BnBModel`](index.md#EAGOBranchBound.BnBModel)
- [`EAGOBranchBound.BnBSolver`](index.md#EAGOBranchBound.BnBSolver)
- [`EAGOBranchBound.BM_breadth!`](index.md#EAGOBranchBound.BM_breadth!)
- [`EAGOBranchBound.BM_depth_best!`](index.md#EAGOBranchBound.BM_depth_best!)
- [`EAGOBranchBound.Bisect_Abs`](index.md#EAGOBranchBound.Bisect_Abs)
- [`EAGOBranchBound.Bisect_Abs_Imp`](index.md#EAGOBranchBound.Bisect_Abs_Imp)
- [`EAGOBranchBound.Bisect_Rel`](index.md#EAGOBranchBound.Bisect_Rel)
- [`EAGOBranchBound.Bisect_Rel_Imp`](index.md#EAGOBranchBound.Bisect_Rel_Imp)
- [`EAGOBranchBound.LBDtime`](index.md#EAGOBranchBound.LBDtime)
- [`EAGOBranchBound.NS_best`](index.md#EAGOBranchBound.NS_best)
- [`EAGOBranchBound.NS_depth_breadth`](index.md#EAGOBranchBound.NS_depth_breadth)
- [`EAGOBranchBound.UBDtime`](index.md#EAGOBranchBound.UBDtime)
- [`EAGOBranchBound.getfeasibility`](index.md#EAGOBranchBound.getfeasibility)
- [`EAGOBranchBound.getobjbound`](index.md#EAGOBranchBound.getobjbound)
- [`EAGOBranchBound.getobjval`](index.md#EAGOBranchBound.getobjval)
- [`EAGOBranchBound.getsolution`](index.md#EAGOBranchBound.getsolution)
- [`EAGOBranchBound.set_Bisect_Func!`](index.md#EAGOBranchBound.set_Bisect_Func!)
- [`EAGOBranchBound.set_Branch_Scheme!`](index.md#EAGOBranchBound.set_Branch_Scheme!)
- [`EAGOBranchBound.set_Verbosity!`](index.md#EAGOBranchBound.set_Verbosity!)
- [`EAGOBranchBound.set_to_default!`](index.md#EAGOBranchBound.set_to_default!)
- [`EAGOBranchBound.solveBnB!`](index.md#EAGOBranchBound.solveBnB!)


<a id='User-Documentation-1'></a>

## User Documentation

