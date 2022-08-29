import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:catapi_1/models/cat_breed_model.dart';
import 'package:catapi_1/services/breed_service.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';

class BreedScreen extends StatefulWidget {
  const BreedScreen({Key? key}) : super(key: key);

  @override
  State<BreedScreen> createState() => _BreedScreenState();
}

class _BreedScreenState extends State<BreedScreen> {
  List<String> catCategoryList = ['One', 'Two', 'Free', 'Four'];
  String dropdownSelectedValue = 'One';
  List<String> selectedFavoriteList = [];
  List<CatBreedModel>? breedList;
  List<String>? category;
  @override
  void initState() {
    fetch();
    super.initState();
  }

  fetch() async {
    breedList = await BreedService().fetchBreedList();
    category = breedList?.map((e) => e.name ?? '').toList();
  }

  @override
  Widget build(BuildContext context) {
    selectedFavoriteList = catCategoryList.map((e) => e).toList();

    log(breedList.toString());

    return Scaffold(
      appBar: const CustomAppBar(title: 'Breed'),
      body: ListView(
        children: [
          DropdownButton<String>(
            value: dropdownSelectedValue,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownSelectedValue = newValue!;
              });
            },
            items:
                catCategoryList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              enlargeCenterPage: true,
            ),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: const BoxDecoration(color: Colors.amber),
                      child: Column(
                        children: [
                          const Text('drop here'),
                          Image.network('https://picsum.photos/250?image=9'),
                          const Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Id',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text('agile ,energetic? here'),
                          const Text('weight'),
                        ],
                      ));
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
