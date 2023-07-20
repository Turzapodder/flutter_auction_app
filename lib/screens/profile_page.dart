

import 'package:auctionapp/const/colors.dart';
import 'package:auctionapp/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../widgets/Profile_item_containers.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isPostedSelected = true;
  final String? userName = SharedPreferenceHelper().getUserName();
  final String? userEmail = SharedPreferenceHelper().getEmail();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
              ),
              Stack(
                children: [
                 CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColor.green,
                      child: Image.asset("assets/images/avatar2.png", fit: BoxFit.cover,),
                    ),
                  Positioned(
                      top: 0,
                      right: 120,
                      child: Icon(Icons.verified, color: Colors.white,))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text("$userName", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.email, color: AppColor.green,size: 15,),
                  SizedBox(width: 8,),
                  Text("$userEmail", style: TextStyle(color: Colors.white),)
                ],
              ),
              SizedBox(
                height: 30,
              ),

              Container(
                height: 30,
                width: 150,
                child: ToggleButtons(
                  borderRadius: BorderRadius.circular(30),
                  selectedColor: Colors.black,
                  borderColor: AppColor.green,
                  color: Colors.white,
                  fillColor: AppColor.green,
                  isSelected: [_isPostedSelected, !_isPostedSelected],
                  onPressed: (index) {
                    setState(() {
                      _isPostedSelected = index == 0;
                    });
                  },
                  children:  [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 0),
                      child: Text('Posted',),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 0),

                      child: Text('Owned'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _isPostedSelected ? PostedContainer() : OwnedContainer(),

            ],
          ),
        ),
      ),
    );
  }
}
