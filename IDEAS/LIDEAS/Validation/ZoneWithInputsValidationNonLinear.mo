within IDEAS.LIDEAS.Validation;
model ZoneWithInputsValidationNonLinear "Model to validate the linearization method by simulating both the original model and the obtained state space model."
  extends Examples.ZoneWithInputsLinearise(
    sim(
      lineariseDymola=false,
      createOutputs=true), validation = true);
  Modelica.Blocks.Sources.Sine occQRad[2](
    freqHz=1/12/3600,
    startTime=7200,
    amplitude=20,
    offset=20) "Fake occupancy gains"
    annotation (Placement(transformation(extent={{40,-144},{60,-124}})));
  Modelica.Blocks.Sources.Sine occQCon[2](
    freqHz=1/6/3600,
    amplitude=80,
    offset=80) "Fake occupancy gains"
    annotation (Placement(transformation(extent={{40,-114},{60,-94}})));
  output Components.BaseClasses.Prescribed prescribedOut
    "Prescribed inputs which do not depend on the model states value (e.g. heat flow from occupancy)"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={100,-120})));
  Modelica.Blocks.Sources.RealExpression preInp[57](y={winBusOut[1].AbsQFlow[1],
        winBusOut[1].AbsQFlow[2],winBusOut[1].AbsQFlow[3],winBusOut[1].iSolDir,
        winBusOut[1].iSolDif,weaBusOut.solTim,weaBusOut.solBus[1].HDirTil,
        weaBusOut.solBus[1].HSkyDifTil,weaBusOut.solBus[1].HGroDifTil,weaBusOut.solBus[
        1].Tenv,weaBusOut.solBus[2].HDirTil,weaBusOut.solBus[2].HSkyDifTil,
        weaBusOut.solBus[2].HGroDifTil,weaBusOut.solBus[2].Tenv,weaBusOut.solBus[
        3].HDirTil,weaBusOut.solBus[3].HSkyDifTil,weaBusOut.solBus[3].HGroDifTil,
        weaBusOut.solBus[3].Tenv,weaBusOut.solBus[4].HDirTil,weaBusOut.solBus[4].HSkyDifTil,
        weaBusOut.solBus[4].HGroDifTil,weaBusOut.solBus[4].Tenv,weaBusOut.solBus[
        5].HDirTil,weaBusOut.solBus[5].HSkyDifTil,weaBusOut.solBus[5].HGroDifTil,
        weaBusOut.solBus[5].Tenv,weaBusOut.solBus[6].HDirTil,weaBusOut.solBus[6].HSkyDifTil,
        weaBusOut.solBus[6].HGroDifTil,weaBusOut.solBus[6].Tenv,weaBusOut.Te,
        weaBusOut.Tdes,weaBusOut.TGroundDes,weaBusOut.hConExt,weaBusOut.X_wEnv,
        weaBusOut.CEnv,weaBusOut.dummy,weaBusOut.TskyPow4,weaBusOut.TePow4,
        weaBusOut.solGloHor,weaBusOut.solDifHor,weaBusOut.F1,weaBusOut.F2,
        weaBusOut.angZen,weaBusOut.angHou,weaBusOut.angDec,weaBusOut.solDirPer,
        weaBusOut.phi,ctrlInputTestCon[1].y,ctrlInputTestCon[2].y,
        ctrlInputTestRad[1].y,ctrlInputTestRad[2].y,ctrlInputTestEmb[1].y,
        prescribedOut.QCon[1],prescribedOut.QCon[2],prescribedOut.QRad[1],
        prescribedOut.QRad[2]})    "Precomputed input values"
    annotation (Placement(transformation(extent={{-70,100},{-50,120}})));
  parameter String fileName = "ssm_ZoneWithInputsLinearise.mat";
  final parameter Integer nSta = Bsize[1] "Number of states";
  final parameter Integer nInp = Bsize[2] "Number of inputs";
  final parameter Integer nPreInp = size(preInp,1) "Number of precomputed inputs";
  final parameter Integer nOut = Csize[1] "Number of precomputed outputs";
   Modelica.Blocks.Continuous.StateSpace stateSpace(
     A=readMatrix(fileName=fileName, matrixName="A", rows=nSta, columns = nSta),
     B=readMatrix(fileName=fileName, matrixName="B", rows=nSta, columns = nInp),
     C=readMatrix(fileName=fileName, matrixName="C", rows=nOut, columns=nSta),
     D=readMatrix(fileName=fileName, matrixName="D", rows=nOut, columns=nInp),
     x_start=x_start,
    initType=Modelica.Blocks.Types.Init.NoInit)       "State space model"
     annotation (Placement(transformation(extent={{-40,100},{-20,120}})));
protected
  parameter Real x_start[nSta](each fixed=false) "Initial state values";
  final parameter Integer[2] Bsize = readMatrixSize(fileName=fileName, matrixName="B") "Size of B matrix of state space model";
  final parameter Integer[2] Csize = readMatrixSize(fileName=fileName, matrixName="C") "Size of C matrix of state space model";
public
  Modelica.Blocks.Sources.Sine ctrlInputTestCon[nZones](
    freqHz=1/1/3600,
    amplitude=30,
    offset=30)  "Fake occupancy gains"
    annotation (Placement(transformation(extent={{26,54},{38,66}})));
  Modelica.Blocks.Sources.Sine ctrlInputTestRad[nZones](
    freqHz=1/2/3600,
    amplitude=40,
    offset=40)       "Fake occupancy gains"
    annotation (Placement(transformation(extent={{26,34},{38,46}})));
  Modelica.Blocks.Sources.Sine ctrlInputTestEmb[nEmb](
    freqHz=1/16/3600,
    amplitude=60,
    offset=60)  "Fake occupancy gains"
    annotation (Placement(transformation(extent={{26,14},{38,26}})));
  Modelica.Blocks.Math.UnitConversions.To_degC TZon_ssm[nZones]
    "Zones temperature from the SSM"
    annotation (Placement(transformation(extent={{-10,100},{10,120}})));
  Modelica.Blocks.Math.UnitConversions.To_degC TZon[nZones]
    "Zones temperature from the zone models"
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Modelica.Blocks.Math.Add err[nZones](k2=-1)
    "Difference between the temperature of the zone models and the state space model outputs"
    annotation (Placement(transformation(extent={{40,100},{60,120}})));
initial algorithm
  x_start :={zone.airModel.TAir,window.heaCapGla.T,window.heaCapFra.T,zone1.airModel.TAir,
    commonWall.layMul.monLay[1].monLayDyn.T[1],commonWall.layMul.monLay[1].monLayDyn.T[
    2],commonWall.layMul.monLay[2].monLayDyn.T[1],commonWall.layMul.monLay[2].monLayDyn.T[
    2],commonWall.layMul.monLay[3].monLayDyn.T[1],commonWall.layMul.monLay[3].monLayDyn.T[
    2],commonWall.layMul.monLay[3].monLayDyn.T[3],floor.layMul.monLay[1].monLayDyn.T[
    1],floor.layMul.monLay[1].monLayDyn.T[2],floor.layMul.monLay[2].monLayDyn.T[
    1],floor.layMul.monLay[3].monLayDyn.T[1],floor.layMul.monLay[4].monLayDyn.T[
    1],floor.layMul.monLay[5].monLayDyn.T[1],slabOnGround.layMul.monLay[1].monLayDyn.T[
    1],slabOnGround.layMul.monLay[1].monLayDyn.T[2],slabOnGround.layMul.monLay[2].monLayDyn.T[
    1],slabOnGround.layMul.monLay[2].monLayDyn.T[2],slabOnGround.layMul.monLay[3].monLayDyn.T[
    1],slabOnGround.layMul.monLay[3].monLayDyn.T[2],slabOnGround.layGro.monLay[1].monLayDyn.T[
    1],slabOnGround.layGro.monLay[1].monLayDyn.T[2],slabOnGround.layGro.monLay[1].monLayDyn.T[
    3],slabOnGround.layGro.monLay[1].monLayDyn.T[4],slabOnGround.layGro.monLay[1].monLayDyn.T[
    5],slabOnGround.layGro.monLay[1].monLayDyn.T[6],slabOnGround.layGro.monLay[1].monLayDyn.T[
    7],slabOnGround.layGro.monLay[2].monLayDyn.T[1],slabOnGround.layGro.monLay[2].monLayDyn.T[
    2],slabOnGround.layGro.monLay[2].monLayDyn.T[3],slabOnGround.layGro.monLay[2].monLayDyn.T[
    4],slabOnGround.layGro.monLay[3].monLayDyn.T[1],slabOnGround.layGro.monLay[3].monLayDyn.T[
    2],outerWall.layMul.monLay[1].monLayDyn.T[1],outerWall.layMul.monLay[1].monLayDyn.T[
    2],outerWall.layMul.monLay[2].monLayDyn.T[1],outerWall.layMul.monLay[3].monLayDyn.T[
    1],outerWall.layMul.monLay[3].monLayDyn.T[2],commonWall1.layMul.monLay[1].monLayDyn.T[
    1],commonWall1.layMul.monLay[1].monLayDyn.T[2],commonWall1.layMul.monLay[2].monLayDyn.T[
    1],commonWall1.layMul.monLay[3].monLayDyn.T[1],commonWall1.layMul.monLay[3].monLayDyn.T[
    2]};


equation
  connect(occQCon.y, prescribedOut.QCon) annotation (Line(points={{61,-104},{61,
          -104},{100.1,-104},{100.1,-120.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(occQRad.y, prescribedOut.QRad) annotation (Line(points={{61,-134},{82,
          -134},{100.1,-134},{100.1,-120.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(preInp.y, stateSpace.u)
    annotation (Line(points={{-49,110},{-45.5,110},{-42,110}},
                                                            color={0,0,127}));
  connect(ctrlInputTestCon.y, preQFloCon.Q_flow)
    annotation (Line(points={{38.6,60},{58,60},{78,60}}, color={0,0,127}));
  connect(ctrlInputTestRad.y, preQFloRad.Q_flow)
    annotation (Line(points={{38.6,40},{58.3,40},{78,40}}, color={0,0,127}));
  connect(ctrlInputTestEmb.y, preQFloTabs.Q_flow)
    annotation (Line(points={{38.6,20},{80,20},{80,20}}, color={0,0,127}));
  connect(occQCon.y, occQFloCon.Q_flow) annotation (Line(points={{61,-104},{74,-104},
          {88,-104},{88,-60},{84,-60}}, color={0,0,127}));
  connect(occQRad.y, occQFloRad.Q_flow)
    annotation (Line(points={{61,-134},{84,-134},{84,-80}}, color={0,0,127}));
  connect(stateSpace.y, TZon_ssm.u)
    annotation (Line(points={{-19,110},{-16,110},{-12,110}}, color={0,0,127}));
  connect(TZon[1].u, zone.TSensor) annotation (Line(
      points={{-12,80},{-36,80},{-36,6},{62,6},{62,-10},{40.6,-10}},
      color={0,0,127},
      visible=false));
  connect(TZon[2].u, zone1.TSensor) annotation (Line(
      points={{-12,80},{-36,80},{-36,6},{150,6},{150,-60},{40.6,-60}},
      color={0,0,127},
      visible=false));
  connect(TZon_ssm.y, err.u1) annotation (Line(points={{11,110},{20,110},{20,116},
          {38,116}}, color={0,0,127}));
  connect(TZon.y, err.u2) annotation (Line(points={{11,80},{20,80},{20,104},{38,
          104}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-120,-160},{100,120}})), Icon(
        coordinateSystem(extent={{-120,-160},{100,120}})),
    experiment(StopTime=1e+006, __Dymola_NumberOfIntervals=1000), __Dymola_Commands(file="Resources/Scripts/Dymola/LIDEAS/Validation/ZoneWithInputsValidationNonLinear.mos"
        "Linearize, simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>May 15, 2018 by Damien Picard: <br>First implementation</li>
</ul>
</html>"));
end ZoneWithInputsValidationNonLinear;
