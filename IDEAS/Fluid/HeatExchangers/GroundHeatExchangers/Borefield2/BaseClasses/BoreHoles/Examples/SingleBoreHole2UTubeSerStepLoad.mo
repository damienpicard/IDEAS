within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield2.BaseClasses.BoreHoles.Examples;
model SingleBoreHole2UTubeSerStepLoad "SingleBoreHoleSer with step input load "
  import IDEAS;
  extends
    IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield2.BaseClasses.BoreHoles.Examples.Interfaces.partial_SingleBoreHoleStepLoad(
    redeclare
      IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Data.ConfigurationData.GeneralTrt2UTube
      gen,
    redeclare
      IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Data.FillingData.FillingTrt
      fil,
    redeclare
      IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Data.SoilData.SoilTrt soi);

  replaceable SingleBoreHolesInSerie2UTube                                                                    borHolSer(
    redeclare package Medium = Medium,
    soi=soi,
    fil=fil,
    gen=gen,
    m_flow_nominal=gen.m_flow_nominal_bh,
    dp_nominal=gen.dp_nominal)
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
  annotation (
    __Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/HeatExchangers/Boreholes/Examples/UTube.mos"
        "Simulate and plot"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
                   graphics),
    experimentSetupOutput,
    Diagram,
    Documentation(info="<html>
<p>

</p>
</html>", revisions="<html>
<ul>
</ul>
</html>"),
    experiment(
      StopTime=360000,
      Tolerance=1e-005,
      __Dymola_Algorithm="Dassl"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
        graphics));
end SingleBoreHole2UTubeSerStepLoad;
