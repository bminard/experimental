"""Create a cumulative bar chart from provided data.

Waterfall: http://pbpython.com/waterfall-chart.html
"""


import matplotlib.pyplot as plt
import math
import numpy as np
import pandas as pd
import random
import sys


data = {
    'category 6': 32,
    'category 5': 16,
    'category 4': 8,
    'category 3': 4,
    'category 2': 2,
    'category 1': 1,
}


df = pd.DataFrame.from_dict(data, orient = 'index', columns = [ 'counts'])
df.index.name = 'Category'

# Create a Pareto bar chart using a single scale.

blank=df.counts.cumsum().shift(1).fillna(0)
total = df.sum().counts
ax1 = df.plot(ylim = (0, total), rot = 0, kind='bar', stacked=True, bottom=blank, legend=None, title="Waterfall")
ax1.set_ylabel('Cummulative Totals')

ax2 = ax1.twinx()
ax2.set_yticks([ x for x in range (0, 101, 10) ], [ (x * total) / 100 for x in range(0, 101, 10) ])
ax2.set_ylabel('Percentage')
ax2.grid(which = 'both', linestyle = 'dotted')

# Create a line chart using a single scale. (Same data as above.)

ax1 = df.plot(ylim = (0, total), rot = 0, kind='line', linestyle = 'None', marker = 'o', stacked=True, legend=None, title="Waterfall (2)")
ax1.set_ylabel('Cummulative Totals')

ax2 = ax1.twinx()
ax2.set_yticks([ x for x in range (0, 101, 10) ], [ (x * total) / 100 for x in range(0, 101, 10) ])
ax2.set_ylabel('Percentage')
ax2.grid(which = 'both', linestyle = 'dotted')

plt.show()
