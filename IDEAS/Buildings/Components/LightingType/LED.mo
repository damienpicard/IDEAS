within IDEAS.Buildings.Components.LightingType;
record LED "Properties for generic LED lights"
  extends Modelica.Icons.Record;
  extends IDEAS.Buildings.Components.LightingType.BaseClasses.PartialLighting(
      eps = 150,
      radFra = 0.35);

  annotation (Documentation(revisions="<html>
<ul>
<li>
August 28, 2018 by Iago Cupeiro:<br/>
First implementation
See <a href=\"https://github.com/open-ideas/IDEAS/issues/879\">#879</a>.
</li>
</ul>
</html>", info=""));

end LED;
