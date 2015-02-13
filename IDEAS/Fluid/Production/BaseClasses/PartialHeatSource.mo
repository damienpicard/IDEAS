within IDEAS.Fluid.Production.BaseClasses;
partial model PartialHeatSource
  "Partial for a heat source production component"
  extends IDEAS.Fluid.Interfaces.OnOffInterface;
  extends IDEAS.Fluid.Production.Interfaces.ModulationSecurity(T_max=data.TMax,T_min=data.TMin);

  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component";
  parameter SI.MassFlowRate m_flow_nominal "Nominal mass flow rate"
    annotation(Dialog(group = "Nominal condition"));
  parameter Boolean useTSet = true
    "If true, use TSet as control input, else QSet";
  parameter Modelica.SIunits.Time riseTime=120
    "The time it takes to reach full/zero power when switching"
    annotation(Dialog(tab="Advanced", group="Events", enable=avoidEvents));
  //Data parameters
  parameter Modelica.SIunits.Power QNomRef = data.QNomRef
    "Nominal power of the production unit for which the data is given";
  parameter Real etaRef = data.etaRef
    "Nominal efficiency (higher heating value)of the xxx boiler at 50/30degC.  See datafile";

  //Scalable parameters
  parameter Modelica.SIunits.Power QNom = data.QNomRef
    "The power at nominal conditions";
  parameter Real scaler = QNom/QNomRef "The scaling factor of the boiler data";
  parameter Modelica.SIunits.ThermalConductance UALoss
    "UA of heat losses of the heat source to environment";
  //Variables
  Real eta "Final efficiency of the heat source";
//  Real release(min=0, max=1) "Stop heat production when the mass flow is zero";
  Modelica.SIunits.Power QLossesToCompensate
    "Artificial heat losses to correct the heat balance";
    Modelica.Blocks.Interfaces.RealOutput PFuel(unit="W")
    "Resulting fuel consumption" annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Real m_flowHx_scaled = IDEAS.Utilities.Math.Functions.smoothMax(x1=m_flow, x2=0,deltaX=m_flow_nominal/10000) * 1/scaler
    "mass flow rate, scaled with the original and the actual nominal power of the boiler";
  //Components
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "heatPort connection to water in condensor"  annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));
  outer SimInfoManager sim
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  //Inputs
  Modelica.Blocks.Interfaces.RealInput hIn "Specific enthalpy at the inlet" annotation (Placement(transformation(
          extent={{-128,60},{-88,100}}), iconTransformation(extent={{-120,68},{-96,
            92}})));
  Modelica.Blocks.Interfaces.RealInput m_flow "Heated fluid mass flow rate" annotation (Placement(transformation(
          extent={{-128,20},{-88,60}}), iconTransformation(extent={{-120,28},{-96,
            52}})));
  Modelica.Blocks.Interfaces.RealInput THxIn "Heated fluid temperature" annotation (Placement(transformation(
          extent={{-128,-20},{-88,20}}),  iconTransformation(extent={{-120,-12},
            {-96,12}})));
  Modelica.Blocks.Interfaces.RealInput TSet if useTSet "Set point temperature" annotation (Placement(transformation(
          extent={{-126,-102},{-86,-62}}),iconTransformation(extent={{-120,-92},
            {-96,-68}})));
  Modelica.Blocks.Interfaces.RealInput QSet if not useTSet
    "Setpoint for net hemal power"
    annotation (Placement(transformation(extent={{-128,-60},{-88,-20}}),
        iconTransformation(extent={{-120,-52},{-96,-28}})));

  //Modulation parameters
  parameter Boolean avoidEvents = true
    "Set to true to switch heat pumps on using a continuous transition"
    annotation(Dialog(tab="Advanced", group="Events"));
  parameter Real modulationMin = data.modulationMin
    "Minimal modulation percentage";
  parameter Real modulationStart = data.modulationStart
    "Starting modulation percentage";
  //Modulation variables
  Modelica.Blocks.Interfaces.RealInput modulationInit
    "Initial modulation, decides on start/stop of the production unit";
  Real modulation(min=0, max=100) "Current modulation percentage";
  Modelica.SIunits.Power QMax
    "Maximum thermal power at 100% modulation for the given input conditions";
  Modelica.SIunits.Power QAsked(start=0) "Desired power of the heatsource";
  //Components
protected
  Modelica.Blocks.Interfaces.RealInput TSet_internal
    "Needed to connect to conditional connector";
  Modelica.Blocks.Interfaces.RealInput QSet_internal
    "Needed to connect to conditional connector";

public
  replaceable parameter PartialData                                              data constrainedby
    PartialData
    annotation (choicesAllMatching=true, Placement(transformation(extent={{70,-88},
            {90,-68}})));

equation
  T_high = THxIn;
  T_low = THxIn;
  // Compuation of QAsked, depends on which input is used
  connect(TSet, TSet_internal);
  connect(QSet, QSet_internal);

  if useTSet then
    QAsked = IDEAS.Utilities.Math.Functions.smoothMax(0, m_flow*(Medium.specificEnthalpy(Medium.setState_pTX(Medium.p_default, TSet_internal, Medium.X_default)) -hIn), 10);
    QSet_internal = 0;
 else
    QAsked = QSet_internal;
    TSet_internal = 0;
  end if;

  //Calculation of the modulation
  //release = if noEvent(m_flow > Modelica.Constants.eps) then 0.0 else 1.0;
  modulationInit = QAsked/QMax*100;
  modulation =   modulation_security_internal*IDEAS.Utilities.Math.Functions.smoothMin(modulationInit, 100, deltaX=0.1);
  //Calcualation of the heat powers
  QLossesToCompensate = if noEvent(modulation > Modelica.Constants.eps) then UALoss*(heatPort.T - sim.Te) else 0;
  //Final heat power of the heat source
  heatPort.Q_flow = -eta/etaRef*modulation/100*QNom - QLossesToCompensate;
  PFuel = if noEvent(eta>Modelica.Constants.eps) then -heatPort.Q_flow/eta else 0;

    annotation (Placement(transformation(extent={{-56,52},{-36,72}})),
                Placement(transformation(extent={{66,74},{86,94}})),
              Icon(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false),
                   graphics={
        Line(
          points={{-98,80},{-80,80},{-50,80},{0,0}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-100,-80},{-80,-80},{-50,-80},{0,0}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-98,40},{-60,40},{-6,20}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-100,-40},{-60,-40},{-2,-20}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{28,0},{90,0},{98,0},{100,0}},
          color={0,0,255},
          smooth=Smooth.None),
      Polygon(
        origin={65.533,-20.062},
        lineColor = {255,0,0},
        fillColor = {255,0,0},
        fillPattern = FillPattern.Solid,
        points={{-60.062,-105.533},{-20.062,-65.533},{19.938,-105.533},{19.938,-45.533},
              {-20.062,-5.533},{-60.062,-45.533},{-60.062,-105.533}},
          rotation=270),
        Line(
          points={{-98,0},{-36,0},{0,0}},
          color={0,0,255},
          smooth=Smooth.None)}), Diagram(coordinateSystem(extent={{-100,-100},{100,
            100}}, preserveAspectRatio=false), graphics));
end PartialHeatSource;
