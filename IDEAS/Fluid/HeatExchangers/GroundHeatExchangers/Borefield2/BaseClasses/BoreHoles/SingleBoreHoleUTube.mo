within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield2.BaseClasses.BoreHoles;
model SingleBoreHoleUTube "Single U-tube borehole heat exchanger"
  extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface;

  extends IDEAS.Fluid.Interfaces.TwoPortFlowResistanceParameters(
      computeFlowResistance=false, linearizeFlowResistance=false);
  extends IDEAS.Fluid.Interfaces.LumpedVolumeDeclarations;

  BaseClasses.InternalHEXUTube borHolSeg[borFieDat.conDat.nVer](
    redeclare each final package Medium =   Medium,
    each final    computeFlowResistance1=computeFlowResistance,
    each final    computeFlowResistance2=computeFlowResistance,
    each final    from_dp1=from_dp,
    each final    from_dp2=from_dp,
    each final    linearizeFlowResistance1=linearizeFlowResistance,
    each final    linearizeFlowResistance2=linearizeFlowResistance,
    each final    deltaM1=deltaM,
    each final    deltaM2=deltaM,
    each final    energyDynamics=energyDynamics,
    each final    massDynamics=massDynamics,
    each final p_start=p_start,
    each final T_start=T_start,
    each final X_start=X_start,
    each final C_nominal=C_nominal,
    each final dynFil=dynFil,
    each final mSenFac=mSenFac,
    each final use_TWall=use_TWall,
    final dp1_nominal={if i == 1 then dp_nominal else 0 for i in 1:borFieDat.conDat.nVer},
    each final dp2_nominal=0,
    each final m1_flow_nominal=m_flow_nominal,
    each final m2_flow_nominal=m_flow_nominal,
    each borFieDat=borFieDat)                  "Discretized borehole segments"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  parameter Data.BorefieldData.Template borFieDat "Borefield parameters"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.SIunits.Temperature TWallAve "Average borehole wall temperature";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_wall[borFieDat.conDat.nVer]
    "Thermal connection for borehole wall"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
equation
  TWallAve = sum(borHolSeg[:].intHEX.port_wall.T)/borFieDat.conDat.nVer;

  connect(port_a, borHolSeg[1].port_a1) annotation (Line(
      points={{-100,5.55112e-16},{-52,5.55112e-16},{-52,6.36364},{-10,6.36364}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_b, borHolSeg[1].port_b2) annotation (Line(
      points={{100,5.55112e-16},{28,5.55112e-16},{28,-40},{-32,-40},{-32,
          -4.54545},{-10,-4.54545}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(borHolSeg[borFieDat.conDat.nVer].port_b1, borHolSeg[borFieDat.conDat.nVer].port_a2) annotation (
     Line(
      points={{10,6},{20,6},{20,-6},{10,-6}},
      color={0,127,255},
      smooth=Smooth.None));
  for i in 1:borFieDat.conDat.nVer - 1 loop
    connect(borHolSeg[i].port_b1, borHolSeg[i + 1].port_a1) annotation (Line(
        points={{10,6.36364},{10,20},{-10,20},{-10,6.36364}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(borHolSeg[i].port_a2, borHolSeg[i + 1].port_b2) annotation (Line(
        points={{10,-4.54545},{10,-20},{-10,-20},{-10,-4.54545}},
        color={0,127,255},
        smooth=Smooth.None));
  end for;
  connect(borHolSeg.port_wall, port_wall)
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
          extent={{56,88},{48,-92}},
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
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0.5), graphics={Text(
          extent={{60,72},{84,58}},
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
end SingleBoreHoleUTube;
