within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield2.BaseClasses.GroundHX;
model BoreFieldWallTemperature
  // FIXME: Massimo's model

  annotation (Documentation(info="<html>
  <p>Return the corrected average borehole wall temperature of the whole borefield in function of the discrete time step t_d.
  The correction is from t=0 till t_d = tBre. Input TResSho gives the vector with the correct temperatures for this time period.</p>
</html>", revisions="<html>
<ul>
<li>
July 2014, by Damien Picard:<br>
First implementation.
</li>
</ul>
</html>"));
end BoreFieldWallTemperature;
