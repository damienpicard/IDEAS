within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.BoreHoles.Examples;
model SingleBoreHole2UTubeSerStepLoadScript2
  extends SingleBoreHoleUTubeSerStepLoadScript(
    redeclare SingleBoreHolesUTubeInSerie  borHolSer,
    redeclare Data.GeneralData.GeneralTrt
      gen,
    redeclare Data.FillingData.FillingTrt                                                           fil,
    redeclare Data.SoilData.SoilTrt                                                                soi,
    mFlo(k=gen.m_flow_nominal_bh*2));

  Modelica.SIunits.Temperature T_measured = 3.307*log(time+1)-6.2715+273.15;

  annotation (experiment(
      StopTime=360000,
      Tolerance=1e-005,
      __Dymola_Algorithm="Dassl"), __Dymola_experimentSetupOutput(events=false));
end SingleBoreHole2UTubeSerStepLoadScript2;
