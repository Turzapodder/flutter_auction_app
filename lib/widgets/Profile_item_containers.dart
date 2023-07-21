import 'package:auctionapp/const/colors.dart';
import 'package:auctionapp/const/shared_preferences.dart';
import 'package:auctionapp/utils/server/Firebase_store_fetch.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class PostedContainer extends StatelessWidget {
  FirestoreService firestoreFetch = FirestoreService();
  final String? userEmail = SharedPreferenceHelper().getEmail();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: AppColor.green),
            borderRadius: BorderRadius.circular(20)),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: firestoreFetch.fetchProductsByUserEmail(userEmail!), // Replace with the user's email
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColor.primary,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error fetching products: ${snapshot.error}"),
              );
            } else {
              List<Map<String, dynamic>> productList = snapshot.data ?? [];
              return ListView.separated(
                shrinkWrap: true,
                itemCount: productList.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.white,
                ),
                itemBuilder: (context, index) {
                  Map<String, dynamic> productData = productList[index];
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: Image.network(productData['productPhotoUrl'], fit: BoxFit.cover,),
                      ),
                    ),
                    title: Text(
                      "Title: ${productData['product_name']}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    subtitle: Text(
                      "Ending on ${DateFormat('MM-dd-yyyy').format(productData['BiddingEnd'].toDate())}",
                      style: TextStyle(
                        color: AppColor.secondary,
                        fontSize: 10,
                      ),
                    ),
                    trailing: Text(
                      '\$${productData['minimumBidPrice']}',
                      style: TextStyle(
                        color: AppColor.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}


class OwnedContainer extends StatelessWidget {
  FirestoreService firestoreFetch = FirestoreService();
  final String? userEmail = SharedPreferenceHelper().getEmail();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2, color: AppColor.green),
        ),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: firestoreFetch.fetchProductsByWinner(userEmail!), // Replace with the user's email
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColor.primary,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error fetching products: ${snapshot.error}"),
              );
            } else {
              List<Map<String, dynamic>> productList = snapshot.data ?? [];
              return ListView.separated(
                shrinkWrap: true,
                itemCount: productList.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.white,
                ),
                itemBuilder: (context, index) {
                  Map<String, dynamic> productData = productList[index];
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: Image.network(productData['productPhotoUrl'], fit: BoxFit.cover,),
                      ),
                    ),
                    title: Text(
                      "Title: ${productData['product_name']}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    subtitle: Text(
                      "Ending on ${DateFormat('MM-dd-yyyy').format(productData['BiddingEnd'].toDate())}",
                      style: TextStyle(
                        color: AppColor.secondary,
                        fontSize: 10,
                      ),
                    ),
                    trailing: Text(
                      '\$${productData['minimumBidPrice']}',
                      style: TextStyle(
                        color: AppColor.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
