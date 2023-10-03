import 'package:ecommerce_app/features/account/services/account_services.dart';
import 'package:ecommerce_app/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class TopButtons extends StatelessWidget {
   TopButtons({Key? key}) : super(key: key);

final Uri avaisStore = Uri.parse('https://avais-store.com');
 Future<void> _launchUrl() async {
  if (!await launchUrl(avaisStore)) {
    throw Exception('Could not launch $avaisStore');
  }
}
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AccountButton(
          text: AppLocalizations.of(context)?.visitOurWebsite ?? '',
          onTap: _launchUrl,
        ),
        AccountButton(
          text: AppLocalizations.of(context)?.logOut ?? '',
          onTap: () => AccountServices().logOut(context),
        ),
      ],
    );
  }
}
