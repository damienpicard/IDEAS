within IDEAS.Buildings.Components.BaseClasses;
package LinExamples
  extends Modelica.Icons.ExamplesPackage;
  model AirLeakage
    import IDEAS;
    package Medium =
          Modelica.Media.Air.SimpleAir(T_min=273.15-50);
    IDEAS.Buildings.Components.BaseClasses.AirLeakage airLeakage(redeclare
        package Medium =Medium,
      m_flow_nominal=1,
      V=1,
      n50=1)
      annotation (Placement(transformation(extent={{-20,-14},{0,6}})));
    IDEAS.Fluid.Sources.Boundary_pT bou(         redeclare package Medium =
          Medium,
      nPorts=2,
      use_T_in=true)
      annotation (Placement(transformation(extent={{-64,-12},{-44,8}})));
    inner IDEAS.SimInfoManager sim(use_lin=true)
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    Modelica.Blocks.Interfaces.RealInput Te(start=293.15)
      annotation (Placement(transformation(extent={{-130,-20},{-90,20}})));
    IDEAS.Fluid.Sensors.TemperatureTwoPort senTem_out(redeclare package Medium
        = Medium, m_flow_nominal=1)
      annotation (Placement(transformation(extent={{16,-14},{36,6}})));
    Modelica.Blocks.Interfaces.RealOutput T_out
      "Temperature of the passing fluid"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealInput T_in1
      "Prescribed boundary temperature"
      annotation (Placement(transformation(extent={{-128,20},{-88,60}})));
  equation
          connect(Te,sim.Te_in);
    connect(airLeakage.port_b, senTem_out.port_a) annotation (Line(
        points={{0,-4},{16,-4}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(senTem_out.port_b, bou.ports[1]) annotation (Line(
        points={{36,-4},{48,-4},{48,-50},{-44,-50},{-44,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(airLeakage.port_a, bou.ports[2]) annotation (Line(
        points={{-20,-4},{-44,-4}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(senTem_out.T, T_out) annotation (Line(
        points={{26,7},{26,20},{80,20},{80,0},{110,0}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(bou.T_in, T_in1) annotation (Line(
        points={{-66,2},{-80,2},{-80,40},{-108,40}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end AirLeakage;

  model airLeakageTest
    AirLeakage airLeakage
      annotation (Placement(transformation(extent={{-10,30},{10,50}})));
    Modelica_LinearSystems2.Controller.StateSpace stateSpace(
      blockType=Modelica_LinearSystems2.Controller.Types.BlockTypeWithGlobalDefault.Continuous,
      initType=Modelica_LinearSystems2.Controller.Types.InitWithGlobalDefault.InitialState,
      x_start=293.15*ones(stateSpace.nx),
      system=Modelica_LinearSystems2.StateSpace.Import.fromFile(
          "dslin_airLeakageTest.mat", "ABCD"))
      annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
    inner SimInfoManager sim
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Te)
      annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
    Modelica.Blocks.Sources.Constant const(k=293.15)
      annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  equation
    connect(realExpression.y, airLeakage.Te) annotation (Line(
        points={{-39,40},{-11,40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression.y, stateSpace.u[1]) annotation (Line(
        points={{-39,40},{-26,40},{-26,-30},{-12,-30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(const.y, airLeakage.T_in1) annotation (Line(
        points={{-39,70},{-22,70},{-22,44},{-10.8,44}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(const.y, stateSpace.u[2]) annotation (Line(
        points={{-39,70},{-22,70},{-22,-30},{-12,-30}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics));
  end airLeakageTest;

  model ExteriorConvection
    import IDEAS;
    IDEAS.Buildings.Components.BaseClasses.ExteriorConvection extConv(A=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
      fixedTemperature
      annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
    Modelica.Blocks.Interfaces.RealInput T
      annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
    Modelica.Blocks.Interfaces.RealInput Te
      annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
    Modelica.Blocks.Interfaces.RealInput hConExt
      "Exterior convective heat transfer coefficient"
      annotation (Placement(transformation(extent={{-120,-48},{-80,-8}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=extConv.port_a.Q_flow)
      annotation (Placement(transformation(extent={{60,-10},{80,10}})));
    Modelica.Blocks.Interfaces.RealOutput QFlow "Value of Real output"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  equation
    connect(fixedTemperature.port, extConv.port_a) annotation (Line(
        points={{-20,20},{-14,20},{-14,0},{-10,0}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(fixedTemperature.T, T) annotation (Line(
        points={{-42,20},{-80,20},{-80,40},{-100,40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(extConv.Te, Te) annotation (Line(
        points={{-10,-4.8},{-46,-4.8},{-46,-6},{-80,-6},{-80,0},{-100,0}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(extConv.hConExt, hConExt) annotation (Line(
        points={{-10,-9},{-20,-9},{-20,-28},{-100,-28}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression.y, QFlow) annotation (Line(
        points={{81,0},{110,0}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics));
  end ExteriorConvection;

  model ExteriorConvection_lin
    import IDEAS;
    parameter Real A = 1;
    parameter Real hConExt_mean = 5.6;
    parameter Real Te_mean = 273.15+10.85;
    parameter Real T_mean = 285;

    Modelica.Blocks.Interfaces.RealInput T
      annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
    Modelica.Blocks.Interfaces.RealInput Te
      annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
    Modelica.Blocks.Interfaces.RealInput hConExt
      "Exterior convective heat transfer coefficient"
      annotation (Placement(transformation(extent={{-120,-48},{-80,-8}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=Q_flow)
      annotation (Placement(transformation(extent={{60,-10},{80,10}})));
    Modelica.Blocks.Interfaces.RealOutput QFlow "Value of Real output"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    Real Q_flow;
  equation

    Q_flow = A* ( hConExt * T_mean + hConExt_mean * T - 2*hConExt_mean*T_mean - hConExt*Te) + hConExt_mean*T_mean;
    connect(realExpression.y, QFlow) annotation (Line(
        points={{81,0},{110,0}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end ExteriorConvection_lin;

  model exteriorConvection_test

    ExteriorConvection extCon
      annotation (Placement(transformation(extent={{-10,50},{10,70}})));
    ExteriorConvection_lin extCon_lin
      annotation (Placement(transformation(extent={{-10,20},{10,40}})));
    inner SimInfoManager sim(numAzi=4)
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    ExteriorConvection extCon1
      annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
    ExteriorConvection_lin extCon_lin1
      annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=sim.weaBus.Te)
      annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=sim.weaBus.hConExt)
      annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
    Modelica.Blocks.Sources.Constant const(k=273.15 + 10.85 + 5)
      annotation (Placement(transformation(extent={{8,78},{-12,98}})));
    Modelica.Blocks.Math.Add absErr1(k2=-1)
      annotation (Placement(transformation(extent={{40,36},{60,56}})));
    Modelica.Blocks.Math.Add absErr2(k2=-1)
      annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
    OuterWall outerWall(
      insulationThickness=0.05,
      AWall=1,
      inc=1.5707963267949,
      azi=0)
      annotation (Placement(transformation(extent={{-30,-98},{-20,-78}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature
      annotation (Placement(transformation(extent={{34,-94},{14,-74}})));
    Interfaces.ZoneBus
            propsBus_a(numAzi=sim.numAzi) "Inner side (last layer)"
                       annotation (Placement(transformation(
          extent={{-6,-10},{6,10}},
          rotation=-90,
          origin={-4,-84}),iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={50,40})));
    Modelica.Blocks.Sources.RealExpression Ta_outWall(y=outerWall.layMul.port_a.T)
      annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
    Modelica.Blocks.Math.Product relErr1
      annotation (Placement(transformation(extent={{72,72},{92,52}})));
    Utilities.Math.InverseXRegularized inverseXRegularized(delta=1)
      annotation (Placement(transformation(extent={{40,70},{60,90}})));
    Utilities.Math.InverseXRegularized inverseXRegularized1(delta=1)
      annotation (Placement(transformation(extent={{40,-20},{60,0}})));
    Modelica.Blocks.Math.Product relErr2
      annotation (Placement(transformation(extent={{72,-14},{92,-34}})));

    Real cumErr(unit="J/m2");
    Modelica.Blocks.Continuous.Filter filter1(
                                             f_cut=5/3.14/2/60)
      annotation (Placement(transformation(extent={{72,-70},{92,-50}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(
                                                          y=sim.weaBus.Te)
      annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=sim.weaBus.hConExt)
      annotation (Placement(transformation(extent={{-80,-68},{-60,-48}})));
    Modelica.Blocks.Sources.RealExpression cumulativeErr2(y=cumErr)
      annotation (Placement(transformation(extent={{70,-100},{90,-80}})));
  equation

    der(cumErr)=filter1.y;

    connect(realExpression.y, extCon.Te) annotation (Line(
        points={{-59,60},{-10,60}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression1.y, extCon.hConExt) annotation (Line(
        points={{-59,40},{-32,40},{-32,57.2},{-10,57.2}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression.y, extCon_lin.Te) annotation (Line(
        points={{-59,60},{-20,60},{-20,30},{-10,30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression1.y, extCon_lin.hConExt) annotation (Line(
        points={{-59,40},{-32,40},{-32,27.2},{-10,27.2}},
        color={0,0,127},
        smooth=Smooth.None));

    connect(const.y, extCon.T) annotation (Line(
        points={{-13,88},{-16,88},{-16,64},{-10,64}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(extCon_lin.T, extCon.T) annotation (Line(
        points={{-10,34},{-16,34},{-16,64},{-10,64}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(extCon_lin1.T, extCon1.T) annotation (Line(
        points={{-10,-56},{-16,-56},{-16,-26},{-10,-26}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(extCon.QFlow, absErr1.u1) annotation (Line(
        points={{11,60},{20,60},{20,52},{38,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(extCon_lin.QFlow, absErr1.u2) annotation (Line(
        points={{11,30},{20,30},{20,40},{38,40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(extCon1.QFlow, absErr2.u1) annotation (Line(
        points={{11,-30},{22,-30},{22,-34},{38,-34}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(extCon_lin1.QFlow, absErr2.u2) annotation (Line(
        points={{11,-60},{22,-60},{22,-46},{38,-46}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(propsBus_a.surfCon, fixedTemperature.port) annotation (Line(
        points={{-4,-84},{14,-84}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(propsBus_a.surfRad, fixedTemperature.port) annotation (Line(
        points={{-4,-84},{14,-84}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(propsBus_a.iSolDir, fixedTemperature.port) annotation (Line(
        points={{-4,-84},{14,-84}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(propsBus_a.iSolDif, fixedTemperature.port) annotation (Line(
        points={{-4,-84},{14,-84}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(propsBus_a, outerWall.propsBus_a) annotation (Line(
        points={{-4,-84},{-20,-84}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(propsBus_a.weaBus, sim.weaBus) annotation (Line(
        points={{-4,-84},{-4,-84},{-4,-100},{-100,-100},{-100,102},{-88.6,102},{-88.6,
            97.2}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(absErr1.y, relErr1.u1) annotation (Line(
        points={{61,46},{70,46},{70,56}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inverseXRegularized.y, relErr1.u2) annotation (Line(
        points={{61,80},{66,80},{66,68},{70,68}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(extCon.QFlow, inverseXRegularized.u) annotation (Line(
        points={{11,60},{20,60},{20,80},{38,80}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(extCon1.QFlow, inverseXRegularized1.u) annotation (Line(
        points={{11,-30},{22,-30},{22,-10},{38,-10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(inverseXRegularized1.y, relErr2.u2) annotation (Line(
        points={{61,-10},{64,-10},{64,-18},{70,-18}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(absErr2.y, relErr2.u1) annotation (Line(
        points={{61,-40},{64,-40},{64,-30},{70,-30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(filter1.u, absErr2.y) annotation (Line(
        points={{70,-60},{61,-60},{61,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Ta_outWall.y, extCon1.T) annotation (Line(
        points={{-59,-20},{-16,-20},{-16,-26},{-10,-26}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression2.y, extCon1.hConExt) annotation (Line(
        points={{-59,-40},{-30,-40},{-30,-32.8},{-10,-32.8}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(extCon_lin1.hConExt, extCon1.hConExt) annotation (Line(
        points={{-10,-62.8},{-30,-62.8},{-30,-32.8},{-10,-32.8}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression3.y, extCon_lin1.Te) annotation (Line(
        points={{-59,-58},{-38,-58},{-38,-60},{-10,-60}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(extCon1.Te, extCon_lin1.Te) annotation (Line(
        points={{-10,-30},{-38,-30},{-38,-60},{-10,-60}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Text(
            extent={{-66,92},{-24,78}},
            lineColor={0,0,0},
            textString="Perfectly linear"),
          Text(
            extent={{-86,4},{-44,-10}},
            lineColor={0,0,0},
            textString="\"Real\" boundary temperature for wall"),
          Line(
            points={{-88,14},{94,14}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-88,12},{94,12}},
            color={0,0,0},
            smooth=Smooth.None)}), __Dymola_Commands(file="modelica://IDEAS/IDEAS/Resources/Scripts/Dymola/Buildings/Components/BaseClasses/LinExamples/exteriorConvection.mos"
          "Simulate and plot"));
  end exteriorConvection_test;
end LinExamples;
