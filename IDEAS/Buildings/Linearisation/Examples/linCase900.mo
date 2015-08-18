within IDEAS.Buildings.Linearisation.Examples;
model linCase900
  extends Modelica.Icons.Example;
  BaseClasses.LinCase900 linear(
    sim(linearise=false),
    roof(linConv=true),
    wall(linConv=true),
    floor(linConv=true),
    win(linConv=true),
    gF(useFluidPorts=false, linRad=true),
    T_start=T_start,
    slabOnGround(linearise=true))
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  BaseClasses.LinCase900 nonLinear(
    T_start=T_start,
    sim(linearise=false),
    roof(linConv=false),
    wall(linConv=false),
    floor(linConv=false),
    win(linConv=false),
    gF(useFluidPorts=false, linRad=false),
    slabOnGround(linearise=false))
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  parameter SI.Temperature T_start=293.15
    "Start temperature for each of the layers";
  Modelica.Blocks.Interfaces.RealOutput y_linear
    annotation (Placement(transformation(extent={{96,38},{116,58}})));
  Modelica.Blocks.Interfaces.RealOutput y_nonLinear
    annotation (Placement(transformation(extent={{98,-62},{118,-42}})));
equation
  connect(linear.y, y_linear)
    annotation (Line(points={{0.6,48},{106,48}}, color={0,0,127}));
  connect(nonLinear.y, y_nonLinear)
    annotation (Line(points={{0.6,-52},{108,-52}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end linCase900;
