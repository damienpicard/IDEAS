within IDEAS.Controls.ControlHeating;
model RunningMeanTemperatureEN15251_discrete
  "Calculate the running mean temperature of 7 days, acccording to norm EN15251"
  extends Simplified2ZonesOfficeBuilding.Control.Interfaces.SubController;
  import SI = Modelica.SIunits;

  parameter Real[7] TAveDayIni(unit="K", displayUnit="degC") = ones(7).* 283.15
    "initial running mean temperature";

  // Interface
   discrete Modelica.Blocks.Interfaces.RealOutput TRm(unit="K",displayUnit = "degC")
    "running mean average temperature"
     annotation (Placement(transformation(extent={{96,-10},{116,10}})));

protected
  discrete Real[7] TAveDay(unit="K",displayUnit = "degC")
    "Vector with the average day temperatures of the previous nTermRm days";
  parameter Real coeTRm[7] = {1, 0.8, 0.6, 0.5, 0.4, 0.3, 0.2}./3.8
    "weighting coefficient for the running average";

  Real intTIn "integral of TIn";

public
  outer SimInfoManager       sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Te)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  der(intTIn) =  realExpression.y;
algorithm
  when initial() then
    // initialization of the discrete variables
    TAveDay:=TAveDayIni;
    TRm:=TAveDayIni[1];
  elsewhen sample(24*3600,24*3600) then
    // Update of TAveDay
    for i in 2:7 loop
      TAveDay[i] := pre(TAveDay[i-1]);
    end for;
    TAveDay[1] := intTIn / 24/3600;
    // reinitialisation of the intTIn
    reinit(intTIn,0);
    TRm :=TAveDay*coeTRm;
  end when;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(StopTime=864000),
    __Dymola_experimentSetupOutput);
end RunningMeanTemperatureEN15251_discrete;
