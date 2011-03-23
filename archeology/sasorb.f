subroutine sasorb(y,t,dec,ra,rad,v,flat,flong,alt)
  dimension y(15),v(3),x(15)
  c y(1)=epoch in Julian day - 244250
  c y(3)=mean anomaly at epoch in degrees from perigee
  c y(4)=inertial period at epoch in seconds
  c y(5)=change of inertial period in sec/(orbit)^2
  c y(6)=eccentricity at epoch
  c y(7)=change of eccentricity per day
  c y(8)=argument of perigee at epoch in degrees
  c y(9)=change of the argument of perigee in degrees per day
  c y(11)=right ascension of the ascending node in degrees per day
  c y(12)=change of the ascending node in degrees per day
  c y(14)=inclination in degrees
  c y(15)=semimajor axis in kilometers
  x(1)=y(1)
  x(3)=y(3)/360.
  x(4)=86400./y(4)
  x(5)=-y(5)*86400.**2/y(4)**3
  x(6)=0.000555 - (t-39.5)*3.33E-08 + 0.000045 * sin(6.28 * (t - 38.64) / 23.488)
  do 1 i=7,15
1 x(i)=y(i)
  call orb(x,t,dec,rad,v)
  flat=dec
  flong=amod(ra-(t-39.5)*360.9856-44.217,360)-180
  alt=rad-6387.7
  return
