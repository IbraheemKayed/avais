import 'package:flutter/material.dart';

String uri = 'https://avais-store-5bd302c76f5c.herokuapp.com';

class GlobalVariables {
  static bool isArabic = true;
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 107, 192, 238),
      Color.fromARGB(255, 108, 193, 239),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;

  static const List<String> carouselImages = [
    'assets/images/avais1.jpg',
    'assets/images/avais2.jpg',
    'assets/images/avais3.jpg',
    'assets/images/avais4.jpg',
    'assets/images/avais5.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'New Arrivals',
      'image': 'assets/images/new_arrival.jpg',
    },
    {
      'title': 'Outerwears',
      'image': 'assets/images/outwears.jpg',
    },
    {
      'title': 'Tops',
      'image': 'assets/images/tops.jpg',
    },
    {
      'title': 'Dresses',
      'image': 'assets/images/dresses.jpg',
    },
    {
      'title': 'Shirts',
      'image': 'assets/images/shirts.jpg',
    },
    {
      'title': 'Jeans',
      'image': 'assets/images/jeans.jpg',
    },
    {
      'title': 'Bags',
      'image': 'assets/images/bags.jpg',
    },
    {
      'title': 'Accessories',
      'image': 'assets/images/accessories.jpg',
    },
    {
      'title': 'Lingerie',
      'image': 'assets/images/lingerie.jpg',
    },
    {
      'title': 'Footwears',
      'image': 'assets/images/shose.jpg',
    },
  ];
}
