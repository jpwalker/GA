#!/bin/env python3
'''
Created on Dec 8, 2019

@author: jpwalker
'''
from random import seed, random
from multiprocessing import Process
from math import floor

seed(0)
N = 1000000
NThread = 2
Pop = { 'gene' : [], 'fitness' : [], 'perc' : []}
GeneLen = 20
template_fn = "template.m" 
with open(template_fn, 'r') as f:
    template = f.read()

def thread_func(i):
    fltN = float(N)
    left = i  * floor(fltN / NThread)
    right = min((i + 1) * floor(fltN / NThread), N)
    print(i, template)
    #for j in Pop['gene'][left:right]:
        

def compute_fitness():
    threads = []
    for i in range(NThread):
        threads.append(Process(target=thread_func, args=(i,)))
        threads[-1].start()
    for i in threads:
        i.join()

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
    not_terminal = True
    #while (not_terminal):
    compute_fitness()