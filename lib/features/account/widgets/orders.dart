import 'package:ecommerce_app/common/widgets/loader.dart';
import 'package:ecommerce_app/features/account/services/account_services.dart';
import 'package:ecommerce_app/features/account/widgets/single_product.dart';
import 'package:ecommerce_app/features/order_details/screens/order_details_screen.dart';
import 'package:flutter/material.dart';
import '../../../models/order.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      AppLocalizations.of(context)?.yourOrders ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              // display orders
              Container(
                  height: 550,
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 20,
                    right: 10,
                  ),
                  child: GridView.builder(
                      itemCount: orders!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              OrderDetailScreen.routeName,
                              arguments: orders![index],
                            );
                          },
                          child: SingleProduct(
                            image: orders![index].products[0].image_url,
                          ),
                        );
                      })),
            ],
          );
  }
}
