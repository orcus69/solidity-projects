import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoBody extends StatefulWidget {
  const VideoBody({ Key? key }) : super(key: key);

  @override
  State<VideoBody> createState() => _VideoBodyState();

}

class _VideoBodyState extends State<VideoBody> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.asset("assets/1.mp4")
          ..initialize().then((_) {
            //_videoPlayerController.play();
            setState(() {});
          });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 27),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Main video
            Container(
              child: _videoPlayerController.value.isInitialized
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children:[
                      FittedBox(
                        fit: BoxFit.fill,
                        child: SizedBox(
                          width: 842,
                          height: 399,
                          child: VideoPlayer(_videoPlayerController),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        child: Text("Play"),
                      )
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 68.0, top: 18),
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            color: Colors.black,
                            child: const Text(
                              'Video title', 
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.red,
                            child: Text('buy a coffee', style: TextStyle(color: Colors.white), textAlign: TextAlign.end,))
                        ],
                      ),
                    ),
                  ),
                const Padding(
                  padding: EdgeInsets.only(left: 68.0, top: 18),
                  child: Text(
                    'Subtitle', 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                    ),
                  ),
                )
                ],
              )
              : Container(),
            ),

            Column(
              children: [
                Container(
                  height: 107,
                  width: 200,
                  color: Colors.black,
                ),
                const SizedBox(height: 39,),
                Container(
                  height: 107,
                  width: 200,
                  color: Colors.black,
                ),
                const SizedBox(height: 39,),
                Container(
                  height: 107,
                  width: 200,
                  color: Colors.black,
                ),
                const SizedBox(height: 39,),
                Container(
                  height: 107,
                  width: 200,
                  color: Colors.black,
                ),
                const SizedBox(height: 39,),
                Container(
                  height: 107,
                  width: 200,
                  color: Colors.black,
                ),
              ],
            )
            

          ],
        ),
      ),
    );
  }
}