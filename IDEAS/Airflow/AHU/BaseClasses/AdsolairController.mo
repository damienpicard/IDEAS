within IDEAS.Airflow.AHU.BaseClasses;
model AdsolairController
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Time tau=60
    "Thermal time constant at nominal flow rate";

  Modelica.Blocks.Interfaces.BooleanInput on "AHU status"       annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-106,80})));
  Modelica.Blocks.Interfaces.RealInput TSet
    "Set point temperature at AHU outlet"
    annotation (Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-106,20})));
  Modelica.Blocks.Interfaces.RealInput TFanOutSup
    "Outlet temperature of supply fan" annotation (Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-106,-10})));
  Modelica.Blocks.Sources.BooleanExpression onAdiaExp(y=on and TSet < TIehInSup
         and (pre(onAdiaExp.y) or TSet < TIehOutSup))
    "Indirect evaporative cooling status"
    annotation (Placement(transformation(extent={{-100,50},{14,70}})));
  Modelica.Blocks.Sources.BooleanExpression onChiExp(y=on and onDelAdi.y and TSet <
        TIehOutSup and (pre(onChiExp.y) or TSet + 0.1 < TIehOutSup))
    "Active chiller status"
    annotation (Placement(transformation(extent={{-100,28},{14,46}})));
  Modelica.Blocks.Interfaces.RealInput TIehOutSup
    "Temperature of IEH supply outlet" annotation (Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-106,-40})));
  Modelica.Blocks.Interfaces.RealInput TIehInSup
    "Temperature of IEH supply inlet" annotation (Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-106,-70})));
  Modelica.Blocks.MathBoolean.OnDelay onDelAdi(delayTime=5*tau)
    "On delay before compressor may be activated"
    annotation (Placement(transformation(extent={{28,56},{36,64}})));
  Modelica.Blocks.Sources.BooleanExpression revAct(y=onAdiaExp.y or onChiExp.y or
        TIehOutSup < TIehInSup) "Reverse action"
    annotation (Placement(transformation(extent={{-100,38},{14,58}})));
  IDEAS.Airflow.AHU.BaseClasses.LimPidAdsolair damPid(
    useRevActIn=true,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=120,
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    y_off=0,
    useKIn=true)
               "PI controller for dampers"
    annotation (Placement(transformation(extent={{30,0},{40,10}})));
  Modelica.Blocks.Math.Abs absdT
    "Absolute temperature difference between inlet streams"
    annotation (Placement(transformation(extent={{-2,0},{8,10}})));
  Modelica.Blocks.Math.Add add(k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{-16,0},{-6,10}})));
  Modelica.Blocks.Interfaces.RealInput TEvaOut "Evaporator outlet temperature"
    annotation (Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-106,-100})));
  Modelica.Blocks.Sources.RealExpression yBypTopExp(y=if not onAdiaExp.y and on
         and not onChiExp.y then 1 - damPid.y else 0)
    "Real expression for connecting to output"
    annotation (Placement(transformation(extent={{40,92},{80,104}})));
  Modelica.Blocks.Sources.RealExpression yRecTopExp(y=if on then 1 else 0)
    "Real expression for connecting to output"
    annotation (Placement(transformation(extent={{40,74},{80,86}})));
  Modelica.Blocks.Sources.RealExpression recupBoty(y=if on then (if onChiExp.y
         then 1 else min(2*damPid.y, 1)) else 0)
    "Real expression for connecting to output"
    annotation (Placement(transformation(extent={{40,52},{92,68}})));
  Modelica.Blocks.Sources.RealExpression bypassBoty(y=if on then (if onChiExp.y
         then 0 else min(2 - 2*damPid.y, 1)) else 0)
    "Real expression for connecting to output"
    annotation (Placement(transformation(extent={{40,32},{92,48}})));
  Modelica.Blocks.Interfaces.RealOutput yBypTop
    "Control signal of top bypass damper"
    annotation (Placement(transformation(extent={{100,88},{120,108}})));
  Modelica.Blocks.Interfaces.RealOutput yRecTop
    "Control signal of top IEH damper"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput yRecBot
    "Control signal of bottom IEH damper"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput yBypBot
    "Control signal of bottom bypass damper"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.BooleanOutput onAdia
    "Indirect evaporative cooling status" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,-30})));
  Modelica.Blocks.Interfaces.BooleanOutput onChi "Chiller status" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,-70})));
  IDEAS.Airflow.AHU.BaseClasses.LimPidAdsolair chiPid(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=180,
    yMax=1,
    yMin=0,
    revActPar=true,
    y_off=0.6,
    useKIn=false,
    k=0.1)    "Pi controller for chiller compressor"
    annotation (Placement(transformation(extent={{30,-24},{40,-14}})));
  Modelica.Blocks.Interfaces.RealOutput mod
    "Modulation signal of chiller compressor"
    annotation (Placement(transformation(extent={{100,-10},{140,30}})));
  Utilities.Math.InverseXRegularized inverseXRegularized(delta=0.1)
    annotation (Placement(transformation(extent={{14,0},{24,10}})));
equation
  connect(onDelAdi.u, onAdiaExp.y) annotation (Line(points={{26.4,60},{19.7,60}},
                color={255,0,255}));
  connect(add.u2, TEvaOut) annotation (Line(points={{-17,2},{-22,2},{-22,-100},{
          -106,-100}},
                  color={0,0,127}));
  connect(TIehInSup, add.u1) annotation (Line(points={{-106,-70},{-24,-70},{-24,
          8},{-17,8}},color={0,0,127}));
  connect(damPid.on, onChiExp.y)
    annotation (Line(points={{33,10},{33,37},{19.7,37}},   color={255,0,255}));
  connect(revAct.y, damPid.revActIn)
    annotation (Line(points={{19.7,48},{35,48},{35,10}}, color={255,0,255}));
  connect(yBypTopExp.y, yBypTop)
    annotation (Line(points={{82,98},{94,98},{110,98}}, color={0,0,127}));
  connect(yRecTopExp.y, yRecTop)
    annotation (Line(points={{82,80},{110,80}}, color={0,0,127}));
  connect(recupBoty.y, yRecBot)
    annotation (Line(points={{94.6,60},{99.3,60},{110,60}}, color={0,0,127}));
  connect(bypassBoty.y, yBypBot)
    annotation (Line(points={{94.6,40},{100.3,40},{110,40}}, color={0,0,127}));
  connect(damPid.u_s, TSet)
    annotation (Line(points={{29,5},{29,20},{-106,20}}, color={0,0,127}));
  connect(damPid.u_m, TFanOutSup)
    annotation (Line(points={{35,-1},{35,-10},{-106,-10}}, color={0,0,127}));
  connect(onAdiaExp.y, onAdia) annotation (Line(points={{19.7,60},{18,60},{18,26},
          {18,24},{120,24},{120,-30}}, color={255,0,255}));
  connect(onChi, onChiExp.y) annotation (Line(points={{120,-70},{19.7,-70},{19.7,
          37}}, color={255,0,255}));
  connect(absdT.u, add.y) annotation (Line(points={{-3,5},{-5.5,5}},
        color={0,0,127}));
  connect(chiPid.on, onChiExp.y) annotation (Line(points={{33,-14},{28,-14},{19.7,
          -14},{19.7,37}},                color={255,0,255}));
  connect(chiPid.u_m, TFanOutSup) annotation (Line(points={{35,-25},{-40,-25},{-40,
          -10},{-106,-10}}, color={0,0,127}));
  connect(chiPid.u_s, TSet) annotation (Line(points={{29,-19},{-38,-19},{-38,20},
          {-106,20}}, color={0,0,127}));
  connect(chiPid.y, mod) annotation (Line(points={{40.5,-19},{60,-19},{60,10},{120,
          10}}, color={0,0,127}));
  connect(absdT.y, inverseXRegularized.u) annotation (Line(points={{8.5,5},{11.25,
          5},{11.25,5},{13,5}}, color={0,0,127}));
  connect(inverseXRegularized.y, damPid.kIn) annotation (Line(points={{24.5,5},{
          27.25,5},{27.25,8},{29,8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end AdsolairController;
