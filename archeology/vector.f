c vector returns the components of a vector with given el,az in degrees
subroutine vector(el,az,v)
  dimension v(3)
  dr=3.14159265/180
  v(1)=cos(el*dr)*cos(az*dr)
  v(2)=cos(el*dr)*sin(az*dr)
  v(3)=sin(el*dr)
  return
  end
