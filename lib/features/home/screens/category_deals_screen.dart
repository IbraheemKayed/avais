import 'dart:convert';

import 'package:ecommerce_app/common/widgets/loader.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/features/product_details/screens/product_details_screen.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/features/home/services/home_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({super.key, required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product> productList =[];
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    //fetchCategoryProducts();
    fetchProducts();
  }
  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('https://avais-store.com/wp-json/custom/v1/allddproducts/'));

    if (response.statusCode == 200) {
      for (int i = 0; i < jsonDecode(response.body).length; i++) {
             
             productList.add(
               Product.fromJson(
                 jsonEncode(
                   jsonDecode(response.body)[i],
                 ),
               ),
             );
    } 
  }else {
      throw Exception('Failed to load products');
    }
  }
  // fetchCategoryProducts() async {
  //   productList = await homeServices.fetchCategoryProducts(
  //       context: context, category: widget.category);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${AppLocalizations.of(context)?.keepShoppingFor ?? ''} ${widget.category}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 15),
                    itemCount: productList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.4,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final product = productList![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, ProductDetailScreen.routeName,
                              arguments: product);
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 130,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 0.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.network(
                                    //'https://www.itprotoday.com/sites/itprotoday.com/files/styles/article_featured_retina/public/uploads/2014/08/clouds-595x335_1.jpg?itok=dy9WsmkJ'
                                    product.image_url,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(
                                  left: 0, top: 5, right: 15),
                              child: const Text(
                                'hhhhhhhhh',
                                //product.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
