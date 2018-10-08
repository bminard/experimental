"""Simulate the distribution of defects amongst several defect types.
"""


#
# Defect type information.
#
defect_types = [ 'Type 1', 'Type 2', 'Type 3', 'Type 4', 'Type 5', 'Type 6', ]
num_defect_types = len(defect_types)


#
# Defect information.
#
num_defects = 40


#
# Defect p-values.
#   Assume all categories are equally probable.
#
equal_p_values = [ 1 / num_defect_types ] * num_defect_types


#
# Defect probability mass function.
#   A multinomial distribution is selected because we want each trial to result
#   in a random distribution of the number of observed defects in a trial.
#
from scipy.stats import *
defect_distribution_per_trial = multinomial(num_defects, equal_p_values)


#
# For each sample, randomly assign the defects to each of the categories and sort.
#
def generate_sample():
    """Obtain a single sample."""
    return defect_distribution_per_trial.rvs()[0]


#
# For sorted observations, Y[1], .. Y[N] in ascending order,
# the confidence interval is then Y [Rlower] to Y [Rupper].
#
# See http://people.stat.sfu.ca/~cschwarz/Stat-650/Notes/PDF/ChapterPercentiles.pdf
#


#
# Monte Carlo time!
#
num_trials = 40000


import math
import numpy as np
import pandas as pd
trial = list()
sorted_trial = list()
for k in range(num_trials):
    s = generate_sample()
    trial.append(s)
    sorted_trial.append(np.sort(s)[::-1])


import matplotlib.pyplot as plt


categories = pd.DataFrame(trial, columns = defect_types)
categories.plot(kind = 'line', subplots = True, sharex = True, sharey = True,
    legend = False, title = 'Frequency by Category (Unsorted)', rot = 0)


sorted_categories = pd.DataFrame(sorted_trial, columns = defect_types)
sorted_categories.plot(kind = 'line', subplots = True, sharex = True, sharey = True,
    legend = False, title = 'Frequency by Category (Sorted)', rot = 0)

# Histogram
num_bins = num_defect_types
fig, ax = plt.subplots(nrows = 3, ncols = 2, sharex = True, sharey = True)
fig.suptitle('Histogram of Categories')
fig.subplots_adjust(hspace=0.6)
for i in range(0, num_defect_types):
    mu = round(sorted_categories.T.iloc[i].mean())
    std = round(sorted_categories.T.iloc[i].std())
    col = i % 2
    row = i // 2
    n, bins, patches = ax[row, col].hist(sorted_categories.T.iloc[i], num_bins, density=1)
    xmin, xmax = plt.xlim()
    y = np.linspace(xmin, xmax, (num_bins + 1)**2) # Selected points to create rounded curve.
    p = norm.pdf(y, mu, std)
    ax[row , col].plot(y, p, '--')
    ax[row , col].set_xlabel('Category {}'.format(i + 1))
    ax[row , col].set_title('$\mu={:10.0f}$, $\sigma={:10.0f}$'.format(mu, std))
    ax[row , col].set_ylabel('Probability Density')


minimum_statistic = pd.DataFrame(columns = defect_types)
maximum_statistic = pd.DataFrame(columns = defect_types)
median_statistic = pd.DataFrame(columns = defect_types)
range_statistic = pd.DataFrame(columns = defect_types)
for i in range(0, num_trials):
    minimum_statistic.loc[i] = sorted_categories.head(i).min()
    maximum_statistic.loc[i] = sorted_categories.head(i).max()
    median_statistic.loc[i] = sorted_categories.head(i).max()
    range_statistic.loc[i] = (sorted_categories.head(i).max() - sorted_categories.head(i).min())


minimum_statistic.plot(kind = 'line', subplots = True, sharex = True, sharey = True,
    legend = False, title = 'Minimum Frequency by Category', rot = 0)
maximum_statistic.plot(kind = 'line', subplots = True, sharex = True, sharey = True,
    legend = False, title = 'Maximum Frequency by Category', rot = 0)
median_statistic.plot(kind = 'line', subplots = True, sharex = True, sharey = True,
    legend = False, title = 'Median Frequency by Category', rot = 0)
range_statistic.plot(kind = 'line', subplots = True, sharex = True, sharey = True,
    legend = False, title = 'Frequency Range by Category', rot = 0)


#
# For sorted observations, Y[1], .. Y[N] in ascending order,
# the confidence interval is then Y [Rlower] to Y [Rupper].
#
# See http://people.stat.sfu.ca/~cschwarz/Stat-650/Notes/PDF/ChapterPercentiles.pdf
#
# Also: https://stats.stackexchange.com/questions/99829/how-to-obtain-a-confidence-interval-for-a-percentile
#


Z = 1.96

alpha = 0.05
half_alpha = alpha / 2
lower_quartile = half_alpha
upper_quartile = 1 - half_alpha


###

lower_boundary_statistics = pd.DataFrame(index = defect_types)
upper_boundary_statistics = pd.DataFrame(index = defect_types)
for i in range(1, num_trials):
    sorted_observations = np.sort(sorted_categories.head(i), axis = 0)
    R_lower = max(0, round(i * lower_quartile - Z * math.sqrt(i * lower_quartile * (1 - lower_quartile))) - 1)
    R_upper = min(i - 1, round(i * upper_quartile + Z * math.sqrt(i * upper_quartile * (1 - upper_quartile))) - 1)
    lower_boundary_statistics[i] = sorted_observations[R_lower, :]
    upper_boundary_statistics[i] = sorted_observations[R_upper, :]

lower_boundary_statistics.T.plot(kind = 'line', subplots = True, sharex = True, sharey = True,
    legend = False, title = 'Lower Bounds by Category', rot = 0)
upper_boundary_statistics.T.plot(kind = 'line', subplots = True, sharex = True, sharey = True,
    legend = False, title = 'Upper Bounds by Category', rot = 0)
###

R_lower = max(0, round(num_trials * lower_quartile - Z * math.sqrt(num_trials * lower_quartile * (1 - lower_quartile))) - 1)
R_upper = min(num_trials - 1, round(num_trials * upper_quartile + Z * math.sqrt(num_trials * upper_quartile * (1 - upper_quartile))) - 1)
acceptance_levels = pd.DataFrame.from_dict({ 'data': [ 17, 9, 5, 4, 3, 2 ],
    'lower': list(sorted_observations[R_lower,:]), 'upper': list(sorted_observations[R_upper,:]-sorted_observations[R_lower,:]) }, orient = 'index',
)
acceptance_levels.columns = defect_types
plt.show()

print(acceptance_levels)
blank=acceptance_levels.T['lower'].fillna(0)
total = (acceptance_levels.T['data'].max() // 5 + 1) * 5

ax1 = acceptance_levels.T[['upper']].plot(ylim = (0, total), rot = 0, kind='bar',
          stacked=True, bottom=blank, legend=None, title="Acceptance Levels", fill = False, yticks = [ x for x in range(0, total + 1, 5)])
ax1.set_xlabel('Category')

ax2 = ax1.twinx()
acceptance_levels.T['data'].plot(ylim = (0, total), rot = 0, kind='line', linestyle = 'None', marker = 'o', stacked=True, legend=None, ax = ax2, yticks=[])
ax3 = ax1.twinx()
ax3.set_yticks([ x for x in range (0, 51, 10) ], [ (x * total) / 100 for x in range(0, 51, 10) ])
ax3.set_ylabel('Percentage')

plt.show()
