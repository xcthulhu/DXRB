import ephem
from math import pi,sin,cos
from time import gmtime,strftime
from numpy import array,dot,cross,zeros
import sys

# Shorthand for arrays
def ar(x): return array(x)

# Calculate the time in astronomer notation
def tm(t): return strftime("%Y/%m/%d %H:%M:%S", gmtime(t))

# Calculate the vector on the unit sphere around the earth for an object
def vec(t,obj):
    obj.compute(tm(t))
    lon = ephem.Ecliptic(obj).lon
    lat = ephem.Ecliptic(obj).lat
    return ar([sin(lon), cos(lon), sin(lat)])

# Gather both the vector and the luminosity for an object
def dat(t,obj):
    return [vec(t,obj), obj.mag]

# Define the pointing vector
sun = ephem.Sun()
def pv(t,theta):
    sv = vec(t,sun)
    b3 = cross(sv,ar([0,0,1]))
    return sv * cos(theta) + b3 * sin(theta)

# Checks if a condition holds for all elements in a list
def all(ls,cond):
    for x in ls:
        if not(cond(x)): return False
    return True

# Get the A4 objects
fp = open("./a4.edb", "r")
# Get the data for the A4 objects
a4 = [dat(0,ephem.readdb(s.rstrip())) for s in fp.readlines()]
fp.close()

def eff(tau, pv_res=300, stepsize=24*60*60, binsize=.005):
    # seconds in a year
    yearsecs = 365*24*60*60
    cos_tau = cos(tau)

    # total luminosity of the a4 catalog in terms of Crab Nebulae
    crabs = sum([x[1] for x in a4])
    # Make an empty histogram
    hgram = zeros(crabs // binsize + 2, float)
    t = 0

    # check every day (or some other time increment specified)
    while ( t < yearsecs):
        t += stepsize
        for theta in [ i*2*pi/pv_res for i in range(pv_res) ]:
            # calculate the pointing vector
            pv_ = pv(t,theta)
            # filter out the a4 catalogue entries that are out of range
            hits = filter((lambda xv: dot(xv[0],pv_) >= cos_tau), a4)
            if hits == []: hgram[0] += 1
            else:
                lum = sum([x[1] for x in hits])
                hgram[(lum // binsize)+1] += 1
    
    for bin_num in range(int(crabs // binsize + 2)):
        yield [tau, bin_num * binsize, hgram[bin_num] / (pv_res*(yearsecs/stepsize))]

res = 300
if __name__ == "__main__":
    print "\t".join(["#half-angle","crabs","frequency"])
    for tau in [ i*pi/res for i in range(res) ]: 
	for val in eff(tau):
            print "\t".join(map(format,val))
	
