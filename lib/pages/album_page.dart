import 'package:flutter/material.dart';
import 'package:spotify/json/songs_json.dart';
import 'package:spotify/pages/music_detail_page.dart';
import 'package:spotify/theme/colors.dart';

class AlbumPage extends StatefulWidget {
  final dynamic song;

  const AlbumPage({Key? key, this.song}) : super(key: key);

  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    List songAlbums = widget.song['songs'];
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: size.width,
            height: 220,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.song['img']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.song['title'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Subscribe",
                      style: TextStyle(color: white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: List.generate(songs.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MusicDetailPage(
                              title: songs[index]['title'],
                              color: songs[index]['color'],
                              description: songs[index]['description'],
                              img: songs[index]['img'],
                              songUrl: songs[index]['song_url'],
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(songs[index]['img']),
                                fit: BoxFit.cover,
                              ),
                              color: primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            songs[index]['title'],
                            style: const TextStyle(
                              fontSize: 15,
                              color: white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: size.width - 210,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  songs[index]['song_count'],
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  songs[index]['date'],
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Column(
            children: List.generate(songAlbums.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MusicDetailPage(
                          title: widget.song['title'],
                          color: widget.song['color'],
                          description: widget.song['description'],
                          img: widget.song['img'],
                          songUrl: widget.song['song_url'],
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: (size.width - 60) * 0.77,
                        child: Text(
                          "${index + 1}  " + songAlbums[index]['title'],
                          style: TextStyle(color: white),
                        ),
                      ),
                      SizedBox(
                        width: (size.width - 60) * 0.23,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: primary,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.play_arrow,
                                  color: white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
