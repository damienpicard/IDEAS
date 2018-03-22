within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield2.BaseClasses.BoreHoles.BaseClasses;
model InternalHEXUTube "Internal part of a borehole for a U-Tube configuration"
  extends IDEAS.Fluid.Interfaces.FourPortHeatMassExchanger(
    redeclare final package Medium1 = Medium,
    redeclare final package Medium2 = Medium,
    T1_start=T_start,
    T2_start=T_start,
    final tau1=Modelica.Constants.pi*gen.rTub^2*gen.hSeg*rho1_nominal/
        m1_flow_nominal,
    final tau2=Modelica.Constants.pi*gen.rTub^2*gen.hSeg*rho2_nominal/
        m2_flow_nominal,
    final show_T=true,
    vol1(
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics,
      final prescribedHeatFlowRate=false,
      final m_flow_small=m1_flow_small,
      V=gen.volOneLegSeg,
      mSenFac=mSenFac),
    redeclare IDEAS.Fluid.MixingVolumes.MixingVolume vol2(
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics,
      final prescribedHeatFlowRate=false,
      final m_flow_small=m2_flow_small,
      V=gen.volOneLegSeg,
      mSenFac=mSenFac));

  parameter Modelica.SIunits.Temperature T_start
    "Initial temperature of the filling material"
    annotation (Dialog(group="Filling material"));
  parameter Data.BorefieldData.Template borFieDat
    annotation (Placement(transformation(extent={{-100,-120},{-80,-100}})));
protected
  parameter Modelica.SIunits.HeatCapacity Co_fil=fil.d*fil.c*gen.hSeg*Modelica.Constants.pi
      *(gen.rBor^2 - 2*(gen.rTub + gen.eTub)^2)
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

  parameter Real Rgb_val(fixed=false);
  parameter Real Rgg_val(fixed=false);
  parameter Real RCondGro_val(fixed=false);
  parameter Real x(fixed=false);

public
  Modelica.Blocks.Sources.RealExpression RVol1(y=
    convectionResistance(
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
    annotation (Placement(transformation(extent={{-100,-2},{-80,18}})));
  Modelica.Blocks.Sources.RealExpression RVol2(y=
    convectionResistance(hSeg=gen.hSeg,
    rBor=gen.rBor,
    rTub=gen.rTub,
    eTub=gen.eTub,
    kMed=kMed,
    mueMed=mueMed,
    cpMed=cpMed,
    m_flow=m2_flow,
    m_flow_nominal=m2_flow_nominal))
    "Convective and thermal resistance at fluid 2"
     annotation (Placement(transformation(extent={{-100,-18},{-80,2}})));

  InternalResistancesUTube internalResistancesUTube
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
initial equation
  (x, Rgb_val, Rgg_val, RCondGro_val) =
    singleUTubeResistances(hSeg=gen.hSeg,
    rBor=gen.rBor,
    rTub=gen.rTub,
    eTub=gen.eTub,
    sha=gen.xC,
    kFil=fil.k,
    kSoi=soi.k,
    kTub=gen.kTub,
    use_Rb=gen.use_Rb,
    Rb = gen.Rb,
    kMed=kMed,
    mueMed=mueMed,
    cpMed=cpMed,
    m_flow_nominal=m1_flow_nominal,
    printDebug=false);

equation
    assert(gen.singleUTube,
  "This model should be used for single U-type borefield, not double U-type. 
  Check that the record General has been correctly parametrized");
  if dynFil then
  end if;

    annotation (Dialog(tab="Dynamics"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,
            100}}), graphics={Rectangle(
          extent={{88,54},{-88,64}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{88,-66},{-88,-56}},
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
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics));
end InternalHEXUTube;
