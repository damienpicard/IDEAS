within IDEAS.Examples.TwinHouses.BaseClasses.Data.Constructions;
record extwall_S_N
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    final mats={
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.ext_plaster(d=0.01),
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.ins_pu(d=0.12),
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.formerext_plast(d=0.03),
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.honeycomb_brick(d=0.3),
      IDEAS.Examples.TwinHouses.BaseClasses.Data.Materials.int_plaster(d=0.01)});
end extwall_S_N;
