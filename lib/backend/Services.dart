import 'package:http/http.dart' as http;
import 'PropertySearch.dart';

class Services{
  static const String url = "http://10.0.2.2:5000/zillow";
  static Future<PropertySearch> getProperties() async {
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final propertySearch = propertySearchFromJson(response.body);
        return propertySearch;
      } else {
        print("error");
      }
    } catch (e) {
      print(e);
    }
  }
}