import 'package:flutter/material.dart';
import 'package:news_app/pages/splash/splash_services.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  final splashServices = SplashService();
  @override
  void initState() {
    splashServices.isUserLoggedIn(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ss = MediaQuery.of(context).size;
    final isSmallScreen = ss.width<600;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: const AssetImage('asset/image/splash.gif'),height:ss.height*.4,width:isSmallScreen?ss.width*.7:ss.width*.7),
            const SizedBox(height: 20),
            const Text('Durust 📜 News',style: TextStyle(fontSize: 40,fontFamily: 'Funky02')),
            const SizedBox(height: 20),
            const Text('Stay informed, stay ahead! 🎓✨ Get the latest news instantly',style: TextStyle(fontSize: 20,fontFamily: 'Funky02'),textAlign: TextAlign.center,)
          ]))
    );
  }
}
