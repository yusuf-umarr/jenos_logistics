import 'package:flutter/material.dart';
import 'package:jenos/scr/common_widgets/custom_widget.dart';
import 'package:jenos/scr/constant/app_assets.dart';
import 'package:jenos/scr/constant/app_colors.dart';
import 'package:jenos/scr/constant/app_size.dart';

class RecentTransactionCard extends StatelessWidget {
  const RecentTransactionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSize.defaultPadding),
      padding: const EdgeInsets.all(AppSize.defaultPadding / 1.1),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomWidget.imagAvatar(
                size: 40,
                isBorder: false,
                image: Assets.walletCircle,
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Withdrawal ",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Today, 7:10pm ",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "N5000 ",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                "15.12,2023",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 10),
              ),
            ],
          )
        ],
      ),
    );
  }
}
