import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/wallpaper models.dart';
import 'detail_screen.dart';

class WallpaperApp extends StatefulWidget {
  const WallpaperApp({super.key});

  @override
  State<WallpaperApp> createState() => _WallpaperAppState();
}
//My Wallpaper App
class _WallpaperAppState extends State<WallpaperApp> {
  TextEditingController searchController = TextEditingController();
  var myKey = "6godvrxFjT9VyLdH4Ba5fnl4VzwWjk0vZmi7yVmwSmuYZ2J7qREkoWdR";
  late Future<Model> wallpaper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wallpaper = getWallpaper('cube');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Wallpaper App"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                  hintText: "Search Wallpaper",
                  suffixIcon: IconButton(
                      onPressed: () {
                        wallpaper =
                            getWallpaper(searchController.text.toString());
                        setState(() {});
                      },
                      icon: Icon(Icons.search)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FutureBuilder(
              future: wallpaper,
              builder: (context, snapshots) {
                if (snapshots.hasData) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: snapshots.data!.photos!
                            .map((pics) => Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                      image: pics
                                                          .src!.portrait!)));
                                    },
                                    child: Container(
                                      clipBehavior: Clip.antiAlias,
                                      height: 200,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Image.network(
                                        "${pics.src!.portrait}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ))
                            .toList()),
                  );
                } else if (snapshots.hasError) {
                  return Center(
                    child: Text("${snapshots.hasError.toString()}"),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              })
        ],
      ),
    );
  }

  Future<Model> getWallpaper(String search) async {
    var url = "https://api.pexels.com/v1/search?query=$search";
    var response =
        await http.get(Uri.parse(url), headers: {'Authorization': myKey});
    if (response.statusCode == 200) {
      var photos = jsonDecode(response.body);
      return Model.fromJson(photos);
    } else {
      return Model();
    }
  }
}
