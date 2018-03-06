"""
    solveBnB!(x::BnBSolver,y::BnBModel)

Solves the branch and bound problem with the input model and solver object.
"""
function solveBnB!(x::BnBSolver,y::BnBModel)

  # initializes counts
  k_int = 0
  k_nod = length(y.LBD)

  # terminates when max nodes or iteration is reach, or when node stack is empty
  while (x.Term_Check(x,y,k_int))

    # fathom nodes with lower bound greater than global upper bound
    y.LBDg = minimum(y.LBD)
    push!(y.LBDg_hist,minimum(y.LBD))

    # selects node (deletion included)
    nsBox,LBDn,UBDn,id,pos = x.Node_Select(y)

    # prints node in full verbosity mode
    print_node!(x,id,LBDn,nsBox)

    # solver LBD/UBD once to get timing right
    if (k_int == 0)
      LBD_valt,LBD_solt,LBD_feast,nsBoxt,temp_objt = x.Lower_Prob(nsBox,k_int,pos,x.opt,y.UBDg)
      UBD_valt,UBD_solt,UBD_feast,nsBoxt = x.Upper_Prob(nsBox,k_int,pos,x.opt,temp_objt)
    end

    # solves & times lower bounding problem
    tic()
    LBD_val,LBD_sol,LBD_feas,nsBox,temp_obj = x.Lower_Prob(nsBox,k_int,pos,x.opt,y.UBDg)
    push!(y.LBDgtime,y.LBDgtime[end]+toq())
    y.lbcnt += 1
    print_results!(x,LBD_val,LBD_sol,LBD_feas,true)

    # checks for infeasibility stores solution
    if (LBD_feas)

      if (~x.converged(x,y.UBDg,LBD_val))

        # solves & times upper bounding problem
        ##### REVAMPED TO HERE ####
        tic()
        UBD_val,UBD_sol,UBD_feas,nsBox = x.Upper_Prob(nsBox,k_int,pos,x.opt,temp_obj)
        push!(y.UBDgtime,y.UBDgtime[end]+toq())
        y.ubcnt += 1
        print_results!(x,UBD_val,UBD_sol,UBD_feas,false)

        # branch the nodes & stores nodes to stack
        Y1,Y2 = x.Bisect_Func(x,y,nsBox)
        x.Branch_Sto(x,y,LBD_val,UBD_val,Y1,Y2,pos)

        # fathoms by value dominance
        if (UBD_feas)
          if (UBD_val < y.UBDg)
            y.feas_fnd = true
            y.first_num = y.lbcnt
            y.UBDg = UBD_val
            y.soln = UBD_sol
            push!(y.UBDg_hist,UBD_val)
          else
            push!(y.UBDg_hist,y.UBDg)
          end
        else
          push!(y.UBDg_hist,y.UBDg_hist[end])
        end

      elseif (~x.exhaust && y.feas_fnd)
      end# end converged check
    end # end LBD feasibility check

    # prints relative statistics for the iteration
    fathom!(y)

    print_int!(x,k_int,length(y.LBD),id,LBD_val,y.LBDg,y.UBDg,LBD_feas,UBD_feas)

    k_int+=1

  end
  y.soln_val = y.UBDg

  # prints the solution
  if ((x.Verbosity == "Full")||(x.Verbosity == "Normal"))
    print_sol!(x,y,y.ubcnt,y.lbcnt,y.UBDgtime[end],y.LBDgtime[end])
  end
end
