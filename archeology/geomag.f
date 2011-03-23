subroutine geomag(tm,flat,flong,alt,ra,b,bmag)
  dimension b(3)
  degrad = 3.14159265/180
  model = 7
  rkm = alt + 6378.17
  tm = tm
  colat = (90. - flat) * degrad
  st = sin(colat)
  ct = cos(colat)
  sph = sin(flong * degrad)
  cph = cos(flong * degrad)
  call allmag(model,tm,rkm,st,ct,sph,cph,br,bt,bp,bmag)
  b(1) = -bt
  b(2) = bp
  b(3) = -br
  call rotate(2,flat+90.,b)
  call rotate(3,-RA,b)
  return
  end
