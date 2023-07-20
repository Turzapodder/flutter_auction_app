import 'package:auctionapp/const/colors.dart';
import 'package:auctionapp/utils/shared_preferences.dart';
import 'package:auctionapp/widgets/page_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);


  /* shared preference functions to store username and email */
  Future<void> saveUserName(String? name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name!);
  }

  Future<void> saveEmail(String? email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', email!);
  }
  /*-----------------------------------------*/

  /* Google Authentication and login function */
  signInWithGoogle(BuildContext context) async{
    final GoogleSignInAccount? gUser= await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? gAuth= await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth?.accessToken,
      idToken: gAuth?.idToken,
    );
    UserCredential user = await FirebaseAuth.instance.signInWithCredential(credential);

     saveUserName(user.user?.displayName);
     saveEmail(user.user?.email);
    
    print(SharedPreferenceHelper);


    if(user.user!=null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) => PageContainer()), (Route route) => false);
    }
  }
  /*--------------------------------------------------*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 500,
                  width: double.infinity,
                  child: Image.asset("assets/images/signup.png", fit: BoxFit.cover,)),
              Text("Sign up today and unlock exclusive access to thrilling bidding wars and unbeatable deals.",
              style: TextStyle(fontSize: 18, color: Colors.white), textAlign: TextAlign.center,),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: (){
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PageContainer()),
                  );*/
                  signInWithGoogle(context);
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColor.green,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/google.png", height: 30, width: 30,),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Sign in with Google", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              )
            ],
        ),
      ),
    );
  }
}
