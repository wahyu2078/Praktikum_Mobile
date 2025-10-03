import 'package:flutter/material.dart';

void main() {
  runApp(WahyuApp());
}

class WahyuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Lirik',
      theme: ThemeData(primarySwatch:   Colors.purple, fontFamily: 'Roboto'),
      home: LyricsPage(),
    );
  }
}

class LyricsPage extends StatelessWidget {
  final String lyrics = """I've been too busy, ignoring, and hiding
About what my heart actually say
Stay awake while I'm drowning on my thoughts
Sometimes a happiness is just a happiness

I've never been enjoyin' my serenity
Even if I've got a lot of company
That makes me happy

Soul try to figure it out
From where I've been escapin'
Running to end all the sin
Get away from the pressure
Wondering to get a love that is so pure
Gotta have to always make sure
That I'm not just somebody's pleasure

I always pretending and lying
I got used to feeling empty
'Cause all I got is unhappy
Happiness, can't I get happiness?

I've never been enjoyin' my serenity
Even if I've got a lot of company
That makes me happy

Soul try to figure it out
From where I've been escapin'
Running to end all the sin
Get away from the pressure
Wondering to get a love that is so pure
Gotta have to always make sure
That I'm not just somebody's pleasure

It was in a blink of an eye
Find a way how to say goodbye
I've got to take me away
From all sadness

Stitch all my wounds, confess all the sins (confess all the sins)
And took all my insecure
When will I got the love that is so pure?
Gotta have to always make sure
That I'm not just somebody's pleasure

Gotta have
Gotta have to always make sure
That I'm not just somebody's pleasure""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Somebody\'s Pleasure',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 33, 63),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(height: 1, color: Colors.white.withOpacity(0.2)),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [const Color.fromARGB(255, 5, 51, 78)!, const Color.fromARGB(255, 5, 194, 207)!],
            ),
          ),
          child: Row(
            children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white.withOpacity(0.12)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.18),
                        blurRadius: 70,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lyrics,
                          style: TextStyle(
                            fontSize: 20,
                            height: 1.75,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
