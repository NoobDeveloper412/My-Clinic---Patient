import 'package:country_calling_code_picker/picker.dart';

class CountryPicker {
  static Future countryCodePicker(context) async {
    final country = await showCountryPickerSheet(
      context,
    );
    return country;
  }
}
