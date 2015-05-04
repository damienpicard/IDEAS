within IDEAS.Buildings.Components.BaseClasses;
model AirLeakage "air leakage due to limied air tightness"

extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface;
  parameter Boolean linearize = sim.linearize;
  parameter Modelica.SIunits.Temperature T_start = 293.15
    "Start value of temperature"
    annotation(Dialog(tab = "Initialization"));
  parameter Modelica.SIunits.Volume V "zone air volume";
  parameter Real n50(min=0.01)=0.4 "n50-value of airtightness";

  parameter SI.Time tau=30 "Tin time constant at nominal flow rate";

  Fluid.Interfaces.IdealSource       idealSource(
    redeclare package Medium = Medium,
    control_m_flow=true,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Fluid.FixedResistances.Pipe_HeatPort       pipe_HeatPort(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    dynamicBalance=false,
    m_flow_nominal=m_flow_nominal + 0.00001,
    T_start=T_start)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=V/3600*n50/20)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Interfaces.RealInput Te if linearize "Ambiant temperature"
    annotation (Placement(transformation(extent={{-120,50},{-80,90}})));
  outer SimInfoManager       sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-80,78},{-60,98}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Te)
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
equation
  connect(pipe_HeatPort.port_b, port_b) annotation (Line(
      points={{80,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(idealSource.port_b, pipe_HeatPort.port_a) annotation (Line(
      points={{20,0},{60,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(realExpression1.y, idealSource.m_flow_in) annotation (Line(
      points={{-19,30},{4,30},{4,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(port_a, idealSource.port_a) annotation (Line(
      points={{-100,0},{0,0}},
      color={0,127,255},
      smooth=Smooth.None));

  if linearize then
    connect(prescribedTemperature.T, Te) annotation (Line(
      points={{18,70},{-100,70}},
      color={0,0,127},
      smooth=Smooth.None));
  else
    connect(realExpression.y, prescribedTemperature.T) annotation (Line(
      points={{-19,80},{0,80},{0,70},{18,70}},
      color={0,0,127},
      smooth=Smooth.None));
  end if;

  connect(prescribedTemperature.port, pipe_HeatPort.heatPort) annotation (Line(
      points={{40,70},{70,70},{70,10}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                   graphics={Text(
          extent={{-60,60},{60,-60}},
          lineColor={0,128,255},
          textString="ACH")}),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
        graphics));
end AirLeakage;
