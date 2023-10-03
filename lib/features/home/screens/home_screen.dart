import 'package:ecommerce_app/common/widgets/languages_picker_widget.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/features/home/widgets/address_box.dart';
import 'package:ecommerce_app/features/home/widgets/carousel_image.dart';
import 'package:ecommerce_app/features/home/widgets/deal_of_the_day.dart';
import 'package:ecommerce_app/features/home/widgets/top_categories.dart';
import 'package:ecommerce_app/features/search/screens/search_screen.dart';
import 'package:ecommerce_app/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void updateLan(String countryCode) {
    var provider = Provider.of<LanguageProvider>(context, listen: false);
    provider.updateLanguage(Locale(countryCode));
    setState(() {});
  }

  Future<void> _launchUrl(Uri uri) async {
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $uri');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 107, 192, 238),
              ),
              child: Text(
                'Avais Store',
                style: TextStyle(fontSize: 30),
              ),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)?.privacyAndCookie ?? ''),
              onTap: () {
                Uri privacyPolicy = Uri.parse('');
                _launchUrl(privacyPolicy);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)?.contactUs ?? ''),
              onTap: () {
                Uri contact = Uri.parse('');
                _launchUrl(contact);
              },
            ),
            ListTile(
              title:
                  Text(AppLocalizations.of(context)?.termsAndConditions ?? ''),
              onTap: () {
                Uri terms = Uri.parse('');
                _launchUrl(terms);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)?.aboutUs ?? ''),
              onTap: () {
                Uri about = Uri.parse('');
                _launchUrl(about);
              },
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          actions: const [LanguagePickerWidget()],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide:
                              BorderSide(color: Colors.black38, width: 1),
                        ),
                        hintText:
                            AppLocalizations.of(context)?.searchForAProduct ??
                                '',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            AddressBox(),
            SizedBox(
              height: 10,
            ),
            TopCategories(),
            SizedBox(
              height: 10,
            ),
            CarouselImage(),
            SizedBox(
              height: 10,
            ),
            DealOfDay(),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
