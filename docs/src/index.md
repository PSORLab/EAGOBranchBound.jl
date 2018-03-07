# EAGOBranchBound

EAGOBranchBound contains a flexible branch and bound library. This package
allows the user to specify termination criteria, lower & upper bounding problems,
as well as search criteria.

## Introduction

More text

```@docs
EAGOBranchBound.BnBModel
EAGOBranchBound.BnBModel(X::Vector{Interval{Float64}})
EAGOBranchBound.BnBSolver
EAGOBranchBound.BnBSolver()
```

```@docs
EAGOBranchBound.solveBnB!
```

```@docs
EAGOBranchBound.Bisect_Abs
EAGOBranchBound.Bisect_Abs_Imp
EAGOBranchBound.Bisect_Rel
EAGOBranchBound.Bisect_Rel_Imp
```

```@docs
EAGOBranchBound.BM_breadth!
EAGOBranchBound.BM_depth_best!
EAGOBranchBound.BM_Single!
EAGOBranchBound.NS_best
EAGOBranchBound.NS_depth_breadth
EAGOBranchBound.fathom!
```

```@docs
EAGOBranchBound.getsolution
EAGOBranchBound.getobjval
EAGOBranchBound.getobjbound
EAGOBranchBound.getfeasibility
EAGOBranchBound.LBDtime
EAGOBranchBound.UBDtime
```

```@docs
EAGOBranchBound.set_Branch_Scheme!
EAGOBranchBound.set_Bisect_Func!
EAGOBranchBound.set_Verbosity!
EAGOBranchBound.set_to_default!
```

```@docs
EAGOBranchBound.Term_Check
EAGOBranchBound.Conv_Check
EAGOBranchBound.Repeat_Node_Default
```

```@docs
EAGOBranchBound.print_sol!
EAGOBranchBound.print_node!
EAGOBranchBound.print_int!
```


```@index
```


## User Documentation
