#!/usr/bin/env julia

using EAGOBranchBound

# write your own tests here
println("Testing 1D Interval Optimization...")
t = @elapsed include("D1_Interval_Test.jl")
println("done (took $t seconds).")

println("Testing Types...")
t = @elapsed include("Test_Types.jl")
println("done (took $t seconds).")

println("Testing Option Setting...")
t = @elapsed include("Options_Types.jl")
println("done (took $t seconds).")
