#!/usr/bin/env julia

using EAGOBranchBound

# write your own tests here
println("Testing 1D Interval Optimization...")
t = @elapsed include("D1_Interval_Test.jl")
println("done (took $t seconds).")
