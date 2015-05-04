within IDEAS;
model SimInfoManager
  "Simulation information manager for handling time and climate data required in each for simulation."
  extends PartialSimInfoManager(final useTmy3Reader = true);

equation
  Te = weaDat.cheTemDryBul.TOut;
  solDirPer=weaDat.cheDirNorRad.HOut;
  solDirHor = weaDat.cheGloHorRad.HOut - solDifHor;
  solDifHor = weaDat.cheDifHorRad.HOut;
  solGloHor = solDirHor + solDifHor;
  TeAv = Te;
  Tground=TdesGround;
  irr = weaDat.cheGloHorRad.HOut;
  summer = timMan.summer;
  relHum = weaDat.cheRelHum.relHumOut;
  TDewPoi = weaDat.cheTemDewPoi.TOut;
  timLoc = timMan.timLoc;
  timSol = timMan.timSol;
  timCal = timMan.timCal;

  if BesTest then
    Tsky = Te - (23.8 - 0.2025*(Te - 273.15)*(1 - 0.87*Fc));
    Va = 2.5;
    Fc = 0.2;
  else
    Tsky = weaDat.TBlaSky.TBlaSky;
    Va = weaDat.cheWinSpe.winSpeOut;
    Fc = weaDat.cheOpaSkyCov.nOut*0.87;
  end if;

  annotation (
    defaultComponentName="sim",
    defaultComponentPrefixes="inner",
    missingInnerMessage=
        "Your model is using an outer \"sim\" component. An inner \"sim\" component is not defined. For simulation drag IDEAS.SimInfoManager into your model.",
    Icon(graphics={
        Bitmap(extent={{22,-8},{20,-8}}, fileName="")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
            graphics),
    Documentation(info="<html>
</html>"));
end SimInfoManager;
