import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jenos/scr/common_widgets/appbbutton.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';

class StatusUpdatePage extends StatefulWidget {
  const StatusUpdatePage({super.key});

  @override
  State<StatusUpdatePage> createState() => _StatusUpdatePageState();
}

class _StatusUpdatePageState extends State<StatusUpdatePage> {
  bool switchValueOne = false;
  bool switchValueTwo = false;
  bool switchValueThree = false;
  bool switchValueFour = false;
  bool switchValueFive = false;

  List stepperList = [
    {
      "id": 0,
      "title": "On the way to receive item",
      "desc": "Confirmation Time:",
      "time": "",
    },
    {
      "id": 1,
      "title": "Received item from requester",
      "desc": "Confirmation Time:",
      "time": "",
    },
    {
      "id": 2,
      "title": "On the way to receiver",
      "desc": "Confirmation Time:",
      "time": "",
    },
    {
      "id": 3,
      "title": "Item has been delivered",
      "desc": "Confirmation Time:",
      "time": "",
    },
    {
      "id": 4,
      "title": "Payment has been made",
      "desc": "Confirmation Time:",
      "time": "",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidget.customAppbar(
        context,
        title: "Staus update",
        isArrow: true,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: AppSize.defaultPadding * 2,
          ),
          Container(
            decoration: const BoxDecoration(color: AppColors.white),
            padding: const EdgeInsets.all(AppSize.defaultPadding),
            child: Column(
              children: [
                stepperCard(
                  context,
                  title: "On the way to receive item",
                  desc: "Confirmation Time:",
                  time: "1:30pm",
                  isStepped: switchValueOne,
                  onChange: (value) {
                    if (!switchValueTwo) {
                      setState(() {
                        switchValueOne = value;
                      });
                    }
                  },
                ),
                stepperCard(
                  context,
                  title: "Received item from requester",
                  desc: "Confirmation Time:",
                  time: "",
                  isStepped: switchValueTwo,
                  onChange: (value) {
                    if (switchValueOne) {
                      setState(() {
                        switchValueTwo = value;
                      });
                    }
                  },
                ),
                stepperCard(
                  context,
                  title: "On the way to receiver",
                  desc: "Confirmation Time:",
                  time: "",
                  isStepped: switchValueThree,
                  onChange: (value) {
                    if (switchValueTwo) {
                      setState(() {
                        switchValueThree = value;
                      });
                    }
                  },
                ),
                stepperCard(
                  context,
                  title: "Item has been delivered",
                  desc: "Confirmation Time:",
                  time: "",
                  isStepped: switchValueFour,
                  onChange: (value) {
                    if (switchValueThree) {
                      setState(() {
                        switchValueFour = value;
                      });
                    }
                  },
                ),
                stepperCard(
                  context,
                  title: "Payment has been made",
                  desc: "Confirmation Time:",
                  time: "",
                  isStepped: switchValueFive,
                  isShowLine: false,
                  onChange: (value) {
                    if (switchValueFour) {
                      setState(() {
                        switchValueFive = value;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSize.defaultPadding,
            ),
            child: AppButton(
                text: "Close",
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          )
        ],
      ),
    );
  }

  stepperCard(BuildContext context,
      {String title = "",
      String desc = "",
      String time = "",
      bool isStepped = false,
      bool isShowLine = true,
      Function(bool)? onChange}) {
    return Stack(
      children: [
        Container(
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: isStepped
                              ? AppColors.primaryColor
                              : AppColors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  isStepped ? AppColors.dark : AppColors.grey,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      value: isStepped,
                      activeColor: AppColors.primaryColor,
                      onChanged: onChange,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  "$desc   $time",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
         isShowLine
            ?
        Positioned(
          left: 5,
          top: 30,
          child: DottedDashedLine(
            height: 100,
            width: 100,
            axis: Axis.vertical,
            dashColor: isStepped ? AppColors.primaryColor : AppColors.grey,
          ),
        ):const SizedBox.shrink()
      ],
    );
  }
}
