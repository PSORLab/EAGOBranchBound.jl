__precompile__()

module EAGOBranchBound

using IntervalArithmetic: Interval, diam
using IntervalRootFinding.bisect

export BnBSolver, BnBModel, set_Branch_Scheme!, set_Bisect_Func!,
       set_Verbosity!, set_to_default!, solveBnB!, getsolution, getobjval,
       getfeasibility, getobjbound, LBDtime, UBDtime

include("src/types/BnBModel.jl")
include("src/types/BnBSolver.jl")
include("src/schemes/Node_Select.jl")
include("src/schemes/Branch_Method.jl")
include("src/schemes/Bisect_Method.jl")
include("src/utils/Access.jl")
include("src/utils/Display.jl")
include("src/utils/Fathom.jl")
include("src/utils/Checks.jl")
include("src/utils/Set_Options.jl")
include("src/solve.jl")

function __init__()
end

end # module
