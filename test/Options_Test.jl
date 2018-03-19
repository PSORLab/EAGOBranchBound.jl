module Options_Test

using Compat
using Compat.Test
using EAGOBranchBound

x = BnBSolver()

set_Branch_Scheme!(x,"best")
@test x.Node_Select == NS_best
@test x.Branch_Sto == BM_depth_best!

set_Branch_Scheme!(x,"breadth")
@test x.Node_Select == NS_depth_breadth
@test x.Branch_Sto == BM_breadth!

set_Branch_Scheme!(x,"depth")
@test x.Node_Select == NS_depth_breadth
@test x.Branch_Sto == BM_depth_best!

set_Bisect_Func!(x,"relative midpoint",-1)
@test x.Bisect_Func == Bisect_Rel
set_Bisect_Func!(x,"absolute midpoint",-1)
@test x.Bisect_Func == Bisect_Abs

set_Verbosity!(x,"Normal")
@test x.Verbosity == "Normal"

end
