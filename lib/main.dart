import 'package:flutter/material.dart';
import 'package:assign3/loginpage.dart';
import 'package:assign3/moviepage.dart';
import 'package:assign3/remote.dart';
import 'package:assign3/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:assign3/firebaseopt.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const Login(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Result>? trending;
  List<Result>? topRated;
  List<Result>? nowPlaying;
  var isLoaded = false;
  var isLoaded2 = false;
  var isLoaded3 = false;
  String imgURL = 'https://image.tmdb.org/t/p/w500';
  String searchURL =
      'https://api.themoviedb.org/3/search/movie?8c692efc1e229d91375320c81f8b7bd7';

  @override
  void initState() {
    super.initState();

    getTrending();
    getRated();
    getPlaying();
  }

  getTrending() async {
    trending = (await RemoteService().getTrendingMovies());
    if (nowPlaying != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  getRated() async {
    topRated = (await RemoteService().getTopRatedMovies());
    if (nowPlaying != null) {
      setState(() {
        isLoaded2 = true;
      });
    }
  }

  getPlaying() async {
    nowPlaying = (await RemoteService().getNowPlayingMovies());
    if (nowPlaying != null) {
      setState(() {
        isLoaded3 = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: Visibility(
            visible: isLoaded3,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Now Playing",
                              style: TextStyle(
                                  fontSize: 28, color: Colors.white))),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        // Horizontal ListView
                        height: 240,
                        child: ListView.builder(
                          itemCount: nowPlaying?.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                                alignment: Alignment.center,
                                // color: Colors.blue[(index % 9) * 100],
                                width: 150,
                                child: Column(
                                  children: [
                                    Image.network(
                                      imgURL + nowPlaying![index].posterPath,
                                      height: 200,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(nowPlaying![index].title,
                                        style: TextStyle(color: Colors.white))
                                  ],
                                )
                                // Text(trending![index].title),

                                );
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Top Rated Movies",
                              style: TextStyle(
                                  fontSize: 28, color: Colors.white))),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        // Horizontal ListView
                        height: 240,
                        child: ListView.builder(
                          itemCount: topRated?.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                                alignment: Alignment.center,
                                // color: Colors.blue[(index % 9) * 100],
                                width: 150,
                                child: Column(
                                  children: [
                                    Image.network(
                                      imgURL + topRated![index].posterPath,
                                      height: 200,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      topRated![index].title,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                )
                                // Text(trending![index].title),

                                );
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Trending Movies",
                            style: TextStyle(fontSize: 28, color: Colors.white),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        // Horizontal ListView
                        // width: 180,
                        height: 240,

                        child: ListView.builder(
                          itemCount: trending?.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                                alignment: Alignment.center,
                                // color: Colors.blue[(index % 9) * 100],
                                width: 150,
                                child: Column(
                                  children: [
                                    Image.network(
                                      imgURL + trending![index].posterPath,
                                      height: 200,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      trending![index].title,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                )
                                // Text(trending![index].title),

                                );
                          },
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.red[700], // Background color
                          ),
                          child: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                ),
              ),
            )));
  }
}
