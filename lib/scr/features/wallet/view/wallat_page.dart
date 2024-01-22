import 'package:flutter/material.dart';
import 'package:jenos/scr/common_widgets/appbbutton.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/common_widgets/recent_transaction_card.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/core/util.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidget.customAppbar(context, title: "Account Wallet"),
      body: ListView(
        padding: const EdgeInsets.all(AppSize.defaultPadding),
        children: [
          CustomWidget.walletBalanceCard(context, balance: "3,236.00"),
          const SizedBox(
            height: AppSize.defaultPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomWidget.commonBtn(
                horizontalPadding: 15,
                title: "Withdraw funds",
                bgColor: AppColors.primaryColor,
                textColor: AppColors.white,
                onTap: () {
                  showModalBottomSheet<void>(
                    backgroundColor: AppColors.scaffoldBackground,
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                    ),
                    builder: (BuildContext context) {
                      return showModal(context);
                    },
                  );
                },
              ),
              CustomWidget.commonBtn(
                  horizontalPadding: 15,
                  title: "Request payout",
                  bgColor: AppColors.white,
                  textColor: AppColors.primaryColor,
                  onTap: () {}),
            ],
          ),
          const SizedBox(
            height: AppSize.defaultPadding * 2,
          ),
          CustomWidget.seeAllWidget(context,
              title: "Recent transaction", onTap: () {}),
          const SizedBox(
            height: AppSize.defaultPadding * 2,
          ),
          const RecentTransactionCard(),
          const RecentTransactionCard(),
          const RecentTransactionCard(),
          const RecentTransactionCard(),
          const RecentTransactionCard(),
        ],
      ),
    );
  }

  showModal(context) {
    final Size size = MediaQuery.of(context).size;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20).copyWith(top: 40),
            height: size.height * 0.9,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Request payout",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Util.inputField2(
                    isExternalLabel: true,
                    useExternalText: true,
                    isPrefix: false,
                    isCompulsory: false,
                    fontSizeExternal: 14,
                    borderRadius: 5,
                    borderColor: AppColors.greyColor,
                    bgColor: Colors.white,
                    externalText: "Bank name",
                    hint: "example: Union bank",
                    hintColor: Colors.grey,
                    externalTextColor: Colors.black,
                    prefixIconColor: AppColors.primaryColor,
                    // controller: _auth.firstName,
                    onChanged: (val) {
                      setState(() {
                        // _auth.firstName.text = val;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Util.inputField2(
                    isExternalLabel: true,
                    useExternalText: true,
                    isPrefix: false,
                    isCompulsory: false,
                    fontSizeExternal: 14,
                    borderRadius: 5,
                    borderColor: AppColors.greyColor,
                    bgColor: Colors.white,
                    externalText: "Account number",
                    hint: "0013942345",
                    hintColor: Colors.grey,
                    externalTextColor: Colors.black,
                    prefixIconColor: AppColors.primaryColor,
                    // controller: _auth.firstName,
                    onChanged: (val) {
                      setState(() {
                        // _auth.firstName.text = val;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Util.inputField2(
                    isExternalLabel: true,
                    useExternalText: true,
                    isPrefix: false,
                    isCompulsory: false,
                    fontSizeExternal: 14,
                    borderRadius: 5,
                    borderColor: AppColors.greyColor,
                    bgColor: Colors.white,
                    externalText: "Account name",
                    hint: "Kayode ade",
                    hintColor: Colors.grey,
                    externalTextColor: Colors.black,
                    prefixIconColor: AppColors.primaryColor,
                    // controller: _auth.firstName,
                    onChanged: (val) {
                      setState(() {
                        // _auth.firstName.text = val;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Util.inputField2(
                    isExternalLabel: true,
                    useExternalText: true,
                    isPrefix: false,
                    isCompulsory: false,
                    fontSizeExternal: 14,
                    borderRadius: 5,
                    borderColor: AppColors.greyColor,
                    bgColor: Colors.white,
                    externalText: "Account",
                    hint: "",
                    hintColor: Colors.grey,
                    externalTextColor: Colors.black,
                    prefixIconColor: AppColors.primaryColor,
                    // controller: _auth.firstName,
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 40),
                  AppButton(
                      height: 55,
                      isIcon: false,
                      text: 'Withdraw',
                      onPressed: () async {},
                      color: AppColors.primaryColor,
                      textColor: Colors.white),
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 5,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.cancel,
                color: AppColors.primaryColor,
              ),
            ),
          )
        ],
      );
    });
  }
}
