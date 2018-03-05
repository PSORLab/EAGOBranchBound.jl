function NS_best(B::BnBModel)
  tL,ind = findmin(B.LBD)
  return splice!(B.box,ind),splice!(B.LBD,ind),splice!(B.UBD,ind),splice!(B.id,ind),splice!(B.pos,ind)
end

function NS_depth_breadth(B::BnBModel)
  return pop!(B.box),pop!(B.LBD),pop!(B.UBD),pop!(B.id),pop!(B.pos)
end
