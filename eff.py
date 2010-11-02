import ephem
from math import pi,sin,cos
from time import gmtime,strftime
from numpy import array,dot
import sys

# Shorthand for arrays
def ar(x): return array(x)

# Calculate the time in astronomer notation
def tm(t): return strftime("%Y/%m/%d %H:%M:%S", gmtime(t))

# Calculate the vector on the unit sphere around the earth for an object
def vec(t,obj):
    obj.compute(tm(t))
    long = ephem.Ecliptic(obj).long
    lat = ephem.Ecliptic(obj).lat
    return ar([sin(long), cos(long), sin(lat)])

# Define the pointing vector
sun = ephem.Sun()
def pv(t,theta):
    sv = vec(t,sun)
    b3 = dot(sv,ar([0,0,1]))
    return sv * cos(theta) + b3 * sin(theta)

# Checks if a condition holds for all elements in a list
def all(ls,cond):
    for x in ls:
        if not(cond(x)): return False
    return True

# Get the A4 objects
fp = open("./a4.edb", "r")
# Get the vectors for the A4 objects
a4 = [vec(0,ephem.readdb(s.rstrip())) for s in fp.readlines()]
fp.close()

def eff(tau):
    pv_res = 300
    stepsize = 24*60*60
    yearsecs = 365*24*60*60
    cos_tau = cos(tau)
    t = 0
    clear = 0.0

    # check every day (or some other time increment specified)
    while ( t < yearsecs):
        t += stepsize
        for theta in [ i*2*pi/pv_res for i in range(pv_res) ]:
            # calculate the pointing vector
            pv_ = pv(t,theta)
            # check if all of the a4 catalogue is out of range
            if all(a4,(lambda xv: dot(xv,pv_) <= cos_tau)): clear += 1
    
    print tau,'\t',(clear / (pv_res*(yearsecs/stepsize)))

res = 300
if __name__ == "__main__":
    for tau in [ i*pi/res for i in range(res) ]: 
	eff(tau)
	sys.stdout.flush()
