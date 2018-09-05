#--------------------------------------------------------------------------------
# BSD 2-Clause License
#
# Copyright (c) 2018, Brian Minard
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
# list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#--------------------------------------------------------------------------------


import matplotlib.pyplot as plt
import math
import numpy as np
import pandas as pd
import scipy.stats as stats
from collections import defaultdict

import sys


observed = pd.DataFrame.from_dict( data = { 'R1': [ 23, 27, 41, 25, 44 ],
                           'R2': [ 44, 49,  7, 28, 19 ] }, orient = 'index',
                           columns = [ 'Blocking', 'Critical', 'Major', 'Minor', 'Inconsequential' ])
observed.index.name = 'Release'
print('Assumes severity is an ordinal with ordering: {}.'.format(' >'.join(observed.columns.values)))

statistics_dict = defaultdict(list)

statistics = pd.DataFrame(observed)
print(statistics.max(axis = 1))
total = 0
for release in observed.index:
    for column in observed.columns.values:
        for entry in range(0, observed.loc[release][column]):
            statistics_dict[release].append(column)
    print(np.median(list(range(0, statistics.loc[release].sum()))))
    total += statistics.loc[release].sum()

raw_cat = dict()
categories = list()
for release in observed.index:
    raw_cat[release] = pd.Categorical(statistics_dict[release], categories = observed.columns.values, ordered=True)
    print('raw cat = ', raw_cat[release])
    s = pd.Series(raw_cat[release])
    print (s.describe())
    categories += statistics_dict[release]

s = pd.Series(pd.Categorical(categories, categories = observed.columns.values, ordered=True))
print (s.describe())

chi2, p, dof, expected = stats.chi2_contingency(observed)
if np.all(observed >= 5) and np.all(expected >= 5): # Chi-Square valid iff all expected and observed values meet this criteria.
    print("Chi-Squared = ", chi2)
    print("p-value = ", p)
    print("Degrees of Freedom = ", dof)
    df = pd.DataFrame(expected, columns = observed.columns.values)
    df = df.assign(release = observed.index.values)
    df = df.set_index('release')
    maximum = max(observed.values.max(), int(math.ceil(df.values.max()))) + 1

    for release in observed.index:
        observed_vs_expected_by_release = pd.DataFrame({
            'severity': list(observed.columns.values),
            'observed': list(observed.loc[release]),
            'expected': list(df.loc[release]) })
        observed_vs_expected_by_release.set_index(["severity"],inplace=True)
        ax = observed_vs_expected_by_release.plot.bar(title = "Observed vs. Expected Counts by Defect Severity",
                                               rot = 0, ylim = (0, maximum))
        ax.set_xlabel("Defect Severity")
        ax.set_ylabel("Defect Counts")
        plt.gcf().subplots_adjust(bottom=0.15) # Prevent cropping the X axis label.
        plt.suptitle('Release: ' + release)
else:
    assert 0, "need a different statistic test"

ax = observed.plot.box(title = 'Observed Severity Counts by Quartile', rot = 0)
ax.set_xlabel("Defect Severity")
ax.set_ylabel("Defect Counts")
plt.gcf().subplots_adjust(bottom=0.15) # Prevent cropping the X axis label.

ax = observed.plot.bar(title = 'Observed Severity Counts by Release', rot = 0, stacked=True);
ax.set_xlabel("Release")
ax.set_ylabel("Defect Counts")
ax.legend(loc = 'center', ncol = math.ceil(len(observed.columns.values) / 2), bbox_to_anchor = (0.5, -0.25))
plt.gcf().subplots_adjust(bottom=0.25) # Prevent cropping the X axis label.

ax = observed.plot.area(title = 'Observed Severity Counts by Release', rot = 0, xticks = list(range(0, len(observed.index.values))))
ax.set_xlabel("Release")
ax.set_ylabel("Defect Counts")
ax.set_xticklabels(observed.index.values, minor = False)
ax.legend(loc = 'center', ncol = math.ceil(len(observed.columns.values) / 2), bbox_to_anchor = (0.5, -0.25))
plt.gcf().subplots_adjust(bottom=0.25) # Prevent cropping the X axis label.

ax = observed.plot.line(title = 'Observed Severity Counts by Release', rot = 0,
                            xticks = list(range(0, len(observed.index.values))), grid = True,
                            ylim = (0, maximum), sharex = True, sharey = True,
                            yticks = list(range(0, maximum, int(math.floor(math.log10(maximum))) * 10)))
ax.set_xlabel("Release")
ax.set_ylabel("Defect Counts")
plt.gcf().subplots_adjust(bottom=0.15) # Prevent cropping the X axis label.

# line plot but with reversed rows (ordering doesn't match area plot)
ax = observed.plot.line(title = 'Observed Severity Counts by Release', rot = 0,
                            xticks = list(range(0, len(observed.index.values))), grid = True,
                            ylim = (0, maximum), subplots = True, sharex = True, sharey = True,
                            yticks = list(range(0, maximum, int(math.floor(math.log10(maximum))) * 10)))
plt.gcf().subplots_adjust(bottom=0.15) # Prevent cropping the X axis label.

plt.show()

table = observed.groupby(level="release").sum().values
values = list()
for i in range(len(observed.index.values) - 1, 0, -1):
    for j in range(len(observed.columns.values) - 1, 0, -1):
        v = (table[i][j]*table[len(observed.index.values) - i - 1][len(observed.columns.values) - 1]) / (table[len(observed.index.values) - i - 1][j]*table[i][len(observed.columns.values) - 1])
        values.append((v, math.log10(v)))
print(values)

