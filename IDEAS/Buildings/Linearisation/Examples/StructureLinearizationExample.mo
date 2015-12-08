within IDEAS.Buildings.Linearisation.Examples;
model StructureLinearizationExample
  import IDEAS;
  extends Modelica.Icons.Example;
  extends IDEAS.Buildings.Linearisation.Interfaces.LinearisationInterface(sim(
        nWindow=9));

  IDEAS.Buildings.Examples.BaseClasses.structure structure(
    redeclare IDEAS.Buildings.Linearisation.Components.LinWindow sF_win(
        indexWindow={7,8,9}),
    redeclare IDEAS.Buildings.Linearisation.Components.LinWindow fF_win(
        indexWindow={4,5,6}),
    redeclare IDEAS.Buildings.Linearisation.Components.LinWindow gF_win(
        indexWindow={1,2,3}),
    redeclare IDEAS.Buildings.Linearisation.Components.LinZone sF,
    redeclare IDEAS.Buildings.Linearisation.Components.LinZone fF,
    redeclare IDEAS.Buildings.Linearisation.Components.LinZone gF,
    redeclare package Medium = IDEAS.Media.Air)
    annotation (Placement(transformation(extent={{-14,-10},{16,10}})));
  IDEAS.Fluid.Sources.Boundary_pT
                            bou(nPorts=3, redeclare package Medium =
        IDEAS.Media.Air)
    annotation (Placement(transformation(extent={{-52,70},{-32,90}})));
equation
  connect(bou.ports[1:3], structure.flowPort_In) annotation (Line(points={{-32,
          77.3333},{3,77.3333},{3,10}},
                               color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end StructureLinearizationExample;
