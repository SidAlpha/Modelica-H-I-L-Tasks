clear
clc

x0 = [39.8858212875252,0.1,0,0];
u0 = [-0.15625,1112.82];



//C=[1 0;0 1]
A = [-0.05321913896678525,-7.309325638062395,-0,-0,-9.809999999999766,-0,-0,-0.1176174797773325,-0,-0,-0,-0;-0.01219893117742086,-1.718678333264892,0,0,-5.377762026288438e-08,0,0,0.972369652215591,0,0,0,0;0,0,-0.1173471007801458,0,0,0.2459520622449354,0.0979177134828252,0,-0.9841312554283186,0,0,0;0,0,0,0,0,-9.989611474825684e-15,0,0,1.000000000000024,0,0,0;0,0,0,0,0,0,0,1,0,0,0,0;0,0,0,0,0,-2.184236747451698e-21,1,0,2.186508207006984e-07,0,0,0;0,0,-11.9005831358691,0,0,0,-8.595915052137459,0,1.755761372351488,0,0,0;8.72055317654725e-15,-23.19570991744142,0,0,0,0,0,-2.990667436458215,0,0,0,0;0,0,4.188841114696014,0,0,0,-0.2644343119382115,0,-8.726332293961047,0,0,0;0.9999999999999761,0,0,0,-8.721067558838564e-06,0,0,0,0,0,0,0;0,0,0,39.88582128752424,0,0,0,0,0,0,0,0;-2.186508207006932e-07,-0,-0,-0,-39.88582128752424,-0,-0,-0,-0,-0,-0,-0];

A_lon = [-295.560744910425, -1545.45800952009, 0, -9.79067257150221; -0.341690129530101, -1.75231245122795, 1, 0; -85.9987076618936, -25.0079177937799, 0, 0; 0, 0, 1, 0];


B = [-0.5601131348246953,0.0009537451500853349;-0.1315801081873247,-2.399191085901589e-06;0,0;0,0;0,0;0,0;0,0;-16.49472705240279,-0;0,0;0,0;0,0;0,0];

B_lon = [-120.180539581675, 0.000954886316059032; -0.136623425884905, -2.01720474449102e-06; -17.7834082089102, 0; 0, 0];
   
C_lon = [1, 0, 0, 0; 0, 1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1];   
   

 
D_lon =  [0, 0, 7.20000000000000, 0];
   
   
k_place=ppol(A_lon,B_lon,x0);
Acl=A_lon-B_lon*k_place
cl_poles=spec(Acl)
Kr=-1/(C_lon*inv(A_lon-B_lon*k_place)*B_lon);
