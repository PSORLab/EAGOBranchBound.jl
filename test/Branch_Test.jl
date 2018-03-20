module D1_Interval_Test

using Compat
using Compat.Test
using IntervalArithmetic
using EAGOBranchBound

S =
B = BnBModel([Interval(1.0,2.0),Interval(3.0,4.0)])
tL =
tU =
X1 =
X2 =
X =
pos =
BM_breadth!(S,B,tL,tU,X1,X2,pos)
BM_Single!(S,B,tL,tU,X,pos)

end
