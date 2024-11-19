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
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AffirmationDetail(
                        image: widget.affirmation.image,
                        text: widget.affirmation.desc,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(widget.affirmation.image),
                ),
              ),
            ),
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

class AffirmationDetail extends StatelessWidget {
  String image;
  String text;

  AffirmationDetail({required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détails de l'affirmation"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 500,  
            width: double.infinity,  
            fit: BoxFit.cover,  
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
} 