import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/data/color_helper.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/screens/category_page.dart';
import 'package:flutter_budget_ui/values/size_config.dart';

class CategoryWidget extends AnimatedWidget {
  final Category category;

  CategoryWidget(this.category, {required Animation animation, Key? key})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    print('rebuild: ${this.runtimeType.toString()} build');

    double totalSpent = 0;

    category.expenses.forEach((element) {
      totalSpent = element.cost + totalSpent;
    });
    final double percentRemain =
        (category.maxAmount - totalSpent) / category.maxAmount;

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CategoryPage(category);
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: EdgeInsets.all(SizeConfig.padding),
        // height: 100.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 2), blurRadius: 6.0)
            ]),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.name,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  '\$${(category.maxAmount - totalSpent).toStringAsFixed(2)} / \$${category.maxAmount.toStringAsFixed(1)}',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: SizeConfig.padding * 2),
              child: LayoutBuilder(builder: (context, constraints) {
                final animation = listenable as Animation<double>;

                final maxWidth = constraints.maxWidth;
                var remainWidth = percentRemain * maxWidth;
                if (remainWidth < 0) remainWidth = 0;

                final spentWith = maxWidth - remainWidth;

                var displayWidth = maxWidth - (spentWith * animation.value);

                print('rebuild: ${this.runtimeType.toString()} LayoutBuilder');

                return Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Container(
                      height: 18.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    Container(
                      height: SizeConfig.barThickness,
                      width: displayWidth,
                      decoration: BoxDecoration(
                        color: ColorHelper.getColor(percentRemain),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    )
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
