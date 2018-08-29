model linear_Wind6DOFLinTest
  parameter Integer n = 12; // states
  parameter Integer k = 2; // top-level inputs
  parameter Integer l = 0; // top-level outputs
  parameter Real x0[12] = {39.88582128752525,0.09999999999999862,0,0,2.186508960985091e-07,0,0,1.987865483530107e-16,0,39885.8213088767,0,99.99136937653074};
  parameter Real u0[2] = {-0.15625,1112.82};
  parameter Real A[12,12] = [-0.05321913896678734,-7.309325638062704,-0,-0,-9.809999999999766,-0,-0,-0.1176174797773372,-0,-0,-0,-0;-0.01219893117742107,-1.718678333264895,0,0,-5.377763880713219e-08,0,0,0.972369652215591,0,0,0,0;0,0,-0.1173471007801448,0,0,0.245952062244935,0.09791771348283063,0,-0.984131255428318,0,0,0;0,0,0,0,0,1.987865483530154e-16,0,0,1.000000000000024,0,0,0;0,0,0,0,0,0,0,1,0,0,0,0;0,0,0,0,0,4.346485692971609e-23,1,0,2.186508960985126e-07,0,0,0;0,0,-11.90058313586914,0,0,0,-8.595915052137471,0,1.755761372351484,0,0,0;1.593168723885149e-15,-23.19570991744149,0,0,0,0,0,-2.990667436458219,0,0,0,0;0,0,4.188841114696025,0,0,0,-0.2644343119382139,0,-8.726332293961059,0,0,0;0.9999999999999761,0,0,0,-8.721070566142317e-06,0,0,0,0,0,0,0;0,0,0,39.8858212875243,0,0,0,0,0,0,0,0;-2.186508960985074e-07,-0,-0,-0,-39.8858212875243,-0,-0,-0,-0,-0,-0,-0];
  parameter Real B[12,2] = [-0.5601131348247189,0.0009537451500853343;-0.1315801081873249,-2.399191085901716e-06;0,0;0,0;0,0;0,0;0,0;-16.49472705240284,-0;0,0;0,0;0,0;0,0];
  parameter Real C[0,12] = zeros(0,12);
  parameter Real D[0,2] = zeros(0,2);
  Real x[12](start=x0);
  input Real u[2](start= u0);
  output Real y[0];

  Real 'x_V' = x[1];
Real 'x_alpha' = x[2];
Real 'x_beta' = x[3];
Real 'x_chi' = x[4];
Real 'x_gamma' = x[5];
Real 'x_mu' = x[6];
Real 'x_p' = x[7];
Real 'x_q' = x[8];
Real 'x_r' = x[9];
Real 'x_x' = x[10];
Real 'x_y' = x[11];
Real 'x_z' = x[12];
Real 'u_deltaE' = u[1];
Real 'u_thrust' = u[2];

equation
  der(x) = A * x + B * u;
  y = C * x + D * u;
end linear_Wind6DOFLinTest;