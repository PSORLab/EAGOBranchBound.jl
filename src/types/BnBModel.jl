type BnBModel
  Init_Box::Vector{Interval{Float64}}
  box::Vector{Vector{Interval{Float64}}} # interval box stack
  Init_Integer::Vector{Vector{Int64}}
  integers::Vector{Vector{Vector{Int64}}}
  LBD::Vector{Float64} # lower bounds associated with each stack
  UBD::Vector{Float64} # Upper bounds associated with each stack
  id::Vector{Int64}  # Node ID
  pos::Vector{Int64} # Position in BnB Tree
  LBDg::Float64 # Global Lower Bound
  UBDg::Float64 # Global Upper Bound
  LBDg_hist::Vector{Float64} # Value history LBD problem
  UBDg_hist::Vector{Float64} # Value history UBD problem
  LBDgtime::Vector{Float64} # Run time history LBD problem
  UBDgtime::Vector{Float64} # Run time history UBD problem
  max_id::Int64             # Max node used
  pstar::Vector{Interval{Float64}}
  soln::Vector{Float64}
  soln_val::Float64
  first_fnd::Bool
  feas_fnd::Bool
  first_num::Int64
  lbcnt::Int64
  ubcnt::Int64
end
# initializes the BnB Storage Object from an initial intervalbox
BnBModel(X::Vector{Interval{Float64}}) = BnBModel(deepcopy(X),
                                                              [deepcopy(X)],
                                                              [[1]],
                                                              [[[1]]],
                                                              [-Inf],
                                                              [Inf],
                                                              [1],
                                                              [1],
                                                              -Inf,
                                                              Inf,
                                                              [-Inf],
                                                              [Inf],
                                                              [0.0],
                                                              [0.0],
                                                              1,
                                                              deepcopy(X),
                                                              [0.0],
                                                              Inf,
                                                              false,
                                                              false,
                                                              -1,
                                                              0,
                                                              0)
BnBModel() = BnBModel([Interval(0,1)])
