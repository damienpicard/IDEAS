within IDEAS.Fluid.Actuators.Valves.Simplified.BaseClasses;
model Partial3WayValve2 "Partial for 3-way valves"
  model IdealSource2
    "Base class for pressure and mass flow source with optional power input"
    extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface(show_T=false);
    // Quantity to control
    parameter Boolean control_m_flow
      "if true, then the mass flow rate is equal to the value of m_flow_in"
      annotation (Evaluate=true);
    parameter Boolean control_dp=not control_m_flow
      "if true, then the head is equal to the value of dp_in"
      annotation (Evaluate=true);

    Modelica.Blocks.Interfaces.RealInput m_flow_in(unit="kg/s") if
                                                                 control_m_flow
      "Prescribed mass flow rate" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={-50,82}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={-60,80})));
    Modelica.Blocks.Interfaces.RealInput dp_in(unit="Pa") if
                                                           control_dp
      "Prescribed pressure difference port_a.p-port_b.p" annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={50,82}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={60,80})));

  protected
    Modelica.Blocks.Interfaces.RealInput m_flow_internal(unit="kg/s")
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput dp_internal(unit="Pa")
      "Needed to connect to conditional connector";

  equation
    // Mass balance (no storage)
    port_a.m_flow + port_b.m_flow = 0;

    // Transport of substances
    port_a.Xi_outflow = if allowFlowReversal then inStream(port_b.Xi_outflow)
       else Medium.X_default[1:Medium.nXi];
    port_b.Xi_outflow = inStream(port_a.Xi_outflow);

    port_a.C_outflow = if allowFlowReversal then inStream(port_b.C_outflow)
       else zeros(Medium.nC);
    port_b.C_outflow = inStream(port_a.C_outflow);

    // Ideal control
    if control_m_flow then
      m_flow = m_flow_internal;
    else
      m_flow_internal = 0;
    end if;
    if control_dp then
      dp = dp_internal;
    else
      dp_internal = 0;
    end if;

    connect(dp_internal, dp_in);
    connect(m_flow_internal, m_flow_in);

    // Energy balance (no storage)
    port_a.h_outflow = if allowFlowReversal then inStream(port_b.h_outflow)
       else Medium.h_default;
    port_b.h_outflow = inStream(port_a.h_outflow);

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Rectangle(
            extent={{-100,60},{100,-60}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Rectangle(
            extent={{-100,50},{100,-48}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,127,255}),
          Text(
            visible=not control_m_flow,
            extent={{24,44},{80,24}},
            lineColor={255,255,255},
            textString="dp"),
          Text(
            visible=control_m_flow,
            extent={{-80,44},{-24,24}},
            lineColor={255,255,255},
            textString="m")}), Documentation(info="<html>
<p>
Model of a fictitious pipe that is used as a base class
for a pressure source or to prescribe a mass flow rate.
</p>
<p>
Note that for fans and pumps with dynamic balance,
both the heat and the flow work are added to the volume of
air or water. This simplifies the equations compared to
adding heat to the volume, and flow work to this model.
</p>
<p>
Typically either <code>control_m_flow</code> or
<code>control_dp</code> should be <code>true</code> to avoid a
singular system.
If <code>control_m_flow = true</code>, then the mass flow rate
is set to the value of the input connector <code>m_flow_in</code>.
Otherwise, this model does not specify the mass flow rate.
Similarly, if <code>control_dp = true</code>, the head is equal to the
value of the input connector <code>dp_in</code>.
Otherwise, this model does not specify the head.
</p>
</html>", revisions="<html>
<ul>
<li>
May 4, 2017, by Filip Jorissen:<br/>
Implemented option to set <code>control_dp</code>
independently from <code>control_m_flow</code>.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/770\">#770</a>.
</li>
<li>
March 2, 2017, by Filip Jorissen:<br/>
Implemented simplification when <code>allowFlowReversal=false</code>.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/673\">#673</a>.
</li>
<li>
March 20, 2016, by Michael Wetter:<br/>
Corrected documentation for <code>dp_in</code>.
</li>
<li>
January 22, 2016, by Michael Wetter:<br/>
Added units to the signal connectors.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/404\">#404</a>.
</li>
<li>
October 8, 2013, by Michael Wetter:<br/>
Removed parameter <code>show_V_flow</code>.
</li>
<li>
May 25, 2011 by Michael Wetter:<br/>
Removed the option to add power to the medium, as this is dealt with in the volume
that is used in the mover model.
</li>
<li>
July 27, 2010 by Michael Wetter:<br/>
Redesigned model to fix bug in medium balance.
</li>
<li>
April 13, 2010 by Michael Wetter:<br/>
Made heat connector optional.
</li>
<li>
March 23, 2010 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
  end IdealSource2;

  extends IDEAS.Fluid.BaseClasses.PartialThreeWayResistance(
    redeclare IdealSource2 res3(
      m_flow_small=m_flow_small,
      m_flow_nominal=m_flow_nominal,
      control_m_flow=true),
    redeclare FixedResistances.LosslessPipe res1(m_flow_nominal=m_flow_nominal),
    redeclare FixedResistances.LosslessPipe res2(m_flow_nominal=m_flow_nominal),
    m_flow_small=m_flow_nominal*1e-4,
    final mDyn_flow_nominal=m_flow_nominal);

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal mass flow rate";

  parameter Real l=0.001 "Valve leakage, minimum fraction of flow rate passing through ports 
    a";

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
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
