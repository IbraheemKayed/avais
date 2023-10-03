import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/features/home/screens/category_deals_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopCategories extends StatefulWidget {
  const TopCategories({super.key});

  @override
  State<TopCategories> createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories> {
  int index = 0;

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealsScreen.routeName,
        arguments: category);
  }

  String whatLang(index) {
    if (GlobalVariables.categoryImages[index]['title']! == 'New Arrivals') {
      return AppLocalizations.of(context)?.newArrivals ?? '';
    }
    if (GlobalVariables.categoryImages[index]['title']! == 'Outerwears') {
      return AppLocalizations.of(context)?.outerwears ?? '';
    }
    if (GlobalVariables.categoryImages[index]['title']! == 'Tops') {
      return AppLocalizations.of(context)?.tops ?? '';
    }
    if (GlobalVariables.categoryImages[index]['title']! == 'Dresses') {
      return AppLocalizations.of(context)?.dresses ?? '';
    }
    if (GlobalVariables.categoryImages[index]['title']! == 'Shirts') {
      return AppLocalizations.of(context)?.shirts ?? '';
    }
    if (GlobalVariables.categoryImages[index]['title']! == 'Jeans') {
      return AppLocalizations.of(context)?.jeans ?? '';
    }
    if (GlobalVariables.categoryImages[index]['title']! == 'Bags') {
      return AppLocalizations.of(context)?.bags ?? '';
    }
    if (GlobalVariables.categoryImages[index]['title']! == 'Accessories') {
      return AppLocalizations.of(context)?.accessories ?? '';
    }
    if (GlobalVariables.categoryImages[index]['title']! == 'Lingerie') {
      return AppLocalizations.of(context)?.lingerie ?? '';
    }
    if (GlobalVariables.categoryImages[index]['title']! == 'Footwears') {
      return AppLocalizations.of(context)?.footwears ?? '';
    }
    return '';
  }

  Widget titleName(context, index) {
    return Text(
      textAlign: TextAlign.center,
      whatLang(index),
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        itemCount: GlobalVariables.categoryImages.length,
        scrollDirection: Axis.horizontal,
        itemExtent: 80,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => navigateToCategoryPage(
              context,
              whatLang(index),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      GlobalVariables.categoryImages[index]['image']!,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                titleName(context, index),
              ],
            ),
          );
        },
      ),
    );
  }
}
