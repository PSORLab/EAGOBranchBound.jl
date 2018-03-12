function default_pre(feas::Bool,X::Vector{Interval{Float64}},UBD::Float64,
                     k::Int64,pos::Int64,opt)
   return feas,X
end

function default_post(feas::Bool,X::Vector{Interval{Float64}},k::Int64,
                     pos::Int64,opt,tempL,tempU,LBD,UBD)
    return feas,X
end
