import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tatpar_orange/l10n/l10n.dart';
import 'package:tatpar_orange/l10n/language_provider.dart';

import '../../../../configurations/configurations.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LanguageProvider>(context);
    final locale = provider.locale;

    // Create a map to associate language codes with language names
    final Map<String, String> languageMap = {
      for (var locale in L10n.all)
        locale.languageCode: L10n.getLanguageName(locale.languageCode)
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: AppTextStyle.titleLarge
              .copyWith(fontSize: 20, height: 1.2, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            right: kPadding * 5, left: kPadding * 3, top: kPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Select Language',
              style: AppTextStyle.titleMedium.copyWith(
                  fontSize: 14, height: 1.2, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                iconSize: 30,
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                value: languageMap[locale.languageCode],
                items:
                    languageMap.entries.map<DropdownMenuItem<String>>((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.value,
                    child: Text(
                      entry.value,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontFamily: FontFamily.poppins,
                            fontSize: 14,
                          ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newLanguageName) {
                  if (newLanguageName != null) {
                    // Find the corresponding Locale object
                    final newLocale = L10n.all.firstWhere(
                      (locale) =>
                          L10n.getLanguageName(locale.languageCode) ==
                          newLanguageName,
                    );
                    provider.setLocale(newLocale);
                  }
                },
                // Customize the DropdownButton to include an underline and end icon
                underline: Container(
                  height: 1,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
