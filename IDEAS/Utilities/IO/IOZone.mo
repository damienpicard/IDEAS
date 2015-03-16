within IDEAS.Utilities.IO;
partial model IOZone
// FIXME: add later on the effect of internal gain: extra inputs
  parameter Integer nWin=1 "number of windows";
  parameter Integer nOutWall=1 "number of outer walls";
  parameter Integer nLay=1;
  parameter Integer nEmb=1;
  parameter Integer nZones=1;
  parameter Integer nOut=1 "size of the general vector output of the structure";

  Modelica.Blocks.Interfaces.RealInput QEmb[nEmb]
    annotation (Placement(transformation(extent={{-146,62},{-100,108}}),
        iconTransformation(extent={{-140,68},{-100,108}})));
  Modelica.Blocks.Interfaces.RealInput QConv[nZones]
    annotation (Placement(transformation(extent={{-144,26},{-100,70}}),
        iconTransformation(extent={{-140,30},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput QRad[nZones]
    annotation (Placement(transformation(extent={{-142,-12},{-100,30}}),
        iconTransformation(extent={{-140,-10},{-100,30}})));
  Modelica.Blocks.Interfaces.RealInput Te "Ambient temperature"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}}),
        iconTransformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput Tsky "Sky temperature"
    annotation (Placement(transformation(extent={{-140,-120},{-100,-80}}),
        iconTransformation(extent={{-140,-120},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput Va "Wind speed"
    annotation (Placement(transformation(extent={{-140,-162},{-100,-122}}),
        iconTransformation(extent={{-140,-162},{-100,-122}})));

  Modelica.Blocks.Interfaces.RealInput outWallSolDir[nOutWall]
    annotation (Placement(transformation(extent={{-140,-220},{-100,-180}})));
  Modelica.Blocks.Interfaces.RealInput outWallSolDif[nOutWall]
    annotation (Placement(transformation(extent={{-140,-260},{-100,-220}})));

  Modelica.Blocks.Interfaces.RealInput winISolAbsQL1[nWin]
    annotation (Placement(transformation(extent={{-140,-320},{-100,-280}})));
  Modelica.Blocks.Interfaces.RealInput winISolAbsQL2[nWin]
    annotation (Placement(transformation(extent={{-140,-348},{-100,-308}}),
        iconTransformation(extent={{-140,-348},{-100,-308}})));
  Modelica.Blocks.Interfaces.RealInput winISolAbsQL3[nWin]
    annotation (Placement(transformation(extent={{-140,-380},{-100,-340}})));
  Modelica.Blocks.Interfaces.RealInput winISolDirQ[nWin]
    annotation (Placement(transformation(extent={{-142,-434},{-102,-394}}),
        iconTransformation(extent={{-142,-434},{-102,-394}})));
  Modelica.Blocks.Interfaces.RealInput winISolDifQ[nWin]
    annotation (Placement(transformation(extent={{-142,-474},{-102,-434}}),
        iconTransformation(extent={{-142,-474},{-102,-434}})));
  Modelica.Blocks.Interfaces.RealOutput TEmb[nEmb]
    annotation (Placement(transformation(extent={{100,72},{138,110}})));
                                                   //(unit="K", displayUnit="degC")

  Modelica.Blocks.Interfaces.RealOutput TConv[nZones]
    annotation (Placement(transformation(extent={{100,30},{140,70}})));
                                                     //(unit="K", displayUnit="degC")
  Modelica.Blocks.Interfaces.RealOutput TRad[nZones]
    annotation (Placement(transformation(extent={{100,-10},{140,30}})));
                                                    //(unit="K", displayUnit="degC")
  Modelica.Blocks.Interfaces.RealOutput TSensor[nZones]
    "Sensor temperature of the zones"
    annotation (Placement(transformation(extent={{100,-70},{140,-30}})));
                                                       //(unit="K", displayUnit="degC")

  Modelica.Blocks.Interfaces.RealOutput genOut[nOut] "general outputs"
    annotation (Placement(transformation(extent={{100,-110},{140,-70}})));

  heatPortPrescribedHeatFlow[nZones] heatCon
    annotation (Placement(transformation(extent={{-14,40},{6,60}})));
  heatPortPrescribedHeatFlow[nZones] heatRad
    annotation (Placement(transformation(extent={{-14,0},{6,20}})));

  inner SimInfoManager       sim(
    PV=false,
    redeclare IDEAS.Occupants.Extern.Interfaces.Occ_Files   occupants,
    fileNamePv="User_zeros",
    nOcc=1,final use_lin=true,
    occBeh=false,
    DHW=false) "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{80,-360},{100,-340}})));
  heatPortPrescribedHeatFlow[nEmb] heatEmb
    annotation (Placement(transformation(extent={{-14,72},{6,92}})));
  Modelica.Blocks.Interfaces.RealInput QGainConv[nZones] annotation (Placement(
        transformation(extent={{-144,-512},{-100,-468}}), iconTransformation(
          extent={{-142,-532},{-102,-492}})));
  Modelica.Blocks.Interfaces.RealInput QGainRad[nZones] annotation (Placement(
        transformation(extent={{-142,-550},{-100,-508}}), iconTransformation(
          extent={{-142,-572},{-102,-532}})));
  Modelica.Blocks.Math.Add add[nZones]
    annotation (Placement(transformation(extent={{-64,-2},{-46,16}})));
  Modelica.Blocks.Math.Add add1[nZones]
    annotation (Placement(transformation(extent={{-80,34},{-62,52}})));
equation
  connect(heatCon.T, TConv) annotation (Line(
      points={{-15.2,43},{-20,43},{-20,44},{-26,44},{-26,24},{86,24},{86,50},{
          120,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatRad.T, TRad) annotation (Line(
      points={{-15.2,3},{-20,3},{-20,4},{-24,4},{-24,-12},{86,-12},{86,10},{120,
          10}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(Te,sim.Te_in);
  connect(Tsky,sim.Tsky_in);
  connect(Va,sim.Va_in);

  if nEmb > 0 then
    connect(QEmb, heatEmb.Q_flow) annotation (Line(
        points={{-123,85},{-92.5,85},{-92.5,89},{-14.8,89}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(heatEmb.T, TEmb) annotation (Line(
        points={{-15.2,75},{-22,75},{-22,76},{-28,76},{-28,66},{70,66},{70,91},
            {119,91}},
        color={0,0,127},
        smooth=Smooth.None));
  end if;
  connect(QRad, add.u1) annotation (Line(
      points={{-121,9},{-109.5,9},{-109.5,12.4},{-65.8,12.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add1.y, heatCon.Q_flow) annotation (Line(
      points={{-61.1,43},{-29.55,43},{-29.55,57},{-14.8,57}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.y, heatRad.Q_flow) annotation (Line(
      points={{-45.1,7},{-42.55,7},{-42.55,17},{-14.8,17}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(QConv, add1.u1) annotation (Line(
      points={{-122,48},{-92,48},{-92,48.4},{-81.8,48.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(QGainConv, add1.u2) annotation (Line(
      points={{-122,-490},{-81.8,-490},{-81.8,37.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(QGainRad, add.u2) annotation (Line(
      points={{-121,-529},{-65.8,-529},{-65.8,1.6}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -540},{100,100}}), graphics), Icon(coordinateSystem(extent={{-100,
            -540},{100,100}}, preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,102},{100,-562}},
          lineColor={135,135,135},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-84,50},{-22,38}},
          lineColor={0,0,0},
          textString="Zone heat 
flows"),Text(
          extent={{-76,-208},{-24,-228}},
          lineColor={0,0,0},
          textString="Solar gains 
outerwalls"),
        Text(
          extent={{-80,-378},{-28,-402}},
          lineColor={0,0,0},
          textString="Solar gains 
windows"),
        Text(
          extent={{30,60},{82,34}},
          lineColor={0,0,0},
          textString="Zone heat port 
temperatures"),
        Text(
          extent={{30,-56},{82,-80}},
          lineColor={0,0,0},
          textString="Outputs from
Structure"),
        Polygon(
          points={{-100,100},{102,100},{0,220},{-100,100}},
          lineColor={135,135,135},
          smooth=Smooth.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,148},{-60,202},{-40,202},{-40,158},{-60,148}},
          lineColor={135,135,135},
          smooth=Smooth.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-88,-88},{-36,-112}},
          lineColor={0,0,0},
          textString="Te, Tsky,
Va"),   Polygon(
          points={{-144,112},{-144,62},{-96,88},{-144,112}},
          lineColor={255,85,85},
          smooth=Smooth.None,
          fillColor={255,85,85},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-144,74},{-144,24},{-96,50},{-144,74}},
          lineColor={255,85,85},
          smooth=Smooth.None,
          fillColor={255,85,85},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-144,34},{-144,-16},{-96,10},{-144,34}},
          lineColor={255,85,85},
          smooth=Smooth.None,
          fillColor={255,85,85},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-76,-518},{-24,-538}},
          lineColor={0,0,0},
          textString="Internal gains")}));
end IOZone;
