within InterProcessCommunication.Examples.InterProcessExamples;

model ArduBasicTest
  Real ModelicaInput;
  Real ModelicaOutput (start = 1);
  Real OutputDummy;
  Real OP (start = 0);
     equation
    
    ModelicaOutput = time;
    when sample(0, 0.05) then
     
      ModelicaInput = InterProcessCommunication.SharedMemory.SharedMemoryRead(1);
      OutputDummy = InterProcessCommunication.SharedMemory.SharedMemoryWrite(1, ModelicaOutput);  
    end when;
    OP =  ModelicaOutput - ModelicaInput;
annotation(
    experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-6, Interval = 0.005));
end ArduBasicTest;