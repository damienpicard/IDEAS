within IDEAS.BoundaryConditions.WeatherData.BaseClasses.Examples;
model ConvertTime "Test model for converting time"
  extends Modelica.Icons.Example;
  IDEAS.Utilities.Time.ModelTime modTim
    "Block that outputs simulation time"
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  IDEAS.BoundaryConditions.WeatherData.BaseClasses.ConvertTime conTim(
    weaDatStaTim=0,
    weaDatEndTim=31536000)
    "Block that converts time"
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
equation
  connect(modTim.y, conTim.modTim) annotation (Line(
      points={{-19,10},{-2,10}},
      color={0,0,127}));
  annotation (
  Documentation(info="<html>
<p>
This example tests the model that converts time.
</p>
</html>",
revisions="<html>
<ul>
<li>
July 14, 2010, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"),
  experiment(Tolerance=1e-6, StopTime=77760000),
__Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/BoundaryConditions/WeatherData/BaseClasses/Examples/ConvertTime.mos"
        "Simulate and plot"));
end ConvertTime;
