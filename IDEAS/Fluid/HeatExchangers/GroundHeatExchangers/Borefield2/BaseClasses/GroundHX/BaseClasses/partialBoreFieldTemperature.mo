within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield2.BaseClasses.GroundHX.BaseClasses;
partial function partialBoreFieldTemperature
  import IDEAS;
  extends Modelica.Icons.Function;

  input IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Data.Records.General
    gen "General parameters of the borefield";
  input IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Data.Records.Soil soi
    "Soil parameters";
  input Integer t_d "Discrete time at which the temperature is calculated";

  output Modelica.SIunits.Temperature T "Borefield temperature";

end partialBoreFieldTemperature;
