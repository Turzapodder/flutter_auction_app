import 'package:auctionapp/const/colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
              Container(
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
              )
            ],
        ),
      ),
    );
  }
}
