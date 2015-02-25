within IDEAS.Controls.ControlHeating.Examples;
model RunningMeanTemperatureEN15251
  import IDEAS;
  extends Modelica.Icons.Example;

  inner IDEAS.SimInfoManager sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  IDEAS.Controls.ControlHeating.RunningMeanTemperatureEN15251
    runningMeanTemperatureEN15251_discrete
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(StopTime=3.15e+007, __Dymola_NumberOfIntervals=50000),
    __Dymola_experimentSetupOutput);
end RunningMeanTemperatureEN15251;
