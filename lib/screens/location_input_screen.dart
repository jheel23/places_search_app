import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:place_search_app/model/place.dart';
import 'package:place_search_app/providers/location_suggestion_provider.dart';
import 'package:place_search_app/screens/map_screen.dart';
import 'package:place_search_app/utils/functions.dart';

class LocationInputScreen extends ConsumerStatefulWidget {
  const LocationInputScreen({super.key});

  @override
  ConsumerState<LocationInputScreen> createState() =>
      _LocationInputScreenState();
}

class _LocationInputScreenState extends ConsumerState<LocationInputScreen> {
  final _searchController = TextEditingController();
  bool isSearching = false;
  List<Place> _searchSuggestions = [];

  //! Function to get search suggestions=============================
  void getSearchSuggestions(String query) {
    ref.read(locationSuggestionProvider.notifier).getPlaceSuggestions(query);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(locationSuggestionProvider);
    _searchSuggestions = ref.watch(locationSuggestionProvider);
    final deviceSizeHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return SafeArea(
      top: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            AnimatedContainer(
              padding: const EdgeInsets.all(10),
              height:
                  isSearching ? deviceSizeHeight * 0.8 : deviceSizeHeight * 0.1,
              margin: const EdgeInsets.all(20),
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Container(
                    height: deviceSizeHeight * 0.07,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: theme.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        addHorizontalSpace(10),
                        Expanded(
                          child: TextField(
                            textInputAction: TextInputAction.search,
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            controller: _searchController,
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              if (_searchController.text.isNotEmpty) {
                                setState(() {
                                  isSearching = true;
                                });
                                getSearchSuggestions(_searchController.text);
                              } else {
                                _searchSuggestions = [];
                                setState(() {
                                  isSearching = false;
                                });
                              }
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: theme.textTheme.titleSmall!.copyWith(
                                    color: Colors.white.withOpacity(0.6)),
                                hintText: 'Search Bangalore, Mumbai, etc.'),
                          ),
                        ),
                        if (_searchController.text.isNotEmpty)
                          IconButton(
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                isSearching = false;
                              });
                            },
                            icon: const Icon(Icons.clear),
                          )
                      ],
                    ),
                  ),
                  if (isSearching)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                              _searchSuggestions.length,
                              (index) => ListTile(
                                    onTap: () {
                                      _searchController.text =
                                          _searchSuggestions[index].name;

                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => MapScreen(
                                                    lat: _searchSuggestions[
                                                            index]
                                                        .lat,
                                                    long: _searchSuggestions[
                                                            index]
                                                        .long,
                                                  )));
                                    },
                                    title: Text(_searchSuggestions[index].name),
                                    trailing: Transform.flip(
                                        flipX: true,
                                        child: const Icon(
                                            Icons.arrow_outward_rounded)),
                                  )),
                        ),
                      ),
                    )
                ],
              ),
            ),
            addVerticalSpace(deviceSizeHeight * 0.1),
            if (!isSearching)
              Container(
                margin: const EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text('Search for a location to get started!🗺️',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineLarge!
                        .copyWith(color: theme.colorScheme.secondary)),
              ),
            if (!isSearching) const Spacer(),
            if (!isSearching)
              Container(
                margin: const EdgeInsets.all(20),
                child: Text(
                  'Note : Coordinates might sometime not make sense because I am using some random Autocomplete API',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelSmall,
                ),
              )
          ],
        ),
      ),
    );
  }
}
