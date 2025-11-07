import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // Import for AudioPlayer
import 'package:spotify/theme/colors.dart';

class MusicDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final Color color;
  final String img;
  final String songUrl;

  const MusicDetailPage({
    Key? key,
    required this.title,
    required this.description,
    required this.color,
    required this.img,
    required this.songUrl,
  }) : super(key: key);

  @override
  _MusicDetailPageState createState() => _MusicDetailPageState();
}

class _MusicDetailPageState extends State<MusicDetailPage> {
  final player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  void initState() {
    super.initState();

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    // Ensure the player is stopped before disposing
    if (isPlaying) {
      player.stop();
    }

    player.dispose(); // Dispose of the AudioPlayer to release resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back, // Back icon
            color: Colors.white, // White color for the back icon
          ),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        actions: const [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white, // Color of the more icon
            ),
            onPressed: null, // You can set this to a function if needed
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    height: 350,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: widget.color,
                          blurRadius: 50,
                          spreadRadius: 5,
                          offset: const Offset(-10, 40),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 30,
                  ), // Adjusted padding
                  child: Container(
                    width: MediaQuery.of(context).size.width -
                        40, // Adjusted width
                    height: MediaQuery.of(context).size.width -
                        20, // Adjusted height
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.img),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                          BorderRadius.circular(10), // Adjusted border radius
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 80,
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.folder,
                      color: white,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 18,
                            color: white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            widget.description,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: white.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 20, // Width of the circular container
                      height: 20, // Height of the circular container
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // Makes the container circular
                        color: Colors.black, // Background color of the circle
                        border: Border.all(
                          color: Colors.white, // Border color
                          width: 2, // Border width
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add, // Plus icon
                          color: Colors.white, // Color of the icon
                          size: 15, // Size of the icon
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              activeColor: primary, // Color of the active part of the slider
              inactiveColor:
                  Colors.grey, // Color of the inactive part of the slider
              onChanged: (value) {
                final newPosition = Duration(seconds: value.toInt());
                player.seek(newPosition);
                setState(() {
                  position = newPosition;
                });
              },
              onChangeEnd: (value) {
                if (isPlaying) {
                  player.resume();
                }
              },
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.shuffle,
                      color: white.withOpacity(0.8),
                      size: 25,
                    ),
                    onPressed: null,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.skip_previous,
                      color: white.withOpacity(0.8),
                      size: 25,
                    ),
                    onPressed: null,
                  ),
                  CircleAvatar(
                    backgroundColor: primary,
                    radius: 25,
                    child: IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: white,
                      ),
                      onPressed: () {
                        if (isPlaying) {
                          player.pause();
                        } else {
                          player.play(AssetSource(widget.songUrl));
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.skip_next,
                      color: white.withOpacity(0.8),
                      size: 25,
                    ),
                    onPressed: null,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.repeat,
                      color: white.withOpacity(0.8),
                      size: 25,
                    ),
                    onPressed: null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.tv,
                  color: primary,
                  size: 20,
                ),
                SizedBox(width: 10),
                Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Text(
                    "Chromecast is ready",
                    style: TextStyle(color: primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
