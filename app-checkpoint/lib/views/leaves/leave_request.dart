import 'package:checkpoint/widgets/background/background.dart';
import 'package:checkpoint/widgets/buttons/text_buttons.dart';
import 'package:checkpoint/widgets/textfields/custom_texfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uicons_pro/uicons_pro.dart';

class LeaveRequest extends StatefulWidget {
  const LeaveRequest({super.key});

  @override
  State<LeaveRequest> createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {
  TextEditingController fromDatecontroller = TextEditingController();
  TextEditingController toDatecontroller = TextEditingController();
  TextEditingController reasoncontroller = TextEditingController();

  final TextEditingController textEditingController = TextEditingController();

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(screenWidth * .6, screenHeight * 0.25),
              painter: BackgroundPainter0(),
            ),
            Positioned(
              top: screenHeight * 0.4,
              right: -20,
              child: CustomPaint(
                size: Size(screenWidth * .21, screenHeight * 0.13),
                painter: BackgroundPainter1(),
              ),
            ),
            Positioned(
              top: screenHeight * 0.75,
              left: -30,
              child: CustomPaint(
                size: Size(screenWidth * .25, screenHeight * 0.126),
                painter: BackgroundPainter2(),
              ),
            ),
            Positioned(
              top: screenHeight * 0.8,
              right: -10,
              child: CustomPaint(
                size: Size(screenWidth * .5, screenHeight * 0.126),
                painter: BackgroundPainter3(),
              ),
            ),
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    Text(
                      "Apply For Leave",
                      style: GoogleFonts.outfit(
                          fontSize: 25,
                          color: const Color.fromRGBO(73, 84, 99, 1),
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * .04,
                          vertical: screenHeight * .03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'From Date',
                                      style: GoogleFonts.redHatDisplay(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                    CustomTextfield(
                                        suffix: GestureDetector(
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime(2100));

                                            if (pickedDate != null) {
                                              String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(pickedDate);
                                              setState(() {
                                                fromDatecontroller.text =
                                                    formattedDate;
                                              });
                                            }
                                          },
                                          child: Icon(
                                            UIconsPro
                                                .regularRounded.calendar,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        hint: "Enter Date",
                                        controller: fromDatecontroller,
                                        keyboardType: TextInputType.datetime,
                                        obscureText: false),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'To Date',
                                      style: GoogleFonts.redHatDisplay(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                    CustomTextfield(
                                        suffix: GestureDetector(
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime(2100));

                                            if (pickedDate != null) {
                                              String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(pickedDate);
                                              setState(() {
                                                toDatecontroller.text =
                                                    formattedDate;
                                              });
                                            }
                                          },
                                          child: Icon(
                                            UIconsPro
                                                .regularRounded.calendar,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        hint: "Enter Date",
                                        controller: toDatecontroller,
                                        keyboardType: TextInputType.datetime,
                                        obscureText: false),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * .02,
                          ),
                          Text(
                            'Choose Leave type',
                            style: GoogleFonts.redHatDisplay(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Select Item',
                                      style: GoogleFonts.redHatDisplay(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: items
                                  .map(
                                      (String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: GoogleFonts.redHatDisplay(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value;
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 50,
                                width: screenWidth * .45,
                                padding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // Shadow color
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                              ),
                              iconStyleData: IconStyleData(
                                icon: Icon(
                                    UIconsPro.regularRounded.angles_up_down),
                                iconSize: 14,
                              ),
                              dropdownStyleData: const DropdownStyleData(
                                maxHeight: 150,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * .02,
                          ),
                          Text(
                            'Reason',
                            style: GoogleFonts.redHatDisplay(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          CustomTextfield(
                            hint: "Enter Reason",
                            controller: reasoncontroller,
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            lines: 3,
                          ),
                          SizedBox(
                            height: screenHeight * .02,
                          ),
                          SizedBox(
                            width: screenHeight,
                            child: TextButtonWithGradient(
                              onPressed: (p0) {},
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xff2789e4),
                                  Color(0xff6c77d0),
                                  Color(0xff9b6bd2)
                                ],
                                stops: [0.16, 0.5, 0.87],
                                begin: Alignment.bottomRight,
                                end: Alignment.topLeft,
                              ),
                              child: Text(
                                'Submit',
                                style: GoogleFonts.outfit(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
