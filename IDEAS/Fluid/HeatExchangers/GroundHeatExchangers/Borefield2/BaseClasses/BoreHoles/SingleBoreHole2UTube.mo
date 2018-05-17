within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield2.BaseClasses.BoreHoles;
model SingleBoreHole2UTube "Single 2U-tube borehole heat exchanger"
  extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface;

  extends IDEAS.Fluid.Interfaces.TwoPortFlowResistanceParameters(
      computeFlowResistance=false, linearizeFlowResistance=false);
  extends IDEAS.Fluid.Interfaces.LumpedVolumeDeclarations;

  BaseClasses.InternalHEX2UTube intHex2UTub[borFieDat.conDat.nVer](
    redeclare each final package Medium = Medium,
    each final borFieDat = borFieDat,
    final dp1_nominal={if i == 1 and borFieDat.conDat.parallel2UTube then dp_nominal elseif i ==
        1 and not borFieDat.conDat.parallel2UTube then dp_nominal/2 else 0 for i in 1:borFieDat.conDat.nVer},
    final dp3_nominal={if i == 1 and borFieDat.conDat.parallel2UTube then dp_nominal elseif i ==
        1 and not borFieDat.conDat.parallel2UTube then dp_nominal/2 else 0 for i in 1:borFieDat.conDat.nVer},
    final dp2_nominal=0,
    final dp4_nominal=0,
    each final show_T=show_T,
    each final energyDynamics=energyDynamics,
    each final massDynamics=massDynamics,
    each final m1_flow_nominal=if borFieDat.conDat.parallel2UTube then m_flow_nominal/2
         else m_flow_nominal,
    each final m2_flow_nominal=if borFieDat.conDat.parallel2UTube then m_flow_nominal/2
         else m_flow_nominal,
    each final m3_flow_nominal=if borFieDat.conDat.parallel2UTube then m_flow_nominal/2
         else m_flow_nominal,
    each final m4_flow_nominal=if borFieDat.conDat.parallel2UTube then m_flow_nominal/2
         else m_flow_nominal,
    each final m1_flow_small=if borFieDat.conDat.parallel2UTube then borFieDat.conDat.m_flow_small/2
         else borFieDat.conDat.m_flow_small,
    each final m2_flow_small=if borFieDat.conDat.parallel2UTube then borFieDat.conDat.m_flow_small/2
         else borFieDat.conDat.m_flow_small,
    each final m3_flow_small=if borFieDat.conDat.parallel2UTube then borFieDat.conDat.m_flow_small/2
         else borFieDat.conDat.m_flow_small,
    each final m4_flow_small=if borFieDat.conDat.parallel2UTube then borFieDat.conDat.m_flow_small/2
         else borFieDat.conDat.m_flow_small,
    each final dynFil=dynFil,
    each final mSenFac=mSenFac,
    each final allowFlowReversal1=allowFlowReversal,
    each final allowFlowReversal2=allowFlowReversal,
    each final allowFlowReversal3=allowFlowReversal,
    each final allowFlowReversal4=allowFlowReversal,
    each final from_dp1=from_dp,
    each final linearizeFlowResistance1=linearizeFlowResistance,
    each final deltaM1=deltaM,
    each final from_dp2=from_dp,
    each final linearizeFlowResistance2=linearizeFlowResistance,
    each final deltaM2=deltaM,
    each final from_dp3=from_dp,
    each final linearizeFlowResistance3=linearizeFlowResistance,
    each final deltaM3=deltaM,
    each final from_dp4=from_dp,
    each final linearizeFlowResistance4=linearizeFlowResistance,
    each final deltaM4=deltaM,
    each final p1_start=p_start,
    each final p2_start=p_start,
    each final p3_start=p_start,
    each final p4_start=p_start) "Discretized borehole segments"
    annotation (Placement(transformation(extent={{-10,-30},{10,10}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_wall[size(
    intHex2UTub, 1)] "Borehole wall temperatures"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
    parameter Boolean dynFil=true
      "Set to false to remove the dynamics of the filling material"
      annotation (Dialog(tab="Dynamics"));
  parameter Data.BorefieldData.Template borFieDat "Borefield parameters"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.SIunits.Temperature TWallAve "Average borehole wall temperature";
equation
  TWallAve =sum(intHex2UTub[:].port_wall.T)/borFieDat.conDat.nVer;

  // Couple borehole port_a and port_b to first borehole segment.
  connect(port_a, intHex2UTub[1].port_a1) annotation (Line(
      points={{-100,5.55112e-016},{-52,5.55112e-016},{-52,6.36364},{-10,6.36364}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(port_b, intHex2UTub[1].port_b4) annotation (Line(
      points={{100,5.55112e-016},{28,5.55112e-016},{28,-40},{-32,-40},{-32,
          -23.6364},{-10,-23.6364}},
      color={0,127,255},
      smooth=Smooth.None));
  if borFieDat.conDat.parallel2UTube then
    connect(port_a, intHex2UTub[1].port_a3) annotation (Line(
        points={{-100,5.55112e-016},{-52,5.55112e-016},{-52,-14},{-10,-14}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(port_b, intHex2UTub[1].port_b2) annotation (Line(
        points={{100,5.55112e-016},{28,5.55112e-016},{28,-40},{-32,-40},{-32,
            -2.72727},{-10,-2.72727}},
        color={0,127,255},
        smooth=Smooth.None));
  else
    // U-tube in serie: couple both U-tube to each other.
    connect(intHex2UTub[1].port_b2, intHex2UTub[1].port_a3) annotation (Line(
        points={{-10,-2.72727},{-24,-2.72727},{-24,-16},{-18,-16},{-18,-14},{
            -10,-14}},
        color={0,127,255},
        smooth=Smooth.None));
  end if;

  // Couple each layer to the next one
  for i in 1:borFieDat.conDat.nVer - 1 loop
    connect(intHex2UTub[i].port_b1, intHex2UTub[i + 1].port_a1) annotation (
        Line(
        points={{10,6.36364},{10,10},{-10,10},{-10,6.36364}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(intHex2UTub[i].port_a2, intHex2UTub[i + 1].port_b2) annotation (
        Line(
        points={{10,-2.72727},{10,0},{-10,0},{-10,-2.72727}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(intHex2UTub[i].port_b3, intHex2UTub[i + 1].port_a3) annotation (
        Line(
        points={{10,-13.8182},{10,-12},{-10,-12},{-10,-14}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(intHex2UTub[i].port_a4, intHex2UTub[i + 1].port_b4) annotation (
        Line(
        points={{10,-22.7273},{10,-22},{-10,-22},{-10,-23.6364}},
        color={0,127,255},
        smooth=Smooth.None));
  end for;

  // Close U-tube at bottom layer
  connect(intHex2UTub[borFieDat.conDat.nVer].port_b1, intHex2UTub[borFieDat.conDat.nVer].port_a2)
    annotation (Line(
      points={{10,6},{16,6},{16,-4},{10,-4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(intHex2UTub[borFieDat.conDat.nVer].port_b3, intHex2UTub[borFieDat.conDat.nVer].port_a4)
    annotation (Line(
      points={{10,-16.2},{14,-16.2},{14,-16},{18,-16},{18,-26},{10,-26}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(intHex2UTub.port_wall, port_wall)
    annotation (Line(points={{0,10},{0,10},{0,100}}, color={191,0,0}));
  annotation (
    Dialog(group="Borehole"),
    Dialog(group="Borehole"),
    defaultComponentName="borehole",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0.5), graphics={
        Rectangle(
          extent={{-68,76},{72,-84}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,-56},{64,-64}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,54},{64,50}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,2},{64,-4}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{58,88},{50,-92}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-52,-92},{-44,88}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-70,76},{-60,-84}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{64,76},{74,-84}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-50,-84},{56,-92}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{22,88},{14,-92}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,88},{-18,-92}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0.5), graphics={Text(
          extent={{60,72},{84,58}},
          lineColor={0,0,255},
          textString=""), Text(
          extent={{50,-32},{90,-38}},
          lineColor={0,0,255},
          textString="")}),
    Documentation(info="<html>
<p>
Model of a single U-tube borehole heat exchanger. 
The borehole heat exchanger is vertically discretized into <i>n<sub>seg</sub></i>
elements of height <i>h=h<sub>Bor</sub>&frasl;n<sub>seg</sub></i>.
each final segment contains a model for the heat transfer in the borehole, 
for heat transfer in the soil and for the far-field boundary condition.
</p>
<p>
The heat transfer in the borehole is computed using a convective heat transfer coefficient
that depends on the fluid velocity, a heat resistance between the two pipes, and
a heat resistance between the pipes and the circumference of the borehole.
The heat capacity of the fluid, and the heat capacity of the grout, is taken into account.
All thermal mass is assumed to be at the two bulk temperatures of the down-flowing 
and up-flowing fluid.
</p>
<p>
The heat transfer in the soil is computed using transient heat conduction in cylindrical
coordinates for the spatial domain <i>r<sub>bor</sub> &le; r &le; r<sub>ext</sub></i>. 
In the radial direction, the spatial domain is discretized into 
<i>n<sub>hor</sub></i> segments with uniform material properties.
Thermal properties can be specified separately for each final horizontal layer.
The vertical heat flow is assumed to be zero, and there is assumed to be 
no ground water flow. 
</p>
<p>
The far-field temperature, i.e., the temperature at the radius 
<i>r<sub>ext</sub></i>, is kept constant because this model is only use to compute the short-term
temperature response of the borehole.
</p>

<h4>Implementation</h4>
<p>
each final horizontal layer is modeled using an instance of
<a href=\"modelica://IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.BoreHoles.BaseClasses.BoreHoleSegmentFourPort\">
IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.BoreHoles.BaseClasses.BoreHoleSegmentFourPort</a>.
This model is composed of the model
<a href=\"modelica://IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.BoreHoles.BaseClasses.SingleUTubeInternalHEX\">
IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.BoreHoles.BaseClasses.SingleUTubeInternalHEX</a> which computes
the heat transfer in the pipes and the borehole filling, and
of the model
<a href=\"modelica://IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.BoreHoles.BaseClasses.CylindricalGroundLayer\">
IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.BoreHoles.BaseClasses.CylindricalGroundLayer</a> which computes
the heat transfer in the soil.
</p>
</html>", revisions="<html>
<ul>
<li>
July 2014, by Damien Picard:<br>
First implementation.
</li>
</ul>
</html>"));
end SingleBoreHole2UTube;
