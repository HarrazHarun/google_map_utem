import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService {
  final String key ='AIzaSyDfdfJw1-V-lZ1s7rLF8jZ5p-ATjUgGX8k';

  Future<String> getPlacedId(String input) async {
    final String url ='https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var placeId = json['candidates'][0]['place_id'] as String;

    print(placeId);

    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async{
    final placeId = await getPlacedId(input);

    final String url = 'https://maps.googleapis.com/maps/api/place/detail/json?place_id=$placeId&key=$key';

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;

    print(results);
    return results;
  }
}
