import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenos/scr/common_widgets/appbbutton.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/common_widgets/navigation.dart';
import 'package:jenos/scr/common_widgets/recent_transaction_card.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';
import 'package:jenos/scr/core/util/enums.dart';
import 'package:jenos/scr/core/util/util.dart';
import 'package:jenos/scr/features/bottom_bar/views/bottom_bar.dart';
import 'package:jenos/scr/features/wallet/controller/wallet_controller.dart';

class WalletPage extends ConsumerStatefulWidget {
  const WalletPage({super.key});

  @override
  ConsumerState<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends ConsumerState<WalletPage> {
  final _rkey = GlobalKey<FormState>();

  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _acctNameController = TextEditingController();
  final TextEditingController _acctNumberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _bankNameController.dispose();
    _acctNameController.dispose();
    _acctNumberController.dispose();
    _amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidget.customAppbar(context, title: "Account Wallet"),
      body: ListView(
        padding: const EdgeInsets.all(AppSize.defaultPadding),
        children: [
          CustomWidget.walletBalanceCard(context, balance: "0.00"),
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
              // CustomWidget.commonBtn(
              //     horizontalPadding: 15,
              //     title: "Request payout",
              //     bgColor: AppColors.white,
              //     textColor: AppColors.primaryColor,
              //     onTap: () {}),
            ],
          ),
          const SizedBox(
            height: AppSize.defaultPadding * 2,
          ),
          CustomWidget.seeAllWidget(
            context,
            desc: "",
            title: "Recent transaction",
            onTap: () {},
            isArrow: false,
          ),
          const SizedBox(
            height: AppSize.defaultPadding * 2,
          ),
          // const RecentTransactionCard(),
          // const RecentTransactionCard(),
          // const RecentTransactionCard(),
          // const RecentTransactionCard(),
          // const RecentTransactionCard(),
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
            height: MediaQuery.of(context).viewInsets.bottom == 0
                ? size.height * 0.9
                : size.height * 1,
            child: SingleChildScrollView(
              child: Form(
                key: _rkey,
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
                      externalText: "Bank name",
                      hint: "example: Union bank",
                      validator: Util.validateName,
                      controller: _bankNameController,
                    ),
                    const SizedBox(height: 20),
                    Util.inputField2(
                      inputType: TextInputType.number,
                      externalText: "Account number",
                      hint: "0013942345",
                      validator: Util.validateName,
                      controller: _acctNumberController,
                    ),
                    const SizedBox(height: 20),
                    Util.inputField2(
                      externalText: "Account name",
                      hint: "Kayode ade",
                      validator: Util.validateName,
                      controller: _acctNameController,
                    ),
                    const SizedBox(height: 20),
                    Util.inputField2(
                        inputType: TextInputType.number,
                        externalText: "Amount",
                        hint: "1000",
                        validator: Util.validateName,
                        controller: _amountController),
                    const SizedBox(height: 40),
                    Consumer(builder: (context, ref, _) {
                      final loadState = ref.watch(walletController).loadState;

                      return AppButton(
                          isLoading: loadState == NetworkState.loading,
                          height: 55,
                          isIcon: false,
                          text: 'Withdraw',
                          onPressed: () async {
                            // FocusScope.of(context).unfocus();

                            if (_rkey.currentState!.validate()) {
                              ref.read(walletController.notifier).withdrawFund(
                                    _bankNameController.text,
                                    int.parse(_acctNumberController.text),
                                    _acctNameController.text,
                                    _amountController.text,
                                    context,
                                  );
                              Future.delayed(Duration(seconds: 1), () {
                                navigate(context, const BottomBar());
                                // Navigator.pop(context);
                              });
                            }
                          },
                          color: AppColors.primaryColor,
                          textColor: Colors.white);
                    }),
                  ],
                ),
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
