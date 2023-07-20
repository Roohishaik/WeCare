import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wecare/components/appointment_cards.dart';
import 'package:wecare/components/doctor_card.dart';
import 'package:wecare/utils/config.dart';
import 'package:wecare/screens/appointment_page.dart';
import 'package:wecare/utils/main_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> medCat = [
    {
      "icon": FontAwesomeIcons.rainbow,
      "category": "Over Coming Depression",
    },
    {
      "icon": FontAwesomeIcons.shield,
      "category": "Tackling Stress",
    },
    {
      "icon": FontAwesomeIcons.bomb,
      "category": "Anger Management",
    },
    {
      "icon": FontAwesomeIcons.solidFaceDizzy,
      "category": "Dealing Anxiety",
    },
    {
      "icon": FontAwesomeIcons.bed,
      "category": "Better Sleep",
    },
    {
      "icon": FontAwesomeIcons.faceSmile,
      "category": "Being More HAppy",
    },
  ];

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // @override
  // //initialize Firebase Cloud Messaging
  // void initState() {
  //   //initState() is a lifecycle method that is commonly used to
  //   //perform one-time setup tasks when a widget is created.
  //   super.initState();
  //   initializeFirebaseMessaging();
  // }

  // void initializeFirebaseMessaging() {
  //   _firebaseMessaging.requestPermission(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );

  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     if (message.notification != null) {
  //       // Show the notification using the Zen Quotes API
  //       showZenQuoteNotification(message.notification!.title ?? '',
  //           message.notification!.body ?? '');
  //     }
  //   });
  // }

  Future<String> fetchRandomQuote() async {
    final response =
        await http.get(Uri.parse('https://zenquotes.io/api/random'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data[0]['q'] + ' - ' + data[0]['a'];
    } else {
      throw Exception('Failed to fetch a random quote');
    }
  }

  // Future<void> showZenQuoteNotification(String title, String body) async {
  //   final randomQuote = await fetchRandomQuote();

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         content: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(body),
  //             SizedBox(height: 10),
  //             Text(randomQuote),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Close'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  bool showNotification = true;

  // Future<String> fetchDailyQuote() async {
  //   final response =
  //       await http.get(Uri.parse('https://zenquotes.io/api/random'));
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     return data[0]['q'] + ' - ' + data[0]['a'];
  //   } else {
  //     throw Exception('Failed to fetch the daily quote');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Prakhar Shukla',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10),
                            if (showNotification)
                              IconButton(
                                icon: Icon(Icons.notifications),
                                color: Colors.blue,
                                onPressed: () async {
                                  final randomQuote = await fetchRandomQuote();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.blue,
                                                    Colors.teal,
                                                  ]),
                                            ),
                                            padding: const EdgeInsets.all(16),
                                            child: Text('Daily Quote')),
                                        content: Text(
                                          textAlign: TextAlign.left,
                                          randomQuote,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Close'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                          ],
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/', (route) => false);
                          },
                          child: const Text('Log out'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/ProPic.png'),
                      ),
                    ),
                  ],
                ),
                Config.spaceSmall,
                const Text(
                  'Your Concerns',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                //building the category list
                SizedBox(
                  height: Config.heightSize * 0.06,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List<Widget>.generate(
                      medCat.length,
                      (index) {
                        return Card(
                          margin: const EdgeInsets.only(right: 10),
                          color: Config.primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                FaIcon(
                                  medCat[index]['icon'],
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  medCat[index]['category'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Config.spaceSmall,
                const Text(
                  'Appointment Today',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,

                AppointmentCard(),

                Config.spaceSmall,

                const Text(
                  'Top Doctor\'s',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //List of top docotr's
                Config.spaceSmall,
                Column(
                  children: List.generate(10, (index) {
                    return const DoctorCard(
                      route: 'doc_details',
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
