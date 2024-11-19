import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'data/loaddata.dart';
import 'domain/affirmation.dart';

void main() {
  runApp(AffirmationApp());
}

/// Configuration des routes
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => AffirmationList(),
      routes: [
        GoRoute(
          path: 'details/:id',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            final Affirmation affirmation = loaddata()[id];
            return AffirmationDetail(
              image: affirmation.image,
              text: affirmation.desc,
            );
          },
        ),
      ],
    ),
  ],
);

class AffirmationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: "Affirmations",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
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
          return AffirmationCard(affirmation: affirmations[index], id: index);
        },
      ),
    );
  }
}

class AffirmationCard extends StatefulWidget {
  final Affirmation affirmation;
  final int id;

  AffirmationCard({required this.affirmation, required this.id});

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
                  //mettre a jour la navigation
                  context.go('/details/${widget.id}');
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
  final String image;
  final String text;

  AffirmationDetail({required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détails de l'affirmation "),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
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
