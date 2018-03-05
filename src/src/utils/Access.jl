getsolution(x::BnBModel) = x.soln
getobjval(x::BnBModel) = x.UBDg
getobjbound(x::BnBModel) = x.UBDg
getfeasibility(x::BnBModel) = x.feas_fnd
LBDtime(x::BnBModel) = x.LBDgtime[end]
UBDtime(x::BnBModel) = x.UBDgtime[end]
