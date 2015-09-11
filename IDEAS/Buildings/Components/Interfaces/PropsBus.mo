within IDEAS.Buildings.Components.Interfaces;
expandable connector PropsBus "Bus to transfer wall properties"
  extends Modelica.Icons.SignalBus;

  Modelica.SIunits.Area area annotation ();
  Modelica.SIunits.Emissivity epsLw annotation ();
  Modelica.SIunits.Emissivity epsSw annotation ();

end PropsBus;
