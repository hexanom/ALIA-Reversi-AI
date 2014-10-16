# pip install matplotlib
import os
import re
from pylab import *

times = 5

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
print reduce(lambda x, y: x + y, w_scores) / len(w_scores)

print "Black AVG: "
print reduce(lambda x, y: x + y, b_scores) / len(b_scores)

figure()
plot(range(0, times), w_scores, '#cccccc', label="White")
plot(range(0, times), b_scores, '#000000', label="Black")
xlabel("plays")
ylabel("score")
show()
