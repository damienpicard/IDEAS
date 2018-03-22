within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield2.BaseClasses.BoreHoles.Examples.Interfaces;
partial model partial_SingleBoreHoleStepLoad
  "SingleBoreHoleSer with step input load "
  import IDEAS;

  extends Modelica.Icons.Example;

  replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater;

  replaceable parameter
    IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Data.SoilData.WetSand_validation
    soi constrainedby
    IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Data.Records.Soil
    annotation (Placement(transformation(extent={{14,-76},{24,-66}})));
  replaceable parameter
    IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Data.FillingData.Bentonite_validation
    fil constrainedby
    IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Data.FillingData.Template
    "Thermal properties of the filling material"
    annotation (Placement(transformation(extent={{30,-76},{40,-66}})));
  replaceable parameter
    IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Data.ConfigurationData.SandBox_validation
    gen constrainedby
    IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Data.Records.General
    "General charachteristic of the borefield"
    annotation (Placement(transformation(extent={{46,-76},{56,-66}})));

  IDEAS.Fluid.Sources.Boundary_ph sin(redeclare package Medium =
        Medium, nPorts=1) "Sink"
    annotation (Placement(transformation(extent={{22,-34},{34,-22}})));

  Modelica.Blocks.Sources.Step step(height=1)
    annotation (Placement(transformation(extent={{48,-18},{36,-6}})));

  IDEAS.Fluid.HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium = Medium,
    m_flow_nominal=gen.m_flow_nominal_bh,
    dp_nominal=10000,
    show_T=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    m_flow(start=gen.m_flow_nominal_bh),
    T_start=gen.T_start,
    Q_flow_nominal=gen.q_ste*gen.hBor*gen.nbSer,
    p_start=100000)
    annotation (Placement(transformation(extent={{26,10},{6,-10}})));
  Modelica.Blocks.Sources.Constant mFlo(k=gen.m_flow_nominal_bh)
    annotation (Placement(transformation(extent={{-50,-28},{-38,-16}})));

  Movers.FlowControlled_m_flow          pum(
    redeclare package Medium = Medium,
    m_flow_nominal=gen.m_flow_nominal_bh,
    T_start=gen.T_start,
    addPowerToMedium=false,
    use_inputFilter=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    annotation (Placement(transformation(extent={{-14,10},{-34,-10}})));
  Sensors.TemperatureTwoPort             TSen_bor_in(
    redeclare package Medium = Medium,
    tau=60,
    m_flow_nominal=gen.m_flow_nominal_bh,
    T_start=gen.T_start) "Temperature at the inlet of the borefield"
    annotation (Placement(transformation(extent={{-54,-54},{-38,-38}})));
  Sensors.TemperatureTwoPort             TSen_bor_out(
    redeclare package Medium = Medium,
    tau=60,
    m_flow_nominal=gen.m_flow_nominal_bh,
    T_start=gen.T_start) "Temperature at the outlet of the borefield"
    annotation (Placement(transformation(extent={{34,-54},{50,-38}})));

equation
  connect(pum.port_a, hea.port_b) annotation (Line(
      points={{-14,0},{6,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hea.port_a, sin.ports[1]) annotation (Line(
      points={{26,0},{56,0},{56,-28},{34,-28}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(mFlo.y, pum.m_flow_in) annotation (Line(
      points={{-37.4,-22},{-24,-22},{-24,-12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, hea.u) annotation (Line(
      points={{35.4,-12},{34,-12},{34,-6},{28,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pum.port_b, TSen_bor_in.port_a) annotation (Line(
      points={{-34,0},{-58,0},{-58,-46},{-54,-46}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(hea.port_a, TSen_bor_out.port_b) annotation (Line(
      points={{26,0},{56,0},{56,-46},{50,-46}},
      color={0,127,255},
      smooth=Smooth.None));

  annotation (
    __Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/HeatExchangers/Boreholes/Examples/UTube.mos"
        "Simulate and plot"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
                   graphics),
    experimentSetupOutput,
    Diagram,
    Documentation(info="<html>
<p>

</p>
</html>", revisions="<html>
<ul>
</ul>
</html>"),
    experiment(
      StopTime=360000,
      Tolerance=1e-005,
      __Dymola_Algorithm="Dassl"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
        graphics));
end partial_SingleBoreHoleStepLoad;
