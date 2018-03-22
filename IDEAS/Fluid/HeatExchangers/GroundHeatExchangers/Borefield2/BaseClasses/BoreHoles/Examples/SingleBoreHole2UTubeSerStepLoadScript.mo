within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield2.BaseClasses.BoreHoles.Examples;
model SingleBoreHole2UTubeSerStepLoadScript
  import IDEAS;
  extends
    IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield2.BaseClasses.BoreHoles.Examples.Interfaces.partial_SingleBoreHoleStepLoad(
    redeclare replaceable
      IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Data.ConfigurationData.GeneralTrt2UTube
      gen,
    redeclare replaceable
      IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Data.FillingData.FillingTrt
      fil,
    redeclare replaceable
      IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Data.SoilData.SoilTrt soi);

  replaceable SingleBoreHolesInSerie2UTube                                                                    borHolSer(
    redeclare package Medium = Medium,
    soi=soi,
    fil=fil,
    gen=gen,
    dp_nominal=gen.dp_nominal,
    m_flow_nominal=gen.m_flow_nominal_bh)
             constrainedby Interface.PartialSingleBoreholeSerie(
    redeclare package Medium = Medium,
     soi=soi,
     fil=fil,
     gen=gen) "NbSer boreholes in series"   annotation (Placement(transformation(
          extent={{-12,-58},{12,-34}}, rotation=0)));

equation
  connect(TSen_bor_in.port_b, borHolSer.port_a) annotation (Line(
      points={{-38,-46},{-12,-46}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TSen_bor_out.port_a, borHolSer.port_b) annotation (Line(
      points={{34,-46},{12,-46}},
      color={0,127,255},
      smooth=Smooth.None));

  annotation (experiment(
      StopTime=360000,
      Tolerance=1e-005,
      __Dymola_Algorithm="Dassl"), __Dymola_experimentSetupOutput(events=false));
end SingleBoreHole2UTubeSerStepLoadScript;
