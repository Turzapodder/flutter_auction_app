import 'package:auctionapp/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

class ProductPage extends StatefulWidget {
  final String image;
  final String name;
  final String price;
  final String author;
  final String desc;
  final DateTime time;
  const ProductPage(
      {required this.image,
      required this.name,
      required this.price,
      required this.author,
        required this.desc,
        required this.time,
      Key? key})
      : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

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
                    "Minimum Bid Price: ",
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
                  buildShowModalBottomSheet(context, widget.time);
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
              BidderListView()
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context, DateTime time) {
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
                              SlideCountdown(
                                textStyle: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
                                separatorType: SeparatorType.symbol,
                                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                duration: Duration(days: time.day,
                                hours: time.hour,
                                minutes: time.minute,
                                seconds: time.second),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  color: AppColor.primary,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
  }
}

class BidderListView extends StatelessWidget {
  const BidderListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 2,
      separatorBuilder: (context, index) => Divider(
        color: Colors.white,
      ),
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColor.green,
            child: Icon(
              Icons.person,
              color: AppColor.primary,
            ),
          ),
          title: Text(
            'Turjha Podder',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '12-22-2024',
            style: TextStyle(color: AppColor.secondary, fontSize: 10),
          ),
          trailing: Text(
            '\$180',
            style: TextStyle(
                color: AppColor.secondary,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}