within IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.BoreHoles.BaseClasses;
function doubleUTubeResistances
  "Thermal resistances for double U-tube, according to Zeng et al. (2003) and Bauer et al (2010)"
  extends
    IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.BaseClasses.BoreHoles.BaseClasses.partialBoreholeResistances(
                                                                                                    kSoi=2.19, kFil=2.32, kTub=0.38,sha=1.3*0.0343, rBor=0.15/2,rTub=0.032,eTub=0.0023,hSeg=75,use_Rb=false,Rb=0);

    // kSoi=1.87, kFil=2.2, kTub=0.35,sha=0.085/2, rBor=0.080,rTub=0.032,eTub=0.0029,hSeg=75,use_Rb=false,Rb=0
    //
    //     rBor=0.15/2,
    // hBor=40,
    // nbBh=1,
    // nbSer=1,
    // cooBh={{0,0}},
    // rTub=0.025,
    // kTub=0.38,
    // eTub=0.0023,
    // xC=rBor/3,
    // T_start=273.15+11.28,
    // tStep=600);

  // Outputs
  output Modelica.SIunits.ThermalResistance Rgb
    "Thermal resistance between a grout capacity and the borehole wall, as defined by Bauer et al (2010)";
  output Modelica.SIunits.ThermalResistance Rgg1
    "Thermal resistance between two neightbouring grout capacities, as defined by Bauer et al (2010)";
  output Modelica.SIunits.ThermalResistance Rgg2
    "Thermal resistance between two  grout capacities opposite to each other, as defined by Bauer et al (2010)";
  output Modelica.SIunits.ThermalResistance RCondGro
    "Thermal resistance between a pipe wall and the grout capacity, as defined by Bauer et al (2010)";
protected
  Real R11(unit="(m.K)/W")
    "Thermal resistance between pipe wall and borehole wall, as defined by Zeng et al. (2003)";
  Real R12(unit="(m.K)/W")
    "Thermal resistance between two neighbouring pipes, as defined by Zeng et al. (2003)";
  Real R13(unit="(m.K)/W")
    "Thermal resistance between two pipes opposite to each other, as defined by Zeng et al. (2003)";

  Real Ra( unit="(m.K)/W");

  Real Rg(unit="(m.K)/W");
  Real Rar1(unit="(m.K)/W");
  Real Rar2(unit="(m.K)/W");
algorithm
  R11 :=RCondPipe + 1/2/Modelica.Constants.pi/kFil*( Modelica.Math.log(rBor/
    (rTub + eTub)) - (kFil - kSoi)/(kFil + kSoi)*Modelica.Math.log((rBor^2 -
    sha^2)/rBor^2));
  R12 :=1/2/Modelica.Constants.pi/kFil*(Modelica.Math.log(rBor/(sqrt(2)*
    sha)) - (kFil - kSoi)/(2*kFil + 2*kSoi)*Modelica.Math.log((rBor^4 + sha^4)/
    rBor^4));
  R13 :=1/2/Modelica.Constants.pi/kFil*(Modelica.Math.log(rBor/(2*sha)) - (
    kFil - kSoi)/(kFil + kSoi)*Modelica.Math.log((rBor^2 - sha^2)/rBor^2));

  Rb_internal :=if use_Rb then Rb else (R11 + 2*R12 + R13); // surprising that factor 1/4 is not include!
  Ra :=2*(R11 - R12);

  // ------ Calculation according to Bauer et al. (2010)
  Rg :=4*Rb_internal - RCondPipe;
  Rar1 :=(2 + sqrt(2))*Rg*(Ra - RCondPipe)/(Rg + Ra - RCondPipe);
  Rar2 :=sqrt(2)*Rar1;

//   1/2/Modelica.Constants.pi/kFil*(Modelica.Math.log(rBor/(rTub +
//     eTub)) + 0.5*Modelica.Math.log(sqrt(2)*sha/(rTub + eTub)) - 0.25*
//     Modelica.Math.log(2*sha/(rTub + eTub)) - 0.25*Modelica.Math.log(1 - sha^8/
//     rBor^8)) + RCondPipe/4;

  Modelica.Utilities.Streams.print(String(Rb_internal)  +  "  \n" + String(Ra));

   x :=1;
  // ********** Resistances and capacity location according to Bauer **********
   while test == false and i <= 10 loop
     // Capacity location (with correction factor in case that the test is negative)
     x := Modelica.Math.log(sqrt(rBor^2 + 4*(rTub + eTub)^2)/(2*sqrt(2)*(rTub + eTub)))/
       Modelica.Math.log(rBor/(2*(rTub + eTub)))*((15 - i + 1)/15);

     //Thermal resistance between the grout zone and bore hole wall
     Rgb := ((1 - x)*Rg)/hSeg;

     //Thermal resistance between the two grout zones
     Rgg1 := 2*Rgb*(Rar1 - 2*x*Rg)/(2*Rgb - Rar1 + 2*x*Rg);
     Rgg2 := 2*Rgb*(Rar2 - 2*x*Rg)/(2*Rgb - Rar2 + 2*x*Rg);

     // Thermodynamic test to check if negative R values make sense. If not, decrease x-value.
     // fixme: the implemented is only for single U-tube BHE's.
     test := (((1/Rgg1 + 1/2/Rgb)^(-1) > 0) and ((1/Rgg2 + 1/2/Rgb)^(-1) > 0));
     i := i + 1;
   end while;
   assert(test,
   "Maximum number of iterations exceeded. Check the borehole geometry.
   The tubes may be too close to the borehole wall.
   Input to the function
   IDEAS.Fluid.HeatExchangers.Boreholes.BaseClasses.singleUTubeResistances
   is
            hSeg = " + String(hSeg) + " m
            rBor = " + String(rBor) + " m
            rTub = " + String(rTub) + " m
            eTub = " + String(eTub) + " m
            kSoi = " + String(kSoi) + " W/m/K
            kFil = " + String(kFil) + " W/m/K
            kTub = " + String(kTub) + " W/m/K
   Computed x    = " + String(x) + " K/W
            Rgb  = " + String(Rgb) + " K/W
            Rgg1  = " + String(Rgg1) + " K/W
            Rgg2  = " + String(Rgg2) + " K/W");

  //Conduction resistance in grout from pipe wall to capacity in grout
  RCondGro := x*Rg + RCondPipe/hSeg;

  annotation (Diagram(graphics), Documentation(info="<html>
<p>
This model computes the different thermal resistances present in a single-U-tube borehole 
using the method of Bauer et al. [1].
It also computes the fluid-to-ground thermal resistance <i>R<sub>b</sub></i> 
and the grout-to-grout thermal resistance <i>R<sub>a</sub></i> 
as defined by Hellstroem [2] using the multipole method.
</p>
<p>
The figure below shows the thermal network set up by Bauer et al.
</p>
<p align=\"center\">
<img alt=\"image\" src=\"E:/work\\modelica/DaPModels/Images/Documentation/Bauer_singleUTube_small.png\"/>
</p>
<p>
The different resistances are calculated with following equations:</p>
<p align=\"center\">
<img alt=\"image\" src=\"E:/work\\modelica/DaPModels/Images/Documentation/Bauer_resistanceValues.PNG\"/>
</p>
<p>
Notice that each resistance each resistance still needs to be divided by 
the height of the borehole segment <i>h<sub>Seg</sub></i>.
</p>
<p>
The fluid-to-ground thermal resistance <i>R<sub>b</sub></i> and the grout-to-grout resistance <i>R<sub>a</sub></i> 
are calculated with the multipole method (Hellstroem (1991)) shown below.
</p>
<p>
<!-- If this is an equation, it needs to be typed, not an image -->
<img alt=\"image\" src=\"E:/work\\modelica/DaPModels/Images/Documentation/Rb_multipole.png\"/>
</p>
<p>
<!-- If this is an equation, it needs to be typed, not an image -->
<img alt=\"image\" src=\"E:/work\\modelica/DaPModels/Images/Documentation/Ra_multipole.png\"/>
</p>
<p>
where 
<!-- fixme: use greek symbols such as &lambda; -->
<i>lambda<sub>b</sub></i> and <i>lambda</i>are the conductivity of the filling material 
and of the ground respectively, 
<i>r<sub>p</sub></i> and <i>r<sub>b</sub></i> 
are the pipe and the borehole radius, 
<i>D</i> is the shank spacing (center of borehole to center of pipe), 
<i>R<sub>p</sub></i> is resistance from the fluid to the outside wall of the pipe, 
<i>r<sub>c</sub></i> is the radius at which the ground temperature is radially uniform and 
<i>Epsilon</i> can be neglected as it is close to zero.
</p>
<h4>References</h4>
<p>G. Hellstr&ouml;m. 
<i>Ground heat storage: thermal analyses of duct storage systems (Theory)</i>. 
Dept. of Mathematical Physics, University of Lund, Sweden, 1991.
</p>
<p>D. Bauer, W. Heidemann, H. M&uuml;ller-Steinhagen, and H.-J. G. Diersch. 
<i>Thermal resistance and capacity models for borehole heat exchangers</i>. 
International Journal Of Energy Research, 35:312&ndash;320, 2010.</p>
</html>", revisions="<html>
<p>
<ul>
<li>
February 14, 2014 by Michael Wetter:<br/>
Added an assert statement to test for non-physical values.
</li>
<li>
February 12, 2014, by Damien Picard:<br/>
Remove the flow dependency of the resistances, as this function calculates the conduction resistances only.
</li>
<li>
January 24, 2014, by Michael Wetter:<br/>
Revised implementation.
</li>
<li>
January 23, 2014, by Damien Picard:<br/>
First implementation.
</li>
</ul></p>
</html>"));
end doubleUTubeResistances;
