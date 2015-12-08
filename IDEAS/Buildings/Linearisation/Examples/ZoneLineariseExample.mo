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
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end ZoneLineariseExample;
