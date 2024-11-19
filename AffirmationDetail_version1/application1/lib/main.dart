import 'package:flutter/material.dart';
import 'data/loaddata.dart';
import 'domain/affirmation.dart';

void main() {
  runApp(AffirmationApp());
}

class AffirmationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Affirmations",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: AffirmationList(),
    );
  }
}

class AffirmationList extends StatelessWidget {
  final List<Affirmation> affirmations = loaddata();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Affirmations"),
      ),
      body: ListView.builder(
        itemCount: affirmations.length,
        itemBuilder: (context, index) {
          return AffirmationCard(affirmation: affirmations[index]);
        },
      ),
    );
  }
}

class AffirmationCard extends StatefulWidget {
  final Affirmation affirmation;

  AffirmationCard({required this.affirmation});

  @override
  _AffirmationCardState createState() => _AffirmationCardState();
}

class _AffirmationCardState extends State<AffirmationCard> {
  int likeCount = 0;

  void _incrementLike() {
    setState(() {
      likeCount++;
    });
  }

  void _decrementLike() {
    setState(() {
      if (likeCount > 0) likeCount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.affirmation.image),
            SizedBox(height: 8.0),
            Text(
              widget.affirmation.desc,
              style: TextStyle(fontSize: 18.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Likes: $likeCount"),
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red),
                  onPressed: _incrementLike,
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border, color: Colors.grey),
                  onPressed: _decrementLike,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
