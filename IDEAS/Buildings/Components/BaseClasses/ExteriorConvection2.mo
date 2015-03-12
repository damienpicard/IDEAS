within IDEAS.Buildings.Components.BaseClasses;
model ExteriorConvection2 "exterior surface convection"

  parameter Modelica.SIunits.Area A "surface area";
  parameter Boolean linearize = false "Use constant convection coefficient"
    annotation(Evaluate=true);
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hConExt_mean = 18.3
    "Value for exterior convection coefficient around which the exterior convection is linearized"
                                                                                                        annotation(Dialog(enable=linearize));
  parameter Real T_mean(unit="K",displayUnit="degC") = 285
    "Value for the wall temperature around which the exterior convection is linearized"
                                                                                                        annotation(Dialog(enable=linearize));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

  Modelica.Blocks.Interfaces.RealInput Te(unit="K",displayUnit="degC")
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
  Modelica.Blocks.Interfaces.RealInput hConExt(unit="W/(m2.K)")
    "Exterior convective heat transfer coefficient"
    annotation (Placement(transformation(extent={{-120,-110},{-80,-70}})));

  Modelica.SIunits.TemperatureDifference dT = port_a.T - Te;
  parameter Modelica.SIunits.TemperatureDifference dT_mean = 0;
  Modelica.Blocks.Interfaces.RealInput hTenvTe(unit="W/m2") annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={10,100})));
  Modelica.Blocks.Interfaces.RealInput hSolTot(unit="W2/(m4.K)") annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={50,100})));

  Real corr;
//   Modelica.SIunits.Temperature Ta;

  //parameter Modelica.SIunits.ThermalResistance RConv = 1 / A / hConExt_mean;
  Modelica.SIunits.ThermalResistance RConv = 1 / A / hConExt_mean;
  Modelica.SIunits.ThermalResistance Rrad = 1 / A / 5.67 / epsLw;
  Modelica.Blocks.Interfaces.RealInput TEnv(unit="K", displayUnit="degC")
    annotation (Placement(transformation(extent={{-120,-50},{-80,-10}})));
  Modelica.Blocks.Interfaces.RealInput solDif(unit="W/m2")
    annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
  Modelica.Blocks.Interfaces.RealInput solDir(unit="W/m2")
    annotation (Placement(transformation(extent={{-120,50},{-80,90}})));
//   Modelica.SIunits.TemperatureDifference errTa;
//   Real errQ;
//   Real term1;
//   Real term2;
//
//     Real QAbs;
//     Real QConv;
//     Real QRad;
//     Real QC;
  Modelica.Blocks.Interfaces.RealInput epsSw
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-30,100})));
  Modelica.Blocks.Interfaces.RealInput epsLw
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-70,100})));

equation
  if linearize then
    corr = A*RConv/(RConv+Rrad)*(hTenvTe - hConExt_mean*(TEnv-Te)) - A*epsSw*RConv*Rrad/(RConv+Rrad)*(A*hSolTot - hConExt_mean*A*(solDir+solDif));
    port_a.Q_flow = A* hConExt_mean*(port_a.T - Te) - corr/2;
    //port_a.Q_flow = A*( hConExt_mean*dT + hConExt*dT_mean - hConExt_mean*dT_mean*u_dummy);
    //port_a.Q_flow = A*RConv/(RConv+Rrad)*(hTenvTe - hConExt_mean*(TEnv-Te)) - A*0.65*RConv*Rrad/(RConv+Rrad)*(A*hSolTot - hConExt_mean*A*(solDir+solDif));
  else
    corr = 0;
    port_a.Q_flow = A*hConExt*(port_a.T - Te);
  end if;

  annotation (Icon(graphics={
        Rectangle(
          extent={{-90,80},{-60,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Line(points={{-60,20},{76,20}}, color={191,0,0}),
        Line(points={{-34,80},{-34,-80}}, color={0,127,255}),
        Line(points={{-60,-20},{76,-20}}, color={191,0,0}),
        Line(points={{56,30},{76,20}}, color={191,0,0}),
        Line(points={{56,10},{76,20}}, color={191,0,0}),
        Line(points={{56,-10},{76,-20}}, color={191,0,0}),
        Line(points={{56,-30},{76,-20}}, color={191,0,0}),
        Line(points={{6,80},{6,-80}}, color={0,127,255}),
        Line(points={{40,80},{40,-80}}, color={0,127,255}),
        Line(points={{76,80},{76,-80}}, color={0,127,255}),
        Line(points={{-34,-80},{-44,-60}}, color={0,127,255}),
        Line(points={{-34,-80},{-24,-60}}, color={0,127,255}),
        Line(points={{6,-80},{-4,-60}}, color={0,127,255}),
        Line(points={{6,-80},{16,-60}}, color={0,127,255}),
        Line(points={{40,-80},{30,-60}}, color={0,127,255}),
        Line(points={{40,-80},{50,-60}}, color={0,127,255}),
        Line(points={{76,-80},{66,-60}}, color={0,127,255}),
        Line(points={{76,-80},{86,-60}}, color={0,127,255}),
        Text(
          extent={{-150,-90},{150,-130}},
          textString="%name",
          lineColor={0,0,255}),
        Line(
          points={{-60,80},{-60,-80}},
          color={0,0,0},
          thickness=0.5)}), Documentation(info="<html>
<p>The exterior convective heat flow is computed as </p>
<p align=\"center\"><img src=\"modelica://IDEAS/Images/equations/equation-dlroqBUD.png\"/></p>
<p>where <img src=\"modelica://IDEAS/Images/equations/equation-pvb42RGk.png\"/> is the surface area, <img src=\"modelica://IDEAS/Images/equations/equation-EFr6uClx.png\"/> is the dry-bulb exterior air temperature, <img src=\"modelica://IDEAS/Images/equations/equation-9BU57cj4.png\"/> is the surface temperature and <img src=\"modelica://IDEAS/Images/equations/equation-HvwkeunV.png\"/> is the wind speed in the undisturbed flow at 10 meter above the ground and where the stated correlation is valid for a <img src=\"modelica://IDEAS/Images/equations/equation-HvwkeunV.png\"/> range of [0.15,7.5] meter per second <a href=\"IDEAS.Buildings.UsersGuide.References\">[Defraeye 2011]</a>. The <img src=\"modelica://IDEAS/Images/equations/equation-HvwkeunV.png\"/>-dependent term denoting the exterior convective heat transfer coefficient <img src=\"modelica://IDEAS/Images/equations/equation-W7Ft8vaa.png\"/> is determined as <img src=\"modelica://IDEAS/Images/equations/equation-aZcbMNkz.png\"/> in order to take into account buoyancy effects at low wind speeds <a href=\"IDEAS.Buildings.UsersGuide.References\">[Jurges 1924]</a>.</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end ExteriorConvection2;
