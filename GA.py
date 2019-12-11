#!/bin/env python3
'''
Created on Dec 8, 2019

@author: jpwalker
'''

#from random import seed
from random import random
from multiprocessing import Process
from math import floor
from subprocess import run
from csv import reader
from numpy import array, append
#import matplotlib.pyplot as plt

#seed(0)
N = 20
NThread = 2
Pop = { 'chrom' : [], 'fitness' : [], 'perc' : []}
GeneLen = 10
g = 200. # Sidelength of periodic structure in nanometers
delR = g / (2 * GeneLen)
#expected_result_fn = 'run_0.csv'
template_fn = "template.m" 
with open(template_fn, 'r') as f:
    template = f.read()
matlab_cmdline_run = 'matlab -nodisplay -nosplash -nodesktop -r "run(\'{0}\'); exit;"'
expected_result = {'lamb' : array([], dtype=float), 'R': array([], dtype=float), 'T' : array([], dtype=float)}
# with open(expected_result_fn, 'r') as f:
#     csvreader = reader(f)
#     for row in csvreader:
#         expected_result['lamb'] = append(expected_result['lamb'], float(row[0]))
#         expected_result['R'] = append(expected_result['R'], float(row[1]))
#         expected_result['T'] = append(expected_result['T'], float(row[2]))
        
def thread_func(i):
    fltN = float(N)
    left = i  * floor(fltN / NThread)
    right = min((i + 1) * floor(fltN / NThread), N)
    for l, j in enumerate(Pop['chrom'][left:right]):
        copper = ''
        cyl_num = 1
        dif_num = 2 
        print(j)
        for k, val in enumerate(j):
            leftR = k * delR
            rightR = (k + 1) * delR
            if (k == 0 and val):
                copper += '''model.component('comp1').geom('geom1').create('cyl{0}', 'Cylinder');
model.component('comp1').geom('geom1').feature('cyl{0}').set('r', '{1}[nm]');
model.component('comp1').geom('geom1').feature('cyl{0}').set('h', 'cu_z');
model.component('comp1').geom('geom1').feature('cyl{0}').set('pos', {{'0' '0' '-cu_z/2'}});
model.component('comp1').geom('geom1').feature('cyl{0}').set('contributeto', 'csel3');
model.component('comp1').geom('geom1').run('cyl{0}');\n'''.format(cyl_num, rightR)
                cyl_num += 1
            elif (k == GeneLen - 1 and val):
                copper += '''model.component('comp1').geom('geom1').create('blk4', 'Block');
model.component('comp1').geom('geom1').feature('blk4').set('size', {{'g' 'g' 'cu_z'}});
model.component('comp1').geom('geom1').feature('blk4').set('base', 'center');
model.component('comp1').geom('geom1').run('blk4');
model.component('comp1').geom('geom1').create('cyl{0}', 'Cylinder');
model.component('comp1').geom('geom1').feature('cyl{0}').set('r', '{1}[nm]');
model.component('comp1').geom('geom1').feature('cyl{0}').set('h', 'cu_z');
model.component('comp1').geom('geom1').feature('cyl{0}').set('pos', {{'0' '0' '-cu_z/2'}});
model.component('comp1').geom('geom1').run('cyl{0}');
model.component('comp1').geom('geom1').create('dif{2}', 'Difference');
model.component('comp1').geom('geom1').feature('dif{2}').selection('input').set({{'blk4'}});
model.component('comp1').geom('geom1').feature('dif{2}').selection('input2').set({{'cyl{0}'}});
model.component('comp1').geom('geom1').feature('dif{2}').set('contributeto', 'csel3');
model.component('comp1').geom('geom1').run('dif{2}');\n'''.format(cyl_num, leftR, dif_num)
                cyl_num += 1
                dif_num += 1 
            elif (val):
                copper += '''model.component('comp1').geom('geom1').create('cyl{0}', 'Cylinder');
model.component('comp1').geom('geom1').feature('cyl{0}').set('r', '{1}[nm]');
model.component('comp1').geom('geom1').feature('cyl{0}').set('h', 'cu_z');
model.component('comp1').geom('geom1').feature('cyl{0}').set('pos', {{'0' '0' '-cu_z/2'}});\n'''.format(cyl_num, rightR)
                cyl_num += 1
                copper += '''model.component('comp1').geom('geom1').create('cyl{0}', 'Cylinder');
model.component('comp1').geom('geom1').feature('cyl{0}').set('r', '{1}[nm]');
model.component('comp1').geom('geom1').feature('cyl{0}').set('h', 'cu_z');
model.component('comp1').geom('geom1').feature('cyl{0}').set('pos', {{'0' '0' '-cu_z/2'}});\n'''.format(cyl_num, leftR)
                cyl_num += 1
                copper += '''model.component('comp1').geom('geom1').create('dif{0}', 'Difference');
model.component('comp1').geom('geom1').feature('dif{0}').selection('input').set({{'cyl{1}'}});
model.component('comp1').geom('geom1').feature('dif{0}').selection('input2').set({{'cyl{2}'}});
model.component('comp1').geom('geom1').feature('dif{0}').set('contributeto', 'csel3');
model.component('comp1').geom('geom1').run('dif{0}');\n'''.format(dif_num, cyl_num - 2, cyl_num - 1)
                dif_num += 1
        matlab_file = 'run_{0}.m'.format(left + l)
        output_file = 'run_{0}.csv'.format(left + l)
        if i == 1:
            server = 'comsol-2'
        else:
            server = 'comsol-1'
        with open(matlab_file, 'w') as f:
            f.write(template.format(copper, output_file, server))
        run(matlab_cmdline_run.format(matlab_file), shell=True)
        data = {'lamb' : array([], dtype=float), 'R' : array([], dtype=float), 'T' : array([], dtype=float)}
        with open(output_file, 'r') as f:
            csvreader = reader(f)
            for row in csvreader:
                data['lamb'] = append(data['lamb'], float(row[0]))
                data['R'] = append(data['R'], float(row[1]))
                data['T'] = append(data['T'], float(row[2]))
        #plt.plot(data['lamb'], data['T'])
        #plt.plot(data['lamb'], data['R'])
        #plt.show()
        #chi_ish2 = (data['R'] - expected_result['R']) ** 2. + (data['T'] - expected_result['T']) ** 2.
        
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
        Pop['chrom'].append(gene)

if __name__ == '__main__':
    init_pop()
    not_terminal = True
    #while (not_terminal):
    compute_fitness()