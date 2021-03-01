import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class AnalyticsEventExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Evento'),
          onPressed: () {
            FirebaseAnalytics()
                .logEvent(name: 'Event', parameters: {"test": "event"});
          },
        ),
      ),
    );
  }
}
