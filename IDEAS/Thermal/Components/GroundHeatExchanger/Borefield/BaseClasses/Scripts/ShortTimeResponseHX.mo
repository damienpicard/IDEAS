within IDEAS.Thermal.Components.GroundHeatExchanger.Borefield.BaseClasses.Scripts;
function ShortTimeResponseHX
    /* Remark: by calling the function, 3 "true" should appear for: \
      1) translation of model \
      2) simulation of model \
      3) writing the data \
      If you get a false, look for the error!
    */

  import SI = Modelica.SIunits;

  input String name=
      "example";
  input String modelToSimulate=
      "IDEAS.Thermal.Components.GroundHeatExchanger.Borefield.BaseClasses.BoreHoles.Examples.SingleBoreHoleSerStepLoad"
    "model to simulate";

  input Data.Records.Soil soi=Data.SoilData.example()
    "Thermal properties of the ground";
  input Data.Records.Filling fill=
      Data.FillingData.example() "Thermal properties of the filling material";
  input Data.Records.Geometry geo=
      Data.GeometricData.example() "Geometric charachteristic of the borehole";
  input Data.Records.Advanced adv=Data.Advanced.example() "Advanced parameters";
  input Data.Records.StepResponse steRes=
      Data.StepResponse.example() "generic step load parameter";

  input String savePath=
      "..\\IDEAS\\IDEAS\\Thermal\\Components\\GroundHeatExchanger\\Borefield\\Data\\ShortTermResponse\\";

  output Real[3,steRes.tBre_d + 1] readData;
protected
  Integer nbOfPoi=1000;
  String filPathAndName=savePath + name "path and name of file";
  String[2] variablesToStore={"borHolSer.sta_a.T","borHolSer.sta_b.T"}
    "variables to store in result file";
  SI.Time[1,steRes.tBre_d + 1] timVec={0:steRes.tStep:steRes.tBre_d*
      steRes.tStep} "time vector for which the data are saved";
  String[3] saveName;

algorithm
  //To ensure that the same number of data points is written in all result files
  //equidistant time grid is enabled and store variables at events is disabled.
  experimentSetupOutput(equdistant=true, events=false);

  //delete the result file if it already exists
  Modelica.Utilities.Files.removeFile(filPathAndName + "_sim");
  Modelica.Utilities.Files.removeFile(filPathAndName + "Data");

  translateModel(modelToSimulate +
    "(redeclare IDEAS.Thermal.Components.GroundHeatExchanger.Borefield.Data.SoilData." + soi.name + " soi" +
    ",redeclare IDEAS.Thermal.Components.GroundHeatExchanger.Borefield.Data.FillingData." + fill.name +
    " fill" + ",redeclare IDEAS.Thermal.Components.GroundHeatExchanger.Borefield.Data.GeometricData." +
    geo.name + " geo" +
    ",redeclare IDEAS.Thermal.Components.GroundHeatExchanger.Borefield.Data.StepResponse." + steRes.name +
    " steRes" + ",redeclare IDEAS.Thermal.Components.GroundHeatExchanger.Borefield.Data.Advanced." + adv.name +
    " adv)");

  // simulation for short time
  simulateModel(
      modelToSimulate,
      stopTime=steRes.tBre_d*steRes.tStep,
      numberOfIntervals=nbOfPoi,
      method="dassl",
      resultFile=filPathAndName + "_sim"); //

  // First columns are shorttime, last column is steady state
  readData := cat(
      1,
      timVec,
      interpolateTrajectory(
        filPathAndName + "_sim.mat",
        variablesToStore,
        timVec[1, :]));

   saveName := {"Time",variablesToStore[1],variablesToStore[2]};

  writeTrajectory(
      fileName=filPathAndName + "Data.mat",
      signals=saveName,
      values=transpose(readData));

end ShortTimeResponseHX;
