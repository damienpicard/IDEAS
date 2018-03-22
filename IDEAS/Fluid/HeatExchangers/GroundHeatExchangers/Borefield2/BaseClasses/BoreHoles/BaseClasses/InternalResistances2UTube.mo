within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield2.BaseClasses.BoreHoles.BaseClasses;
model InternalResistances2UTube
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor RConv1
    "Pipe convective resistance" annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-26,70})));
  Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor RConv2
    "Pipe convective resistance"
    annotation (Placement(transformation(extent={{32,12},{40,20}})));
  Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor RConv3
    "Pipe convective resistance" annotation (Placement(transformation(
        extent={{4,4},{-4,-4}},
        rotation=180,
        origin={-26,-52})));
  Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor RConv4
    "Pipe convective resistance" annotation (Placement(transformation(
        extent={{-4,4},{4,-4}},
        rotation=180,
        origin={-50,16})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rpg1(R=RCondGro_val)
    "Grout thermal resistance" annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=90,
        origin={-9,51})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rgb1(R=Rgb_val)
    "Grout thermal resistance" annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=90,
        origin={-9,27})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rpg2(R=RCondGro_val)
    "Grout thermal resistance" annotation (Placement(transformation(
        extent={{-7,7},{7,-7}},
        rotation=180,
        origin={25,5})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rgb2(R=Rgb_val)
    "Grout thermal resistance" annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=0,
        origin={7,5})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rpg3(R=RCondGro_val)
    "Grout thermal resistance" annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-9,-29})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rgb3(R=Rgb_val)
    "Grout thermal resistance" annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-9,-9})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rpg4(R=RCondGro_val)
    "Grout thermal resistance" annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=180,
        origin={-39,7})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rgb4(R=Rgb_val)
    "Grout thermal resistance" annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=180,
        origin={-21,7})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rgg11(R=Rgg1_val)
    "Grout thermal resistance" annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=90,
        origin={13,27})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rgg21(R=Rgg2_val)
    "Grout thermal resistance" annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=180,
        origin={35,51})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rgg12(R=Rgg1_val)
    "Grout thermal resistance" annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=90,
        origin={13,-13})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rgg22(R=Rgg2_val)
    "Grout thermal resistance" annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=90,
        origin={41,-15})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rgg14(R=Rgg1_val)
    "Grout thermal resistance" annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=90,
        origin={-29,25})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rgg24(R=Rgg2_val)
    "Grout thermal resistance" annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-47,29})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rgg13(R=Rgg1_val)
    "Grout thermal resistance" annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=90,
        origin={-27,-13})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Rgg23(R=Rgg2_val)
    "Grout thermal resistance" annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=180,
        origin={-37,-33})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor capFil1(T(start=
          T_start, fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial)),
      der_T(fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial)),
    C=Co_fil/4) if  dynFil "Heat capacity of the filling material"
                                            annotation (Placement(
        transformation(
        extent={{-54,21.6},{-42,9.6}},
        rotation=90,
        origin={23.6,98})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor capFil2(T(start=
          T_start, fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial)),
      der_T(fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial)),
    C=Co_fil/4) if   dynFil "Heat capacity of the filling material"
                                            annotation (Placement(
        transformation(
        extent={{54,-21.6},{42,-9.6}},
        rotation=180,
        origin={73.6,-26})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor capFil3(T(start=
          T_start, fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial)),
      der_T(fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial)),
    C=Co_fil/4) if  dynFil "Heat capacity of the filling material"
                                            annotation (Placement(
        transformation(
        extent={{54,-21.6},{42,-9.6}},
        rotation=180,
        origin={53.6,-46})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor capFil4(T(start=
          T_start, fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial)),
      der_T(fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial)),
    C=Co_fil/4) if  dynFil "Heat capacity of the filling material"
                                            annotation (Placement(
        transformation(
        extent={{54,-21.6},{42,-9.6}},
        rotation=180,
        origin={7.6,-24})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a1
    annotation (Placement(transformation(extent={{30,90},{50,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b1
    annotation (Placement(transformation(extent={{30,-110},{50,-90}})));
equation
  connect(RConv1.solid,Rpg1. port_a) annotation (Line(
      points={{-26,64},{-26,58},{-9,58}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rpg1.port_b,Rgb1. port_a) annotation (Line(
      points={{-9,44},{-9,34}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(RConv2.solid,Rpg2. port_a) annotation (Line(
      points={{32,16},{32,5}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rgb2.port_a,Rpg2. port_b) annotation (Line(
      points={{14,5},{18,5}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rgb2.port_b, port) annotation (Line(
      points={{0,5},{0,6},{-2,6},{-2,66},{12,66},{12,0},{100,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rgb1.port_b, port) annotation (Line(
      points={{-9,20},{-8,20},{-8,6},{-2,6},{-2,66},{12,66},{12,0},{100,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(RConv3.solid,Rpg3. port_a) annotation (Line(
      points={{-30,-52},{-32,-52},{-32,-40},{-9,-40},{-9,-36}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rgb3.port_a,Rpg3. port_b) annotation (Line(
      points={{-9,-16},{-9,-22}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rgb3.port_b, port) annotation (Line(
      points={{-9,-2},{-8,-2},{-8,6},{-2,6},{-2,66},{12,66},{12,0},{100,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(RConv4.solid,Rpg4. port_a) annotation (Line(
      points={{-46,16},{-46,7}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rpg4.port_b,Rgb4. port_a) annotation (Line(
      points={{-32,7},{-28,7}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rgb4.port_b, port) annotation (Line(
      points={{-14,7},{-12,7},{-12,6},{-2,6},{-2,66},{12,66},{12,0},{100,0}},
      color={191,0,0},
      smooth=Smooth.None));
     connect(capFil1.port,Rpg1. port_b) annotation (Line(
      points={{2,50},{2,40},{-8,40},{-8,44},{-9,44}},
      color={191,0,0},
      smooth=Smooth.None));
    connect(capFil2.port,Rpg2. port_b) annotation (Line(
      points={{25.6,-4.4},{18,-4.4},{18,5}},
      color={191,0,0},
      smooth=Smooth.None));
    connect(capFil3.port,Rpg3. port_b) annotation (Line(
      points={{5.6,-24.4},{5.6,-22},{-9,-22}},
      color={191,0,0},
      smooth=Smooth.None));
    connect(capFil4.port,Rpg4. port_b) annotation (Line(
      points={{-40.4,-2.4},{-32,-2.4},{-32,7}},
      color={191,0,0},
      smooth=Smooth.None));
    connect(Rgg21.port_b,capFil3. port) annotation (Line(
      points={{42,51},{72,51},{72,50},{104,50},{104,-24.4},{5.6,-24.4}},
      color={191,0,0},
      smooth=Smooth.None));
    connect(Rgg22.port_a,capFil2. port) annotation (Line(
      points={{41,-8},{40,-8},{40,-4.4},{25.6,-4.4}},
      color={191,0,0},
      smooth=Smooth.None));
    connect(Rgg22.port_b,capFil4. port) annotation (Line(
      points={{41,-22},{42,-22},{42,-84},{-50,-84},{-50,-2.4},{-40.4,-2.4}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rgg11.port_a,Rpg1. port_b) annotation (Line(
      points={{13,34},{14,34},{14,40},{-9,40},{-9,44}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rgg11.port_b,Rgb2. port_a) annotation (Line(
      points={{13,20},{14,20},{14,5}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rgg12.port_a,Rgb2. port_a) annotation (Line(
      points={{13,-6},{14,-6},{14,5}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rgg12.port_b,Rpg3. port_b) annotation (Line(
      points={{13,-20},{8,-20},{8,-22},{-9,-22}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rgg13.port_b,Rpg3. port_b) annotation (Line(
      points={{-27,-20},{-10,-20},{-9,-22}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rgg13.port_a,Rpg4. port_b) annotation (Line(
      points={{-27,-6},{-30,-6},{-30,-2},{-32,-2},{-32,7}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rgg14.port_b,Rgb4. port_a) annotation (Line(
      points={{-29,18},{-28,18},{-28,7}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rgg14.port_a,Rgb1. port_a) annotation (Line(
      points={{-29,32},{-28,32},{-28,40},{-10,40},{-9,34}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rgg21.port_a,Rpg1. port_b) annotation (Line(
      points={{28,51},{22,51},{22,40},{-9,40},{-9,44}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rgg23.port_b,Rpg3. port_b) annotation (Line(
      points={{-30,-33},{-26,-33},{-26,-34},{-20,-34},{-20,-20},{-10,-20},{-9,
          -22}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rgg23.port_a,Rpg1. port_b) annotation (Line(
      points={{-44,-33},{-64,-33},{-64,-34},{-82,-34},{-82,40},{-9,40},{-9,44}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rgg24.port_a,Rgb4. port_a) annotation (Line(
      points={{-47,22},{-40,22},{-40,16},{-28,16},{-28,7}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Rgg24.port_b,Rgb2. port_a) annotation (Line(
      points={{-47,36},{-46,36},{-46,90},{24,90},{24,18},{14,18},{14,5}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-18,20},{-8,10}},
          lineColor={0,0,0},
          textString="Tb")}));
end InternalResistances2UTube;
