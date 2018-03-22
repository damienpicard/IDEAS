within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield2.Examples;
model borefied8x1_2UTubeParallel_2Series
  import IDEAS;
  extends
    IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield2.Examples.borefield8x1
    (redeclare
      IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Data.BorefieldData.SandStone_Bentonite_c8x1_h110_b5_d600_T283_2UTubeParallel_2Series
      bfData, redeclare
      IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield2.borefield2UTube
      borFie);
  annotation (experiment(StopTime=3.1536e+007), __Dymola_experimentSetupOutput(
        events=false));
end borefied8x1_2UTubeParallel_2Series;
