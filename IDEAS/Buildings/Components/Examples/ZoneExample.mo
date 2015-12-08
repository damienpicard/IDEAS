within IDEAS.Buildings.Components.Examples;
model ZoneExample
  extends IDEAS.Buildings.Components.Examples.Interfaces.partial_zoneExample;

    inner SimInfoManager sim
    annotation (Placement(transformation(extent={{-96,76},{-76,96}})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/Examples/ZoneExample.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
By Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
end ZoneExample;
