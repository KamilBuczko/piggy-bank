import 'package:flutter/material.dart';
import 'package:skarbonka/utils/number_utils.dart';
import 'package:skarbonka/widgets/app_tooltip.dart';

class ExpenseTabBottomBar extends StatelessWidget {
  final double monthlyBalance;
  final double totalSpareAmount;

  ExpenseTabBottomBar({this.monthlyBalance, this.totalSpareAmount});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "BUDŻET",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(color: Theme.of(context).primaryColorLight),
                    ),
                    SizedBox(width: 4,),
                    AppTooltip(
                      message: "Zalecany budżet na obecny miesiąc, przekroczenie lub niewykorzstanie spowoduje odpowiednio zmniejszenie lub zwiększenie budżetu następnych miesięcy",
                      child: Icon(
                          Icons.info_outline,
                          size: 16,
                          color: Theme.of(context).indicatorColor,
                      ),
                    )
                  ],
                ),
                Text(
                  "${format(monthlyBalance)} zł",
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    AppTooltip(
                      message: "Suma oszczędności przeszłych miesiący",
                      child: Icon(
                        Icons.info_outline,
                        size: 16,
                        color: Theme.of(context).indicatorColor,
                      ),
                    ),
                    SizedBox(width: 4,),
                    Text(
                      "OSZCZĘDZONO",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Theme.of(context).primaryColorLight),
                    ),
                  ],
                ),
                Text(
                  "${format(totalSpareAmount)} zł",
                  textAlign: TextAlign.right,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
