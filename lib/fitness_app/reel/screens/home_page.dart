import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import './content_screen.dart';

class HomePage extends StatelessWidget {
  final List<String> videos = [
    'https://firebasestorage.googleapis.com/v0/b/librefit-dev.appspot.com/o/istockphoto-1335253635-640_adpp_is.mp4?alt=media&token=3a5dc2d1-9950-4d0d-93e4-707f70e81e0a',
    'https://firebasestorage.googleapis.com/v0/b/librefit-dev.appspot.com/o/istockphoto-1250037868-640_adpp_is.mp4?alt=media&token=ab530f54-a070-4d46-8716-99c2b0faacc6',
    'https://firebasestorage.googleapis.com/v0/b/librefit-dev.appspot.com/o/istockphoto-1132962059-640_adpp_is.mp4?alt=media&token=5c47451d-42e0-475d-b33c-bfec3b5fd0ab',
    'https://firebasestorage.googleapis.com/v0/b/librefit-dev.appspot.com/o/istockphoto-1132958084-640_adpp_is.mp4?alt=media&token=17d7cb2d-eac2-4f7f-bc45-3a8821f4dbf8',
    'https://firebasestorage.googleapis.com/v0/b/librefit-dev.appspot.com/o/istockphoto-1132957137-640_adpp_is.mp4?alt=media&token=56289189-f776-4792-b6fa-2ae23e436983'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              //We need swiper for every content
              Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return ContentScreen(
                    src: videos[index],
                  );
                },
                itemCount: videos.length,
                scrollDirection: Axis.vertical,
              ),
              SizedBox(
                height: 16,
              )
              /*
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Flutter Shorts',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.camera_alt),
                  ],
                ),
              ),
              */
            ],
          ),
        ),
      ),
    );
  }
}
