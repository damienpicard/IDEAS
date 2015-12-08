within IDEAS.Buildings.Components;
model Zone "thermal building zone"
  extends IDEAS.Buildings.Components.BaseClasses.partial_zone(Eexpr(y=E));

  Modelica.SIunits.Energy E = vol.dynBal.U;

protected
  BaseClasses.AirLeakage airLeakage(
    redeclare package Medium = Medium,
    m_flow_nominal=V/3600*n50/20,
    V=V,
    n50=n50,
    allowFlowReversal=allowFlowReversal,
    show_T=false)
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
  Fluid.MixingVolumes.MixingVolume         vol(
    V=V,
    m_flow_nominal=m_flow_nominal,
    nPorts=if allowFlowReversal then 4 else 2,
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    p_start=p_start,
    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    C_nominal=C_nominal,
    allowFlowReversal=allowFlowReversal,
    mSenFac=corrCV)                            annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-10,30})));

public
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTem
    annotation (Placement(transformation(extent={{0,-28},{-16,-12}})));

equation
  connect(summation.y, TSensor) annotation (Line(
      points={{12.6,-60},{59.3,-60},{59.3,0},{106,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(vol.heatPort, gainCon) annotation (Line(
      points={{0,30},{10,30},{10,-30},{100,-30}},
      color={191,0,0},
      smooth=Smooth.None));
  for i in 1:nSurf loop
       connect(propsBus[i].surfCon, vol.heatPort) annotation (Line(
        points={{-100.1,39.9},{-46,39.9},{-46,12},{10,12},{10,30},{4.44089e-16,30}},
        color={191,0,0},
        smooth=Smooth.None));
  end for;
 connect(flowPort_In, vol.ports[1]) annotation (Line(
      points={{20,100},{20,40},{-10,40}},
      color={0,128,255},
      smooth=Smooth.None));
  connect(flowPort_Out, vol.ports[2]) annotation (Line(
      points={{-20,100},{-20,40},{-10,40}},
      color={0,128,255},
      smooth=Smooth.None));

  if allowFlowReversal then
    connect(airLeakage.port_a, vol.ports[4]) annotation (Line(
        points={{40,40},{-10,40}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(airLeakage.port_b, vol.ports[3]) annotation (Line(
        points={{60,40},{70,40},{70,14},{-32,14},{-32,40},{-10,40}},
        color={0,127,255},
        smooth=Smooth.None));
  else
    connect(airLeakage.port_a, vol.ports[2]) annotation (Line(
        points={{40,40},{-10,40}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(airLeakage.port_b, vol.ports[1]) annotation (Line(
        points={{60,40},{70,40},{70,14},{-32,14},{-32,40},{-10,40}},
        color={0,127,255},
        smooth=Smooth.None));
  end if;
   annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics),
    Documentation(info="<html>
<p><h4><font color=\"#008000\">General description</font></h4></p>
<p><h5>Goal</h5></p>
<p>Also the thermal response of a zone can be divided into a convective, longwave radiative and shortwave radiative process influencing both thermal comfort in the depicted zone as well as the response of adjacent wall structures.</p>
<p><h5>Description</h5></p>
<p>The air within the zone is modeled based on the assumption that it is well-stirred, i.e. it is characterized by a single uniform air temperature. This is practically accomplished with the mixing caused by the air distribution system. The convective gains and the resulting change in air temperature T_{a} of a single thermal zone can be modeled as a thermal circuit. The resulting heat balance for the air node can be described as c_{a}.V_{a}.dT_{a}/dt = som(Q_{ia}) + sum(h_{ci}.A_{si}.(T_{a}-T_{si})) + sum(m_{az}.(h_{a}-h_{az})) + m_{ae}(h_{a}-h_{ae}) + m_{sys}(h_{a}-h_{sys}) wherefore h_{a} is the specific air enthalpy and where T_{a} is the air temperature of the zone, c_{a} is the specific heat capacity of air at constant pressure, V_{a} is the zone air volume, Q_{a} is a convective internal load, R_{si} is the convective surface resistance of surface s_{i}, A_{si} is the area of surface s_{i}, T_{si} the surface temperature of surface s_{i}, m_{az} is the mass flow rate between zones, m_{ae} is the mass flow rate between the exterior by natural infiltrationa and m_{sys} is the mass flow rate provided by the ventilation system. </p>
<p>Infiltration and ventilation systems provide air to the zones, undesirably or to meet heating or cooling loads. The thermal energy provided to the zone by this air change rate can be formulated from the difference between the supply air enthalpy and the enthalpy of the air leaving the zone <img src=\"modelica://IDEAS/Images/equations/equation-jiSQ22c0.png\" alt=\"h_a\"/>. It is assumed that the zone supply air mass flow rate is exactly equal to the sum of the air flow rates leaving the zone, and all air streams exit the zone at the zone mean air temperature. The moisture dependence of the air enthalpy is neglected.</p>
<p>A multiplier for the zone capacitance f_{ca} is included. A f_{ca} equaling unity represents just the capacitance of the air volume in the specified zone. This multiplier can be greater than unity if the zone air capacitance needs to be increased for stability of the simulation. This multiplier increases the capacitance of the air volume by increasing the zone volume and can be done for numerical reasons or to account for the additional capacitances in the zone to see the effect on the dynamics of the simulation. This multiplier is constant throughout the simulation and is set to 5.0 if the value is not defined <a href=\"IDEAS.Buildings.UsersGuide.References\">[Masy 2008]</a>.</p>
<p>The exchange of longwave radiation in a zone has been previously described in the building component models and further considering the heat balance of the interior surface. Here, an expression based on <i>radiant interchange configuration factors</i> or <i>view factors</i> is avoided based on a delta-star transformation and by definition of a <i>radiant star temperature</i> T_{rs}. Literature <a href=\"IDEAS.Buildings.UsersGuide.References\">[Liesen 1997]</a> shows that the overall model is not significantly sensitive to this assumption. ThisT_{rs} can be derived from the law of energy conservation in the radiant star node as sum(Q_{si,rs}) must equal zero. Long wave radiation from internal sources are dealt with by including them in the heat balance of the radiant star node resulting in a diffuse distribution of the radiative source.</p>
<p>Transmitted shortwave solar radiation is distributed over all surfaces in the zone in a prescribed scale. This scale is an input value which may be dependent on the shape of the zone and the location of the windows, but literature <a href=\"IDEAS.Buildings.UsersGuide.References\">[Liesen 1997]</a> shows that the overall model is not significantly sensitive to this assumption.</p>
<p><h4><font color=\"#008000\">Validation </font></h4></p>
<p>By means of the <code>BESTEST.mo</code> examples in the <code>Validation.mo</code> package.</p>
</html>", revisions="<html>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})));
end Zone;
