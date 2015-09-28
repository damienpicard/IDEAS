within IDEAS.Buildings.Components.Interfaces;
partial model StateWallNoSol
  "Partial model for building envelope components without transparent surfaces."
  extends IDEAS.Buildings.Components.Interfaces.StateWall;
  parameter Modelica.SIunits.Temperature T_start=293.15
    "Start temperature for each of the layers";
  parameter Boolean linearise=true
    "= true, if convective heat transfer should be linearised"
    annotation(Dialog(tab="Convection"));
  parameter Modelica.SIunits.TemperatureDifference dT_nominal=-3
    "Nominal temperature difference used for linearisation, negative temperatures indicate the solid is colder"
    annotation(Dialog(tab="Convection"));
  parameter Modelica.SIunits.Length insulationThickness
    "Thermal insulation thickness"
    annotation (Dialog(group="Construction details"));
  replaceable IDEAS.Buildings.Data.Constructions.CavityWall constructionType
    constrainedby Data.Interfaces.Construction(final insulationType=
        insulationType, final insulationTickness=insulationThickness)
    "Type of building construction" annotation (
    __Dymola_choicesAllMatching=true,
    Placement(transformation(extent={{-38,72},{-34,76}})),
    Dialog(group="Construction details"));
  replaceable IDEAS.Buildings.Data.Insulation.Rockwool insulationType
    constrainedby Data.Interfaces.Insulation(final d=insulationThickness)
    "Type of thermal insulation" annotation (
    __Dymola_choicesAllMatching=true,
    Placement(transformation(extent={{-38,84},{-34,88}})),
    Dialog(group="Construction details"));
  parameter Modelica.SIunits.Area AWall "Total wall area";
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow iSolDir(Q_flow=0)
    annotation (Placement(transformation(extent={{80,54},{60,74}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow iSolDif(Q_flow=0)
    annotation (Placement(transformation(extent={{80,72},{60,92}})));
protected
  Modelica.Blocks.Sources.RealExpression E if
       sim.computeConservationOfEnergy "Internal energy model"
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  IDEAS.Buildings.Components.BaseClasses.PrescribedEnergy prescribedHeatFlowE if
       sim.computeConservationOfEnergy
    "Component for computing conservation of energy"
    annotation (Placement(transformation(extent={{10,80},{30,100}})));
  Modelica.Blocks.Sources.RealExpression Qgai if
     sim.computeConservationOfEnergy "Heat gains in model"
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowQgai if
     sim.computeConservationOfEnergy
    "Component for computing conservation of energy"
    annotation (Placement(transformation(extent={{10,60},{30,80}})));
  BaseClasses.MultiLayerOpaque                            layMul(
    final A=AWall,
    final inc=inc,
    final nLay=constructionType.nLay,
    final mats=constructionType.mats,
    final locGain=constructionType.locGain,
    T_start=T_start,
    final nGain=constructionType.nGain)
    "declaration of array of resistances and capacitances for wall simulation"
    annotation (Placement(transformation(extent={{-10,-38},{10,-18}})));
public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_emb[constructionType.nGain]
    "port for gains by embedded active layers"
    annotation (Placement(transformation(extent={{-10,-108},{10,-88}})));
protected
  BaseClasses.InteriorConvection                            intCon_a(
    final A=AWall,
    final inc=inc + Modelica.Constants.pi,
    linearise=linearise,
    dT_nominal=dT_nominal)
    "convective surface heat transimission on the interior side of the wall"
    annotation (Placement(transformation(extent={{20,-38},{40,-18}})));
equation
  connect(iSolDif.port, propsBus_a.iSolDif) annotation (Line(
      points={{60,82},{46,82},{46,39.9},{50.1,39.9}},
      color={191,0,0},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(iSolDir.port, propsBus_a.iSolDir) annotation (Line(
      points={{60,64},{56,64},{56,39.9},{50.1,39.9}},
      color={191,0,0},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(prescribedHeatFlowE.port, propsBus_a.E) annotation (Line(points={{30,90},
          {44,90},{44,39.9},{50.1,39.9}},     color={191,0,0}));
  connect(Qgai.y, prescribedHeatFlowQgai.Q_flow)
    annotation (Line(points={{1,70},{4,70},{4,70},{6,70},{6,70},{10,70}},
                                              color={0,0,127}));
  connect(prescribedHeatFlowQgai.port, propsBus_a.Qgai)
    annotation (Line(points={{30,70},{50.1,70},{50.1,39.9}}, color={191,0,0}));
  connect(E.y, prescribedHeatFlowE.E)
    annotation (Line(points={{1,90},{10,90},{10,90}}, color={0,0,127}));
  connect(layMul.port_gain,port_emb)  annotation (Line(
      points={{0,-38},{0,-98}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(layMul.port_b,intCon_a. port_a) annotation (Line(
      points={{10,-28},{20,-28}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(layMul.port_b, propsBus_a.surfRad) annotation (Line(
      points={{10,-28},{14,-28},{14,39.9},{50.1,39.9}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(propsBus_a.surfCon,intCon_a. port_b) annotation (Line(
      points={{50.1,39.9},{46,39.9},{46,-28},{40,-28}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(layMul.iEpsLw_b, propsBus_a.epsLw) annotation (Line(
      points={{10,-20},{14,-20},{14,39.9},{50.1,39.9}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(layMul.iEpsSw_b, propsBus_a.epsSw) annotation (Line(
      points={{10,-24},{18,-24},{18,39.9},{50.1,39.9}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(layMul.area, propsBus_a.area) annotation (Line(
      points={{0,-18},{0,39.9},{50.1,39.9}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-50,-100},{50,100}}), graphics),
    Documentation(revisions="<html>
<ul>
<li>
February 10, 2015 by Filip Jorissen:<br/>
Adjusted implementation for grouping of solar calculations.
</li>
</ul>
</html>"));
end StateWallNoSol;
