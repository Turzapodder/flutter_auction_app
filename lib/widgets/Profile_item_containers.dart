import 'package:auctionapp/const/colors.dart';
import 'package:flutter/material.dart';


class PostedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: AppColor.green),
        borderRadius: BorderRadius.circular(20)
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 10,
        separatorBuilder: (context, index) => Divider(
          color: Colors.white,
        ),
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColor.green,
              child: Icon(Icons.person, color: AppColor.primary,),
            ),
            title: Text('Turjha Podder', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
            subtitle: Text('12-22-2024',style: TextStyle(color: AppColor.secondary, fontSize: 10),),
            trailing: Text('\$180', style: TextStyle(color: AppColor.secondary, fontSize: 16, fontWeight: FontWeight.bold),),
          );
        },
      )
    ),);
  }
}

class OwnedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2, color: AppColor.green),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: 10,
          separatorBuilder: (context, index) => Divider(
            color: Colors.white,
          ),
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColor.green,
                child: Icon(Icons.person, color: AppColor.primary,),
              ),
              title: Text('Turjha Podder', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
              subtitle: Text('12-22-2024',style: TextStyle(color: AppColor.secondary, fontSize: 10),),
              trailing: Text('\$180', style: TextStyle(color: AppColor.secondary, fontSize: 16, fontWeight: FontWeight.bold),),
            );
          },
        )
      ),
    );
  }
}
