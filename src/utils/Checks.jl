function Term_Check(x::BnBSolver,y::BnBModel,k_int::Int64)
  t1 = length(y.LBD)>0
  t2 = (x.iter_lim ? k_int<x.max_iter : true)
  t3 = (length(y.LBD)<x.max_nodes)
  t4 = (y.UBDg-y.LBDg)>x.BnB_atol
  t5 = x.target_upper <= y.UBDg
  if t1 & t2 & t3 & t4 & t5
    return true
  else
    if (x.Verbosity=="Normal"||x.Verbosity=="Full")
      if ~(length(y.LBD)>0)
        if (y.first_num>0)
          println("Empty Stack: Exhaustive Search Finished")
        else
          println("Empty Stack: Infeasible")
        end
      elseif ~(length(y.LBD)<x.max_nodes)
        println("Node Limit Exceeded")
      elseif ~(x.iter_lim ? k_int<x.max_iter : true)
        println("Maximum Iteration Exceeded")
      else
        println("Convergence Tolerance Reached")
      end
    end
    return false
  end
end

function Conv_Check(x::BnBSolver,ubd::Float64,lbd::Float64)
  return (((ubd-lbd) <= x.BnB_atol) || ((ubd-lbd) <= abs(lbd)*x.BnB_rtol))
end
