within IDEAS.Fluid.BaseCircuits.Interfaces;
model PartialMixingCircuit "Partial for a mixing circuit"
  import IDEAS;

  //Extensions
  extends IDEAS.Fluid.BaseCircuits.Interfaces.PartialCircuitBalancingValve;

  //Parameters
  parameter SI.Mass mMix=1 "Mass of fluid inside the mixing valve"
  annotation(Dialog(group = "Mixing valve"));
  parameter SI.Mass mPipe=1 "Mass of fluid inside the middle pipe"
  annotation(Dialog(group = "Mixing valve"));
  parameter Modelica.SIunits.Pressure dpMixPipe=0
    "Pressure drop over the middle single pipe"
    annotation(Dialog(group = "Mixing valve"));
  parameter SI.ThermalConductance UAMix=10 if includePipes
    "Thermal conductance of the insulation of the middle pipe"
    annotation(Dialog(group = "Mixing valve"));
  IDEAS.Fluid.FixedResistances.InsulatedPipe pipeMix(
    UA=UAMix,
    m=mPipe,
    dp_nominal=dpMixPipe,
    m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,0})), choicesAllMatching=true);
  IDEAS.Fluid.Valves.Thermostatic3WayValve thermostatic3WayValve(
    m_flow_nominal=m_flow_nominal,
    m=mMix,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Blocks.Interfaces.RealInput TMixedSet
    "Setpoint for the supply temperature"                                              annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,104}),   iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,100})));
equation
  connect(pipeMix.heatPort, pipeReturn.heatPort) annotation (Line(
      points={{-4,0},{-80,0},{-80,-56}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermostatic3WayValve.port_a2, pipeMix.port_a) annotation (Line(
      points={{0,50},{0,10}},
      color={0,127,255},
      smooth=Smooth.None));

  if not measureSupplyT then
    connect(thermostatic3WayValve.port_b, port_b1);
  end if;
  connect(TMixedSet, thermostatic3WayValve.TMixedSet) annotation (Line(
      points={{0,104},{0,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(thermostatic3WayValve.port_a1, pipeSupply.port_b) annotation (Line(
      points={{-10,60},{-70,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipeMix.port_b, balancingValve.port_a) annotation (Line(
      points={{0,-10},{0,-60},{-18,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(thermostatic3WayValve.port_b, senTem.port_a) annotation (Line(
      points={{10,60},{40,60},{40,20},{60,20}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{-20,70},{-20,50},{0,60},{-20,70}},
          lineColor={0,0,127},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,70},{20,50},{0,60},{20,70}},
          lineColor={0,0,127},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,40},{0,60}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{0,100},{-6,80},{0,60}},
          color={0,255,128},
          smooth=Smooth.None),
        Polygon(
          points={{-10,10},{-10,-10},{10,0},{-10,10}},
          lineColor={0,0,127},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={0,50},
          rotation=90),
        Line(
          points={{0,40},{0,-60}},
          color={0,0,255},
          smooth=Smooth.None)}));
end PartialMixingCircuit;
