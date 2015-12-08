within IDEAS.Buildings.Linearisation.Examples;
model ZoneLineariseExample
  extends Modelica.Icons.Example;
  extends IDEAS.Buildings.Components.Examples.Interfaces.partial_zoneExample(
    redeclare Components.LinWindow window1,
    redeclare Components.LinWindow window(indexWindow=2),
    redeclare Components.LinZone zone(redeclare package Medium = Medium),
    redeclare Components.LinZone zone1(redeclare package Medium = Medium));
  extends IDEAS.Buildings.Linearisation.Interfaces.LinearisationInterface(sim(
        nWindow=2));
  Utilities.IO.heatPortPrescribedHeatFlow       heatPortPrescribedHeatFlow1
    annotation (Placement(transformation(extent={{74,-26},{64,-16}})));
  Utilities.IO.heatPortPrescribedHeatFlow       heatPortPrescribedHeatFlow2
    annotation (Placement(transformation(extent={{76,-82},{66,-72}})));
  Modelica.Blocks.Interfaces.RealOutput TSensor1
    "Sensor temperature of the zone, i.e. operative temeprature"
    annotation (Placement(transformation(extent={{94,-20},{114,0}})));
  Modelica.Blocks.Interfaces.RealOutput TSensor2
    "Sensor temperature of the zone, i.e. operative temeprature"
    annotation (Placement(transformation(extent={{94,-70},{114,-50}})));
  Modelica.Blocks.Interfaces.RealInput Q_flow(start = 100)
    annotation (Placement(transformation(extent={{114,-38},{92,-16}})));
  Modelica.Blocks.Interfaces.RealInput Q_flow1(start = 100)
    annotation (Placement(transformation(extent={{116,-94},{94,-72}})));
equation
  connect(zone.TSensor,TSensor1)
    annotation (Line(points={{40.6,-10},{70,-10},{104,-10}},
                                                    color={0,0,127}));
  connect(zone1.TSensor,TSensor2)
    annotation (Line(points={{40.6,-60},{70,-60},{104,-60}},
                                                    color={0,0,127}));
  connect(heatPortPrescribedHeatFlow1.port1, zone.gainCon) annotation (Line(
        points={{64,-21},{58,-21},{58,-20},{50,-20},{50,-13},{40,-13}}, color={
          191,0,0}));
  connect(heatPortPrescribedHeatFlow1.Q_flow,Q_flow)  annotation (Line(points={{74.4,
          -17.5},{84,-17.5},{84,-27},{103,-27}},      color={0,0,127}));
  connect(Q_flow1,heatPortPrescribedHeatFlow2. Q_flow) annotation (Line(points={{105,-83},
          {86,-83},{86,-73.5},{76.4,-73.5}},            color={0,0,127}));
  connect(heatPortPrescribedHeatFlow2.port1, zone1.gainCon) annotation (Line(
        points={{66,-77},{62,-77},{62,-78},{52,-78},{52,-63},{40,-63}}, color={
          191,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end ZoneLineariseExample;
