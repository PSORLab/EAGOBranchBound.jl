module Test_Types

using Compat
using Compat.Test
using IntervalArithmetic
using EAGOBranchBound

@test BnBModel() == BnBModel([Interval(0,1)])

end
