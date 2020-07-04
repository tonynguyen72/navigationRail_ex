import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'sizeConfig.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return MaterialApp(
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          home: NatureSound(),
        );
      });
    });
  }
}

class NatureSound extends StatefulWidget {
  const NatureSound({
    Key key,
  }) : super(key: key);

  @override
  _NatureSoundState createState() => _NatureSoundState();
}

class _NatureSoundState extends State<NatureSound> {
  //
  int _selectedIndex = 0;
  final padding = 8.0;
  double _value = 0.0;
  void _setValue(double val) {
    setState(() {
      _value = val;
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff152a3d),
      body: Stack(
        children: [
          Row(
            children: [
              ContentSpace(_selectedIndex),
              NavigationRail(
                minWidth: 15 * SizeConfig.widthMultiplier,
                groupAlignment: 0,
                backgroundColor: Color(0xff152a3d),
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                selectedIndex: _selectedIndex,
                labelType: NavigationRailLabelType.all,
                leading: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 7 * SizeConfig.heightMultiplier,
                      ),
                      child: Image.asset(
                        'assets/images/dotnav.png',
                        height: 5 * SizeConfig.imageSizeMultiplier,
                        width: 5 * SizeConfig.imageSizeMultiplier,
                      ),
                    )
                  ],
                ),
                selectedLabelTextStyle: TextStyle(
                    color: Colors.white70,
                    fontSize: 13.0,
                    letterSpacing: 0.8,
                    decorationThickness: 2.0),
                unselectedLabelTextStyle: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 13.0,
                  letterSpacing: 0.8,
                ),
                destinations: [
                  buildRotatedTextRailDestinations('NATURAL', padding),
                  buildRotatedTextRailDestinations('FOREST', padding),
                  buildRotatedTextRailDestinations('RAIN', padding),
                  buildRotatedTextRailDestinations('OTHERS', padding),
                ],
              ),
            ],
          ),
          //
          Positioned(
            bottom: 8,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 12 * SizeConfig.heightMultiplier,
              decoration: BoxDecoration(
                color: Color(0xff294461),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 7 * SizeConfig.widthMultiplier,
                  vertical: 4 * SizeConfig.heightMultiplier,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xff3e5771),
                      child: Icon(Icons.pause,
                          color: Colors.white,
                          size: 6 * SizeConfig.imageSizeMultiplier),
                    ),
                    Icon(Icons.fast_forward,
                        color: Colors.white,
                        size: 6 * SizeConfig.imageSizeMultiplier),
                    Slider(
                      activeColor: Colors.white,
                      inactiveColor: Colors.grey,
                      value: _value,
                      onChanged: _setValue,
                    ),
                    Icon(Icons.shuffle,
                        color: Colors.white,
                        size: 6 * SizeConfig.imageSizeMultiplier),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  NavigationRailDestination buildRotatedTextRailDestinations(
      String text, double padding) {
    return NavigationRailDestination(
        icon: SizedBox.shrink(),
        label: RotatedBox(
          quarterTurns: -1,
          child: Text(text),
        ));
  }
}

class ContentSpace extends StatelessWidget {
  final int selectedIndex;
  ContentSpace(this.selectedIndex);

  final List<String> titles = [
    "Natural Collection",
    "Forest Collection",
    "Rain Collection",
    "Others",
  ];
  //create screens for different tabs
  final List screens = [
    // NatureScreen(),
    // ForestScreen(),
    // RainScreen(),
    // Others(),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 50, 0),
        child: MediaQuery.removePadding(
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 6 * SizeConfig.heightMultiplier,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        "assets/images/tony.jpg",
                        height: 10 * SizeConfig.imageSizeMultiplier,
                        width: 10 * SizeConfig.imageSizeMultiplier,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 3 * SizeConfig.widthMultiplier,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tony Code",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 3 * SizeConfig.textMultiplier,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "133 sounds",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 1.8 * SizeConfig.textMultiplier,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 7 * SizeConfig.heightMultiplier,
              ),
              Text(
                titles[selectedIndex],
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 4 * SizeConfig.textMultiplier,
                    letterSpacing: 0.5),
              ),
              SizedBox(
                height: 5 * SizeConfig.heightMultiplier,
              ),
              Expanded(
                child: ListView(
                  children: [
                    _colorContainer("The Forest", "3.15s", "01",
                        Color(0xff5ac786), "assets/images/forest.png"),
                    SizedBox(height: 5 * SizeConfig.heightMultiplier),
                    _colorContainer("Bird Cry", "2.48s", "02",
                        Color(0xff6e74e1), "assets/images/bird.png"),
                    SizedBox(height: 5 * SizeConfig.heightMultiplier),
                    _colorContainer("Sound of Wind", "1.49s", "03",
                        Color(0xfff7bf45), "assets/images/wind.png"),
                    SizedBox(height: 5 * SizeConfig.heightMultiplier),
                    _colorContainer("Rainy Day", "4.05s", "04", Colors.blue,
                        "assets/images/forest.png"),
                    SizedBox(height: 5 * SizeConfig.heightMultiplier),
                    _colorContainer("Icy Weather", "3.22s", "05", Colors.indigo,
                        "assets/images/wind.png"),
                    SizedBox(height: 5 * SizeConfig.heightMultiplier),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _colorContainer(
      String heading, String time, String count, Color color, String asset) {
    return Container(
      width: 100 * SizeConfig.widthMultiplier,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 7 * SizeConfig.widthMultiplier,
          vertical: 4 * SizeConfig.heightMultiplier,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 2.8 * SizeConfig.textMultiplier),
                ),
                Spacer(),
                Icon(
                  Icons.bookmark_border,
                  color: Colors.white,
                  size: 6 * SizeConfig.imageSizeMultiplier,
                ),
              ],
            ),
            SizedBox(height: 0.5 * SizeConfig.heightMultiplier),
            Text(
              time,
              style: TextStyle(
                  color: Colors.white60,
                  fontWeight: FontWeight.w500,
                  fontSize: 2 * SizeConfig.textMultiplier),
            ),
            SizedBox(height: 10 * SizeConfig.heightMultiplier),
            Row(
              children: [
                Text(
                  count,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 8 * SizeConfig.textMultiplier),
                ),
                Spacer(),
                Image.asset(
                  asset,
                  height: 20 * SizeConfig.imageSizeMultiplier,
                  width: 20 * SizeConfig.imageSizeMultiplier,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
