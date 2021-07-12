import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:majorproject_covid19_tracker/homepage.dart';
import 'package:majorproject_covid19_tracker/loading/splashscreen.dart';
import 'package:majorproject_covid19_tracker/login.dart';
import 'package:majorproject_covid19_tracker/login_option.dart';
import 'package:majorproject_covid19_tracker/panels/comments.dart';
import 'package:majorproject_covid19_tracker/signup.dart';
import 'package:majorproject_covid19_tracker/signup_option.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: StartPage.id,
      routes: {
        StartPage.id: (context)=>StartPage(),
        'login_screen': (context)=>Login(),
        'signup_screen': (context)=>SignUp(),
        'splash_screen': (context)=>SplashScreen(),
        'home_screen': (context)=>HomePage(),
        'comment_screen': (context)=>CommentPage(),
      },
      title: 'Major Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.muktaVaaniTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: StartPage(),

    );
  }
}

class StartPage extends StatefulWidget {
  static const String id = 'start_screen';
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {



  bool login = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1C),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            GestureDetector(
              onTap: () {
                setState(() {
                  login = true;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
                height: login ? MediaQuery.of(context).size.height * 0.6 : MediaQuery.of(context).size.height * 0.4,
                child: CustomPaint(
                  painter: CurvePainter(login),
                  child: Container(
                    padding: EdgeInsets.only(bottom: login ? 0 : 55),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          child: login 
                          ? Login()
                          : LoginOption(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  login = false;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
                height: login ? MediaQuery.of(context).size.height * 0.4 : MediaQuery.of(context).size.height * 0.6,
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.only(top: login ? 55 : 0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        child: !login 
                        ? SignUp()
                        : SignUpOption(),
                      ),
                    ),
                  )
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {

  bool outterCurve;

  CurvePainter(this.outterCurve);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xFF4E89F5);
    paint.style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 1.5, outterCurve ? size.height + 10 : size.height - 10, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}