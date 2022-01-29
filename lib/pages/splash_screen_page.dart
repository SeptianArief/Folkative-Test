part of 'pages.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    startNavigate();
  }

  startNavigate() async {
    var _duration = const Duration(seconds: 2);
    // BlocProvider.of<UserCubit>(context).loadSession();
    return Timer(_duration, () async {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const MainPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.3,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
