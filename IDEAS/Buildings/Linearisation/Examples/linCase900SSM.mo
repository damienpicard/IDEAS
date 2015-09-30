within IDEAS.Buildings.Linearisation.Examples;
model linCase900SSM
  extends Modelica.Icons.Example;
  extends IDEAS.Buildings.Linearisation.Interfaces.StateSpaceModelInterface(ssm(
        fileName="linCase900_ssm.mat",
      nEmb=0,
      nQRad=0,
      nQConvGai=0,
      nWin=3,
      nQConv=1,
      nQRadGai=1));

  Components.LinWindow[3] win(
    final A={6,6,6},
    redeclare final parameter
      IDEAS.Buildings.Validation.Data.Glazing.GlaBesTest glazing,
    each inc=IDEAS.Constants.Wall,
    each azi=IDEAS.Constants.South,
    redeclare replaceable IDEAS.Buildings.Components.Shading.None shaType,
    redeclare final parameter IDEAS.Buildings.Data.Frames.None fraType,
    each frac=0,
    final indexWindow={1,2,3},
    removeDynamics=true) annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=0,
        origin={-45,62})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));

  Modelica.Blocks.Interfaces.RealOutput y_ssm[size(ssm.y, 1)]
    annotation (Placement(transformation(extent={{100,44},{120,64}})));
  Components.StateSpaceExtended rom5(fileName="linCase900_ssm.mat",
      nEmb=0,
      nQConv=0,
      nQRad=0,
      nQConvGai=0,
      nQRadGai=0,
      nWin=3,
    A=[-7.259423880576415e-06,3.936798340546162e-05,-4.962445012914214e-06,
        1.323915718796795e-05,-1.88252375481358e-06; 3.936798103488421e-05,-0.001281010714171152,
        0.0002227710710907596,-0.0007264543515296409,0.0001196438489482868; -4.962440063394087e-06,
        0.0002227705553963902,-4.683964589080359e-05,0.000183790037130858,-3.677238259917545e-05;
        1.323915321592108e-05,-0.0007264541842569522,0.000183789619766693,-0.0009475490393106751,
        0.0003155835733540964; 1.882486301515951e-06,-0.0001196416756030853,
        3.677170148502493e-05,-0.0003155799466889636,-0.0001238372026284371],
    B=[2.115961730976504e-07,9.415299563526941e-07,9.562171554686224e-07,
        1.392330158093027e-06,1.387791711011944e-06,2.116575036525356e-07,
        9.41526905975543e-07,9.562251828100972e-07,1.392330158093027e-06,
        1.387791711011944e-06,2.116575036525356e-07,9.415269053193813e-07,
        9.562251828100972e-07,1.392330158093027e-06,1.387791711011944e-06,
        6.002829214004856e-07,6.002829214004856e-07,4.604795023726834e-06,
        1.797727296355219e-07,1.797727296355219e-07,1.660772333314842e-05,
        3.027988683608231e-07,3.027988683608231e-07,2.322782465470689e-06,
        4.034375830848198e-07,4.034375830848198e-07,3.094786148271522e-06,
        3.027988720310179e-07,3.027988720310179e-07,2.322782493624903e-06,
        0.0001211224767777238,0,-8.203891708066289e-07,4.835017819350557e-07,-0.04413630565597016;
        -1.148791687883438e-06,-5.110649072221679e-06,-5.190499701570168e-06,-2.308008300866362e-06,
        -2.352911780146526e-06,-1.148909289860066e-06,-5.110652311977443e-06,-5.190493905148147e-06,
        -2.308008300866362e-06,-2.352911780146526e-06,-1.148909289860066e-06,-5.110652304416558e-06,
        -5.190493905148147e-06,-2.308008300866362e-06,-2.352911780146526e-06,-2.260168040429273e-07,
        -2.260168040429273e-07,-1.733784216461422e-06,1.379709287212327e-07,
        1.379709287212327e-07,-8.160404402353749e-05,2.326302278728606e-07,
        2.326302278728606e-07,1.784515963242098e-06,3.100404879207015e-07,
        3.100404879207015e-07,2.378333223403734e-06,2.326302310793093e-07,
        2.326302310793093e-07,1.784515987838896e-06,-0.0003505515730032248,0,-1.230236473507752e-06,
        1.106427172877891e-06,0.1251268091327537; 1.402839575561204e-07,
        6.240075741228931e-07,6.337447384599521e-07,-1.335165844667851e-07,-1.255928159624685e-07,
        1.402950403149568e-07,6.240234831017831e-07,6.337707995594652e-07,-1.335165844667851e-07,
        -1.255928159624685e-07,1.402950403149568e-07,6.240234818471926e-07,
        6.337707995594652e-07,-1.335165844667851e-07,-1.255928159624685e-07,-4.671969734603537e-07,
        -4.671969734603537e-07,-3.583887233491987e-06,-8.581649229516527e-10,-8.581649229516527e-10,
        1.008652889637919e-05,1.432131498756809e-10,1.432131498756809e-10,
        1.098593912047449e-09,4.789293053881188e-10,4.789293053881188e-10,
        3.673886227909593e-09,1.432161308011249e-10,1.432161308011249e-10,
        1.098616778848074e-09,3.195859436702155e-05,0,-1.065348337776455e-05,
        1.395997779681921e-05,-0.01536900165852341; -4.152997982527017e-07,-1.846803047225214e-06,
        -1.875631992869525e-06,1.193489634643559e-06,1.168499157348892e-06,-4.152517338415466e-07,
        -1.846880141459753e-06,-1.875757299981212e-06,1.193489634643559e-06,
        1.168499157348892e-06,-4.152517338415466e-07,-1.846880137101042e-06,-1.875757299981212e-06,
        1.193489634643559e-06,1.168499157348892e-06,2.584497490841266e-06,
        2.584497490841266e-06,1.982578674218254e-05,-2.816306534406579e-07,-2.816306534406579e-07,
        -3.20320777146414e-05,-4.748332043654697e-07,-4.748332043654697e-07,-3.642464871464076e-06,
        -6.330400263363614e-07,-6.330400263363614e-07,-4.856075851503699e-06,-4.748332106287473e-07,
        -4.748332106287473e-07,-3.642464919509934e-06,-0.0001164555140750265,0,
        -1.120559574477629e-06,2.62865024555068e-06,0.04050580096303039; -1.728696800778574e-07,
        -7.691504233505617e-07,-7.810713676846508e-07,2.37701398264187e-07,
        2.373378408712591e-07,-1.729564660409453e-07,-7.692101742769838e-07,-7.811925621043352e-07,
        2.37701398264187e-07,2.373378408712591e-07,-1.729564660409453e-07,-7.692101726294353e-07,
        -7.811925621043352e-07,2.37701398264187e-07,2.373378408712591e-07,
        3.811125266566226e-06,3.811125266566226e-06,2.923529895093491e-05,-3.982654878663702e-07,
        -3.982654878663702e-07,-1.549584023356e-05,-6.847569677904322e-07,-6.847569677904322e-07,
        -5.252798620096433e-06,-9.179576890242755e-07,-9.179576890242755e-07,-7.04169085827185e-06,
        -6.847569960914509e-07,-6.847569960914509e-07,-5.252798837194702e-06,-2.289424032120371e-05,
        0,-8.738467471461194e-08,7.20017668234416e-06,0.005716978453839506],
    C=[0.04413647566939506,-0.1251273276434769,0.01536904874249329,-0.04050598715557479,
        0.005717136967536052],
    use_matrix=true,
    nout=1) annotation (Placement(transformation(extent={{56,-70},{76,-50}})));

  Modelica.Blocks.Interfaces.RealOutput y_rom5[size(rom5.y, 1)]
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Components.StateSpaceExtended rom10(
    A=[-7.259423880576436e-06,3.936798340546161e-05,-4.962445012914217e-06,
        1.323915718796794e-05,-1.882523754813623e-06,-3.911609603141266e-08,
        2.621063229519136e-06,-4.380518919529037e-07,2.543999158579763e-08,-1.786394963953866e-07;
        3.936798103488413e-05,-0.001281010714171152,0.0002227710710907596,-0.0007264543515296408,
        0.0001196438489482868,2.405660769712307e-06,-0.0001642819277331216,
        2.72608475814845e-05,-1.583587497683691e-06,1.111899785185829e-05; -4.962440063394093e-06,
        0.0002227705553963902,-4.683964589080359e-05,0.000183790037130858,-3.677238259917548e-05,
        -7.036529306917642e-07,4.941901255971695e-05,-8.113022024704069e-06,
        4.714670448648373e-07,-3.309937839945136e-06; 1.323915321592105e-05,-0.0007264541842569522,
        0.000183789619766693,-0.0009475490393106751,0.0003155835733540964,
        5.112664189844298e-06,-0.0003927554076281794,6.221558742603632e-05,-3.619997040261604e-06,
        2.54037111541516e-05; 1.882486301515953e-06,-0.0001196416756030853,
        3.677170148502493e-05,-0.0003155799466889637,-0.0001238372026284372,-1.309258778473947e-05,
        0.0002583453757057733,-5.822506475042131e-05,3.339464690779622e-06,-2.354677622889269e-05;
        -3.751941263517113e-08,2.305032546191618e-06,-6.728752747304157e-07,
        4.862606577151843e-06,1.296396948621575e-05,-8.758944476076624e-08,
        2.558233121312522e-05,-1.932815208067613e-06,1.145052861729769e-07,-7.984507582971735e-07;
        -2.620995589318052e-06,0.0001642780278145966,-4.941789564526951e-05,
        0.000392747981506578,0.0002583421288378982,-2.527299083153933e-05,-0.0007160876026974882,
        0.0002461816694007672,-1.377244623843382e-05,9.790156687724996e-05; -4.377744780509603e-07,
        2.724367929686917e-05,-8.107923509285367e-06,6.217759641417197e-05,
        5.820029446205834e-05,-1.854025849660214e-06,-0.000246076933188449,-0.0007302549249037891,
        0.0001351020310908538,-0.0005431831834938199; -2.321045511655022e-08,
        1.444783827079955e-06,-4.299914509585149e-07,3.303479046655612e-06,
        3.049605667750145e-06,-1.103261542668955e-07,-1.254424678646527e-05,-0.0001302122842106777,
        -6.377615952268178e-06,0.0001173714438727466; -1.784391254956576e-07,
        1.110671578884342e-05,-3.30622570252773e-06,2.537607371846058e-05,
        2.352563829046327e-05,-7.683885303109888e-07,-9.782292102858837e-05,-0.000542648459240472,
        -0.0001111454077799756,-0.001256933970752341],
    B=[2.115961730976505e-07,9.415299563526941e-07,9.562171554686224e-07,
        1.392330158093027e-06,1.387791711011944e-06,2.116575036525356e-07,
        9.41526905975543e-07,9.562251828100972e-07,1.392330158093027e-06,
        1.387791711011944e-06,2.116575036525356e-07,9.415269053193813e-07,
        9.562251828100972e-07,1.392330158093027e-06,1.387791711011944e-06,
        6.002829214004856e-07,6.002829214004856e-07,4.604795023726834e-06,
        1.797727296355219e-07,1.797727296355219e-07,1.660772333314842e-05,
        3.027988683608231e-07,3.027988683608231e-07,2.322782465470689e-06,
        4.034375830848198e-07,4.034375830848198e-07,3.094786148271522e-06,
        3.027988720310179e-07,3.027988720310179e-07,2.322782493624903e-06,
        0.0001211224767777238,0,-8.203891708066289e-07,4.835017819350557e-07,-0.04413630565597018;
        -1.148791687883438e-06,-5.11064907222168e-06,-5.190499701570167e-06,-2.308008300866362e-06,
        -2.352911780146526e-06,-1.148909289860066e-06,-5.110652311977443e-06,-5.190493905148147e-06,
        -2.308008300866362e-06,-2.352911780146526e-06,-1.148909289860066e-06,-5.110652304416557e-06,
        -5.190493905148147e-06,-2.308008300866362e-06,-2.352911780146526e-06,-2.260168040429273e-07,
        -2.260168040429273e-07,-1.733784216461422e-06,1.379709287212327e-07,
        1.379709287212327e-07,-8.160404402353749e-05,2.326302278728606e-07,
        2.326302278728606e-07,1.784515963242098e-06,3.100404879207015e-07,
        3.100404879207015e-07,2.378333223403734e-06,2.326302310793093e-07,
        2.326302310793093e-07,1.784515987838896e-06,-0.0003505515730032248,0,-1.230236473507752e-06,
        1.106427172877891e-06,0.1251268091327537; 1.402839575561204e-07,
        6.240075741228932e-07,6.337447384599522e-07,-1.335165844667851e-07,-1.255928159624685e-07,
        1.402950403149568e-07,6.240234831017831e-07,6.337707995594651e-07,-1.335165844667851e-07,
        -1.255928159624685e-07,1.402950403149568e-07,6.240234818471926e-07,
        6.337707995594651e-07,-1.335165844667851e-07,-1.255928159624685e-07,-4.671969734603537e-07,
        -4.671969734603537e-07,-3.583887233491987e-06,-8.581649229516527e-10,-8.581649229516527e-10,
        1.008652889637919e-05,1.432131498756809e-10,1.432131498756809e-10,
        1.098593912047449e-09,4.789293053881188e-10,4.789293053881188e-10,
        3.673886227909593e-09,1.432161308011249e-10,1.432161308011249e-10,
        1.098616778848074e-09,3.195859436702156e-05,0,-1.065348337776455e-05,
        1.395997779681921e-05,-0.01536900165852341; -4.152997982527017e-07,-1.846803047225214e-06,
        -1.875631992869525e-06,1.193489634643559e-06,1.168499157348892e-06,-4.152517338415466e-07,
        -1.846880141459753e-06,-1.875757299981211e-06,1.193489634643559e-06,
        1.168499157348892e-06,-4.152517338415466e-07,-1.846880137101042e-06,-1.875757299981211e-06,
        1.193489634643559e-06,1.168499157348892e-06,2.584497490841266e-06,
        2.584497490841266e-06,1.982578674218254e-05,-2.816306534406579e-07,-2.816306534406579e-07,
        -3.203207771464142e-05,-4.748332043654697e-07,-4.748332043654697e-07,-3.642464871464076e-06,
        -6.330400263363614e-07,-6.330400263363614e-07,-4.856075851503699e-06,-4.748332106287473e-07,
        -4.748332106287473e-07,-3.642464919509934e-06,-0.0001164555140750265,0,
        -1.120559574477629e-06,2.62865024555068e-06,0.04050580096303039; -1.728696800778574e-07,
        -7.691504233505618e-07,-7.810713676846508e-07,2.377013982641869e-07,
        2.373378408712591e-07,-1.729564660409453e-07,-7.692101742769837e-07,-7.811925621043352e-07,
        2.377013982641869e-07,2.373378408712591e-07,-1.729564660409453e-07,-7.692101726294352e-07,
        -7.811925621043352e-07,2.377013982641869e-07,2.373378408712591e-07,
        3.811125266566226e-06,3.811125266566226e-06,2.923529895093491e-05,-3.982654878663702e-07,
        -3.982654878663702e-07,-1.549584023356e-05,-6.847569677904322e-07,-6.847569677904322e-07,
        -5.252798620096433e-06,-9.179576890242755e-07,-9.179576890242755e-07,-7.04169085827185e-06,
        -6.847569960914509e-07,-6.847569960914509e-07,-5.252798837194702e-06,-2.289424032120372e-05,
        0,-8.738467471461194e-08,7.20017668234416e-06,0.00571697845383952; -1.109879135098975e-08,
        -4.915870429727562e-08,-5.001404413879521e-08,-3.408417657353374e-08,-4.054072412699773e-08,
        -1.102027331161783e-08,-4.911568769889554e-08,-4.99177948913592e-08,-3.408417657353374e-08,
        -4.054072412699773e-08,-1.102027331161783e-08,-4.911568767370827e-08,-4.99177948913592e-08,
        -3.408417657353374e-08,-4.054072412699773e-08,-2.504812850684385e-08,-2.504812850684385e-08,
        -1.921452258426546e-07,1.220105999757275e-07,1.220105999757275e-07,
        1.408147355253143e-07,2.128906951100428e-07,2.128906951100428e-07,
        1.633093202561828e-06,2.838351245961663e-07,2.838351245961663e-07,
        2.17731081293053e-06,2.128907137314505e-07,2.128907137314505e-07,
        1.633093345407406e-06,2.114889678556663e-05,0,-1.490870725764979e-06,-2.615193168831742e-05,
        -0.0001140708136474992; 5.493339612069886e-07,2.443545953475751e-06,
        2.481898461091347e-06,1.575925717344504e-06,1.598740375344613e-06,
        5.492516317760674e-07,2.443448938261417e-06,2.481685091958505e-06,
        1.575925717344504e-06,1.598740375344613e-06,5.492516317760674e-07,
        2.443448935080334e-06,2.481685091958505e-06,1.575925717344504e-06,
        1.598740375344613e-06,-5.41279551096654e-06,-5.41279551096654e-06,-4.152177738989977e-05,
        6.238489355827228e-08,6.238489355827228e-08,4.000171371532221e-05,
        9.702143740180868e-08,9.702143740180868e-08,7.442554022465458e-07,
        1.269236358087808e-07,1.269236358087808e-07,9.736363850531262e-07,
        9.702142611624814e-08,9.702142611624814e-08,7.442553156745507e-07,
        2.312041560884536e-05,0,-1.074208547424785e-07,3.108002044501987e-06,-0.007965003363065732;
        8.53061569014754e-08,3.78530018134748e-07,3.846691503903152e-07,-1.452395141148995e-06,
        -1.439775507321683e-06,8.50518282205153e-08,3.784531463762047e-07,
        3.844668592903327e-07,-1.452395141148995e-06,-1.439775507321683e-06,
        8.50518282205153e-08,3.784531446022814e-07,3.844668592903327e-07,-1.452395141148995e-06,
        -1.439775507321683e-06,-5.380706401425592e-06,-5.380706401425592e-06,-4.127562050843254e-05,
        7.018604491671742e-07,7.018604491671742e-07,1.150682397847325e-05,
        1.184336488460152e-06,1.184336488460152e-06,9.085093492932938e-06,
        1.583637591017259e-06,1.583637591017259e-06,1.214814852668769e-05,
        1.184336497706132e-06,1.184336497706132e-06,9.085093563859223e-06,
        8.468658571348367e-06,0,3.948911489398185e-07,-4.478655180694178e-06,-0.001330802106286825;
        -1.776557935622128e-07,-7.903603395953044e-07,-8.02760476690402e-07,-1.242490013178028e-06,
        -1.249809412941731e-06,-1.776469538944154e-07,-7.903213494954731e-07,-8.026865862754194e-07,
        -1.242490013178028e-06,-1.249809412941731e-06,-1.776469538944154e-07,-7.903213490483054e-07,
        -8.026865862754194e-07,-1.242490013178028e-06,-1.249809412941731e-06,-1.575730444212858e-06,
        -1.575730444212858e-06,-1.208749316292038e-05,5.710821576819856e-07,
        5.710821576819856e-07,-8.40282109020686e-06,9.779720609247093e-07,
        9.779720609247093e-07,7.502063555036901e-06,1.327113487191157e-06,
        1.327113487191157e-06,1.018034166757343e-05,9.77972059878302e-07,
        9.77972059878302e-07,7.502063547009867e-06,1.38877104090292e-05,0,
        4.37768774540683e-06,-1.834134644916866e-05,-7.052388961923994e-05;
        3.559558575898406e-07,1.584039392933661e-06,1.608534826373414e-06,
        3.443771449490462e-07,3.604263555903154e-07,3.562056493361725e-07,
        1.584178833653771e-06,1.608833626638579e-06,3.443771449490462e-07,
        3.604263555903154e-07,3.562056493361725e-07,1.584178830939616e-06,
        1.608833626638579e-06,3.443771449490462e-07,3.604263555903154e-07,-1.710772400210339e-06,
        -1.710772400210339e-06,-1.312340557155723e-05,-2.763929876726135e-07,-2.763929876726135e-07,
        2.350098863899141e-05,-4.607413685711542e-07,-4.607413685711542e-07,-3.534365824507522e-06,
        -6.088789534574095e-07,-6.088789534574095e-07,-4.670735276385693e-06,-4.607413705464939e-07,
        -4.607413705464939e-07,-3.534365839660432e-06,8.815543095589247e-06,0,
        1.964193527710853e-06,-5.603313878163482e-06,-0.0005424163356336835],
    C=[0.04413647566939506,-0.1251273276434769,0.01536904874249329,-0.04050598715557479,
        0.005717136967536052,0.0001189794128431975,-0.00796525320739722,
        0.001331665007563578,-7.733588841390016e-05,0.0005430544336355652],
    use_matrix=true,
    nout=1,
    nEmb=0,
      nQConv=0,
      nQRad=0,
      nQConvGai=0,
      nQRadGai=0,
      nWin=3)
            annotation (Placement(transformation(extent={{56,-10},{76,10}})));

  Modelica.Blocks.Interfaces.RealOutput y_rom10[size(rom5.y, 1)]
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Sources.Constant QConv[ssm.nQConv](k=10)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Blocks.Sources.Constant QGaiRad[ssm.nQRadGai](k=20)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
equation
  connect(const.y, win[3].Ctrl) annotation (Line(
      points={{-59,40},{-48,40},{-48,52},{-49,52}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(ssm.y, y_ssm)
    annotation (Line(points={{76.4,54},{110,54}}, color={0,0,127}));
  connect(rom5.winBus, windowBusOut) annotation (Line(
      points={{56,-52},{34,-52},{18,-52},{18,62}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(rom5.y, y_rom5)
    annotation (Line(points={{76.4,-60},{110,-60}}, color={0,0,127}));
  connect(rom10.winBus, windowBusOut) annotation (Line(
      points={{56,8},{34,8},{18,8},{18,62}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(rom10.y, y_rom10)
    annotation (Line(points={{76.4,0},{110,0}}, color={0,0,127}));
  connect(ssm.Q_flowConv, QConv.y) annotation (Line(points={{55.2,56},{40,56},{
          40,20},{-40,20},{-40,10},{-59,10}}, color={0,0,127}));
  connect(QGaiRad.y, ssm.Q_flowRadGai) annotation (Line(points={{-59,-30},{-40,
          -30},{-20,-30},{-20,14},{46,14},{46,46.6},{55.2,46.6}}, color={0,0,
          127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    Documentation(info="<html>
<p>
This model allows comparing the simulation accuracy of the 
\"true\" linearised state space model with two reduced order models (ROMs).
</p>
<p>
Before running this model, 
you may need to run the following script in order to create the state space model:
</p>
<code>OutputCPUtime:=false;<br/>
re=Modelica_LinearSystems2.ModelAnalysis.Linearize(\"IDEAS.Buildings.Linearisation.Examples.BaseClasses.LinCase900\");<br/>
writeMatrix(fileName=\"linCase900_ssm.mat\",matrixName=\"A\",matrix=re.A);<br/>
writeMatrix(fileName=\"linCase900_ssm.mat\",matrixName=\"B\",matrix=re.B, append=true);<br/>
writeMatrix(fileName=\"linCase900_ssm.mat\",matrixName=\"C\",matrix=re.C, append=true);<br/>
writeMatrix(fileName=\"linCase900_ssm.mat\",matrixName=\"D\",matrix=re.D, append=true);<br/>
OutputCPUtime:=true;</code>
</html>", revisions="<html>
<ul>
<li>
August, 2015 by Damien Picard:<br/>
First implementation
</li>
</ul>
</html>"),
    experiment(StopTime=1e+006),
    __Dymola_experimentSetupOutput);
end linCase900SSM;