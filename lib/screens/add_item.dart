import 'dart:io';

import 'package:auctionapp/const/colors.dart';
import 'package:auctionapp/utils/common_widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  File? _image;
  final picker = ImagePicker();
  DateTime dateTime = DateTime(2023, 07, 19, 3, 24);
  TextEditingController datecontroller = TextEditingController();
  String dropdownValue = 'Gadget';

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;
    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() {
      this.dateTime = dateTime;
    });
  }

  Future<DateTime?> pickDate() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
  }

  Future<TimeOfDay?> pickTime() async {
    return await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
    );
  }

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final min = dateTime.minute.toString().padLeft(2, '0');
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColor.green,
            ),
          ),
        ),
        title: Text(
          "Add item for Auction",
          style: TextStyle(color: AppColor.green),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add details of your item",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Please correctly fill up all the information about the product",
                style: TextStyle(color: Colors.white54),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      getImage();
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.white54)),
                      child: _image != null
                          ? Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Icon(
                                Icons.add_circle_outline_rounded,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add item photo",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        "Max 5 MB",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextfield(
                label: 'Product Name',
                hinttext: "Enter Your Product Name",
                type: TextInputType.text,
                size: 5.0,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextfield(
                label: 'Product Description',
                hinttext: "Describe your product",
                type: TextInputType.text,
                size: 100.0,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextfield(
                label: 'Price',
                hinttext: "Minimum Bid Price",
                type: TextInputType.number,
                size: 5.0,
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Auction End Date",
                    style: TextStyle(color: AppColor.green),
                  ),
                  TextField(
                    controller: TextEditingController(
                      text: dateTime != null
                          ? '${_formatNumber(dateTime.day)}/${_formatNumber(dateTime.month)}/${dateTime.year} at ${_formatNumber(dateTime.hour)} Hour ${_formatNumber(dateTime.minute)} Minute'
                          : '',
                    ),
                    style: TextStyle(color: Colors.white),
                    onTap: () {
                      pickDateTime();
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        hintText: 'Choose a suitable date',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.green)),
                        suffixIcon: Icon(
                          Icons.calendar_month,
                          color: AppColor.green,
                        )),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Category',
                style: TextStyle(color: AppColor.green),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.transparent,
                  border: Border.all(color: AppColor.green),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    underline: Container(
                      height: 0,
                      color: Colors.transparent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>[
                      'Gadget',
                      'Art',
                      'Toys',
                      'Cars',
                      'Shoes',
                      'Misc'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColor.green,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(child: Text("Add your product", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
