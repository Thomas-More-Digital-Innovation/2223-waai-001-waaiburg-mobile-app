import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'jongeren',
          builder: (BuildContext context, GoRouterState state) {
            return const JongerenScreen();
          },
        ),
        GoRoute(
          path: 'volwassenen',
          builder: (BuildContext context, GoRouterState state) {
            return const VolwassenenScreen();
          },
        ),
        GoRoute(
          path: 'nieuwtjes',
          builder: (BuildContext context, GoRouterState state) {
            return const NieuwtjesScreen();
          },
        ),
        GoRoute(
          path: 'website',
          builder: (BuildContext context, GoRouterState state) {
            return const WebsiteScreen();
          },
        ),
      ],
    ),
  ],
);

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

class BackgroundPainter4 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.shader = const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: <Color>[
        Color(0xFFF25B58),
        Color(0xFFF38E3B),
      ],
    ).createShader(Rect.fromPoints(const Offset(0, 0), Offset(width, height)));

    canvas.drawPath(mainBackground, paint);

    Path topRightTriangle = Path();
    topRightTriangle.addPolygon(
        [
          Offset(width * 0.75, 0),
          Offset(width, 0),
          Offset(width, height * 0.12),
        ], //Lijst van punten
        true //Close is true, het begin punt en eind punt wordt verbonden
        );
    paint.color = Colors.white;
    paint.shader = null;
    canvas.drawPath(topRightTriangle, paint);

    Path bottomLeftTriangle = Path();
    bottomLeftTriangle.addPolygon(
        [
          Offset(0, height * 0.75),
          Offset(width * 0.45, height),
          Offset(0, height),
        ], //Lijst van punten
        true //Close is true, het begin punt en eind punt wordt verbonden
        );
    paint.color = Colors.white;
    canvas.drawPath(bottomLeftTriangle, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

/// The home screen
class HomeScreen extends StatelessWidget {
  /// Constructs a [HomeScreen]
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).primaryColorDark,
            Theme.of(context).primaryColorLight,
          ], begin: Alignment.topLeft),
        ),
        child: CustomPaint(
          painter: BackgroundPainter4(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Titel
                Column(
                  children: [
                    Center(
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: screenHeight * 0.05,
                              bottom: screenHeight * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "De Waaiburg",
                                style: GoogleFonts.poppins(
                                    color: const Color(0xFFF3D015),
                                    shadows: [
                                      Shadow(
                                          color: Theme.of(context).shadowColor,
                                          offset: const Offset(0, 3),
                                          blurRadius: 15)
                                    ],
                                    fontWeight: FontWeight.w900,
                                    fontSize: 48),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "VZW",
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xFFF3D015),
                                      shadows: [
                                        Shadow(
                                            color:
                                                Theme.of(context).shadowColor,
                                            offset: const Offset(0, 3),
                                            blurRadius: 15)
                                      ],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Menu
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.count(
                      padding: const EdgeInsets.only(top: 00.0, bottom: 10.0),
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1,
                      primary: false,
                      shrinkWrap: false,
                      children: [
                        buildMenuButton(context = context,
                            name: "JONGEREN",
                            iconData: FontAwesomeIcons.child,
                            iconColor: Theme.of(context).colorScheme.secondary),
                        buildMenuButton(context = context,
                            name: "VOLWASSENEN",
                            iconData: FontAwesomeIcons.userTie,
                            iconColor: const Color(0xBBFFFFFF)),
                        buildMenuButton(context = context,
                            name: "NIEUWTJES",
                            iconData: FontAwesomeIcons.newspaper,
                            iconColor: const Color(0xBBFFFFFF)),
                        buildMenuButton(context = context,
                            name: "WEBSITE",
                            iconData: FontAwesomeIcons.globe,
                            iconColor: Theme.of(context).colorScheme.secondary),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuButton(
    BuildContext context, {
    String name = "Button",
    IconData iconData = Icons.device_unknown,
    Color iconColor = Colors.white,
  }) {
    return GestureDetector(
      onTap: () => context.go('/$name'),
      child: Container(
        margin: const EdgeInsets.all(0.0),
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
            color: Colors.white.withAlpha(64),
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            children: [
              FaIcon(
                iconData,
                color: iconColor,
                size: 82,
              ),
              const SizedBox(height: 15), // padding tussen icon en tekst
              Text(
                name,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    shadows: [
                      const Shadow(
                        blurRadius: 5,
                        color: Colors.black45,
                        offset: Offset(0, 2),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The jongeren screen
class JongerenScreen extends StatelessWidget {
  /// Constructs a [JongerenScreen]
  const JongerenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jongeren Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <ElevatedButton>[
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go back to the Home screen'),
            ),
          ],
        ),
      ),
    );
  }
}

/// The volwassenen screen
class VolwassenenScreen extends StatelessWidget {
  /// Constructs a [VolwassenenScreen]
  const VolwassenenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Volwassenen Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <ElevatedButton>[
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go back to the Home screen'),
            ),
          ],
        ),
      ),
    );
  }
}

/// The nieuwtjes screen
class NieuwtjesScreen extends StatelessWidget {
  /// Constructs a [NieuwtjesScreen]
  const NieuwtjesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nieuwtjes Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <ElevatedButton>[
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go back to the Home screen'),
            ),
          ],
        ),
      ),
    );
  }
}

/// The website screen
/// This screen is a webview
class WebsiteScreen extends StatelessWidget {
  /// Constructs a [WebsiteScreen]
  const WebsiteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Website Screen')),
    );
  }
import 'package:mobileapp/pages/adult_info_segments.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Poppins'),
    //initialRoute: '/',
    routes: {
      '/': (context) => const AdultInfoSegments(),
      // '/HomeScreen': (context) => Home(),
    },
  ));
}
