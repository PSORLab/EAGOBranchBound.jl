function default_pre(feas::Bool,X::Vector{Interval{Float64}},UBD::Float64,
                     k::Int64,pos::Int64,opt,LBDn::Float64,UBDn::Float64,x::BnBSolver,
                     y::BnBModel)
   return feas,X
end

function default_post(feas::Bool,X::Vector{Interval{Float64}},k::Int64,
                     pos::Int64,opt,tempL,tempU,LBD,UBD)
    return feas,X
end
