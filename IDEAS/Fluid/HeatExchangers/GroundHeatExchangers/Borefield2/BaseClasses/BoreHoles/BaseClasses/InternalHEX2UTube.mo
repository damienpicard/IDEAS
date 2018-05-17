within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield2.BaseClasses.BoreHoles.BaseClasses;
model InternalHEX2UTube
  "Internal part of a borehole for a double U-Tube configuration. In loop 1, fluid 1 streams from a1 to b1 and comes back from a3 to b3. In loop 2: fluid 2 streams from a2 to b2 and comes back from a4 to b4."
  extends IDEAS.Fluid.Interfaces.EightPortHeatMassExchanger(
    redeclare final package Medium1 = Medium,
    redeclare final package Medium2 = Medium,
    redeclare final package Medium3 = Medium,
    redeclare final package Medium4 = Medium,
    T1_start=T_start,
    T2_start=T_start,
    T3_start=T_start,
    T4_start=T_start,
    final tau1=Modelica.Constants.pi*borFieDat.conDat.rTub^2*borFieDat.conDat.hSeg*rho1_nominal/
        m1_flow_nominal,
    final tau2=Modelica.Constants.pi*borFieDat.conDat.rTub^2*borFieDat.conDat.hSeg*rho2_nominal/
        m2_flow_nominal,
    final tau3=Modelica.Constants.pi*borFieDat.conDat.rTub^2*borFieDat.conDat.hSeg*rho3_nominal/
        m3_flow_nominal,
    final tau4=Modelica.Constants.pi*borFieDat.conDat.rTub^2*borFieDat.conDat.hSeg*rho4_nominal/
        m4_flow_nominal,
    final show_T=true,
    vol1(
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics,
      final prescribedHeatFlowRate=false,
      final allowFlowReversal=allowFlowReversal1,
      final m_flow_small=m1_flow_small,
      final V=borFieDat.conDat.volOneLegSeg,
      mSenFac=mSenFac),
    vol2(
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics,
      final prescribedHeatFlowRate=false,
      final m_flow_small=m2_flow_small,
      final V=borFieDat.conDat.volOneLegSeg,
      mSenFac=mSenFac),
    vol3(
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics,
      final prescribedHeatFlowRate=false,
      final allowFlowReversal=allowFlowReversal3,
      final m_flow_small=m3_flow_small,
      final V=borFieDat.conDat.volOneLegSeg,
      mSenFac=mSenFac),
    vol4(
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics,
      final prescribedHeatFlowRate=false,
      final m_flow_small=m4_flow_small,
      final V=borFieDat.conDat.volOneLegSeg,
      mSenFac=mSenFac));

  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium"
      annotation (choicesAllMatching = true);
  Modelica.Blocks.Sources.RealExpression RVol1(y=convectionResistance(
        hSeg=borFieDat.conDat.hSeg,
        rBor=borFieDat.conDat.rBor,
        rTub=borFieDat.conDat.rTub,
        eTub=borFieDat.conDat.eTub,
        kMed=kMed,
        mueMed=mueMed,
        cpMed=cpMed,
        m_flow=m1_flow,
        m_flow_nominal=m1_flow_nominal))
    "Convective and thermal resistance at fluid 1"
    annotation (Placement(transformation(extent={{-16,56},{-30,72}})));
  Modelica.Blocks.Sources.RealExpression RVol2(y=convectionResistance(
        hSeg=borFieDat.conDat.hSeg,
        rBor=borFieDat.conDat.rBor,
        rTub=borFieDat.conDat.rTub,
        eTub=borFieDat.conDat.eTub,
        kMed=kMed,
        mueMed=mueMed,
        cpMed=cpMed,
        m_flow=m2_flow,
        m_flow_nominal=m2_flow_nominal))
    "Convective and thermal resistance at fluid 2"
    annotation (Placement(transformation(extent={{88,-8},{72,-26}})));
  Modelica.Blocks.Sources.RealExpression RVol3(y=convectionResistance(
        hSeg=borFieDat.conDat.hSeg,
        rBor=borFieDat.conDat.rBor,
        rTub=borFieDat.conDat.rTub,
        eTub=borFieDat.conDat.eTub,
        kMed=kMed,
        mueMed=mueMed,
        cpMed=cpMed,
        m_flow=m3_flow,
        m_flow_nominal=m3_flow_nominal))
    "Convective and thermal resistance at fluid 1"
    annotation (Placement(transformation(extent={{-12,-60},{-26,-76}})));

  Modelica.Blocks.Sources.RealExpression RVol4(y=convectionResistance(
        hSeg=borFieDat.conDat.hSeg,
        rBor=borFieDat.conDat.rBor,
        rTub=borFieDat.conDat.rTub,
        eTub=borFieDat.conDat.eTub,
        kMed=kMed,
        mueMed=mueMed,
        cpMed=cpMed,
        m_flow=m1_flow,
        m_flow_nominal=m4_flow_nominal))
    "Convective and thermal resistance at fluid 1"
    annotation (Placement(transformation(extent={{-68,12},{-54,28}})));
  parameter Modelica.SIunits.Temperature T_start
    "Initial temperature of the filling material and fluid"
    annotation (Dialog(group="Filling material"));
  parameter Real mSenFac=1
    "Factor for scaling the sensible thermal mass of the volume"
    annotation (Dialog(tab="Dynamics"));
   parameter Boolean dynFil=true
      "Set to false to remove the dynamics of the filling material"
      annotation (Dialog(tab="Dynamics"));
  InternalResistances2UTube intRes2UTub(
    T_start=T_start,
    borFieDat=borFieDat,
    Rgb_val=Rgb_val,
    Rgg1_val=Rgg1_val,
    Rgg2_val=Rgg2_val,
    RCondGro_val=RCondGro_val,
    x=x) "Internal resistances for a double U-tube configuration"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  parameter Data.BorefieldData.Template borFieDat
    annotation (Placement(transformation(extent={{-100,-120},{-80,-100}})));
 Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor RConv1
    "Pipe convective resistance" annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={0,46})));

  Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor RConv2
    "Pipe convective resistance" annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=180,
        origin={34,0})));
  Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor RConv3
    "Pipe convective resistance" annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=90,
        origin={0,-32})));
  Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor RConv4
    "Pipe convective resistance" annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={-34,0})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_wall
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));

protected
  parameter Modelica.SIunits.SpecificHeatCapacity cpMed=
      Medium.specificHeatCapacityCp(Medium.setState_pTX(
      Medium.p_default,
      Medium.T_default,
      Medium.X_default)) "Specific heat capacity of the fluid";
  parameter Modelica.SIunits.ThermalConductivity kMed=
      Medium.thermalConductivity(Medium.setState_pTX(
      Medium.p_default,
      Medium.T_default,
      Medium.X_default)) "Thermal conductivity of the fluid";
  parameter Modelica.SIunits.DynamicViscosity mueMed=Medium.dynamicViscosity(
      Medium.setState_pTX(
      Medium.p_default,
      Medium.T_default,
      Medium.X_default)) "Dynamic viscosity of the fluid";

  parameter Real x(fixed=false);
  parameter Real Rgb_val(fixed=false);
  parameter Real Rgg1_val(fixed=false);
  parameter Real Rgg2_val(fixed=false);
  parameter Real RCondGro_val(fixed=false);

initial equation
  (x,Rgb_val,Rgg1_val,Rgg2_val,RCondGro_val) = doubleUTubeResistances(
    hSeg=borFieDat.conDat.hSeg,
    rBor=borFieDat.conDat.rBor,
    rTub=borFieDat.conDat.rTub,
    eTub=borFieDat.conDat.eTub,
    sha=borFieDat.conDat.xC,
    kFil=borFieDat.filDat.k,
    kSoi=borFieDat.soiDat.k,
    kTub=borFieDat.conDat.kTub,
    use_Rb=borFieDat.conDat.use_Rb,
    Rb=borFieDat.conDat.Rb,
    kMed=kMed,
    mueMed=mueMed,
    cpMed=cpMed,
    m_flow_nominal=m1_flow_nominal,
    printDebug=false);

equation
  assert(not borFieDat.conDat.singleUTube,
  "This model should be used for double U-type borefield, not single U-type. 
  Check that the record General has been correctly parametrized");
  connect(RVol1.y, RConv1.Rc) annotation (Line(
      points={{-30.7,64},{-34,64},{-34,46},{-8,46}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(RConv1.fluid, vol1.heatPort) annotation (Line(
      points={{4.44089e-016,54},{-14,54},{-14,70},{-10,70}},
      color={191,0,0},
      smooth=Smooth.None));

 if dynFil then
 else
 end if;

  connect(RConv1.solid, intRes2UTub.port_1)
    annotation (Line(points={{0,38},{0,24},{0,10}}, color={191,0,0}));
  connect(RConv2.fluid, vol2.heatPort)
    annotation (Line(points={{42,0},{46,0},{50,0}}, color={191,0,0}));
  connect(RConv2.solid, intRes2UTub.port_2)
    annotation (Line(points={{26,0},{18,0},{10,0}}, color={191,0,0}));
  connect(RConv3.fluid, vol3.heatPort) annotation (Line(points={{0,-40},{-14,-40},
          {-14,-60},{-10,-60}}, color={191,0,0}));
  connect(RConv3.solid, intRes2UTub.port_3)
    annotation (Line(points={{0,-24},{0,-10}}, color={191,0,0}));
  connect(RConv4.fluid, vol4.heatPort)
    annotation (Line(points={{-42,0},{-46,0},{-50,0}}, color={191,0,0}));
  connect(RConv4.solid, intRes2UTub.port_4)
    annotation (Line(points={{-26,0},{-18,0},{-10,0}}, color={191,0,0}));
  connect(RVol4.y, RConv4.Rc)
    annotation (Line(points={{-53.3,20},{-34,20},{-34,8}}, color={0,0,127}));
  connect(RVol3.y, RConv3.Rc) annotation (Line(points={{-26.7,-68},{-30,-68},{-30,
          -32},{-8,-32}}, color={0,0,127}));
  connect(RVol2.y, RConv2.Rc)
    annotation (Line(points={{71.2,-17},{34,-17},{34,-8}}, color={0,0,127}));
  connect(intRes2UTub.port_wall, port_wall) annotation (Line(points={{0,0},{6,0},
          {6,20},{20,20},{20,100},{0,100}}, color={191,0,0}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,100}}),
        graphics={
        Rectangle(
          extent={{98,74},{-94,86}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{96,24},{-96,36}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{100,-38},{-92,-26}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{94,-88},{-98,-76}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
Model for the heat transfer between the fluid and within the borehole filling. 
This model computes the dynamic response of the fluid in the tubes, 
the heat transfer between the fluid and the borehole filling, 
and the heat storage within the fluid and the borehole filling.
</p>
<p>
This model computes the different thermal resistances present 
in a single-U-tube borehole using the method of Bauer et al. (2011) 
and computing explicitely the fluid-to-ground thermal resistance 
<i>R<sub>b</sub></i> and the 
grout-to-grout resistance
<i>R<sub>a</sub></i> as defined by Hellstroem (1991)
using the multipole method.
The multipole method is implemented in
<a href=\"modelica://IDEAS.Fluid.HeatExchangers.Boreholes.BaseClasses.singleUTubeResistances\">
IDEAS.Fluid.HeatExchangers.Boreholes.BaseClasses.singleUTubeResistances</a>. 
The convection resistance is calculated using the 
Dittus-Boelter correlation
as implemented in
<a href=\"modelica://IDEAS.Fluid.HeatExchangers.Boreholes.BaseClasses.convectionResistance\">
IDEAS.Fluid.HeatExchangers.Boreholes.BaseClasses.convectionResistance</a>. 
</p>
<p>
The figure below shows the thermal network set up by Bauer et al. (2010).
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://IDEAS/Resources/Images/Fluid/HeatExchangers/Boreholes/BaseClasses/Bauer_singleUTube.png\"/>
</p>
<h4>References</h4>
<p>
G. Hellstr&ouml;m. 
<i>Ground heat storage: thermal analyses of duct storage systems (Theory)</i>. 
Dept. of Mathematical Physics, University of Lund, Sweden, 1991.
</p>
<p>
D. Bauer, W. Heidemann, H. M&uuml;ller-Steinhagen, and H.-J. G. Diersch.
<i>
<a href=\"http://dx.doi.org/10.1002/er.1689\">
Thermal resistance and capacity models for borehole heat exchangers
</a>
</i>.
International Journal Of Energy Research, 35:312&ndash;320, 2011.
</p>
</html>", revisions="<html>
<p>
<ul>
<li>
June 18, 2014, by Michael Wetter:<br/>
Added initialization for temperatures and derivatives of <code>capFil1</code>
and <code>capFil2</code> to avoid a warning during translation.
</li>
<li>
February 14, 2014, by Michael Wetter:<br/>
Removed unused parameters <code>B0</code> and <code>B1</code>.
</li>
<li>
January 24, 2014, by Michael Wetter:<br/>
Revised implementation, added comments, replaced 
<code>HeatTransfer.Windows.BaseClasses.ThermalConductor</code>
with resistance models from the Modelica Standard Library.
</li>
<li>
January 23, 2014, by Damien Picard:<br/>
First implementation.
</li>
</ul>
</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end InternalHEX2UTube;
