import 'package:camera/camera.dart';
import 'package:camera_call/contoroller/re_scanner_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late CameraController cameraController;
  late VideoPlayerController _controller;
  int index = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    startVideo();
  }

  getdata() {
    Provider.of<ReProvider>(context, listen: false)
        .updateIndex(i: 1, mounted: mounted);
    
  }

  startVideo() {
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Parth");
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
             child: 
             _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : 
                Container(),
          ),
          Consumer<ReProvider>(
            builder: (context, value, child) {
              return (value.cameraController.value.isInitialized)
                  ? Align(
                      alignment: Alignment(0.8, 0.65),
                      child: Container(
                        height: 160,
                        width: 110,
                        child: CameraPreview(value.cameraController),
                      ),
                    )
                  : SizedBox();
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: Colors.black54,
                      mini: true,
                      child: Icon(
                        Icons.mic,
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    width: 70,
                    child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: Colors.red,
                      isExtended: true,
                      child: Icon(
                        Icons.call,
                        size: 28,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    child: Consumer<ReProvider>(
                      builder: (context, value, child) {
                        return FloatingActionButton(
                          onPressed: () {
                            (value.index == 1)
                                ? value.updateIndex(i: 0, mounted: mounted)
                                : value
                                    .updateIndex(i: 1, mounted: mounted);
                          },
                          backgroundColor: Colors.black54,
                          mini: true,
                          child: Icon(
                            Icons.flip_camera_ios_rounded,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
