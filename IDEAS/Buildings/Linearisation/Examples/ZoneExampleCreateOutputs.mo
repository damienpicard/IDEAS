within IDEAS.Buildings.Linearisation.Examples;
model ZoneExampleCreateOutputs
  extends ZoneExampleLinearise(sim(createOutputs=true, linearise=false));
  annotation (
    experiment(StopTime=1e+06),
    __Dymola_experimentSetupOutput(
      states=false,
      derivatives=false,
      inputs=false,
      auxiliaries=false,
      events=false),
    Documentation(info="<html>
<p>All required model inputs when linearising a model are generated by this example (see results). Make sure to set outputCPUtime=false first.</p>
</html>"),
    __Dymola_Commands(file="../../IDEAS/IDEAS/Resources/Scripts/Dymola/Buildings/Linearisation/Examples/ZoneExampleCreateOutputs.mos"
        "Simulate and Plot"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})));
end ZoneExampleCreateOutputs;
