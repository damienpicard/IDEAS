within IDEAS.Buildings.Components.Examples;
package Interfaces
  partial model partial_zoneExample
    package Medium = IDEAS.Media.Air;
    extends Modelica.Icons.Example;
    replaceable Zone
         zone(
      redeclare package Medium = Medium,
      V=2,
      allowFlowReversal=true,
      nSurf=5) constrainedby BaseClasses.partial_zone(
      redeclare package Medium = Medium,
      V=2,
      allowFlowReversal=true,
      nSurf=5)
           annotation (Placement(transformation(extent={{20,-20},{40,0}})));
    BoundaryWall
               commonWall(
      redeclare parameter
        IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
        constructionType,
      redeclare parameter IDEAS.Buildings.Data.Insulation.Rockwool insulationType,
      insulationThickness=0.1,
      AWall=10,
      inc=0,
      azi=0)
      annotation (Placement(transformation(extent={{-54,-2},{-44,18}})));
    Fluid.Sources.Boundary_pT bou(          redeclare package Medium = Medium,
        nPorts=2)
      annotation (Placement(transformation(extent={{-60,100},{-40,80}})));

    InternalWall
               commonWall1(
      redeclare parameter
        IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
        constructionType,
      redeclare parameter IDEAS.Buildings.Data.Insulation.Rockwool insulationType,
      insulationThickness=0.1,
      AWall=10,
      inc=0,
      azi=0)
      annotation (Placement(transformation(extent={{-5,-10},{5,10}},
          rotation=90,
          origin={11,-38})));
    replaceable Window
           window(
      A=1,
      inc=0,
      azi=0,
      redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2 glazing,
      redeclare IDEAS.Buildings.Data.Interfaces.Frame fraType,
      redeclare IDEAS.Buildings.Components.Shading.Screen shaType)
      annotation (Placement(transformation(extent={{-54,-82},{-44,-62}})));
    SlabOnGround slabOnGround(
      redeclare parameter
        IDEAS.Buildings.Validation.Data.Constructions.LightWall
        constructionType,
      redeclare parameter IDEAS.Buildings.Data.Insulation.Pir insulationType,
      insulationThickness=0.1,
      AWall=20,
      PWall=3,
      inc=0,
      azi=0) annotation (Placement(transformation(extent={{-54,20},{-44,40}})));
    OuterWall outerWall(
      inc=0,
      azi=0,
      redeclare parameter
        IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
        constructionType,
      redeclare parameter IDEAS.Buildings.Data.Insulation.Glasswool insulationType,
      AWall=10,
      insulationThickness=0)
      annotation (Placement(transformation(extent={{-54,-58},{-44,-38}})));
    replaceable Zone
         zone1(
      nSurf=2,
      redeclare package Medium = Medium,
      V=2,
      allowFlowReversal=true) constrainedby BaseClasses.partial_zone(
      nSurf=2,
      redeclare package Medium = Medium,
      V=2,
      allowFlowReversal=true)
           annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
    Shading.ShadingControl shadingControl
      annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
    replaceable Window                 window1(
      inc=0,
      redeclare parameter IDEAS.Buildings.Data.Glazing.Ins2 glazing,
      redeclare IDEAS.Buildings.Data.Interfaces.Frame fraType,
      redeclare IDEAS.Buildings.Components.Shading.Screen shaType,
      azi=IDEAS.Constants.West,
      A=2) annotation (Placement(transformation(extent={{-54,-26},{-44,-6}})));
    Shading.ShadingControl                            shadingControl1
      annotation (Placement(transformation(extent={{-80,-44},{-60,-24}})));
  equation
    connect(commonWall.propsBus_a, zone.propsBus[1]) annotation (Line(
        points={{-44,12},{-12,12},{-12,-4.4},{20,-4.4}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(commonWall1.propsBus_a, zone.propsBus[2]) annotation (Line(
        points={{7,-33},{6,-33},{6,-5.2},{20,-5.2}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(window.propsBus_a, zone1.propsBus[2]) annotation (Line(
        points={{-44,-68},{6,-68},{6,-57},{20,-57}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(outerWall.propsBus_a, zone.propsBus[4]) annotation (Line(
        points={{-44,-44},{-12,-44},{-12,-6.8},{20,-6.8}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(slabOnGround.propsBus_a, zone.propsBus[3]) annotation (Line(
        points={{-44,34},{-12,34},{-12,-6},{20,-6}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(commonWall1.propsBus_b, zone1.propsBus[1]) annotation (Line(
        points={{7,-43},{6.5,-43},{6.5,-55},{20,-55}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(shadingControl.y, window.Ctrl) annotation (Line(
        points={{-60,-84},{-58,-84},{-58,-86},{-53,-86},{-53,-82}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(shadingControl1.y,window1. Ctrl) annotation (Line(
        points={{-60,-28},{-58,-28},{-58,-30},{-53,-30},{-53,-26}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(window1.propsBus_a, zone.propsBus[5]) annotation (Line(
        points={{-44,-12},{-12,-12},{-12,-7.6},{20,-7.6}},
        color={255,204,51},
        thickness=0.5));
    connect(bou.ports[1], zone.flowPort_In) annotation (Line(points={{-40,88},{
            8,88},{32,88},{32,0}}, color={0,127,255}));
    connect(bou.ports[2], zone1.flowPort_In) annotation (Line(points={{-40,92},
            {46,92},{46,-38},{32,-38},{32,-50}}, color={0,127,255}));
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
  end partial_zoneExample;
end Interfaces;
