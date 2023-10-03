import 'package:ecommerce_app/common/widgets/loader.dart';
import 'package:ecommerce_app/common/widgets/stars.dart';
import 'package:ecommerce_app/features/home/services/home_services.dart';
import 'package:ecommerce_app/features/product_details/screens/product_details_screen.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();
  double avgRatingg = 0;
  double myRating = 0;
  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  double avgRating(Product product) {
    double totalRating = 0;

    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating as double;
    }
    if (totalRating != 0) {
      avgRatingg = totalRating / product.rating!.length;
    }
    return avgRatingg;
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    const Locale english = Locale('en');
    return product == null
        ? const Loader()
        : product!.title.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigateToDetailScreen,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment:
                                Localizations.localeOf(context) == english
                                    ? Alignment.topLeft
                                    : Alignment.topRight,
                            child: Text(
                              AppLocalizations.of(context)?.title ?? '',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Image.network(
                      product!.image_url,
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 0),
                      alignment: Alignment.center,
                      child: Text(
                        '₪${product!.price}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        product!.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Stars(rating: avgRating(product!)),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // children: product!.image_url
                        //     .map(
                        //       (e) => Image.network(
                        //         e,
                        //         fit: BoxFit.contain,
                        //         width: 100,
                        //         height: 100,
                        //       ),
                        //     )
                        //     .toList(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ).copyWith(left: 15),
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)?.seeAllDetails ?? '',
                        style: TextStyle(
                          color: Colors.cyan[800],
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
