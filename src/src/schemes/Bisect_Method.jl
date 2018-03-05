function Bisect_Abs(S::BnBSolver,B::BnBModel,N::Vector{Interval{Float64}})
  i::Int64 = indmax(diam.(N))
  N1::Interval{Float64},N2::Interval{Float64} = bisect(N[i])
  X1::Vector{Interval{Float64}} = deepcopy(N)
  X2::Vector{Interval{Float64}} = deepcopy(N)
  X1[i] = N1
  X2[i] = N2
  return X1,X2
end

function Bisect_Rel(S::BnBSolver,B::BnBModel,N::Vector{Interval{Float64}})
  i::Int64 = indmax(diam.(N)./diam.(B.Init_Box))
  N1::Interval{Float64},N2::Interval{Float64} = bisect(N[i])
  X1::Vector{Interval{Float64}} = deepcopy(N)
  X2::Vector{Interval{Float64}} = deepcopy(N)
  X1[i] = N1
  X2[i] = N2
  return X1,X2
end

function Bisect_Abs_Imp(S::BnBSolver,B::BnBModel,N::Vector{Interval{Float64}},nx::Int64)
  i::Int64 = indmax(diam.(N[(nx+1):end]))
  N1::Interval{Float64},N2::Interval{Float64} = bisect(N[nx+i])
  X1::Vector{Interval{Float64}} = deepcopy(N)
  X2::Vector{Interval{Float64}} = deepcopy(N)
  X1[i] = N1
  X2[i] = N2
  return X1,X2
end

function Bisect_Rel_Imp(S::BnBSolver,B::BnBModel,N::Vector{Interval{Float64}},nx::Int64)
  i::Int64 = indmax(diam.(N[(nx+1):end])./diam.(B.Init_Box[(nx+1):end]))
  N1::Interval{Float64},N2::Interval{Float64} = bisect(N[nx+i])
  X1::Vector{Interval{Float64}} = deepcopy(N)
  X2::Vector{Interval{Float64}} = deepcopy(N)
  X1[i] = N1
  X2[i] = N2
  return X1,X2
end
