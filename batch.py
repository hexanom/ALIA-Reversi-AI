# pip install matplotlib
# pip install numpy
import os
import re
from pylab import *
import numpy

times = 20

w_scores = []
b_scores = []

for i in range(0, times):
    f = os.popen("swipl -O -q -s main.pl")
    for l in f.readlines():
        if l.startswith("White: "):
            w_scores.append(float(re.split('\s', l)[1]))
        elif l.startswith("Black: "):
            b_scores.append(float(re.split('\s', l)[1]))

print "White AVG: "
print numpy.mean(w_scores)
print "Median: "
print numpy.median(w_scores)
print "25th percentile: "
print numpy.percentile(w_scores, 25)
print "75th percentile: "
print numpy.percentile(w_scores, 75)
print "Variance: "
print numpy.var(w_scores)
print " "

print "Black AVG: "
print numpy.mean(b_scores)
print "Median: "
print numpy.median(b_scores)
print "25th percentile: "
print numpy.percentile(b_scores, 25)
print "75th percentile: "
print numpy.percentile(b_scores, 75)
print "Variance: "
print numpy.var(b_scores)
print " "

figure()
plot(range(0, times), w_scores, '#cccccc', label="White")
plot(range(0, times), b_scores, '#000000', label="Black")
xlabel("plays")
ylabel("score")
show()
