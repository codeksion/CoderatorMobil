import 'package:coderatorfoss/back/api.dart';
import 'package:coderatorfoss/front/errors.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

//???DEVNOTE: video.dart'ın tamamının, baştan, 0'dan yazılması gerekiyor. Bu hali ile, burası oldukça çirkin.

class VideoViewer extends StatelessWidget {
  final String id;
  final String title;
  const VideoViewer({Key? key, required this.id, this.title = "Video Viewer"})
      : super(key: key);

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: DownloadRequest(id).getUrl(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            );
          }

          if (snapshot.hasError) {
            return ArsivError(
              snapshot.error,
              stackTrace: snapshot.stackTrace,
              ek: "video id: " + id,
              showError: false,
            );
          }

          var co = VideoPlayerController.network(snapshot.data!,
              httpHeaders: {"Referer": snapshot.data!});

          var cc = ChewieController(
            videoPlayerController: co,
            allowMuting: true,
            allowPlaybackSpeedChanging: true,
            autoPlay: true,
            fullScreenByDefault: true,
            errorBuilder: (context, errorMessage) => ArsivError(errorMessage),
            showControls: true,
            allowedScreenSleep: false,
          );
          Wakelock.enable();
          return FutureBuilder(
            future: co.initialize(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                Wakelock.disable();
                return ArsivError(
                  snapshot.error,
                  stackTrace: snapshot.stackTrace,
                  ek: "video id: " + id,
                  showError: true,
                );
              }

              co.play();

              return WillPopScope(
                  onWillPop: () async {
                    Wakelock.disable();
                    try {
                      co.dispose();
                    } catch (e) {
                      print(e);
                    }

                    try {
                      cc.dispose();
                    } catch (e) {
                      print(e);
                    }

                    Navigator.pop(context);
                    return true;
                  },
                  child: Scaffold(
                    appBar: AppBar(
                      leading: BackButton(
                        onPressed: () {
                          Wakelock.disable();
                          try {
                            co.dispose();
                          } catch (e) {
                            print(e);
                          }

                          try {
                            cc.dispose();
                          } catch (e) {
                            print(e);
                          }

                          Navigator.pop(context);
                        },
                      ),
                      title: Text(title),
                    ),
                    body: Chewie(
                      controller: cc,
                    ),
                  ));
            },
          );
        },
      );
}

//Todo: Video dispose kesinlikle baştan kodlanacak.