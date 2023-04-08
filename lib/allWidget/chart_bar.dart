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
              // height:
              //     20, //we fix height of amount for always same.so that big amount dont impact on bar and amount , day height
              height:
                  constraints.maxHeight * 0.15, //dynamically calculating height
              child: FittedBox(
                  child: Text('\$${spendingAmount.toStringAsFixed(0)}')),
            ), // FittedBox force to be in the available space even text to shrinks
            SizedBox(
              // height: 4,
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              //height: 60,
              height:
                  constraints.maxHeight * 0.6, //dynamically calculating height
              width: 10,
              child: Stack(
                //use for element top to eachother (overlapping)
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  FractionallySizedBox(
                    //create a box that sized of fraction of another value
                    heightFactor: spendingPctofTotal, //height of box
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
              // height: 4,
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
