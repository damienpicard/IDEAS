within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.BoreHoles.Interface;
partial model PartialSingleBoreHole "Single borehole heat exchanger"
//   replaceable package Medium =
//       Modelica.Media.Interfaces.PartialMedium "Medium in the component"
//       annotation (choicesAllMatching = true);
  extends PartialBoreHoleElement;
   extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface;
  //  (redeclare package
//       Medium =                                                                                   Medium);
  extends IDEAS.Fluid.Interfaces.TwoPortFlowResistanceParameters(
      computeFlowResistance=false, linearizeFlowResistance=false);
  extends IDEAS.Fluid.Interfaces.LumpedVolumeDeclarations;

  Modelica.SIunits.Temperature TWallAve "Average borehole temperature";

  parameter Boolean use_parallel = true
    "True if the 2U configuration is in parallel, False if in serie: FIXME: the Ra might be different for serie";
end PartialSingleBoreHole;
