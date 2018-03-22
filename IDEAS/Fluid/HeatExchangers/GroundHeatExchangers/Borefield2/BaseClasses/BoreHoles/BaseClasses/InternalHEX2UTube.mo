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
    final tau1=Modelica.Constants.pi*gen.rTub^2*gen.hSeg*rho1_nominal/
        m1_flow_nominal,
    final tau2=Modelica.Constants.pi*gen.rTub^2*gen.hSeg*rho2_nominal/
        m2_flow_nominal,
    final tau3=Modelica.Constants.pi*gen.rTub^2*gen.hSeg*rho3_nominal/
        m3_flow_nominal,
    final tau4=Modelica.Constants.pi*gen.rTub^2*gen.hSeg*rho4_nominal/
        m4_flow_nominal,
    final show_T=true,
    vol1(
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics,
      final prescribedHeatFlowRate=false,
      final allowFlowReversal=allowFlowReversal1,
      final m_flow_small=m1_flow_small,
      final V=gen.volOneLegSeg,
      mSenFac=mSenFac),
    vol2(
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics,
      final prescribedHeatFlowRate=false,
      final m_flow_small=m2_flow_small,
      final V=gen.volOneLegSeg,
      mSenFac=mSenFac),
    vol3(
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics,
      final prescribedHeatFlowRate=false,
      final allowFlowReversal=allowFlowReversal3,
      final m_flow_small=m3_flow_small,
      final V=gen.volOneLegSeg,
      mSenFac=mSenFac),
    vol4(
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics,
      final prescribedHeatFlowRate=false,
      final m_flow_small=m4_flow_small,
      final V=gen.volOneLegSeg,
      mSenFac=mSenFac));

  Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor RConv1
    "Pipe convective resistance" annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-18,64})));

protected
  parameter Modelica.SIunits.HeatCapacity Co_fil=fil.d*fil.c*gen.hSeg*Modelica.Constants.pi
      *(gen.rBor^2 - 4*(gen.rTub + gen.eTub)^2)
    "Heat capacity of the whole filling material";

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

public
  Modelica.Blocks.Sources.RealExpression RVol1(y=convectionResistance(
        hSeg=gen.hSeg,
        rBor=gen.rBor,
        rTub=gen.rTub,
        eTub=gen.eTub,
        kMed=kMed,
        mueMed=mueMed,
        cpMed=cpMed,
        m_flow=m1_flow,
        m_flow_nominal=m1_flow_nominal))
    "Convective and thermal resistance at fluid 1"
    annotation (Placement(transformation(extent={{-56,56},{-42,72}})));
  Modelica.Blocks.Sources.RealExpression RVol2(y=convectionResistance(
        hSeg=gen.hSeg,
        rBor=gen.rBor,
        rTub=gen.rTub,
        eTub=gen.eTub,
        kMed=kMed,
        mueMed=mueMed,
        cpMed=cpMed,
        m_flow=m2_flow,
        m_flow_nominal=m2_flow_nominal))
    "Convective and thermal resistance at fluid 2"
    annotation (Placement(transformation(extent={{88,18},{72,0}})));
  Modelica.Blocks.Sources.RealExpression RVol3(y=convectionResistance(
        hSeg=gen.hSeg,
        rBor=gen.rBor,
        rTub=gen.rTub,
        eTub=gen.eTub,
        kMed=kMed,
        mueMed=mueMed,
        cpMed=cpMed,
        m_flow=m3_flow,
        m_flow_nominal=m3_flow_nominal))
    "Convective and thermal resistance at fluid 1"
    annotation (Placement(transformation(extent={{-12,-60},{-26,-76}})));

  Modelica.Blocks.Sources.RealExpression RVol4(y=convectionResistance(
        hSeg=gen.hSeg,
        rBor=gen.rBor,
        rTub=gen.rTub,
        eTub=gen.eTub,
        kMed=kMed,
        mueMed=mueMed,
        cpMed=cpMed,
        m_flow=m1_flow,
        m_flow_nominal=m4_flow_nominal))
    "Convective and thermal resistance at fluid 1"
    annotation (Placement(transformation(extent={{-68,12},{-54,28}})));

  parameter Real mSenFac=1
    "Factor for scaling the sensible thermal mass of the volume"
    annotation (Dialog(tab="Dynamics"));
  InternalResistances2UTube internalResistances2UTube
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  parameter Data.BorefieldData.Template borFieDat
    annotation (Placement(transformation(extent={{-100,-120},{-80,-100}})));
initial equation
  (x,Rgb_val,Rgg1_val,Rgg2_val,RCondGro_val) = doubleUTubeResistances(
    hSeg=gen.hSeg,
    rBor=gen.rBor,
    rTub=gen.rTub,
    eTub=gen.eTub,
    sha=gen.xC,
    kFil=fil.k,
    kSoi=soi.k,
    kTub=gen.kTub,
    use_Rb=gen.use_Rb,
    Rb=gen.Rb,
    kMed=kMed,
    mueMed=mueMed,
    cpMed=cpMed,
    m_flow_nominal=m1_flow_nominal,
    printDebug=false);

equation
  assert(not gen.singleUTube,
  "This model should be used for double U-type borefield, not single U-type. 
  Check that the record General has been correctly parametrized");
  connect(RVol1.y, RConv1.Rc) annotation (Line(
      points={{-41.3,64},{-24,64}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(RConv1.fluid, vol1.heatPort) annotation (Line(
      points={{-18,70},{-10,70}},
      color={191,0,0},
      smooth=Smooth.None));

 if dynFil then
 else
 end if;

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,
            100}}), graphics={Text(
          extent={{-114,74},{-84,68}},
          lineColor={0,0,0},
          textString="Loop 1"), Text(
          extent={{-160,-36},{-130,-42}},
          lineColor={0,0,0},
          textString="Loop 1")}),
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
