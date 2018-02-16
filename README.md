IDEAS v1.0.0
============

Modelica model environment for Integrated District Energy Assessment Simulations (IDEAS), allowing simultaneous transient simulation of thermal and electrical systems at both building and feeder level.

### IDEAS v1.0.0
May 5th 2017: IDEAS v1.0.0 has been released.  
February 16th 2018: A [paper describing IDEAS v1.0.0](http://www.tandfonline.com/doi/full/10.1080/19401493.2018.1428361) has been published on line.

## Backward compatibility
Quite some backward incompatible changes have been performed. However, a conversion script is provided that fixes most of these. The conversion script prompt should occur automatically if your model or package 'uses' IDEAS version 3.0 before updating. Make sure you have a backup (e.g. using git) before running the conversion script.

The insulationType and insulationThickness parameters were removed from the wall/surface models. The insulation types and thicknesses will therefore need to be integrated manually into the construction types that you use. If the insulationthickness is zero or you did not use 'insulationType' in your construction records, then both parameters can just be removed.

## Release notes
Changes compared to v0.3 include but are not limited to:

0. IDEAS 1.0.0 is based on Annex 60 version 1.0.0
1. The IDEAS packages have been restructured to be more in line with the Annex 60 package structure.
..* IDEAS.Constants has been replaced by IDEAS.Types
..* The SimInfoManager has been moved to IDEAS.BoundaryConditions
..* Interfaces such as HeatingSystem and BaseCircuits have been moved to IDEAS.Templates
2. Setting up new Construction records has been simplified. Parameter values of nLay and nGain are now inferred from the other parameters and may therefore no longer be assigned.
3. Optional parameter incLastLay has been added to Construction records. Users may use this to double-check if InternalWalls are connected as intended.
4. The way how internal gains may be connected to surfaces has been changed.
5. Convection and thermal radiation equations have been tuned to be more accurate and faster.
6. Added an option to the zone model for evaluating thermal comfort.
7. Added an option to the zone model for computing the sensible and latent heat gains from occupants.
8. The zone air model is now replaceable such that custom models may be created.
9. A zone template has been added that allows to add a rectangular zone, including 4 walls, 4 optional windows, a floor and a ceiling.
10. Some variables have been renamed. A conversion script is provided for converting the user's models to accomodate these changes.
..* TStar has been renamed into TRad in the zone model.
..* flowPort_Out and flowPort_In have been renamed in the zone model, heating system, ventilaiton system and structure models.
..* Some Annex 60 models were renamed.
11. Added example model of a terraced house in IDEAS.Examples.PPD12
12. Added twin house validation models in IDEAS.Examples.TwinHouse
13. Added solar irradiation model for window frames.
14. Added optional thermal bridge model for windows.
15. Extended implementation of building shade model.
16. Fixed bug in view factor implementation.
17. Updated documentation for many models in IDEAS.Buildings
18. Added thermostatic valve model: IDEAS.Fluid.Actuators.Valves.TwoWayTRV
19. Removed insulationType and insulationThickness parameters. These should now be defined in the Construction records.
20. Harmonised implementation of Perez solar irradiation model with Annex 60 implementation.
21. Cleaned up implementation of BESTEST models.
22. Added new, specialised window types.
23. Added options for model linearisation.
24. Improved accuracy of model that computes internal longwave radiation.
25. Improved accuracy of model that computes exterior sky temperature.
26. Moved Electrical package into Experimental package since this package contains broken models.
27. Added unit tests for templates.
28. Added Menerga Adsolair model.

## Tool compatibility
The library is developed using Dymola. Furthermore, changes have been made such that the library can be read using OpenModelica. The building models can be simulated using JModelica too, although not everything is supported yet.

### IDEAS v0.3.0

IDEAS release v0.3 has been pushed on 2 september 2015. Major changes compared to v0.2 are:

1. Added code for checking conservation of energy
2. Added options for linear / non-linear radiative heat exchange and convection for exterior and interior faces of walls and floors/ceilings. Respective correlations have been changed.
3. Overall improvements resulting in more efficient code and less warnings.
4. The emissivity of window coatings must now be specified as a property of the solid (glass sheet) and not as a property of the gas between the glass sheets. This is only relevant if you create your own glazing.
5. Merged Annex 60 library up to commit d7749e3
6. Expanded unit tests
7. More correct implementation of Koschenz's model for TABS. Also added the option for discretising TABS sections.
8. Added new building shade components.
9. Removed inefficient code that would lead to numerical Jacobians in grid.
10. Added new AC and DC electrical models.



### License

The **IDEAS** package is licensed by [KU Leuven](http://www.kuleuven.be) and [3E](http://www.3e.eu) under the [Modelica License Version 2](https://www.modelica.org/licenses/ModelicaLicense2).

### Development and contribution

1. You may report any bugfixes or suggestions as a [github issue](https://github.com/open-ideas/IDEAS/issues).
2. Contributions in the form of [Pull Requests](https://help.github.com/articles/using-pull-requests) are always welcome. Prior to issuing a pull request, make sure :
    1. your code follows the [Style Guide and Conventions](https://github.com/open-ideas/IDEAS/wiki/Style%20Guide%20and%20GitHub%20Good%20Practice),
    2. you use this **IDEAS** GitHub repository as escribed in the [GitHub Good Practice Description](https://github.com/open-ideas/IDEAS/wiki/Style%20Guide%20and%20GitHub%20Good%20Practice)
    3. unittests are included for your models, and
    4. the model physics are described in the [Specifications](https://github.com/open-ideas/IDEAS/tree/master/Specifications).

### References
#### Development of IDEAS
1. **F. Jorissen, G. Reynders, R. Baetens, D. Picard, D. Saelens, and L. Helsen. (2018) [Implementation and Verification of the IDEAS Building Energy Simulation Library.](http://www.tandfonline.com/doi/full/10.1080/19401493.2018.1428361) *Journal of Building Performance Simulation*, doi: 10.1080/19401493.2018.1428361. Published on line**
2. R. Baetens, R. De Coninck, F. Jorissen, D. Picard, L. Helsen, D. Saelens (2015). OpenIDEAS - An Open Framework for Integrated District Energy Simulations. In Proceedings of Building Simulation 2015, Hyderabad, 347--354.
3. R. Baetens. (2015) On externalities of heat pump-based low-energy dwellings at the low-voltage distribution grid. PhD thesis, Arenberg Doctoral School, KU Leuven.
4. F. Jorissen, W. Boydens, and L. Helsen. (2017) Validated air handling unit model using indirect evaporative cooling. *Journal of Building Performance Simulation*, **11** (1), 48–64, doi: 10.1080/19401493.2016.1273391
5. R. Baetens, D. Saelens. (2016) Modelling uncertainty in district energy simulations by stochastic residential occupant behaviour. *Journal of Building Performance Simulation* **9** (4), 431–447, doi:10.1080/19401493.2015.1070203.
6. M. Wetter, M. Fuchs, P. Grozman, L. Helsen, F. Jorissen, M. Lauster, M. Dirk, C. Nytsch-geusen, D. Picard, P. Sahlin, and M. Thorade. (2015) IEA EBC Annex 60 Modelica Library - An International Collaboration to Develop a Free Open-Source Model Library for Buildings and Community Energy Systems. In Proceedings of Building Simulation 2015, Hyderabad, 395–402.

#### Applications of IDEAS
1. D. Picard. (2017) Modeling, optimal control and HVAC design of large buildings using ground source heat pump systems. PhD thesis, Arenberg Doctoral School, KU Leuven.
2. G. Reynders. (2015) Quantifying the impact of building design on the potential of structural storage for active demand response in residential buildings. PhD thesis, Arenberg Doctoral School, KU Leuven.
3. R. De Coninck. (2015) Grey-box based optimal control for thermal systems in buildings - Unlocking energy efficiency and flexibility. PhD thesis, Arenberg Doctoral School, KU Leuven.
4. G. Reynders, T. Nuytten, D. Saelens. (2013) Potential of structural thermal mass for demand-side management in dwellings. *Building and Environment* **64**, 187–199, doi:10.1016/j.buildenv.2013.03.010.
5. R. De Coninck, R. Baetens, D. Saelens, A. Woyte, L. Helsen (2014). Rule-based demand side management of domestic hot water production with heat pumps in zero energy neighbourhoods. *Journal of Building Performance Simulation*, **7** (4), 271-288.
6. R. Baetens, R. De Coninck, J. Van Roy, B. Verbruggen, J. Driesen, L. Helsen, D. Saelens (2012). Assessing electrical bottlenecks at feeder level for residential net zero-energy buildings by integrated system simulation. *Applied Energy*, **96**, 74-83.
7. F. Reynders, J. Diriken, D. Saelens. (2014) Quality of grey-box models and identified parameters as function of the accuracy of input and observation signals. *Energy & Buildings* **82**, 263–274, doi:10.1016/j.enbuild.2014.07.025.

#### Bibtex entry for citing IDEAS
@article{Jorissen2018ideas,  
author = {Jorissen, Filip and Reynders, Glenn and Baetens, Ruben and Picard, Damien and Saelens, Dirk and Helsen, Lieve},  
journal = {Journal of Building Performance Simulation},  
note = {Published on line},  
title = {{Implementation and Verification of the IDEAS Building Energy Simulation Library}},  
volume = {},  
doi={10.1080/19401493.2018.1428361},  
year = {2018}  
}
