function out = model
%
% template.m
%
% Model exported on Dec 7 2019, 23:41 by COMSOL 5.4.0.225.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/home/comsol/COMSOL_Batch');

model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 3);

model.component('comp1').mesh.create('mesh1');

model.component('comp1').physics.create('emw', 'ElectromagneticWaves', 'geom1');

model.study.create('std1');
model.study('std1').setGenConv(true);

model.param.set('g', '200[nm]');
model.param.set('cu_z', '25[nm]');
model.param.set('air_z', '2[um]');
model.param.set('PML_z', '1.5[um]');
model.param.set('N_f', '100');
model.param.set('lambda_min', '230[nm]');
model.param.set('lambda_max', '1000[nm]');

% Selections
model.component('comp1').selection.create('box1', 'Box');
model.component('comp1').selection('box1').label('side1');
model.component('comp1').selection('box1').set('entitydim', 2);
model.component('comp1').selection('box1').set('xmin', '-g/2-0.01');
model.component('comp1').selection('box1').set('xmax', '-g/2+0.01');
model.component('comp1').selection('box1').set('condition', 'inside');
model.component('comp1').selection.create('box2', 'Box');
model.component('comp1').selection('box2').label('side3');
model.component('comp1').selection('box2').set('entitydim', 2);
model.component('comp1').selection('box2').set('ymax', 'g/2+0.01');
model.component('comp1').selection('box2').set('ymin', 'g/2-0.01');
model.component('comp1').selection('box2').set('condition', 'inside');
model.component('comp1').selection.create('box3', 'Box');
model.component('comp1').selection('box3').label('side4');
model.component('comp1').selection('box3').set('entitydim', 2);
model.component('comp1').selection('box3').set('ymin', '-g/2-0.01');
model.component('comp1').selection('box3').set('ymax', '-g/2+0.01');
model.component('comp1').selection('box3').set('condition', 'inside');
model.component('comp1').selection.create('box4', 'Box');
model.component('comp1').selection('box4').label('side2');
model.component('comp1').selection('box4').set('entitydim', 2);
model.component('comp1').selection('box4').set('xmin', 'g/2-0.01');
model.component('comp1').selection('box4').set('xmax', 'g/2+0.01');
model.component('comp1').selection('box4').set('condition', 'inside');
model.component('comp1').selection.create('uni1', 'Union');
model.component('comp1').selection('uni1').label('PC1');
model.component('comp1').selection('uni1').set('entitydim', 2);
model.component('comp1').selection('uni1').set('input', {{'box1' 'box4'}});
model.component('comp1').selection.duplicate('uni2', 'uni1');
model.component('comp1').selection('uni2').label('PC2');
model.component('comp1').selection('uni2').set('input', {{'box2' 'box3'}});
model.component('comp1').selection.create('box5', 'Box');
model.component('comp1').selection('box5').label('P1');
model.component('comp1').selection('box5').set('entitydim', 2);
model.component('comp1').selection('box5').set('zmin', 'air_z/2-0.01');
model.component('comp1').selection('box5').set('zmax', 'air_z/2+0.01');
model.component('comp1').selection('box5').set('condition', 'inside');
model.component('comp1').selection.duplicate('box6', 'box5');
model.component('comp1').selection('box6').label('P2');
model.component('comp1').selection('box6').set('zmin', '-air_z/2-0.01');
model.component('comp1').selection('box6').set('zmax', '-air_z/2+0.01');

%Geometry
model.component('comp1').geom('geom1').lengthUnit('nm');
model.component('comp1').geom('geom1').create('blk1', 'Block');
model.component('comp1').geom('geom1').feature('blk1').label('Top PML');
model.component('comp1').geom('geom1').feature('blk1').set('size', {{'g' 'g' 'PML_z'}});
model.component('comp1').geom('geom1').feature('blk1').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk1').set('pos', {{'0' '0' '(PML_z+air_z)/2'}});
model.component('comp1').geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.component('comp1').geom('geom1').selection('csel1').label('PML');
model.component('comp1').geom('geom1').feature('blk1').set('contributeto', 'csel1');
model.component('comp1').geom('geom1').run('blk1');
model.component('comp1').geom('geom1').feature.duplicate('blk2', 'blk1');
model.component('comp1').geom('geom1').feature('blk2').set('pos', {{'0' '0' '-(PML_z+air_z)/2'}});
model.component('comp1').geom('geom1').feature('blk2').label('Bottom PML')
model.component('comp1').geom('geom1').run('blk2');
model.component('comp1').geom('geom1').create('blk3', 'Block');
model.component('comp1').geom('geom1').feature('blk3').set('size', {{'g' 'g' 'air_z'}});
model.component('comp1').geom('geom1').feature('blk3').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk3').label('Air Block');
model.component('comp1').geom('geom1').feature('blk3').label('Air Block Tool');
model.component('comp1').geom('geom1').run('blk3');
model.component('comp1').geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.component('comp1').geom('geom1').selection('csel2').label('geom_air');
model.component('comp1').geom('geom1').selection.create('csel3', 'CumulativeSelection');
model.component('comp1').geom('geom1').selection('csel3').label('Copper');
% Begin Copper
{0}
% End Copper
model.component('comp1').geom('geom1').create('dif1', 'Difference');
model.component('comp1').geom('geom1').feature('dif1').label('Air Block');
model.component('comp1').geom('geom1').feature('dif1').selection('input').set({{'blk3'}});
model.component('comp1').geom('geom1').feature('dif1').selection('input2').named('csel3');
model.component('comp1').geom('geom1').feature('dif1').set('keep', true);
model.component('comp1').geom('geom1').feature('dif1').set('contributeto', 'csel2');
model.component('comp1').geom('geom1').run('dif1');
model.component('comp1').geom('geom1').create('del1', 'Delete');
model.component('comp1').geom('geom1').feature('del1').selection('input').init;
model.component('comp1').geom('geom1').feature('del1').selection('input').set({{'blk3'}});
model.component('comp1').geom('geom1').run;
% End Geometry

model.component('comp1').material.create('mat1', 'Common');
model.component('comp1').material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.component('comp1').material('mat1').propertyGroup.create('linzRes', 'Linearized resistivity');
model.component('comp1').material('mat1').label('Copper');
model.component('comp1').material('mat1').set('family', 'copper');
model.component('comp1').material('mat1').propertyGroup('def').set('relpermeability', {{'1' '0' '0' '0' '1' '0' '0' '0' '1'}});
model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity', {{'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'}});
model.component('comp1').material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {{'17e-6[1/K]' '0' '0' '0' '17e-6[1/K]' '0' '0' '0' '17e-6[1/K]'}});
model.component('comp1').material('mat1').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', {{'1' '0' '0' '0' '1' '0' '0' '0' '1'}});
model.component('comp1').material('mat1').propertyGroup('def').set('density', '8960[kg/m^3]');
model.component('comp1').material('mat1').propertyGroup('def').set('thermalconductivity', {{'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'}});
model.component('comp1').material('mat1').propertyGroup('Enu').set('youngsmodulus', '110e9[Pa]');
model.component('comp1').material('mat1').propertyGroup('Enu').set('poissonsratio', '0.35');
model.component('comp1').material('mat1').propertyGroup('linzRes').set('rho0', '');
model.component('comp1').material('mat1').propertyGroup('linzRes').set('alpha', '');
model.component('comp1').material('mat1').propertyGroup('linzRes').set('Tref', '');
model.component('comp1').material('mat1').propertyGroup('linzRes').set('rho0', '1.72e-8[ohm*m]');
model.component('comp1').material('mat1').propertyGroup('linzRes').set('alpha', '0.0039[1/K]');
model.component('comp1').material('mat1').propertyGroup('linzRes').set('Tref', '298[K]');
model.component('comp1').material('mat1').propertyGroup('linzRes').addInput('temperature');
model.component('comp1').material('mat1').set('family', 'copper');
model.component('comp1').material.create('mat2', 'Common');
model.component('comp1').material('mat2').propertyGroup('def').func.create('eta', 'Piecewise');
model.component('comp1').material('mat2').propertyGroup('def').func.create('Cp', 'Piecewise');
model.component('comp1').material('mat2').propertyGroup('def').func.create('rho', 'Analytic');
model.component('comp1').material('mat2').propertyGroup('def').func.create('k', 'Piecewise');
model.component('comp1').material('mat2').propertyGroup('def').func.create('cs', 'Analytic');
model.component('comp1').material('mat2').propertyGroup('def').func.create('an1', 'Analytic');
model.component('comp1').material('mat2').propertyGroup('def').func.create('an2', 'Analytic');
model.component('comp1').material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.component('comp1').material('mat2').propertyGroup.create('NonlinearModel', 'Nonlinear model');
model.component('comp1').material('mat2').label('Air');
model.component('comp1').material('mat2').set('family', 'air');
model.component('comp1').material('mat2').propertyGroup('def').func('eta').set('arg', 'T');
model.component('comp1').material('mat2').propertyGroup('def').func('eta').set('pieces', {{'200.0' '1600.0' '-8.38278E-7+8.35717342E-8*T^1-7.69429583E-11*T^2+4.6437266E-14*T^3-1.06585607E-17*T^4'}});
model.component('comp1').material('mat2').propertyGroup('def').func('eta').set('argunit', 'K');
model.component('comp1').material('mat2').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.component('comp1').material('mat2').propertyGroup('def').func('Cp').set('arg', 'T');
model.component('comp1').material('mat2').propertyGroup('def').func('Cp').set('pieces', {{'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'}});
model.component('comp1').material('mat2').propertyGroup('def').func('Cp').set('argunit', 'K');
model.component('comp1').material('mat2').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.component('comp1').material('mat2').propertyGroup('def').func('rho').set('expr', 'pA*0.02897/R_const[K*mol/J]/T');
model.component('comp1').material('mat2').propertyGroup('def').func('rho').set('args', {{'pA' 'T'}});
model.component('comp1').material('mat2').propertyGroup('def').func('rho').set('dermethod', 'manual');
model.component('comp1').material('mat2').propertyGroup('def').func('rho').set('argders', {{'pA' 'd(pA*0.02897/R_const/T,pA)'; 'T' 'd(pA*0.02897/R_const/T,T)'}});
model.component('comp1').material('mat2').propertyGroup('def').func('rho').set('argunit', 'Pa,K');
model.component('comp1').material('mat2').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.component('comp1').material('mat2').propertyGroup('def').func('rho').set('plotargs', {{'pA' '0' '1'; 'T' '0' '1'}});
model.component('comp1').material('mat2').propertyGroup('def').func('k').set('arg', 'T');
model.component('comp1').material('mat2').propertyGroup('def').func('k').set('pieces', {{'200.0' '1600.0' '-0.00227583562+1.15480022E-4*T^1-7.90252856E-8*T^2+4.11702505E-11*T^3-7.43864331E-15*T^4'}});
model.component('comp1').material('mat2').propertyGroup('def').func('k').set('argunit', 'K');
model.component('comp1').material('mat2').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.component('comp1').material('mat2').propertyGroup('def').func('cs').set('expr', 'sqrt(1.4*R_const[K*mol/J]/0.02897*T)');
model.component('comp1').material('mat2').propertyGroup('def').func('cs').set('args', {{'T'}});
model.component('comp1').material('mat2').propertyGroup('def').func('cs').set('dermethod', 'manual');
model.component('comp1').material('mat2').propertyGroup('def').func('cs').set('argunit', 'K');
model.component('comp1').material('mat2').propertyGroup('def').func('cs').set('fununit', 'm/s');
model.component('comp1').material('mat2').propertyGroup('def').func('cs').set('plotargs', {{'T' '273.15' '373.15'}});
model.component('comp1').material('mat2').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.component('comp1').material('mat2').propertyGroup('def').func('an1').set('expr', '-1/rho(pA,T)*d(rho(pA,T),T)');
model.component('comp1').material('mat2').propertyGroup('def').func('an1').set('args', {{'pA' 'T'}});
model.component('comp1').material('mat2').propertyGroup('def').func('an1').set('argunit', 'Pa,K');
model.component('comp1').material('mat2').propertyGroup('def').func('an1').set('fununit', '1/K');
model.component('comp1').material('mat2').propertyGroup('def').func('an1').set('plotargs', {{'pA' '101325' '101325'; 'T' '273.15' '373.15'}});
model.component('comp1').material('mat2').propertyGroup('def').func('an2').set('funcname', 'muB');
model.component('comp1').material('mat2').propertyGroup('def').func('an2').set('expr', '0.6*eta(T)');
model.component('comp1').material('mat2').propertyGroup('def').func('an2').set('args', {{'T'}});
model.component('comp1').material('mat2').propertyGroup('def').func('an2').set('argunit', 'K');
model.component('comp1').material('mat2').propertyGroup('def').func('an2').set('fununit', 'Pa*s');
model.component('comp1').material('mat2').propertyGroup('def').func('an2').set('plotargs', {{'T' '200' '1600'}});
model.component('comp1').material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.component('comp1').material('mat2').propertyGroup('def').set('molarmass', '');
model.component('comp1').material('mat2').propertyGroup('def').set('bulkviscosity', '');
model.component('comp1').material('mat2').propertyGroup('def').set('relpermeability', {{'1' '0' '0' '0' '1' '0' '0' '0' '1'}});
model.component('comp1').material('mat2').propertyGroup('def').set('relpermittivity', {{'1' '0' '0' '0' '1' '0' '0' '0' '1'}});
model.component('comp1').material('mat2').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.component('comp1').material('mat2').propertyGroup('def').set('ratioofspecificheat', '1.4');
model.component('comp1').material('mat2').propertyGroup('def').set('electricconductivity', {{'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'}});
model.component('comp1').material('mat2').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.component('comp1').material('mat2').propertyGroup('def').set('density', 'rho(pA,T)');
model.component('comp1').material('mat2').propertyGroup('def').set('thermalconductivity', {{'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'}});
model.component('comp1').material('mat2').propertyGroup('def').set('soundspeed', 'cs(T)');
model.component('comp1').material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {{'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)'}});
model.component('comp1').material('mat2').propertyGroup('def').set('molarmass', '0.02897');
model.component('comp1').material('mat2').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.component('comp1').material('mat2').propertyGroup('def').addInput('temperature');
model.component('comp1').material('mat2').propertyGroup('def').addInput('pressure');
model.component('comp1').material('mat2').propertyGroup('RefractiveIndex').set('n', '');
model.component('comp1').material('mat2').propertyGroup('RefractiveIndex').set('ki', '');
model.component('comp1').material('mat2').propertyGroup('RefractiveIndex').set('n', {{'1' '0' '0' '0' '1' '0' '0' '0' '1'}});
model.component('comp1').material('mat2').propertyGroup('RefractiveIndex').set('ki', {{'0' '0' '0' '0' '0' '0' '0' '0' '0'}});
model.component('comp1').material('mat2').propertyGroup('NonlinearModel').set('BA', '(def.gamma+1)/2');
model.component('comp1').material('mat2').materialType('nonSolid');
model.component('comp1').material('mat2').set('family', 'air');

model.component('comp1').selection.create('uni3', 'Union');
model.component('comp1').selection('uni3').set('input', {{'geom1_csel1_dom' 'geom1_csel2_dom'}});
model.component('comp1').selection('uni3').label('Air');

model.component('comp1').material('mat2').selection.named('uni3');
model.component('comp1').material('mat1').selection.named('geom1_csel3_dom');

model.component('comp1').physics('emw').create('pc1', 'PeriodicCondition', 2);
model.component('comp1').physics('emw').create('pc2', 'PeriodicCondition', 2);
model.component('comp1').physics('emw').feature('pc1').selection.named('uni1');
model.component('comp1').physics('emw').feature('pc1').create('dd1', 'DestinationDomains', 2);
model.component('comp1').physics('emw').feature('pc1').feature('dd1').selection.named('box1');
model.component('comp1').physics('emw').feature('pc2').create('dd1', 'DestinationDomains', 2);
model.component('comp1').physics('emw').feature('pc2').feature('dd1').selection.named('box2');
model.component('comp1').physics('emw').feature('pc2').selection.named('box6');
model.component('comp1').physics('emw').feature('pc2').selection.named('uni2');
model.component('comp1').physics('emw').create('port1', 'Port', 2);
model.component('comp1').physics('emw').feature('port1').selection.named('box5');
model.component('comp1').physics('emw').feature('port1').set('PortType', 'Periodic');
model.component('comp1').physics('emw').feature('port1').set('PortSlit', true);
model.component('comp1').physics('emw').feature('port1').set('SlitType', 'DomainBacked');

model.component('comp1').physics('emw').feature('port1').set('Eampl', [0 1 0]);
model.component('comp1').physics('emw').create('port2', 'Port', 2);
model.component('comp1').physics('emw').feature('port2').set('PortType', 'Periodic');
model.component('comp1').physics('emw').feature('port2').selection.named('box6');
model.component('comp1').physics('emw').feature('port2').set('PortSlit', true);
model.component('comp1').physics('emw').feature('port2').set('SlitType', 'DomainBacked');
model.component('comp1').physics('emw').feature('port2').set('Eampl', [0 1 0]);

model.component('comp1').coordSystem.create('pml1', 'PML');
model.component('comp1').coordSystem('pml1').selection.named('geom1_csel1_dom');

model.study('std1').create('wave', 'Wavelength');
model.study('std1').feature('wave').set('plist', 'range(lambda_min,(lambda_max-(lambda_min))/(N_f-1),lambda_max)');

out = model;
