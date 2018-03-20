module D1_Interval_Test

using Compat
using Compat.Test
using IntervalArithmetic
using EAGOBranchBound

X = [Interval(1,5)]
model = BnBModel(X)
solver = BnBSolver()
set_to_default!(solver)
solver.Verbosity = "Normal"
solver.opt = [x -> x[1]^2]
solver.Lower_Prob = (X,k,p,opt,temp) -> [opt[1](X).lo,mid.(X),true,X,[]]
solver.Upper_Prob = (X,k,p,opt,temp) -> [opt[1](X).hi,mid.(X),true,X,[]]
a = solver.Lower_Prob(X,1,1,solver.opt,[])
b = solver.Upper_Prob(X,1,1,solver.opt,[])
solveBnB!(solver,model)

@test -1E-4 <= getobjval(model)-1 <= 1E-4

end
