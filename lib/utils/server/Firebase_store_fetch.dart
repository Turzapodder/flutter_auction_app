import 'dart:io';
import 'package:auctionapp/const/shared_preferences.dart';
import 'package:auctionapp/widgets/page_container.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../common_methods/methods.dart';

class FirestoreService {

  CommonMethods methods = CommonMethods();


  Future<void> uploadAuctionData(BuildContext context,
      String product_name,
      String type,
      String min_price,
      DateTime endDate,
      String desc,
      String author,
      String author_email,
      File photo,) async {
    try {
      final storage = FirebaseStorage.instance;
      final storageRef = storage.ref();

      final photo1Ref = storageRef.child(
          'AuctionProduct/$product_name - $author/Product.jpg');
      final uploadTask1 = await photo1Ref.putFile(photo);

      final productPicUrl = await uploadTask1.ref.getDownloadURL();

      final firestore = FirebaseFirestore.instance;
      final userCollection = firestore.collection('Auctions');

      final userDocument = userCollection.doc('$product_name-$author_email');

      await userDocument.set({
        'product_name': product_name,
        'type': type,
        'description': desc,
        'minimumBidPrice': min_price,
        'BiddingEnd': endDate,
        'posted-by': author,
        'Poster_email': author_email,
        'status': 'running',
        'productPhotoUrl': productPicUrl,
        'winner': 'none',
        'currentBid': min_price,
      });
      methods.showSimpleToast("Your Product has been Uploaded");

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => PageContainer()),
            (Route<dynamic> route) => false,
      );
    } catch (e) {
      print('Error uploading auction data: $e');
    }
  }

  Future<void> placeBid(String productID,
      String bidderName,
      String biddingPrice,
      String balance,) async {
    try {
      double bidAmount = double.parse(biddingPrice);
      double currentBalance = double.parse(balance);

      if (bidAmount <= currentBalance) {
        double remainingBalance = currentBalance - bidAmount;
        if (remainingBalance < 0) {
          methods.showSimpleToast("Insufficient Balance!");
          return;
        }

        final CollectionReference bidsCollection =
        FirebaseFirestore.instance.collection('Bids');
        final CollectionReference auctionCollection =
        FirebaseFirestore.instance.collection('Auctions');

        DocumentReference newBidDocRef = bidsCollection.doc();
        String bidID = newBidDocRef.id;

        Map<String, dynamic> bidData = {
          'product-id': productID,
          'Bidder_name': bidderName,
          'Bidding_price': bidAmount,
          'Bidding_date': DateTime.now(),
        };

        await newBidDocRef.set(bidData);

        methods.showSimpleToast("Bid placed Successfully!");

        SharedPreferenceHelper().saveBalance2(remainingBalance.toString());

        await FirebaseFirestore.instance.runTransaction((transaction) async {
          DocumentReference auctionDocRef = auctionCollection.doc(productID);
          DocumentSnapshot auctionSnapshot = await transaction.get(
              auctionDocRef);
          double currentBid = double.parse(
              auctionSnapshot.get('currentBid') ?? '0');
          if (bidAmount > currentBid) {
            transaction.update(
                auctionDocRef, {'currentBid': bidAmount.toString()});
          }
        });
      } else {
        methods.showSimpleToast(
            'Bidding price is greater than the available balance.');
      }
    } catch (e) {
      print('Error placing bid: $e');
    }
  }


  Future<String?> updateStatusToCompleted(String documentID) async {
    try {
      final CollectionReference auctionsCollection =
      FirebaseFirestore.instance.collection('Auctions');
      final CollectionReference bidsCollection =
      FirebaseFirestore.instance.collection('Bids');

      QuerySnapshot bidsSnapshot =
      await bidsCollection.where('product-id', isEqualTo: documentID).get();

      double highestBidPrice = 0;
      String winner = '';


      for (var bidDoc in bidsSnapshot.docs) {
        double bidPrice = bidDoc['Bidding_price'];
        if (bidPrice > highestBidPrice) {
          highestBidPrice = bidPrice;
          winner = bidDoc['Bidder_name'];
        }
      }

      if (highestBidPrice > 0) {
        await auctionsCollection.doc(documentID).update({
          'status': 'completed',
          'winner': winner,
        });

        print('Status updated to Completed successfully');
        return winner;
      } else {
        print('No bids found for the documentID');
      }
    } catch (e) {
      print('Error updating status: $e');
    }
  }


  Future<List<Map<String, dynamic>>> fetchProductsAll() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Auctions')
          .get();

      List<Map<String, dynamic>> productList = querySnapshot.docs.map((
          doc) => doc.data() as Map<String, dynamic>).toList();
      return productList;
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchProductsByUserEmail(
      String userEmail) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Auctions')
          .where('Poster_email', isEqualTo: userEmail)
          .get();

      List<Map<String, dynamic>> productList =
      querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      return productList;
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchProductsByWinner(
      String userName) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Auctions')
          .where('winner', isEqualTo: userName)
          .get();

      List<Map<String, dynamic>> productList =
      querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      return productList;
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }


  Future<List<Map<String, dynamic>>> fetchProductsByType(
      String productType) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Auctions')
          .where('type', isEqualTo: productType)
          .where('status', isEqualTo: 'running')
          .get();

      List<Map<String, dynamic>> productList = querySnapshot.docs.map((
          doc) => doc.data() as Map<String, dynamic>).toList();
      return productList;
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchCompletedProducts() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Auctions')
          .where('status', isEqualTo: "completed")
          .get();

      List<Map<String, dynamic>> productList = querySnapshot.docs.map((
          doc) => doc.data() as Map<String, dynamic>).toList();
      return productList;
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchBidsForProduct(
      String productID) async {
    try {
      final CollectionReference bidsCollection =
      FirebaseFirestore.instance.collection('Bids');

      QuerySnapshot snapshot =
      await bidsCollection.where('product-id', isEqualTo: productID).get();

      List<Map<String, dynamic>> bids = [];
      snapshot.docs.forEach((doc) {
        bids.add(doc.data() as Map<String, dynamic>);
      });

      return bids;
    } catch (e) {
      print('Error fetching bids: $e');
      return [];
    }
  }

  Future<List<double>> getAuctionStats() async {
    try {
      final CollectionReference auctionsCollection =
      FirebaseFirestore.instance.collection('Auctions');
      final CollectionReference bidsCollection =
      FirebaseFirestore.instance.collection('Bids');

      QuerySnapshot runningBidsSnapshot =
      await auctionsCollection.where('status', isEqualTo: 'running').get();
      int runningCount = runningBidsSnapshot.size;

      QuerySnapshot completedSnap =
      await auctionsCollection.where('status', isEqualTo: 'completed').get();
      int completeCount = completedSnap.size;

      double totalValue = 0;
      completedSnap.docs.forEach((auctionDoc) {
        double currentBid = double.parse(auctionDoc['currentBid']);
        totalValue += currentBid;
      });

      QuerySnapshot totalBidsSnapshot = await bidsCollection.get();
      int totalBids = totalBidsSnapshot.size;

      return [ totalBids.toDouble(),  runningCount.toDouble(), completeCount.toDouble(), totalValue, ];
    } catch (e) {
      print('Error fetching auction stats: $e');
      return [];
    }
  }

}
