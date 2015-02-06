within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.BoreHoles.Interface;
partial model PartialBoreHoleElement

  parameter Data.Records.Soil soi = IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.SoilData.SandStone()
    "Thermal properties of the ground"
    annotation (Placement(transformation(extent={{-46,-116},{-26,-96}})));
  parameter Data.Records.Filling fil = IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.FillingData.Bentonite()
    "Thermal properties of the filling material"
    annotation (Placement(transformation(extent={{-22,-116},{-2,-96}})));
  parameter Data.Records.General gen = IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.GeneralData.c8x1_h110_b5_d3600_T283()
    "General charachteristics of the borefield"
    annotation (Placement(transformation(extent={{2,-116},{22,-96}})));
end PartialBoreHoleElement;
