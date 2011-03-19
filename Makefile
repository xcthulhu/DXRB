all : mka4edb

mka4edb : mka4edb.hs
	ghc --make mka4edb.hs

a4.edb : mka4edb a4.dat
	mka4edb a4.dat

table.tsv : eff.py
	python eff.py > $@

clean :
	rm -f mka4edb *.hi *.o *.pyc
