// ignore_for_file: avoid_print

import 'package:catapi_1/models/random_image_model.dart';

import 'package:catapi_1/services/cat_api_service.dart';
import 'package:catapi_1/widgets/custom_appbar.dart';

import 'package:flutter/material.dart';

class VoteCatScreen extends StatefulWidget {
  const VoteCatScreen({Key? key}) : super(key: key);

  @override
  State<VoteCatScreen> createState() => _VoteCatScreenState();
}

class _VoteCatScreenState extends State<VoteCatScreen> {
  //can be null if not then  need to initialize
  // Future<RandomImageModel>? randomImageApiMap;
  String? imageIdString;
  String? randomImageId;

  int? favId;
  String? subID;
  // late Future<FavoriteModel>? sendingFavId;
  // late Future<VoteImageModel> sendingImageUrl;
  bool fav = false;

  // @override
  // void initState() {
  //   super.initState();
  // fetch();
  // }

  // fetch() {
  //   randomImageApiMap = CatApiService().fetchRandomImage();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'voting page1'),
      body: setBodyView(),
    );
  }

  ListView setBodyView() {
    return ListView(
      children: [
        favoriteButton(),
        futureBuilderForRAndomCatImage(),
        setVotebuttons(),
      ],
    );
  }

  Padding favoriteButton() {
    return fav == false ? setFavButton() : setUnFavButton();
  }

  Padding setUnFavButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
          onPressed: () async {
            setState(() {
              if (imageIdString != null) {
                CatApiService().unFav(favId ?? 0, 'null');
                fav = false;
                print('query for image id is$favId');
              }
            });
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red)),
          child: const Text('unFav it ')),
    );
  }

  Padding setFavButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
          onPressed: () async {
            setState(() {
              (imageIdString != null) {
             
                CatApiService()
                    .favorites(imageIdString ?? '', 'Ganesh')
                    .then((returnedValue) => favId = returnedValue?.id)
                    .then((value) => print('favId:$favId'))
                    .then((value) => fav = true);
              };
            });
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.cyan)),
          child: const Text('fav it ')),
    );
  }

  Row setVotebuttons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        voteUpButton(),
        voteDownButton(),
      ],
    );
  }

  Padding voteDownButton() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
          onPressed: () async {
            // fetch();
            setState(() {
              CatApiService().vote(imageIdString ?? '', -1);
            });
          },
          child: const Text('NOPE IT')),
    );
  }

  Padding voteUpButton() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: ElevatedButton(
          style: ButtonStyle(
              //making material state property
              backgroundColor: MaterialStateProperty.all(Colors.greenAccent)),
          onPressed: () async {
            // fetch();
            setState(() {
              CatApiService().vote(imageIdString ?? '', 1);
            });
          },
          child: const Text('Love It ')),
    );
  }

  FutureBuilder<RandomImageModel> futureBuilderForRAndomCatImage() {
    return FutureBuilder<RandomImageModel>(
        future: CatApiService().fetchRandomImage(),
        builder: (context, snapshot) {
          snapshot.hasData ? imageIdString = '${snapshot.data!}' : '';
          if (snapshot.hasData) {
            imageIdString = snapshot.data?.id ?? "";

            return buildCatVotingImage(snapshot);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Container(
              height: 400,
              alignment: Alignment.center,
              child: const CircularProgressIndicator());
        });
  }

  Image buildCatVotingImage(AsyncSnapshot<RandomImageModel> snapshot) {
    // log(snapshot.toString());
    return Image.network(
      //snap nullable data ??not empty apply url else send empty
      snapshot.data?.url ?? 'Something went Wrong',
      height: 300,
      width: double.infinity,
    );
  }

  AppBar setAppBar() {
    return AppBar(
      title: const Text('Vote Cat'),
      centerTitle: true,
    );
  }
}
