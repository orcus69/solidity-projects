import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youcubes/components/video_items.dart';

class VideoBody extends StatefulWidget {
  const VideoBody({Key? key}) : super(key: key);

  @override
  State<VideoBody> createState() => _VideoBodyState();
}

class _VideoBodyState extends State<VideoBody> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _videoPlayer;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset("assets/1.mp4");
    _videoPlayer = _videoPlayerController.initialize().then((_) {
      //_videoPlayerController.play();
      setState(() {});
    });
    ;
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 27),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Main video
          Container(
            child: _videoPlayerController.value.isInitialized
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            FutureBuilder(
                              future: _videoPlayer,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return VideoItems(
                                    videoPlayerController:
                                        VideoPlayerController.asset("assets/1.mp4"),
                                    looping: false,
                                    autoplay: false,
                                  );
                                } else {
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    height:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: const CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, top: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Video title',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                child: Row(
                                  children: const [
                                    Text(
                                      'buy a coffee',
                                      style: TextStyle(color: Colors.black),
                                      textAlign: TextAlign.end,
                                    ),
                                    Icon(Icons.coffee_outlined)
                                  ],
                                ))
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 40.0, top: 18),
                        child: Text(
                          'Subtitle',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 36,
                          ),
                        ),
                      )
                    ],
                  )
                : Container(),
          ),

          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => print('Hello World!'),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.fill,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.width * 0.1,
                              child: Container(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text('Title'), Text('Subtitle')],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
