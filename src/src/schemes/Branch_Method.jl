function BM_breadth!(S::BnBSolver,B::BnBModel,tL::Float64,tU::Float64,
                             X1::Vector{Interval{Float64}},
                             X2::Vector{Interval{Float64}},pos::Int64)
  unshift!(B.box,X1,X2)
  unshift!(B.LBD,tL,tL)
  unshift!(B.UBD,tU,tU)
  unshift!(B.id,B.max_id+1,B.max_id+2)
  unshift!(B.pos,pos+1,pos+1)
  B.max_id += 2
end

function BM_depth_best!(S::BnBSolver,B::BnBModel,tL::Float64,tU::Float64,
                             X1::Vector{Interval{Float64}},
                             X2::Vector{Interval{Float64}},pos::Int64)
  push!(B.box,X1,X2)
  push!(B.LBD,tL,tL)
  push!(B.UBD,tU,tU)
  push!(B.id,B.max_id+1,B.max_id+2)
  push!(B.pos,pos+1,pos+1)
  B.max_id += 2
end
