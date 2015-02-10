within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.BoreHoles.Examples;
model SingleBoreHole2UTubeSerStepLoadScript2
  extends SingleBoreHoleUTubeSerStepLoadScript(
    redeclare SingleBoreHoles2UTubeInSerie borHolSer,
    redeclare
      SmartGeotherm.HeatingSystems.TerPotterie.BaseClasses.borefieldRecord.genTerPotterieTRT
      gen,
    redeclare
      SmartGeotherm.HeatingSystems.TerPotterie.BaseClasses.borefieldRecord.groutTerPotterie
                                                                                                    fil,
    redeclare
      SmartGeotherm.HeatingSystems.TerPotterie.BaseClasses.borefieldRecord.soilTerPotterie
                                                                                                   soi,
    mFlo(k=gen.m_flow_nominal_bh*2));

  Modelica.SIunits.Temperature TMea_ret = TRet_measured.y[1];
  Modelica.SIunits.Temperature TMea_in = TIn_measured.y[1];
  Modelica.Blocks.Sources.CombiTimeTable TIn_measured(
    tableOnFile=true,
    tableName="data",
    columns={2},
    offset={0},
    fileName="E:\\work\\modelica\\SmartGeotherm\\VerificationData\\TerPotterie\\TRT_time_inletTemp.txt")
    annotation (Placement(transformation(extent={{38,50},{58,70}})));
  Modelica.Blocks.Sources.CombiTimeTable TRet_measured(
    tableOnFile=true,
    tableName="data",
    columns={2},
    offset={0},
    fileName="E:\\work\\modelica\\SmartGeotherm\\VerificationData\\TerPotterie\\TRT_time_returnTemp.txt")
    annotation (Placement(transformation(extent={{38,80},{58,100}})));
  annotation (experiment(
      StopTime=360000,
      Tolerance=1e-005,
      __Dymola_Algorithm="Dassl"), __Dymola_experimentSetupOutput(events=false));
end SingleBoreHole2UTubeSerStepLoadScript2;
