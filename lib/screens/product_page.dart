import 'package:auctionapp/const/colors.dart';
import 'package:auctionapp/const/shared_preferences.dart';
import 'package:auctionapp/screens/product_page.dart';
import 'package:auctionapp/utils/common_methods/methods.dart';
import 'package:auctionapp/utils/server/Firebase_store_fetch.dart';
import 'package:auctionapp/widgets/bidding_list_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown/slide_countdown.dart';

class ProductPage extends StatefulWidget {
  final String image;
  final String name;
  final String price;
  final String author;
  final String desc;
  final String email;
  final DateTime time;
  const ProductPage(
      {required this.image,
      required this.name,
      required this.price,
      required this.author,
      required this.desc,
      required this.email,
      required this.time,
      Key? key})
      : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _numberInput;
  bool _isAuctionCompleted = false;

  CommonMethods methods = CommonMethods();
  FirestoreService firestoreService = FirestoreService();
  final String? userEmail = SharedPreferenceHelper().getEmail();
  final String? userName = SharedPreferenceHelper().getUserName();
  final String? balance = SharedPreferenceHelper().getBalance();
  late String? productId = widget.name + "-" + userEmail!;

  late Duration dateTime = methods.calculateRemainingTime(widget.time);

  @override
  void initState() {
    super.initState();
    _checkAuctionStatus();
  }

  void _checkAuctionStatus() {
    DateTime currentTime = DateTime.now();
    if (currentTime.isAfter(widget.time)) {
      firestoreService
          .updateStatusToCompleted(widget.name + "-" + widget.email);
      setState(() {
        _isAuctionCompleted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.green,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Product Details",
          style: TextStyle(color: AppColor.green),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: SizedBox(
                  width: 350,
                  height: 280,
                  child: Image.network(
                    widget.image,
                    height: 200,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.name,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Product Description: ",
                style: TextStyle(color: AppColor.secondary),
              ),
              Text(
                widget.desc,
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "@${widget.author}",
                    style: TextStyle(color: AppColor.secondary),
                  ),
                  Icon(
                    Icons.verified,
                    color: AppColor.green,
                    size: 14,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Current Min. Bid Price: ",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                        color: AppColor.secondary,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Text(
                        "\$${widget.price}",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  buildShowModalBottomSheet(
                      context, widget.time, widget.author);
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColor.green,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Text(
                      "Place a Bid",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              if (_isAuctionCompleted)
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColor.secondary,
                        border: Border.all(width: 1, color: AppColor.secondary),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.celebration_outlined),
                          Text(
                            "Winner: Turjha Podder",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.celebration_outlined)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Text(
                "Other Biddings",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              BidderListView(
                productID: productId!,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(
      BuildContext context, DateTime time, String bidderName) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: AppColor.secondary),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Time Remaining",
                  ),
                  SlideCountdown(
                    textStyle: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    separatorType: SeparatorType.symbol,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    duration: Duration(
                        days: dateTime.inDays,
                        hours: dateTime.inHours,
                        minutes: dateTime.inMinutes,
                        seconds: dateTime.inSeconds),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: AppColor.primary,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Enter Amount",
                    style: TextStyle(fontSize: 16),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Enter a Number',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a number.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _numberInput = value;
                          },
                        ),
                        SizedBox(height: 16),
                        InkWell(
                          onTap: () {
                            if (widget.email == userEmail) {
                              methods.showSimpleToast(
                                  "You can't Place Bid On your Own Listed Item");
                            } else {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                firestoreService.placeBid(productId!, userName!,
                                    _numberInput!, balance!);
                                Navigator.pop(context);

                                setState(() {});
                              }
                            }
                          },
                          child: Container(
                            width: 120,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                                child: Text(
                              "Confirm Bid",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
