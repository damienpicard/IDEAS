within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.BorefieldData;
record SandStone_Bentonite_c8x8_h110_b5_d600_T283 = Records.BorefieldData (
    pathMod=
        "IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.BorefieldData.SandStone_Bentonite_c8x8_h110_b5_d600_T283",

    pathCom=Modelica.Utilities.Files.loadResource(
        "modelica://IDEAS/Fluid/HeatExchangers/GroundHeatExchangers/Borefield/Data/BorefieldData/SandStone_Bentonite_c8x8_h110_b5_d600_T283.mo"),

    redeclare replaceable record Soi = SoilData.SandStone,
    redeclare replaceable record Fil = FillingData.Bentonite,
    redeclare replaceable record Gen = GeneralData.c8x8_h110_b5_d600_T283)
  "Borefield with 8x8 boreholes with Bentonite filling and Sandstone soil";
