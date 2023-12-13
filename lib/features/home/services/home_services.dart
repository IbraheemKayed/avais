import 'dart:convert';
import 'package:ecommerce_app/constants/error_handling.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('https://avais-store.com/wp-json/custom/v1/allddproducts/'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
            
          }
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
    return productList;
  }
  // Future<List<Product>> fetchCategoryProducts({
  //   required BuildContext context,
  //   required String category,
  // }) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   List<Product> productList = [];
  //   try {
  //     http.Response res = await http
  //         .get(Uri.parse('https://avais-store.com/wp-json/custom/v1/allddproducts/'), headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'x-auth-token': userProvider.user.token,
  //     });

  //     // ignore: use_build_context_synchronously
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         int flag =0;
  //         for(int i = 0; i < jsonDecode(res.body).length; i++) {
  //           for(int j =0; j< jsonDecode(res.body)[i]['categories'].length; j++){
  //           if(category== jsonDecode(res.body)[i]['categories'][j]){
  //             flag =1;
  //           }
  //         }}
  //         for (int i = 0; i < jsonDecode(res.body).length; i++) {
  //           if (flag==1)
  //          { productList.add(
  //             Product.fromJson(
  //               jsonEncode(
  //                 jsonDecode(res.body)[i],
  //               ),
  //             ),
  //           );}
            
  //         }
  //       },
  //     );
  //   } catch (e) {
  //     // ignore: use_build_context_synchronously
  //     showSnackBar(context, e.toString());
  //   }
  //   return productList;
  // }

  Future<Product> fetchDealOfDay({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(
      title: '',
      description: '',
      quantity: 0,
      image_url: '',
      categories: [],
      price: 0,
      //id: 0,
      rating: '',
      attributes: {},
      //gallery_images: [],
      stock_quantity: 0,
      stock_status: ''
    );
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/deal-of-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            product = Product.fromJson(res.body);
          });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
