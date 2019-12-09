'''
Created on Dec 8, 2019

@author: jpwalker
'''
from random import seed, random

seed(0)
N = 50
NThread = 2
Pop = {[] : 'gene', [] : 'fitness', [] : 'perc'}
GeneLen = 20

def compute_fitness():
    pass

def compute_crossover():
    pass

def init_pop():
    for _ in range(N):
        gene = []
        for _ in range(GeneLen):
            if random() < 0.5:
                gene.append(True)
            else:
                gene.append(False)
        Pop['gene'].append(gene)

if __name__ == '__main__':
    init_pop()