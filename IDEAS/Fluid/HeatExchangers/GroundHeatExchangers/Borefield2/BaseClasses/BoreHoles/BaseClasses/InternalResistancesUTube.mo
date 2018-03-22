within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield2.BaseClasses.BoreHoles.BaseClasses;
model InternalResistancesUTube
  Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor RConv1
    "Pipe convective resistance"
    annotation (Placement(transformation(extent={{-48,50},{-72,26}})));
  Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor RConv2
    "Pipe convective resistance"
    annotation (Placement(transformation(extent={{-46,-30},{-70,-6}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rpg1(
    R=RCondGro_val) "Grout thermal resistance"
    annotation (Placement(transformation(extent={{-40,26},{-16,50}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rpg2(
    R=RCondGro_val) "Grout thermal resistance"
    annotation (Placement(transformation(extent={{-38,-30},{-14,-6}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rgb1(
    R=Rgb_val) "Grout thermal resistance"
    annotation (Placement(transformation(extent={{62,36},{86,60}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rgb2(
    R=Rgb_val) "Grout thermal resistance"
    annotation (Placement(transformation(extent={{62,-30},{86,-6}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rgg(
    R=Rgg_val) "Grout thermal resistance"
    annotation (Placement(transformation(extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={30,12})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor capFil1(C=Co_fil/2, T(
        start=T_start, fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial)),
        der_T(fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial))) if dynFil
    "Heat capacity of the filling material"
                                         annotation (
      Placement(transformation(
        extent={{-90,36},{-70,16}},
        rotation=0,
        origin={90,10})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor capFil2(C=Co_fil/2, T(
        start=T_start, fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial)),
        der_T(fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial))) if   dynFil
    "Heat capacity of the filling material"                                                                                        annotation (
      Placement(transformation(
        extent={{-90,-36},{-70,-16}},
        rotation=0,
        origin={90,22})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(RConv1.solid,Rpg1. port_a) annotation (Line(
      points={{-48,38},{-40,38}},
      color={191,0,0},
      smooth=Smooth.None));
    connect(capFil1.port,Rgb1. port_a) annotation (Line(
      points={{10,46},{10,48},{62,48}},
      color={191,0,0},
      smooth=Smooth.None));
    connect(capFil2.port,Rgb2. port_a) annotation (Line(
      points={{10,-14},{10,-18},{62,-18}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(RConv2.solid,Rpg2. port_a) annotation (Line(
      points={{-46,-18},{-38,-18}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rpg1.port_b,Rgb1. port_a) annotation (Line(
      points={{-16,38},{-6,38},{-6,48},{62,48}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rgg.port_a,Rgb1. port_a) annotation (Line(
      points={{30,24},{30,48},{62,48}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rpg2.port_b,Rgb2. port_a) annotation (Line(
      points={{-14,-18},{62,-18}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rgg.port_b,Rgb2. port_a) annotation (Line(
      points={{30,0},{30,-18},{62,-18}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end InternalResistancesUTube;
