within IDEAS.Thermal.Components.GroundHeatExchanger.Borefield.BaseClasses.BoreHoles.BaseClasses.Examples;
model BoreholeSegment "Test for the boreholeSegment model"
  import Buildings;
  import DaPModels;
  extends Modelica.Icons.Example;
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  package Medium = Buildings.Media.ConstantPropertyLiquidWater;

  BoreHoleSegmentFourPort seg(
    redeclare package Medium = Medium,
    dp_nominal=5,
    matSoi=Data.SoilData.Sandstone(),
    matFil=Data.BoreholeFillingData.Sandstone(),
    bfGeo=Data.BorefieldGeometricData.Line1_rB010_h100(),
    adv=Data.Advanced.Default(),
    TExt_start=273.15,
    TFil_start=273.15) annotation (Placement(transformation(
        extent={{-13,-13},{13,13}},
        rotation=270,
        origin={11,-1})));
  Buildings.Fluid.Sources.Boundary_pT sou_1(
    redeclare package Medium = Medium,
    nPorts=1,
    use_T_in=false,
    p=101340,
    T=303.15) annotation (Placement(transformation(extent={{-60,40},{-40,60}},
          rotation=0)));
  Buildings.Fluid.Sources.Boundary_pT sin_2(
    redeclare package Medium = Medium,
    use_p_in=false,
    use_T_in=false,
    nPorts=1,
    p=101330,
    T=283.15) annotation (Placement(transformation(extent={{-60,10},{-40,30}},
          rotation=0)));
equation
  connect(sou_1.ports[1], seg.port_a1) annotation (Line(
      points={{-40,50},{20,50},{20,12},{18.8,12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(seg.port_b1, seg.port_a2) annotation (Line(
      points={{18.8,-14},{3.2,-14}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(seg.port_b2, sin_2.ports[1]) annotation (Line(
      points={{3.2,12},{4,12},{4,20},{-40,20}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Fluid/HeatExchangers/Boreholes/BaseClasses/Examples/BoreholeSegment.mos"
        "Simulate and plot"),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics),
    experimentSetupOutput,
    Diagram,
    Documentation(info="<html>
This example illustrates modeling a segment of a borehole heat exchanger.
It simulates the behavior of the borehole on a single horizontal section including the ground and the
boundary condition.
</html>", revisions="<html>
<ul>
<li>
August 30, 2011, by Pierre Vigouroux:<br>
First implementation.
</li>
</ul>
</html>"));
end BoreholeSegment;
