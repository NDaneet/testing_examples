import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'custom_pop_up_menu.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const String searchPrefKey = 'previousSearches';

  late TextEditingController searchTextController;
  List<String> previousSearches = <String>[];

  @override
  void initState() {
    super.initState();
    getPreviousSearchesList();
    searchTextController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  Future<void> getPreviousSearchesList() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(searchPrefKey)) {
      final search = prefs.getStringList(searchPrefKey);
      if (search != null) {
        previousSearches = search;
      } else {
        previousSearches = <String>[];
      }
    }
  }

  Future<void> savePreviousSearchesList() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(searchPrefKey, previousSearches);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Search",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              _buildSearchCard()
            ],
          )),
    );
  }

  Widget _buildSearchCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          4.0,
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                addSearchItem(searchTextController.text);
                final currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
            ),
            const SizedBox(width: 5.0),
            Expanded(
              child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search",
                  ),
                  autofocus: false,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) {
                    addSearchItem(searchTextController.text);
                  },
                  controller: searchTextController),
            ),
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Color.fromARGB(255, 167, 165, 165),
              ),
              onSelected: (value) {
                searchTextController.text = value;
                addSearchItem(searchTextController.text);
              },
              itemBuilder: (context) {
                return previousSearches
                    .map<CustomPopUpMenuItem<String>>((value) {
                  return CustomPopUpMenuItem<String>(
                    value: value,
                    text: value,
                    callback: () {
                      setState(() {
                        previousSearches.remove(value);
                        savePreviousSearchesList();
                        Navigator.pop(context);
                      });
                    },
                  );
                }).toList();
              },
            )
          ],
        ),
      ),
    );
  }

  void addSearchItem(String value) {
    value = value.trim();
    if (!previousSearches.contains(value)) {
      previousSearches.add(value);
      savePreviousSearchesList();
    }
  }
}
