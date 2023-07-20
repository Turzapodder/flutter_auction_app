import 'package:auctionapp/const/colors.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<GridItem> gridItems = [
    GridItem(Icons.align_vertical_bottom_outlined, 'Total Number of Bids in this app','100'),
    GridItem(Icons.assignment_outlined, 'Currently running Number of bids', '57'),
    GridItem(Icons.brightness_high_outlined, 'Total Number of Completed Bids', '43'),
    GridItem(Icons.price_change_rounded, 'Total Auction Value Amount', '30000.0'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            SizedBox(height: 30,),
            Row(
              children: const [
                Icon(Icons.menu_rounded, color: Colors.white,),
                SizedBox(width: 10,),
                Text("Dashboard", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
              ],
            ),
            Container(
              height: 360,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                ),
                itemCount: gridItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColor.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(gridItems[index].icon,color: AppColor.primary, size: 30,),
                        SizedBox(height: 10,),
                        Text(gridItems[index].title, style: TextStyle(fontSize: 13),),
                        SizedBox(height: 10,),
                        Text(gridItems[index].number, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
                      ],
                    )
                  );
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Icon(Icons.insert_chart_outlined, size: 30, color: Colors.white,),
                SizedBox(width: 8,),
                Text("Summary Charts", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),)
              ],
            )
          ],
        ),
      )
    );
  }
}

class GridItem {
  final IconData icon;
  final String title;
  final String number;

  GridItem( this.icon, this.title, this.number);
}
