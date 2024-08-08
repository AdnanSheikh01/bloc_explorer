import 'package:flutter/material.dart';

class DetailedHomePage extends StatefulWidget {
  const DetailedHomePage({super.key, required this.image, required this.title});
  final String image;
  final String title;

  @override
  State<DetailedHomePage> createState() => _DetailedHomePageState();
}

class _DetailedHomePageState extends State<DetailedHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text('Bloc Explorer'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Image.network(
                  widget.image,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Divider(),
                      ),
                      const Text(
                        'Accusam lorem voluptua amet no aliquyam, elitr ipsum aliquyam stet magna ipsum, lorem no eos sit vero sea consetetur diam. Tempor sanctus amet dolor gubergren erat, amet lorem nonumy et diam nonumy est, eirmod lorem sea rebum ut. Amet eos est sed et, et diam sit no sed takimata ea.',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
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
