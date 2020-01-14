within IDEAS.Fluid.Actuators.Valves.Simplified.BaseClasses;
model Partial3WayValve2 "Partial for 3-way valves"
  extends IDEAS.Fluid.BaseClasses.PartialThreeWayResistance(redeclare
      IDEAS.Fluid.Movers.BaseClasses.IdealSource res3(m_flow_small=m_flow_small,
                                                      control_m_flow=true,
                                                      dp_start=0),
    redeclare FixedResistances.LosslessPipe res1(m_flow_nominal=m_flow_nominal),
    redeclare FixedResistances.LosslessPipe res2(m_flow_nominal=m_flow_nominal),
    m_flow_small = m_flow_nominal*1e-4,
    final mDyn_flow_nominal = m_flow_nominal);

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal "Nominal mass flow rate";

  parameter Real l = 0.001
    "Valve leakage, minimum fraction of flow rate passing through ports 
    a";

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    Icon(graphics={
        Polygon(
          points={{-60,30},{-60,-30},{0,0},{-60,30}},
          lineColor={0,0,127},
          smooth=Smooth.None),
        Polygon(
          points={{60,30},{60,-30},{0,0},{60,30}},
          lineColor={0,0,127},
          smooth=Smooth.None),
        Polygon(
          points={{-30,30},{-30,-30},{30,0},{-30,30}},
          lineColor={0,0,127},
          smooth=Smooth.None,
          origin={0,-30},
          rotation=90),
        Ellipse(extent={{-20,80},{20,40}}, lineColor={0,0,127}),
        Line(
          points={{0,0},{0,40}},
          color={0,0,127},
          smooth=Smooth.None),
        Text(
          extent={{-10,70},{10,50}},
          lineColor={0,0,127},
          textString="M"),
        Line(
          points={{-70,30},{-70,-30}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{70,30},{70,-30}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-30,-70},{30,-70}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-70,0},{-100,0}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{70,0},{100,0}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{0,-70},{0,-100}},
          color={0,0,127},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<p><b>Description</b> </p>
<p>3-way valve with temperature set point for mixing a cold and hot fluid to obtain outlet fluid at the desired temperature. If the desired temperature is higher than the hot fluid, no mixing will occur and the outlet will have the temperature of the hot fluid. </p>
<p>Inside the valve, the cold water flowrate is fixed with a pump component.  The fluid content in the valve is equally split between the mixing volume and this pump.  Without fluid content in the pump, this model does not work in all operating conditions.  </p>
<h4>Assumptions and limitations </h4>
<ol>
<li>Correct connections of hot and cold fluid to the corresponding flowPorts is NOT CHECKED.</li>
<li>The fluid content m of the valve has to be larger than zero</li>
<li>There is an internal parameter mFlowMin which sets a minimum mass flow rate for mixing to start. </li>
</ol>
<h4>Model use</h4>
<ol>
<li>Set medium and the internal fluid content of the valve (too small values of m could increase simulation times)</li>
<li>Set mFlowMin, the minimum mass flow rate for mixing to start. </li>
<li>Supply a set temperature at the outlet</li>
</ol>
<h4>Validation </h4>
<p>None </p>
<h4>Example (optional) </h4>
<p>Examples of this model can be found in<a href=\"modelica://IDEAS.Thermal.Components.Examples.TempMixingTester\"> IDEAS.Thermal.Components.Examples.TempMixingTester</a> and<a href=\"modelica://IDEAS.Thermal.Components.Examples.RadiatorWithMixingValve\"> IDEAS.Thermal.Components.Examples.RadiatorWithMixingValve</a></p>
</html>", revisions="<html>
<ul>
<li>
October 2, 2019 by Filip Jorissen:<br/> 
Avoiding division by zero for zero flow rates when <code>SteadyState</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1063\">#1063</a>.
</li>
<li>
May 3, 2019 by Filip Jorissen:<br/> 
Propagated <code>mSenFac</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1018\">#1018</a>.
</li>
<li>
April 23, 2019 by Filip Jorissen:<br/> 
Using separate port for each connection to avoid algebraic loops.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1019\">#1019</a>.
</li>
<li>
March 26, 2018 by Filip Jorissen:<br/> 
Implemented valve leakage,
see <a href=\"https://github.com/open-ideas/IDEAS/issues/782\">#782</a>.
</li>
<li>
March 2014 by Filip Jorissen:<br/> 
Initial implementation
</li>
</ul>
</html>
"));
end Partial3WayValve2;
