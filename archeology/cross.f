c  cross returns the components of the cross product of two given vectors, either unnormalized (n=1) or normalized (n=2)
subroutine cross(n,u,v,uxv)
    dimension u(3),v(3),uxv(3)
    do 1 i=1,3
    j=mod(i,3)+1
    k=mod(i+1,3)+1
1   uxv(i)=u(j)*v(k)-u(k)*v(j)
    if(n.eq.1) return
    s=0.
    do 2 i=1,3
2   s=s+uxv(i)**2
    s=sqrt(s)
    do 3 i=1,3
3   uxv(i)=uxv(i)/s
    return
    end
