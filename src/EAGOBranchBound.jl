__precompile__(true)

module EAGOBranchBound

using ValidatedNumerics
using IntervalArithmetic
using IntervalRootFinding

import IntervalArithmetic: @interval

export BnB, BnBObject, set_Branch_Scheme!, set_Bisect_Func!,
       set_Verbosity!, set_to_default!, solve

""" BnB contains all relevant options and functions required to solve a branch-and-bound problem. The fields in this type are:

- Init_Box:    Contains the initial box (interval box) used to setup the problem.
- Lower_Prob:  <p> Stores the function containing the lower bounding problem. This function must return a tuple (val::Float64, sol::Array, feas::Bool). <p>
- Upper_Prob:  <p> Stores the function containing the upper bounding problem. This function must return a tuple (val::Float64, sol::Array, feas::Bool). <p>
- Term_Check:  Stores a function used to check for termination.
- Branch_Sto:  Stores a function that to store nodes on the stack of a BNBObject.
- Node_Select: Stores a function which selects a node from the BNBObject stack.
- Bisect_Func: Stores a function for bisecting nodes.
- Verbosity:   <p> A string that sets the verbosity of the output. The setting "None" prevents any output from appearing in the console. The setting "Normal" results in the iteration number, number of nodes remaining,
               the current LBD, global LBD/UBD, the absolute gap and ratio. The "Full" setting prints current node information in addition to the normal information. <p>
- max_iter:    Maximum iteration number when the default termination check.
- iter_lim:    A boolean flag that indicates a maximum iteration limit termination condition is used.
- max_nodes:   The maximum number of nodes that can be stored on the stack prior to the problem terminating.
- BnB_tol:     The absolute convergence tolerance for the B&B routine.
- UBDg:        An array of Float64 objects storing the upper bounds at each iteration of the problem.
- LBGg:        An array of Float64 objects storing the lower bounds at each iteration of the problem.
- LBDgtime:    An array of Float64 objects storing the lower bounds at each iteration of the problem.
- UBDgtime:    An array of Float64 objects storing the upper bounds at each iteration of the problem.
- pstar:       IntervalBox corresponding to the optimal point.
- soln:        Optimal solution found.
- soln_val:    Optimal solution value.
- first_fnd:   Node id of first solution found.
- feas_fnd:    Boolean flag indicating a feasible solution has been found.
- first_num:   Number of the first node found.
- max_id:      Maximum node id number.
- itr_intv:    Number of iterations to skip between printing iteration information.
- hdr_intv:    Number of iterations to skip between printing console header.
- converged:   Convergence check for the algorithm.
- BnB_rtol:    Relative tolerance for convergence check.
- BnB_digits:  Number of digits to be displayed in the console output.
- hist_return: <p> If set to false, it returns a solution value, a solution, and a feasibility flag. If set to false, the array of UBDs, LBDs, and solution times are found. <p>
- opt:         A generic option array passed to each lower & upper bounding problem.

The 'BnB(X::IntervalBox)' constructor initializes the 'BnB' type using an IntervalBox X:

- Init_Box:    Contains the initial box (interval box) used to setup the problem.
- Lower_Prob:  []
- Upper_Prob:  []
- Term_Check:  <p> Default termination check: checks iteration number, relative/absolute tolerance, & number of nodes. <p>
- Branch_Sto:  Defaults to best-first search.
- Node_Select: Defaults to best-first search.
- Bisect_Func: Defaults to relative midpoint bisection.
- Verbosity:   Defaults to printing iterations.
- iter_lim:    A boolean flag that indicates a maximum iteration limit termination condition is used.
- max_nodes:   The maximum number of nodes that can be stored on the stack prior to the problem terminating.
- BnB_tol:     Default tolerance is 1E-6.
- UBDg:        Initialized to array containg Inf.
- LBGg:        Initialized to array containing -Inf.
- feas_fnd:    false
- first_num:   0
- max_id:      1
- itr_intv:    1
- hdr_intv:    20
- converged:   Checks for absolute and relative tolerance.
- BnB_rtol:    Default tolerance is 1E-4.
- BnB_digits:  Number of digits to be displayed in the console output.
- hist_return: false
"""

type BnB
  # Initial IntervalBox
  Init_Box::IntervalBox
  # Stores lower problem function
  Lower_Prob::Any
  # Stores upper problem function
  Upper_Prob::Any
  # Stores termination check function
  Term_Check::Any
  # Stores branching function
  Branch_Sto::Any
  # Stores node selection function
  Node_Select::Any
  # Stores branching function
  Bisect_Func::Any
  # Stores output function
  Verbosity::String
  # max number of iterations
  max_iter::Number
  # determines if iteration limit is checked
  iter_lim::Bool
  # max number of nodes to store in memory
  max_nodes::Int64
  # absolute tolerance for BnB
  BnB_tol::Float64
  # global lower bound at each iteration
  LBDg::Array{Float64,1}
  # global upper bound at each iteration
  UBDg::Array{Float64,1}
  # global lower bound at each iteration
  LBDgtime::Array{Float64,1}
  # global upper bound at each iteration
  UBDgtime::Array{Float64,1}
  # optimal point
  pstar::IntervalBox
  # first founds node
  soln::Array{Float64,1}
  # first founds node
  soln_val::Float64
  # first founds node
  first_fnd::Bool
  # feasible point founds
  feas_fnd::Bool
  # first gound number
  first_num::Int64
  # max id number
  max_id::Int64
  # number of iterations to skip between printing iteration summary
  itr_intv::Int64
  # number of iterations to skip between printing header
  hdr_intv::Int64
  # convergence criterion
  converged::Any
  # relative tolerance for BnB
  BnB_rtol::Float64
  # digits displayed before decimal
  BnB_digits::Int64
  # returns LBD,UBD array and time vector
  hist_return::Bool
  # optional storage array
  opt::Any
end
# initializes the BnB Object from an initial intervalbox
BnB(X::IntervalBox) =  BnB(X,[],[],Term_Check,BM_depth_best!,NS_best,Bisect_Rel,"Normal",Inf,false,100000,1E-6,
[-Inf],[Inf],[],[],zeros(X),[],Inf,false,false,0,1,1,20,[],1E-4,3,false,[])

"""BnBObject{N} is used to store the working stack for a Branch and Bound problem. This type consists of four fields:
- box: An array of IntervalBox{N,Float64} objects containing the remaining nodes.
- LBD: An array of Float64 values containing lower bounds corresponding to each remaining node in box.
- UBD: An array of Float64 values containing upper bounds corresponding to each remaining node in box.
- id: An array containing the indexes of all nodes on the stack.
"""
type BnBObject{N}
  # interval box stack
  box::Array{IntervalBox{N,Float64}}
  # lower bounds associated with each stack
  LBD::Array{Float64,1}
  # Upper bounds associated with each stack
  UBD::Array{Float64,1}
  # Node ID
  id::Array{Int64,1}
end
# initializes the BnB Storage Object from an initial intervalbox
BnBObject(X::IntervalBox) = BnBObject{length(X)}([X],[-Inf],[Inf],[1])


# node selection functions
@inline function NS_best(B::BnBObject)
  tL,ind = findmin(B.LBD)
  return splice!(B.box,ind),splice!(B.LBD,ind),splice!(B.UBD,ind),splice!(B.id,ind)
end
@inline function NS_depth_breadth(B::BnBObject)
  return pop!(B.box),pop!(B.LBD),pop!(B.UBD),pop!(B.id)
end

# branching methods
@inline function BM_breadth!(x::BnB,B::BnBObject,tL::Float64,tU::Float64,X1,X2)
  unshift!(B.box,X1,X2)
  unshift!(B.LBD,tL,tL)
  unshift!(B.UBD,tU,tU)
  unshift!(B.id,x.max_id+1,x.max_id+2)
  x.max_id += 2
end
@inline function BM_depth_best!(x::BnB,B::BnBObject,tL::Float64,tU::Float64,X1,X2)
  push!(B.box,X1,X2)
  push!(B.LBD,tL,tL)
  push!(B.UBD,tU,tU)
  push!(B.id,x.max_id+1,x.max_id+2)
  x.max_id += 2
end

# bisection method function
@inline function Bisect_Abs(B::BnB,N::IntervalArithmetic.IntervalBox)
  i = indmax(diam.(N))
  X1,X2 = bisect(N,i)
end
@inline function Bisect_Rel(B::BnB,N::IntervalArithmetic.IntervalBox)
  i = indmax(diam.(N)./diam.(B.Init_Box))
  X1,X2 = bisect(N,i)
end

@inline function print_sol!(x::BnB,ubdcnt::Int64,lbdcnt::Int64,ubdtime::Float64,lbdtime::Float64)
  temp = 0.0
  println("First Solution Found at Node $(x.first_num)")
  if (x.Verbosity=="Normal"||x.Verbosity=="Full")
    println("UBD = $(x.soln_val)")
    println("Solution is :")
    if (x.feas_fnd)
      for i=1:length(x.Init_Box)
        temp = x.soln[i]
        println("    X[$i] = $temp")
      end
    end
    println("Total UBD problems solved = $ubdcnt in $ubdtime seconds.")
    println("Total LBD problems solved = $lbdcnt in $lbdtime seconds.")
  end
end
@inline function print_node!(id::Int64,lbd::Float64,box::IntervalBox)
  println("Node ID: $(id), Lower Bound: $(lbd), IntervalBox: $(box)")
end

@inline function print_int!(B::BnB,k_int::Int64,k_nod::Int64,nid::Int64,lbdp::Float64,lbd::Float64,ubd::Float64)
  # prints header line every aaa times
  if (mod(k_int,B.hdr_intv)==0||k_int==1)
    println("Iteration   NodeID    Current_LBD     Global_LBD     Global_UBD      NodesLeft     Absolute_Gap    Absolute_Ratio")
  end
  # prints iteration summary every aaa times
  if ((mod(k_int,B.itr_intv)==0))
    ptr_arr_temp = [k_int nid lbdp lbd ubd k_nod (ubd-lbd) (lbd/ubd)]
    ptr_arr1 = join([@sprintf("%6u",x) for x in ptr_arr_temp[1:2]], ",   ")
    ptr_arr2 = join([@sprintf("%3.7f",x) for x in ptr_arr_temp[3:5]], ",     ")
    ptr_arr3 = join([@sprintf("%6u",x) for x in ptr_arr_temp[6:6]], ",")
    ptr_arr4 = join([@sprintf("%3.7f",x) for x in ptr_arr_temp[7:8]], ",       ")
    println(string(ptr_arr1,",      ",ptr_arr2,",      ",ptr_arr3),",        ", ptr_arr4)
  end
end

# fathoms nodes with lower bound greater than upper bound
@inline function fathom!(x::BnB,y::BnBObject)
  loc = find(z->(z>x.UBDg[end]),y.LBD)
  deleteat!(y.LBD,loc)
  deleteat!(y.UBD,loc)
  deleteat!(y.box,loc)
  deleteat!(y.id,loc)
end

# checks for algorithm termination
@inline function Term_Check(x::BnB,y::BnBObject,k_int::Int64)
  t1 = length(y.LBD)>0
  t2 = (x.iter_lim ? k_int<x.max_iter : true)
  t3 = (length(y.LBD)<x.max_nodes)
  t4 = (x.UBDg[end]-x.LBDg[end])>x.BnB_tol
  if t1 & t2 & t3 & t4
    return true
  else
    if (x.Verbosity=="Normal"||x.Verbosity=="Full")
      if ~(length(y.LBD)>0)
        println("Problem Infeasible (Empty Stack)")
      elseif ~(length(y.LBD)<x.max_nodes)
        println("Node Limit Exceeded")
      elseif ~(x.iter_lim ? k_int<x.max_iter : true)
        println("Maximum Iteration Exceeded")
      else
        println("Convergence Tolerance Reached")
      end
    end
    return false
  end
end

# checks for algorithm Convergence
@inline function Conv_Check(x::BnB,ubd::Float64,lbd::Float64)
  return (((ubd-lbd) <= x.BnB_tol) || ((ubd-lbd) <= abs(lbd)*x.BnB_rtol))
end

"""set_Branch_Scheme! specifies the bisection method: "best", "breadth", or "depth".
"""
function set_Branch_Scheme!(x::BnB,BM::String)
  if (BM == "best")
    x.Node_Select = NS_best
    x.Branch_Sto = BM_depth_best!
  elseif (BM == "breadth")
    x.Node_Select = NS_depth_breadth
    x.Branch_Sto = BM_breadth!
  elseif (BM == "depth")
    x.Node_Select = NS_depth_breadth
    x.Branch_Sto = BM_depth_best!
  else
    error("Invalid branching method")
  end
end
"""set_Bisect_Func! specifies the bisection method: "relative midpoint", or "absolute midpoint".
"""
function set_Bisect_Func!(x::BnB,BF::String)
  if (BF == "relative midpoint")
    x.Bisect_Func = Bisect_Rel
  elseif (BF == "absolute midpoint")
    x.Bisect_Func = Bisect_Abs
  else
    error("Invalid bisection method")
  end
end
"""set_Verbosity! specifies the verbosity of the console return: "None","Normal","Full".
"""
function set_Verbosity!(x::BnB,VB::String)
  if (VB == "None"||VB == "Normal"||VB == "Full")
    x.Verbosity = VB
  else
    error("Invalid Verbosity Option")
  end
end
"""set_to_default!

The 'set_to_default!(x::BnB)' function restores the 'x::BnB' object to it's default parameters.
"""
function set_to_default!(x::BnB)
  x.Term_Check = Term_Check
  x.Branch_Sto = BM_depth_best!
  x.Node_Select = NS_best
  x.Bisect_Func = Bisect_Abs
  x.Verbosity = "Normal"
  x.max_iter = Inf
  x.iter_lim = false
  x.max_nodes = 100000
  x.BnB_tol = 1E-6
  x.BnB_rtol = 1E-4
  x.LBDg = [-Inf]
  x.UBDg = [Inf]
  x.pstar = zeros(x.Init_Box)
  x.soln = Array{Float64}(length(x.Init_Box))
  x.soln_val = Inf
  x.first_fnd = false
  x.feas_fnd = false
  x.first_num = -1
  x.max_id = 1
  x.itr_intv = 1
  x.hdr_intv = 20
  x.converged = Conv_Check
  x.BnB_digits = 3
  x.hist_return = false
  x.opt = []
end

"""solve runs the branch-and-bound problem defined by the BnB type x and the BnBObject type y.
"""
function solve(x::BnB,y::BnBObject)

  # initializes counts
  k_int = 0
  k_nod = length(y.LBD)
  lbdcnt = 0
  ubdcnt = 0
  lbdtime = 0.0
  ubdtime = 0.0

  # terminates when max nodes or iteration is reach, or when node stack is empty
  while (x.Term_Check(x,y,k_int))

    # fathom nodes with lower bound greater than global upper bound
    fathom!(x,y)
    push!(x.LBDg,minimum(y.LBD))
    if (x.hist_return)
      push!(x.LBDgtime,lbdtime)
    end
    # selects node (deletion included)
    nsBox,LBDn,UBDn,id = x.Node_Select(y)

    # prints node in full verbosity mode
    if (x.Verbosity == "Full")
      print_node!(id,LBDn,nsBox)
    end

    # solves & times lower bounding problem
    tic()
    LBD_val,LBD_sol,LBD_feas = x.Lower_Prob(nsBox,k_int,x.opt)
    lbdtime += toq()
    lbdcnt += 1

    # checks for infeasibility stores solution
    if (LBD_feas)

      flag_temp1 = x.converged(x,x.UBDg[end],LBD_val)

      if (~x.converged(x,x.UBDg[end],LBD_val))
        # solves & times upper bounding problem
        tic()
        UBD_val,UBD_sol,UBD_feas = x.Upper_Prob(nsBox,k_int,x.opt)
        ubdtime += toq()
        ubdcnt += 1

        # branch the nodes & stores nodes to stack
        Y1,Y2 = x.Bisect_Func(x,nsBox)
        #println("Node Bisected")
        x.Branch_Sto(x,y,LBD_val,UBD_val,Y1,Y2)

        # fathoms by value dominance
        if (UBD_feas)
          if (UBD_val < x.UBDg[end])
            x.feas_fnd = true
            x.first_num = lbdcnt
            push!(x.UBDg,UBD_val)
            x.soln = UBD_sol
            if (x.hist_return)
              push!(x.UBDgtime,ubdtime)
            end
          end
        else
          push!(x.UBDg,x.UBDg[end])
          if (x.hist_return)
            push!(x.UBDgtime,ubdtime)
          end
        end

      end # end converged check
    end # end LBD feasibility check

    # prints relative statistics for the iteration
    if ((x.Verbosity == "Full")||(x.Verbosity == "Normal"))
      print_int!(x,k_int,length(y.LBD),id,LBD_val,x.LBDg[end],x.UBDg[end])
    end
    k_int+=1
  end
  x.soln_val = x.UBDg[end]

  # prints the solution
  if ((x.Verbosity == "Full")||(x.Verbosity == "Normal"))
    print_sol!(x,ubdcnt,lbdcnt,ubdtime,lbdtime)
  end

  if (x.hist_return)
    push!(x.LBDgtime,lbdtime)
    push!(x.UBDgtime,ubdtime)
    x.UBDg,x.LBDg,x.UBDgtime,x.LBDgtime,x.soln,x.feas_fnd
  else
    return x.UBDg[end], x.soln, x.feas_fnd
  end
end
end # module
