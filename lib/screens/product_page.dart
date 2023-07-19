
import 'package:auctionapp/const/colors.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final String image;
  final String name;
  final double price;
  final String author;
  const ProductPage({
    required this.image,
    required this.name,
    required this.price,
    required this.author,
    Key? key}) : super(key: key);

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
                  child: Image.asset(widget.image, height: 200, width: 300, fit: BoxFit.cover,),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.name,
                style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Product Description: ",
                style: TextStyle(color: AppColor.secondary),
              ),
              Text(
                "Product Type: Basmati Rice \nBrand: Daawat\nNet weight: 5 kg\nIngredients: Basmati Rice\nit promises a great taste and rich aroma as each grain is naturally aged.",
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
                    child: Center(child: Text("\$${widget.price}", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold),),),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.green,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(child: Text("Place a Bid", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),),
              ),
              SizedBox(
                height: 15,
              ),
              Text("Other Biddings", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(
                height: 15,
              ),
              ListView.separated(
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
                      child: Icon(Icons.person, color: AppColor.primary,),
                    ),
                    title: Text('Turjha Podder', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                    subtitle: Text('12-22-2024',style: TextStyle(color: AppColor.secondary, fontSize: 10),),
                    trailing: Text('\$180', style: TextStyle(color: AppColor.secondary, fontSize: 16, fontWeight: FontWeight.bold),),
                  );
                },
              )


            ],
          ),
          
        ),
      ),
    );
  }
}
