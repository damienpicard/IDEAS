within IDEAS.Buildings.Components.Interfaces;
expandable connector SolBus
  "Bus containing solar radiation for various incidence angles"
  extends Modelica.Icons.SignalBus;

  Real iSolDir(start=100);
  Real iSolDif(start=100);

  Modelica.SIunits.Angle angZen;
  Modelica.SIunits.Angle angAzi;
  Modelica.SIunits.Angle angInc;

  Modelica.SIunits.Temperature Tenv(start=293.15);

  Real hTenvTe(unit="W/m2") "Input for linearization = hConExt*(Tenv-Te)";
  Real hSolTot(unit="W2/(m2.K)")
    "Input for linearization = hConExt*(iSolDir + iSolDif)";
end SolBus;
