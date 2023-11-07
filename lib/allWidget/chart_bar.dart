import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  late final String lable; //detect the week day
  late final double spendingAmount;
  late final double spendingPctofTotal;

  ChartBar(this.lable, this.spendingAmount, this.spendingPctofTotal);
  @override
  Widget build(BuildContext context) {
    print('build() ChartBar');
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: <Widget>[
            Container(
              height:
                  constraints.maxHeight * 0.15, 
              child: FittedBox(
                  child: Text('\$${spendingAmount.toStringAsFixed(0)}')),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height:
                  constraints.maxHeight * 0.6, 
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPctofTotal, 
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(lable),
              ),
            ),
          ],
        );
      },
    );
  }
}
