## A/B Testing
import numpy as np
from scipy import stats

# Set up a random normal distribution with 25 as the mean, 5 as the standard deviation, and N=10000
A = np.random.normal(25.0,5.0,10000)

# Set up a random normal distribution with 26 as the mean, 5 as the standard deviation, and N=10000
B = np.random.normal(26,5.0,10000)

print 'A versus B, when mean of A = 25 and mean of B = 26:\t',stats.ttest_ind(A,B)

# Set up the distribution of B to be similar to distribution of A.
B = np.random.normal(25.0,5.0,10000)

print 'A versus B, when the means are equal:\t'stats.ttest_ind(A,B)