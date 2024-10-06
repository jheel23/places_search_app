import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:place_search_app/environment/environment_variable.dart';
import 'package:place_search_app/model/place.dart';
import 'package:http/http.dart' as http;

class LocationSuggestionProvider extends StateNotifier<List<Place>> {
  LocationSuggestionProvider() : super([]);

  Future<void> getPlaceSuggestions(String query) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.geoapify.com/v1/geocode/autocomplete?text=$query&apiKey=$suggestionApiKey'));
      final decodedData = jsonDecode(response.body);
      final requiredData = decodedData['features'] as List<dynamic>;
      state = requiredData
          .map((place) => Place.fromJson(place['properties']))
          .toList();
    } catch (e) {
      Future.error('Error fetching location suggestions');
    }
  }
}

final locationSuggestionProvider =
    StateNotifierProvider<LocationSuggestionProvider, List<Place>>((ref) {
  return LocationSuggestionProvider();
});
