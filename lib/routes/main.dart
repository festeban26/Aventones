import 'package:aventones/res/company_colors.dart';
import 'package:aventones/routes/post.dart';
import 'package:aventones/widgets/drawer/menu_page.dart';
import 'package:aventones/widgets/drawer/zoom_scaffold.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aventones',
      theme: ThemeData(
          primaryColor: CompanyColors.customBlack,
          // This is the theme of your application.
          // TODO primarySwatch: Colors.blue Modify Swatch
          primaryTextTheme: Typography().white,
          textTheme: Typography().white,
          iconTheme: IconThemeData(color: CompanyColors.green)),
      home: MyHomePage(title: 'Aventones'),
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('es'), // Spanish
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  MenuController menuController;

  @override
  void initState() {
    super.initState();

    menuController = new MenuController(
      vsync: this,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    return ChangeNotifierProvider(
      builder: (context) => menuController,
      child: ZoomScaffold(
        menuScreen: MenuScreen(),
        contentScreen: Layout(
            contentBuilder: (cc) => Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(60, 67, 73, .99),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32.0),
                              topRight: Radius.circular(32.0)),
                        ),
                        width: double.infinity,
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "Viajes compartidos y seguros",
                            style: TextStyle(
                                fontFamily: 'Casual',
                                fontStyle: FontStyle.italic,
                                fontSize: 16.0),
                          ),
                        )),
                      ),
                      Expanded(
                        child: Container(
                          color: CompanyColors.homeScreenLightGray,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("¿Necesitas un puesto?",
                                  style: TextStyle(
                                      color: CompanyColors.green,
                                      fontFamily: 'Casual',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0)),
                              SizedBox(height: 16), // Space between widgets
                              Center(
                                child: Container(
                                  padding: EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: CompanyColors.green),
                                  child: Icon(Icons.search,
                                      color: CompanyColors.customWhite,
                                      size: 80),
                                ),
                              ),
                            ],
                          ),
                        ),
                        flex: 5,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostScreen()),
                            );
                          },
                          child: Container(
                            color: CompanyColors.customWhite,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("¿Tienes un puesto libre?",
                                    style: TextStyle(
                                        color: CompanyColors.blue,
                                        fontFamily: 'Casual',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0)),
                                SizedBox(height: 16), // Space between widgets
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: CompanyColors.blue),
                                    child: Icon(Icons.add,
                                        color: CompanyColors.customWhite,
                                        size: 80),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        flex: 5,
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}
