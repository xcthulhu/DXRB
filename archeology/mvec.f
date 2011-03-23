c mvec returns the product of a scalar and a vector
subroutine mvec(a,v,av)
  dimension v(3),av(3)
  av(1)=a*v(1)
  av(2)=a*v(2)
  av(3)=a*v(3)
  return
  end
