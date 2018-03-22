within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield2.BaseClasses.BoreHoles.Interface;
partial model PartialBoreHoleElement
  import IDEAS;
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the component" annotation (choicesAllMatching=true);
  parameter Boolean dynFil=true
    "Set to false to remove the dynamics of the filling material."
    annotation (Dialog(tab="Dynamics"));

  IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Data.BorefieldData.ExampleBorefieldData
    borFieDat
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
equation
    assert(gen.rBor > gen.xC + gen.rTub + gen.eTub and
         0 < gen.xC - gen.rTub - gen.eTub,
         "The borehole geometry is not physical. Check rBor, rTub and xC to make sure that the tube is placed inside the halve of the borehole.");

end PartialBoreHoleElement;
