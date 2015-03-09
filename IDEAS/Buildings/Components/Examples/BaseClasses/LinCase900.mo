within IDEAS.Buildings.Components.Examples.BaseClasses;
model LinCase900
  import Buildings;

protected
  Zone                            gF(
    V=129.6,
    n50=0.5*20,
    corrCV=0.822,
    T_start=293.15,
    linear=true,
    redeclare package Medium = Medium,
    linearize=true,
    nSurf=9)
    annotation (Placement(transformation(extent={{50,-2},{90,38}})));
  OuterWall[                           4] wall(
    final AWall={21.6,16.2,9.6,16.2},
    final azi={IDEAS.Constants.North,IDEAS.Constants.East,IDEAS.Constants.South,
        IDEAS.Constants.West},
    final inc={IDEAS.Constants.Wall,IDEAS.Constants.Wall,IDEAS.Constants.Wall,
        IDEAS.Constants.Wall},
    redeclare final parameter
      IDEAS.Buildings.Validation.Data.Constructions.HeavyWall                         constructionType,
    redeclare final parameter
      IDEAS.Buildings.Validation.Data.Insulation.foaminsulation                         insulationType,
    final insulationThickness={0.0615,0.0615,0.0615,0.0615}) annotation (
      Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-39,-16})));
  BoundaryWall                            floor(
    redeclare final parameter
      IDEAS.Buildings.Validation.Data.Constructions.HeavyFloor                         constructionType,
    redeclare final parameter
      IDEAS.Buildings.Validation.Data.Insulation.insulation                         insulationType,
    final insulationThickness=1.003,
    final AWall=48,
    final inc=IDEAS.Constants.Floor,
    final azi=IDEAS.Constants.South) annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-9,-16})));
  LinearizableWindow[3] win(
    final A={6,6,6},
    redeclare final parameter
      IDEAS.Buildings.Validation.Data.Glazing.GlaBesTest                         glazing,
    each inc=IDEAS.Constants.Wall,
    each azi=IDEAS.Constants.South,
    redeclare replaceable IDEAS.Buildings.Components.Shading.None shaType,
    redeclare final parameter IDEAS.Buildings.Data.Frames.None fraType,
    each frac=0,
    each linearizeWindow=true,
    each linOut=false)
    annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={21,-16})));
  OuterWall                            roof(
    redeclare final parameter
      IDEAS.Buildings.Validation.Data.Constructions.LightRoof                         constructionType,
    redeclare final parameter
      IDEAS.Buildings.Validation.Data.Insulation.fiberglass                         insulationType,
    final insulationThickness=0.1118,
    final AWall=48,
    final inc=IDEAS.Constants.Ceiling,
    final azi=IDEAS.Constants.South) annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-69,-16})));
public
  inner SimInfoManager       sim
    "Simulation information manager for climate data"
    annotation (Placement(transformation(extent={{-102,78},{-82,98}})));
  Fluid.Sources.Boundary_pT bou(nPorts=1, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-14,62},{6,82}})));
  replaceable package Medium = IDEAS.Experimental.Media.AirPTDecoupled
    constrainedby Modelica.Media.Interfaces.PartialMedium;
  inner Modelica.Fluid.System system
  annotation (Placement(transformation(extent={{56,-94},{76,-74}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{72,-30},{52,-10}})));
  input BoundaryConditions.WeatherData.Bus
                                     weaBus1(numSolBus=sim.numAzi + 1)
    annotation (Placement(transformation(extent={{-108,24},{-88,44}})));
  input Interfaces.WinBus winBus[3](nLay=win.glazing.nLay) annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-98,-50})));
equation
   connect(roof.propsBus_a,gF. propsBus[1]) annotation (Line(
      points={{-73,-11},{-73,29.5556},{50,29.5556}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(wall.propsBus_a,gF. propsBus[2:5]) annotation (Line(
      points={{-43,-11},{-43,26},{50,26}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(floor.propsBus_a,gF. propsBus[6]) annotation (Line(
      points={{-13,-11},{-13,25.1111},{50,25.1111}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(win.propsBus_a,gF. propsBus[7:9]) annotation (Line(
      points={{17,-11},{17,22.4444},{50,22.4444}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(bou.ports[1], gF.flowPort_In) annotation (Line(
      points={{6,72},{74,72},{74,38}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(const.y, win[1].Ctrl) annotation (Line(
      points={{51,-20},{42,-20},{42,-19},{31,-19}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, win[2].Ctrl) annotation (Line(
      points={{51,-20},{42,-20},{42,-19},{31,-19}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gF.weaBus, weaBus1) annotation (Line(
      points={{50,17.6},{-24,17.6},{-24,34},{-98,34}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(const.y, win[3].Ctrl) annotation (Line(
      points={{51,-20},{42,-20},{42,-19},{31,-19}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(win.winBus, winBus) annotation (Line(
      points={{27,-10.8},{27,-50},{-98,-50}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end LinCase900;
