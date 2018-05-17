within IDEAS.Buildings.Components.ZoneAirModels;
model Thermal
  "Thermal-only air model without other fluid properties or mass exchange"
  extends IDEAS.Buildings.Components.ZoneAirModels.BaseClasses.PartialAirModel(
    m_flow_nominal=0,
    nSurf=1,
    useFluPor=false);

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heaCap(C=if energyDynamics==Modelica.Fluid.Types.Dynamics.SteadyState then 0 else Vtot*rho_default*cp_default
        *mSenFac) "Heat capacitor that represents the zone air heat capacity"
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTem
    "Zone air temperature sensor"
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
  Modelica.Blocks.Sources.Constant zero(k=0)
    "Constant output for relative humidity"
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  AirLeakageThermal airLeakageThermal(cp_default=cp_default,
    m_flow_nominal_airLea=m_flow_nominal_airLea)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
initial equation
  if energyDynamics==Modelica.Fluid.Types.Dynamics.FixedInitial then
    heaCap.T=T_start;
  end if;

equation
  QGai=0;
  E=heaCap.T*heaCap.C;
  for i in 1:nSurf loop
  connect(heaCap.port, ports_surf[i])
    annotation (Line(points={{0,0},{-100,0}}, color={191,0,0}));
  end for;
  for i in 1:nSeg loop
  connect(heaCap.port, ports_air[i])
    annotation (Line(points={{0,0},{52,0},{100,0}}, color={191,0,0}));
  end for;
  connect(senTem.port, heaCap.port)
    annotation (Line(points={{0,-60},{0,-60},{0,0}}, color={191,0,0}));
  connect(senTem.T,TAir)
    annotation (Line(points={{20,-60},{108,-60}}, color={0,0,127}));
  connect(zero.y, phi)
    annotation (Line(points={{61,-40},{108,-40},{108,-40}}, color={0,0,127}));
  connect(airLeakageThermal.heatPort, heaCap.port) annotation (Line(points={{0,40},
          {-10,40},{-20,40},{-20,0},{0,0}}, color={191,0,0}));
  annotation (Documentation(revisions="<html>
<ul>
<li>
November 15, 2016 by Filip Jorissen:<br/>
Revised documentation.
</li>
<li>
August 26, 2016 by Filip Jorissen:<br/>
Added support for conservation of energy.
</li>
<li>
July 18, 2016 by Filip Jorissen:<br/>
First implementation
</li>
</ul>
</html>", info="<html>
<p>
Zone air model that only considers thermal aspects, 
i.e. no moisture or trace substances (e.g. CO2) may be computed.
</p>
</html>"));
end Thermal;
