import 'dart:developer';

import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';

class DetailScreen extends StatefulWidget {
  String image;
  DetailScreen({super.key, required this.image});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(),
              child: Image.network(
                "${widget.image}",
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        String path = widget.image;
                        GallerySaver.saveImage(path).then((value) {
                          return log("Downloaded Successfully");
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 70 * 1,
                            width: 70 * 1,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.5),
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(Icons.download, size: 30 * 1),
                          ),
                          Text(
                            "Download",
                            style: TextStyle(
                                color: Colors.white.withOpacity(.5),
                                fontSize: 17,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                       return showDialog(context: context, builder: (BuildContext context){
                         return AlertDialog(
                           content: Column(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: [
                                   Text("Home Screen",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                                   IconButton(onPressed: ()async{
                                     String result;
                                     try {
                                       result = await AsyncWallpaper.setWallpaper(
                                           url: widget.image,
                                           wallpaperLocation:
                                           AsyncWallpaper.HOME_SCREEN,
                                           toastDetails: ToastDetails.success(),
                                           errorToastDetails: ToastDetails.error())
                                           ? "Wallpaper Successfully set"
                                           : "Failed to get wallpaper";
                                     } on PlatformException {
                                       result = "Failed to set wallpaper";
                                     }
                                     Navigator.pop(context);
                                   }, icon: Icon(Icons.home))
                                 ],
                               ),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: [
                                   Text("Lock Screen",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                                   IconButton(onPressed: ()async{
                                     String result;
                                     try {
                                       result = await AsyncWallpaper.setWallpaper(
                                           url: widget.image,
                                           wallpaperLocation:
                                           AsyncWallpaper.LOCK_SCREEN,
                                           toastDetails: ToastDetails.success(),
                                           errorToastDetails: ToastDetails.error())
                                           ? "Wallpaper Successfully set"
                                           : "Failed to get wallpaper";
                                     } on PlatformException {
                                       result = "Failed to set wallpaper";
                                     }
                                     Navigator.pop(context);
                                   }, icon: Icon(Icons.lock))
                                 ],
                               ),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: [
                                   Text("Both Screen",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                                   IconButton(onPressed: ()async{
                                     String result;
                                     try {
                                       result = await AsyncWallpaper.setWallpaper(
                                           url: widget.image,
                                           wallpaperLocation:
                                           AsyncWallpaper.BOTH_SCREENS,
                                           toastDetails: ToastDetails.success(),
                                           errorToastDetails: ToastDetails.error())
                                           ? "Wallpaper Successfully set"
                                           : "Failed to get wallpaper";
                                     } on PlatformException {
                                       result = "Failed to set wallpaper";
                                     }
                                     Navigator.pop(context);
                                   }, icon: Icon(Icons.directions))
                                 ],
                               ),

                             ],
                           ),
                           actions: [
                             TextButton(onPressed: (){
                               Navigator.pop(context);
                             }, child: Text("Ok"))
                           ],
                         );
                       });
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 70 * 1,
                            width: 70 * 1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white.withOpacity(.5)),
                            child: Icon(Icons.ad_units_outlined, size: 30 * 1),
                          ),
                          Text(
                            "Set",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.white.withOpacity(.5)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
