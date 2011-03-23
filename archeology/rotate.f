c rotate returns the components of a given vector after a right handed screwn rotation of the coordinate system around the nth axis by the angle a
subroutine rotate(n,a,v)
    dimension v(3)
    aa=a*3.14159265/180
    sina=sin(aa)
    cosa=cos(aa)
    u1=v(1)
    u2=v(2)
    u3=v(3)
    nn=n
    go to (1,2,3),NN
1   v(2)=u2*cosa+u3*sina
    v(3)=u3*cosa-u2*sina
    go to 4
2   v(3)=u3*cosa+u1*sina
    v(1)=u1*cosa-u3*sina
    go to 4
3   v(1)=u1*cosa+u2*sina
    v(2)=u2*cosa-u1*sina
4   if(abs(v(1))-1.0)5,6,6
5   if(abs(v(2))-1.0)7,8,8
7   if(abs(v(3))-1.0)9,10,10
6   v(1)=sign(.9999999,v(1))
    v(2)=0.
    v(3)=0.
    return
8   v(1)=0.
    v(2)=sign(.9999999,v(2))
    v(3)=0.
    return
10  v(1)=0.
    v(2)=0.
    v(3)=sign(.9999999,v(3))
9   return
    end
