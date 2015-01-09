within IDEAS.Fluid.BaseCircuits;
model ThermostaticRadiatiorValve
  "Simple TRV model approximated by a P-control action"

  //Extensions
  extends Interfaces.PartialValveCircuit(
    redeclare Actuators.Valves.TwoWayQuickOpening    flowRegulator);
  extends Interfaces.ValveParametersTop;
  Modelica.Blocks.Interfaces.RealInput u1 "measurement signal"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,108})));
  Modelica.Blocks.Continuous.LimPID PID(controllerType=Modelica.Blocks.Types.SimpleController.P,
      k=1) annotation (Placement(transformation(extent={{20,72},{40,92}})));
equation
  connect(PID.u_m, u1) annotation (Line(
      points={{30,70},{30,66},{-60,66},{-60,108}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PID.y, flowRegulator.y) annotation (Line(
      points={{41,82},{44,82},{44,62},{18,62},{18,74},{0,74},{0,72}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(u, PID.u_s) annotation (Line(
      points={{0,108},{0,82},{18,82}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation(Dialog(group = "Thermostatic valve parameters",
                    enable = (CvData==IDEAS.Fluid.Types.CvTypes.Kv)),
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{0,100},{6,80},{0,60}},
          color={0,255,128},
          smooth=Smooth.None),
        Line(
          points={{0,-60},{0,-40}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-10,-40},{10,-40}},
          color={0,0,127},
          smooth=Smooth.None),
        Polygon(
          points={{-20,-50},{-20,-70},{0,-60},{-20,-50}},
          lineColor={0,0,127},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,-50},{20,-70},{0,-60},{20,-50}},
          lineColor={0,0,127},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{4,44},{24,24}},
          lineColor={0,0,127},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Line(
          points={{-40,100},{-16,86},{0,60}},
          color={255,0,0},
          smooth=Smooth.None)}));
end ThermostaticRadiatiorValve;
