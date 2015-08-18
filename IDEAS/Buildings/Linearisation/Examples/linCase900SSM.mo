within IDEAS.Buildings.Linearisation.Examples;
model linCase900SSM
  extends Modelica.Icons.Example;
  extends IDEAS.Buildings.Linearisation.Interfaces.StateSpaceModelInterface(ssm(
        fileName="linCase900_ssm.mat"));

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
  Components.StateSpaceExtended rom5(
    A=[-7.240752735415507e-06,3.914601540856084e-05,-4.970015006147561e-06,
        1.322149115531332e-05,-1.875299012245814e-06; 3.914601300632805e-05,-0.001277263235530498,
        0.0002233784752756869,-0.0007274504812855267,0.0001195665380144088; -4.970010041780563e-06,
        0.0002233779561700741,-4.711346977580989e-05,0.0001845198735497701,-3.679526619572756e-05;
        1.322148714705371e-05,-0.0007274503128865402,0.0001845194575339173,-0.0009513920825096328,
        0.0003164709606512273; 1.875261528400152e-06,-0.0001195643574374423,
        3.679458248732967e-05,-0.0003164673160224137,-0.0001228719982286662],
    B=[2.117878334166119e-07,9.421972767672239e-07,9.569068609818592e-07,
        1.393293604861256e-06,1.388696528335063e-06,2.117960842947654e-07,
        9.421457005924047e-07,9.568816229920917e-07,1.393293604861256e-06,
        1.388696528335063e-06,2.117960846230675e-07,9.421457005924047e-07,
        9.568816233203939e-07,1.393293604861256e-06,1.388696528335063e-06,
        6.006516483204749e-07,6.006516483204749e-07,4.607623543122853e-06,
        1.799237717078577e-07,1.799237717078577e-07,1.661926925297611e-05,
        3.030527120206974e-07,3.030527120206974e-07,2.324729710535767e-06,
        4.037753136224591e-07,4.037753136224591e-07,3.097376892995259e-06,
        3.030527422701483e-07,3.030527422701483e-07,2.324729942580539e-06,
        0.0001209291354973603,0,-8.218284803072145e-07,4.847642241739316e-07,-0.04408613921674573;
        -1.152386786345827e-06,-5.126300515071969e-06,-5.206399481681352e-06,-2.316462451934174e-06,
        -2.361397589601712e-06,-1.152401373604826e-06,-5.12618468076582e-06,-5.206329060062572e-06,
        -2.316462451934174e-06,-2.361397589601712e-06,-1.152401377396226e-06,-5.12618468076582e-06,
        -5.206329063853971e-06,-2.316462451934174e-06,-2.361397589601712e-06,-2.288261298907716e-07,
        -2.288261298907716e-07,-1.755334670793855e-06,1.385653996156428e-07,
        1.385653996156428e-07,-8.185154437672148e-05,2.336335331027901e-07,
        2.336335331027901e-07,1.792212358569501e-06,3.113777031229949e-07,
        3.113777031229949e-07,2.38859105573971e-06,2.336335589177136e-07,
        2.336335589177136e-07,1.792212556596831e-06,-0.0003484091672453264,0,-1.242896351818664e-06,
        1.12074444701387e-06,0.1245659711349663; 1.421637897727823e-07,
        6.323546539635969e-07,6.422340402131477e-07,-1.292323337628639e-07,-1.212666335767749e-07,
        1.42169476990782e-07,6.323382718570075e-07,6.422401199870707e-07,-1.292323337628639e-07,
        -1.212666335767749e-07,1.421694776240362e-07,6.323382718570075e-07,
        6.422401206203248e-07,-1.292323337628639e-07,-1.212666335767749e-07,-4.657739189926438e-07,
        -4.657739189926438e-07,-3.572970924035581e-06,-1.313039020835164e-09,-1.313039020835164e-09,
        1.021791539416907e-05,-6.228624002088158e-10,-6.228624002088158e-10,-4.778002868498208e-09,
        -5.419233389995272e-10,-5.419233389995272e-10,-4.157116028052804e-09,-6.228374938471125e-10,
        -6.228374938471125e-10,-4.777811810782054e-09,3.197453826911114e-05,0,-1.066299410629062e-05,
        1.397664061679185e-05,-0.01541453665431983; -4.203466908333411e-07,-1.869460443243933e-06,
        -1.898702212111695e-06,1.187456691011985e-06,1.162327864006362e-06,-4.203573880826655e-07,
        -1.869493005002915e-06,-1.898788360185411e-06,1.187456691011985e-06,
        1.162327864006362e-06,-4.203573902805133e-07,-1.869493005002915e-06,-1.898788362383258e-06,
        1.187456691011985e-06,1.162327864006362e-06,2.588444675229659e-06,
        2.588444675229659e-06,1.985606575626309e-05,-2.81654208382963e-07,-2.81654208382963e-07,
        -3.239910621255766e-05,-4.748709042929041e-07,-4.748709042929041e-07,-3.642754069144596e-06,
        -6.330889966762659e-07,-6.330889966762659e-07,-4.856451504977662e-06,-4.748709514411447e-07,
        -4.748709514411447e-07,-3.642754430820673e-06,-0.0001161200682011374,0,
        -1.114564614702881e-06,2.620299498852917e-06,0.04050887646388854; -1.743881466767378e-07,
        -7.757172115389802e-07,-7.878006339914581e-07,2.379736835277093e-07,
        2.376942259167664e-07,-1.744189755172609e-07,-7.756158194785245e-07,-7.878185360227873e-07,
        2.379736835277093e-07,2.376942259167664e-07,-1.744189763471642e-07,-7.756158194785245e-07,
        -7.878185368526905e-07,2.379736835277093e-07,2.376942259167664e-07,
        3.808485277618973e-06,3.808485277618973e-06,2.921504748694416e-05,-3.98168544540299e-07,
        -3.98168544540299e-07,-1.560056220973203e-05,-6.845833137900963e-07,-6.845833137900963e-07,
        -5.251466513179315e-06,-9.177214527087133e-07,-9.177214527087133e-07,-7.039878679863656e-06,
        -6.845834906988536e-07,-6.845834906988536e-07,-5.251467870253605e-06,-2.27258968112783e-05,
        0,-8.577807202383144e-08,7.199340257771144e-06,0.005703217883647396],
    C=[0.04408630889823481,-0.1245664861378431,0.01541458373975517,-0.04050906199131475,
        0.005703376284341259],
    use_matrix=true,
    nout=1) annotation (Placement(transformation(extent={{56,-70},{76,-50}})));

  Modelica.Blocks.Interfaces.RealOutput y_rom5[size(rom5.y, 1)]
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Components.StateSpaceExtended rom10(
    A=[-7.240752735415493e-06,3.914601540856085e-05,-4.970015006147564e-06,
        1.322149115531332e-05,-1.875299012245791e-06,-3.925550299310191e-08,
        2.617889673536108e-06,-4.364960530571096e-07,2.534881013579473e-08,-1.781095417796851e-07;
        3.914601300632816e-05,-0.001277263235530498,0.0002233784752756869,-0.0007274504812855268,
        0.0001195665380144089,2.421243873550671e-06,-0.000164584829878789,
        2.724564476636488e-05,-1.582654507778185e-06,1.111932586507079e-05; -4.97001004178057e-06,
        0.0002233779561700741,-4.71134697758099e-05,0.0001845198735497701,-3.679526619572757e-05,
        -7.09167651562194e-07,4.957329806207235e-05,-8.119130882606168e-06,
        4.718059940976971e-07,-3.314368650978714e-06; 1.322148714705365e-05,-0.0007274503128865402,
        0.0001845194575339173,-0.0009513920825096328,0.0003164709606512272,
        5.156181849320434e-06,-0.0003945168355813165,6.233094063978867e-05,-3.626602588468133e-06,
        2.546573687082302e-05; 1.875261528400157e-06,-0.0001195643574374424,
        3.67945824873297e-05,-0.0003164673160224137,-0.0001228719982286662,-1.306177069438469e-05,
        0.0002571232763624661,-5.77840111304313e-05,3.314276065515343e-06,-2.338360685051012e-05;
        -3.766920839273088e-08,2.320958385624766e-06,-6.784551480495851e-07,
        4.906253492343804e-06,1.29344318417446e-05,-8.832161740406688e-08,
        2.56634408304385e-05,-1.935307017496579e-06,1.146417093549385e-07,-7.9989053234511e-07;
        -2.617821739043327e-06,0.0001645809039569248,-4.957217306679573e-05,
        0.0003945093467705803,0.0002571200314218236,-2.53560233312007e-05,-0.0007155342177676594,
        0.0002453758509007367,-1.37287186051439e-05,9.765271815127905e-05; -4.362171709337111e-07,
        2.722833429934268e-05,-8.113983921310941e-06,6.229254016232067e-05,
        5.775918523638291e-05,-1.857186618851885e-06,-0.0002452704413657778,-0.0007304021721570691,
        0.0001358755444229813,-0.00054357141455233; -2.311434143027672e-08,
        1.44312439200196e-06,-4.300593015767368e-07,3.307657318756787e-06,
        3.024910480839355e-06,-1.104222353368338e-07,-1.249713739632079e-05,-0.0001309683339508356,
        -6.320103586594381e-06,0.0001160639901020168; -1.779062986227736e-07,
        1.110683026107039e-05,-3.310588775466936e-06,2.543755034471665e-05,
        2.33622219798325e-05,-7.700412958074052e-07,-9.757276624271898e-05,-0.0005430289133891942,
        -0.0001098391985198911,-0.001257583105627461],
    B=[2.117878334166119e-07,9.421972767672237e-07,9.569068609818592e-07,
        1.393293604861256e-06,1.388696528335063e-06,2.117960842947654e-07,
        9.421457005924047e-07,9.568816229920917e-07,1.393293604861256e-06,
        1.388696528335063e-06,2.117960846230675e-07,9.421457005924047e-07,
        9.568816233203936e-07,1.393293604861256e-06,1.388696528335063e-06,
        6.006516483204749e-07,6.006516483204749e-07,4.607623543122853e-06,
        1.799237717078577e-07,1.799237717078577e-07,1.661926925297611e-05,
        3.030527120206974e-07,3.030527120206974e-07,2.324729710535767e-06,
        4.037753136224591e-07,4.037753136224591e-07,3.097376892995259e-06,
        3.030527422701483e-07,3.030527422701483e-07,2.324729942580539e-06,
        0.0001209291354973603,0,-8.218284803072145e-07,4.847642241739316e-07,-0.04408613921674573;
        -1.152386786345828e-06,-5.126300515071969e-06,-5.206399481681352e-06,-2.316462451934174e-06,
        -2.361397589601712e-06,-1.152401373604826e-06,-5.126184680765819e-06,-5.206329060062572e-06,
        -2.316462451934174e-06,-2.361397589601712e-06,-1.152401377396226e-06,-5.126184680765819e-06,
        -5.206329063853971e-06,-2.316462451934174e-06,-2.361397589601712e-06,-2.288261298907716e-07,
        -2.288261298907716e-07,-1.755334670793855e-06,1.385653996156428e-07,
        1.385653996156428e-07,-8.185154437672146e-05,2.336335331027901e-07,
        2.336335331027901e-07,1.792212358569501e-06,3.113777031229949e-07,
        3.113777031229949e-07,2.38859105573971e-06,2.336335589177136e-07,
        2.336335589177136e-07,1.792212556596831e-06,-0.0003484091672453264,0,-1.242896351818664e-06,
        1.12074444701387e-06,0.1245659711349663; 1.421637897727823e-07,
        6.323546539635968e-07,6.422340402131477e-07,-1.292323337628639e-07,-1.212666335767749e-07,
        1.421694769907819e-07,6.323382718570076e-07,6.422401199870706e-07,-1.292323337628639e-07,
        -1.212666335767749e-07,1.421694776240362e-07,6.323382718570076e-07,
        6.422401206203247e-07,-1.292323337628639e-07,-1.212666335767749e-07,-4.657739189926438e-07,
        -4.657739189926438e-07,-3.572970924035581e-06,-1.313039020835164e-09,-1.313039020835164e-09,
        1.021791539416907e-05,-6.228624002088158e-10,-6.228624002088158e-10,-4.778002868498208e-09,
        -5.419233389995272e-10,-5.419233389995272e-10,-4.157116028052804e-09,-6.228374938471125e-10,
        -6.228374938471125e-10,-4.777811810782054e-09,3.197453826911114e-05,0,-1.066299410629062e-05,
        1.397664061679185e-05,-0.01541453665431983; -4.203466908333411e-07,-1.869460443243933e-06,
        -1.898702212111695e-06,1.187456691011986e-06,1.162327864006362e-06,-4.203573880826654e-07,
        -1.869493005002915e-06,-1.898788360185411e-06,1.187456691011986e-06,
        1.162327864006362e-06,-4.203573902805133e-07,-1.869493005002915e-06,-1.898788362383258e-06,
        1.187456691011986e-06,1.162327864006362e-06,2.588444675229659e-06,
        2.588444675229659e-06,1.985606575626309e-05,-2.81654208382963e-07,-2.81654208382963e-07,
        -3.239910621255767e-05,-4.748709042929041e-07,-4.748709042929041e-07,-3.642754069144596e-06,
        -6.330889966762659e-07,-6.330889966762659e-07,-4.856451504977662e-06,-4.748709514411447e-07,
        -4.748709514411447e-07,-3.642754430820673e-06,-0.0001161200682011373,0,
        -1.114564614702881e-06,2.620299498852917e-06,0.04050887646388852; -1.743881466767378e-07,
        -7.757172115389799e-07,-7.878006339914581e-07,2.379736835277093e-07,
        2.376942259167665e-07,-1.744189755172609e-07,-7.756158194785245e-07,-7.878185360227871e-07,
        2.379736835277093e-07,2.376942259167665e-07,-1.744189763471642e-07,-7.756158194785245e-07,
        -7.878185368526903e-07,2.379736835277093e-07,2.376942259167665e-07,
        3.808485277618973e-06,3.808485277618973e-06,2.921504748694416e-05,-3.98168544540299e-07,
        -3.98168544540299e-07,-1.560056220973203e-05,-6.845833137900963e-07,-6.845833137900963e-07,
        -5.251466513179315e-06,-9.177214527087133e-07,-9.177214527087133e-07,-7.039878679863656e-06,
        -6.845834906988536e-07,-6.845834906988536e-07,-5.251467870253605e-06,-2.27258968112783e-05,
        0,-8.577807202383144e-08,7.199340257771144e-06,0.005703217883647403; -1.106462750479866e-08,
        -4.918387405580725e-08,-4.999111555783219e-08,-3.408814123099547e-08,-4.068067570269219e-08,
        -1.103832684503757e-08,-4.927227254075018e-08,-4.99813738920909e-08,-3.408814123099547e-08,
        -4.068067570269219e-08,-1.103832685767851e-08,-4.927227254075018e-08,-4.998137390473183e-08,
        -3.408814123099547e-08,-4.068067570269219e-08,-2.48126251052301e-08,-2.48126251052301e-08,
        -1.903386695453479e-07,1.219689054184309e-07,1.219689054184309e-07,
        1.394330466916094e-07,2.12815756290992e-07,2.12815756290992e-07,
        1.632518343825345e-06,2.837347257536507e-07,2.837347257536507e-07,
        2.176540649316263e-06,2.128159329889853e-07,2.128159329889853e-07,
        1.632519699282857e-06,2.115317314229265e-05,0,-1.486415895084678e-06,-2.615266308362785e-05,
        -0.0001146914493639216; 5.527860086612531e-07,2.459020812966779e-06,
        2.4975140453011e-06,1.579151244753948e-06,1.602350533892562e-06,
        5.527391584857264e-07,2.459130019486097e-06,2.497445557247484e-06,
        1.579151244753948e-06,1.602350533892562e-06,5.527391600892432e-07,
        2.459130019486097e-06,2.497445558851e-06,1.579151244753948e-06,
        1.602350533892562e-06,-5.414792049243175e-06,-5.414792049243175e-06,-4.15370929172839e-05,
        6.265278880208649e-08,6.265278880208649e-08,4.025477218397652e-05,
        9.748464613957302e-08,9.748464613957302e-08,7.478086953607385e-07,
        1.275449627954169e-07,1.275449627954169e-07,9.784026096995402e-07,
        9.748458048222189e-08,9.748458048222189e-08,7.478081917005208e-07,
        2.288132628546303e-05,0,-1.071399931649438e-07,3.103628938317245e-06,-0.007966804638763973;
        8.720061268760127e-08,3.875807643191152e-07,3.937550222656061e-07,-1.456179657385941e-06,
        -1.443056499435574e-06,8.712996905489343e-08,3.878531984567107e-07,
        3.937840640118272e-07,-1.456179657385941e-06,-1.443056499435574e-06,
        8.712996995164213e-08,3.878531984567107e-07,3.937840649085759e-07,-1.456179657385941e-06,
        -1.443056499435574e-06,-5.39147829348101e-06,-5.39147829348101e-06,-4.135825213622763e-05,
        7.031924325530086e-07,7.031924325530086e-07,1.166559368425798e-05,
        1.186543487962028e-06,1.186543487962028e-06,9.102023476099686e-06,
        1.586557968531557e-06,1.586557968531557e-06,1.217055086166567e-05,
        1.186543535696204e-06,1.186543535696204e-06,9.102023842270496e-06,
        8.321636361247809e-06,0,3.900584924536122e-07,-4.473413095705938e-06,-0.00132797654120265;
        -1.775279250587076e-07,-7.89775325785958e-07,-8.02134300346451e-07,-1.244269784464292e-06,
        -1.251602289172119e-06,-1.775149595106326e-07,-7.897973545114379e-07,-8.020997881435825e-07,
        -1.244269784464292e-06,-1.251602289172119e-06,-1.775149597331078e-07,-7.897973545114379e-07,
        -8.020997883660576e-07,-1.244269784464292e-06,-1.251602289172119e-06,-1.581234340914087e-06,
        -1.581234340914087e-06,-1.212971378129446e-05,5.709450203884177e-07,
        5.709450203884177e-07,-8.394515276086161e-06,9.776752830880821e-07,
        9.776752830880821e-07,7.499786960151359e-06,1.326667502727685e-06,
        1.326667502727685e-06,1.017692050257104e-05,9.776748689907159e-07,
        9.776748689907159e-07,7.499783783593578e-06,1.391944318988444e-05,0,
        4.365585008938117e-06,-1.833181302059186e-05,-7.033276424683665e-05;
        3.594950800168603e-07,1.599232463246916e-06,1.624113673220201e-06,
        3.472247280571228e-07,3.629537600033269e-07,3.595797874869699e-07,
        1.598945110832507e-06,1.624131924634955e-06,3.472247280571228e-07,
        3.629537600033269e-07,3.595797888568731e-07,1.598945110832507e-06,
        1.624131926004858e-06,3.472247280571228e-07,3.629537600033269e-07,-1.717541977794582e-06,
        -1.717541977794582e-06,-1.317533528013518e-05,-2.759560772333792e-07,-2.759560772333792e-07,
        2.374782816301596e-05,-4.599814640987324e-07,-4.599814640987324e-07,-3.528536566315345e-06,
        -6.078324105917533e-07,-6.078324105917533e-07,-4.662707203394972e-06,-4.599816511533434e-07,
        -4.599816511533434e-07,-3.528538001218893e-06,8.633602194431809e-06,0,
        1.971766566023265e-06,-5.639047207458143e-06,-0.0005415752514204469],
    C=[0.04408630889823481,-0.1245664861378431,0.01541458373975517,-0.04050906199131475,
        0.005703376284341255,0.0001195753997144063,-0.007967055126819504,
        0.001328844785628714,-7.716959395852405e-05,0.0005422225689482572],
    use_matrix=true,
    nout=1) annotation (Placement(transformation(extent={{56,-10},{76,10}})));

  Modelica.Blocks.Interfaces.RealOutput y_rom10[size(rom5.y, 1)]
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(const.y, win[3].Ctrl) annotation (Line(
      points={{-59,40},{-48,40},{-48,52},{-49,52}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(ssm.y, y_ssm)
    annotation (Line(points={{76.4,54},{110,54}}, color={0,0,127}));
  connect(rom5.winBus, windowBusOut) annotation (Line(
      points={{56,-54},{34,-54},{18,-54},{18,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(rom5.y, y_rom5)
    annotation (Line(points={{76.4,-60},{110,-60}}, color={0,0,127}));
  connect(rom10.winBus, windowBusOut) annotation (Line(
      points={{56,6},{34,6},{18,6},{18,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(rom10.y, y_rom10)
    annotation (Line(points={{76.4,0},{110,0}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    Documentation(info="<html>
            <p>Before running this model, you might need to run the following script in order to create the state space model:</p>
<pre> 
OutputCPUtime:=false;
re=Modelica_LinearSystems2.ModelAnalysis.Linearize(&QUOT;IDEAS.Buildings.Linearisation.Examples.BaseClasses.LinCase900&QUOT;);
writeMatrix(fileName=&QUOT;linCase900_ssm.mat&QUOT;,matrixName=&QUOT;A&QUOT;,matrix=re.A);
writeMatrix(fileName=&QUOT;linCase900_ssm.mat&QUOT;,matrixName=&QUOT;B&QUOT;,matrix=re.B, append=true);
writeMatrix(fileName=&QUOT;linCase900_ssm.mat&QUOT;,matrixName=&QUOT;C&QUOT;,matrix=re.C, append=true);
writeMatrix(fileName=&QUOT;linCase900_ssm.mat&QUOT;,matrixName=&QUOT;D&QUOT;,matrix=re.D, append=true);
OutputCPUtime:=true;
</pre>
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
