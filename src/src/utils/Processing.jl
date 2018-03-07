function default_pre(feas::Bool,X::Vector{Interval{Float64}},UBD::Float64,
                     k::Int64,pos::Int64,opt::Array{Any,1})
    return X,true
end

function default_post(feas::Bool,X::Vector{Interval{Float64}},arr::Array{Any,1},
                      UBD::Float64,k::Int64,pos::Int64,opt::Array{Any,1})
    return X,true
end
