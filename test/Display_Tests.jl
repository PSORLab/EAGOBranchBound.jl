module Display_Test

using Compat
using Compat.Test
using IntervalArithmetic
using EAGOBranchBound

S = BnBSolver()
S.Verbosity = "Full"

@test_nowarn EAGOBranchBound.print_node!(S,1,3.0,[Interval(1.0,2.0)])
@test_nowarn EAGOBranchBound.print_results!(S,2.0,[1.5],false,true)
@test_nowarn EAGOBranchBound.print_results!(S,2.0,[1.5],false,false)

end
