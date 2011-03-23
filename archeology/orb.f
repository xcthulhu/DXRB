c ORB.FORTRAN 01/30/79 1742.6RE 01/10/79 1548.3 12060 

SUBROUTINE ORB(X,T,DEC,RA,RAD,V)
  DIMENSION X(15),V(3)
  c  X(1)=EPOCH
  c  X(3)=MEAN ANOMALY AT EPOCH IN FRACTION OF ONE REVOLUTION
  c  X(4)=MEAN MOTION AT EPOCH IN REVOLUTIONS PER DAY(RELATIVE TO PERIGEE)
  c  X(5)=CHANGE OF THE MEAN MOTION IN REVOLUTIONS PER DAY**2
  c  X(6)=ECCENTRICITY AT EPOCH
  c  X(7)=CHANGE OF ECCENTRICITY PER DAY
  c  X(8)=ARGUMENT OF PERIGEE AT EPOCH IN DEGREES 
  c  X(9)=CHANGE OF ARGUMENT OF PERIGEE IN DEGREES PER DAY
  c  X(11)=RIGHT ASCENSION OF THE ASCENDING NODE IN DEGREES
  c  X(12)=CHANGE OF THE ASCENDING NODE IN DEGREES PER DAY
  c  X(14)=INCLINATION IN DEGREES
  c  X(15)=SEMIMAJOR AXIS IN KILOMETERS
  c  T=TIME IN DAYS
  PI=3.14159265
  DR=PI/180.
  S=T-X(1)
  Q=X(3)+X(4)*S+0.5*X(5)*S**2
  EC=X(6)+X(7)*S
  AP=(X(8)+X(9)*S)*DR
  AN=(X(11)+X(12)*S)*DR
  XI=X(14)*DR
  A=X(15)
  Q=AMOD(AMOD(Q,1.0)+1.0,1.0)*2.*PI
  U=Q
1 EA=Q+EC*SIN(U)
  IF(ABS(EA-U)-.0001)3,3,2
2 U=EA
  GO TO 1
3 TA=(COS(EA)-EC)/(1.-EC*COS(EA))
  IF(ABS(TA).GT.1.) TA=SIGN(.99999,TA)
  TA=ACOS(TA)
  IF(EA-PI)5,4,4
4 TA=-TA+2.*PI
5 AL=TA+AP
  COSAL=COS(AL)
  SINAL=SIN(AL)
  COSXI=COS(XI)
  SINXI=SIN(XI)
  COSAN=COS(AN)
  SINAN=SIN(AN)
  V(1)=COSAL*COSAN-SINAL*SINAN*COSXI
  V(2)=SINAL*COSAN*COSXI+COSAL*SINAN
  V(3)=SINAL*SINXI
  DEC=ASIN(V(3))*180./3.14159265
  RA=AMOD(SIGN(ACOS(V(1)/SQRT(V(1)**2+V(2)**2)),V(2))*180./3.14159265+720.,360.)
  RAD=A*(1.-EC*COS(EA))
  RETURN
  END