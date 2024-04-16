// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/**
 * 1. import Pushwoosh package
 * 2. place the google-services.json file into android/app folder in your project directory.
 */
import 'package:pushwoosh_flutter/pushwoosh_flutter.dart';

void main() {
  runApp(const MyApp());
/**
 * initialize Pushwoosh SDK.
 * Example params: {"app_id": "application id", "sender_id": "FCM sender id"}
 * 
 * 1. app_id - YOUR_APP_ID
 * 2. sender_id - FCM_SENDER_ID
 */
  Pushwoosh.initialize({"app_id": "XXXXX-XXXXX", "sender_id": "XXXXXXXXXXXX"});

/**
 * To process various events, use the corresponding listeners as follows.
 * Push receipt:
 * **********************************************************
 * Pushwoosh.getInstance.onPushReceived.listen((event) {}); *
 * **********************************************************
 * 
 * Push open:
 * **********************************************************
 * Pushwoosh.getInstance.onPushAccepted.listen((event) {}); *
 * **********************************************************
 * 
 *      PUSHWOOSH CODE
 *          |   |
 *         _|   |_
 *         \     /
 *          \   /
 *           \_/
 */
  Pushwoosh.getInstance.onPushReceived.listen((event) {
    if (kDebugMode) {
      print(event.pushwooshMessage.payload);
    }
  });

  Pushwoosh.getInstance.onPushAccepted.listen((event) {
    if (kDebugMode) {
      print(event.pushwooshMessage.payload);
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'PUSHWOOSH DEMO'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool notificationsEnabled = false;
  bool foregroundAlertEnabled = true;
  String userId = '';
  String eventName = '';
  String tagKey = '';
  String tagValue = '';
  String language = '';
  int badges = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void registerForRemoteNotification(bool value) {
    setState(() {
      notificationsEnabled = value;
      if (value == false) {
        /**
         * To unregister for push notifications, call the following method:
         * 
         * PUSHWOOSH CODE
         *    |   |
         *   _|   |_
         *   \     /
         *    \   /
         *     \_/
         */
        Pushwoosh.getInstance.unregisterForPushNotifications();
      } else {
        /**
         * To register for push notifications, call the following method:
         * 
         * PUSHWOOSH CODE
         *    |   |
         *   _|   |_
         *   \     /
         *    \   /
         *     \_/
         */
        Pushwoosh.getInstance.registerForPushNotifications();
      }
    });
  }

  void showForegroundAlert(bool value) {
    setState(() {
      foregroundAlertEnabled = value;
      if (foregroundAlertEnabled == true) {
        showAlert(context, 'INFO', "FOREGROUND ALERTS ENABLED");
      } else {
        showAlert(context, 'INFO', "FOREGROUND ALERTS DISABLED");
      }
      /**
       * Show push notifications alert when push notification is received while the app is running, default is `true`
       * 
       * PUSHWOOSH CODE
       *    |   |
       *   _|   |_
       *   \     /
       *    \   /
       *     \_/
       */
      Pushwoosh.getInstance.setShowForegroundAlert(value);
    });
  }

  void showAlert(BuildContext context, String title, String content) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showToken() async {
    /**
     * Push notification token or null if device is not registered yet.
     * 
     * PUSHWOOSH CODE 
     *    |   |
     *   _|   |_
     *   \     /
     *    \   /
     *     \_/
     */
    String? token = await Pushwoosh.getInstance.getPushToken;
    showAlert(context, "Push Token", token!);
  }

  void showHWID() async {
    /**
     * Pushwoosh HWID associated with current device
     * 
     * PUSHWOOSH CODE 
     *    |   |
     *   _|   |_
     *   \     /
     *    \   /
     *     \_/
     */
    String hwid = await Pushwoosh.getInstance.getHWID;
    showAlert(context, "HWID", hwid);
  }

  Widget buildButtonRow(
    String buttonText,
    void Function()? onPressed, {
    double? buttonWidth,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (buttonWidth != null)
          SizedBox(
            width: buttonWidth,
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: TextStyle(fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 25, 14, 184)),
              ),
            ),
          )
        else
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  buttonText,
                  style: TextStyle(fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 25, 14, 184)),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 101, 240, 154),
        title: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        buildButtonRow('SET USER ID', () async {
                          /**
                           * Set User indentifier. This could be Facebook ID, username or email, or any other user ID.
                           * This allows data and events to be matched across multiple user devices.
                           * 
                           * PUSHWOOSH CODE 
                           *    |   |
                           *   _|   |_
                           *   \     /
                           *    \   /
                           *     \_/
                           */
                          Pushwoosh.getInstance.setUserId(userId);
                        }, buttonWidth: 170),
                        SizedBox(width: 16),
                        Expanded(
                          child: CupertinoTextField(
                            placeholder: 'USER ID',
                            onChanged: (value) {
                              setState(() {
                                userId = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        buildButtonRow('POST EVENT', () async {
                          /**
                           * Post events for In-App Messages. This can trigger In-App message HTML as specified in Pushwoosh Control Panel.
                           * [event] is string name of the event
                           * [attributes] is map contains additional event attributes
                           * 
                           * PUSHWOOSH CODE 
                           *    |   |
                           *   _|   |_
                           *   \     /
                           *    \   /
                           *     \_/
                           */
                          Pushwoosh.getInstance.postEvent(
                              eventName, {"KEY1": "VALUE1", "KEY2": "VALUE2"});
                        }, buttonWidth: 170),
                        SizedBox(width: 16),
                        Expanded(
                          child: CupertinoTextField(
                            placeholder: 'EVENT NAME',
                            onChanged: (value) {
                              setState(() {
                                eventName = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        buildButtonRow('SET TAGS', () async {
                          /**
                           * Associates device with given [tags]. If setTags request fails tags will be resent on the next application launch.
                           * 
                           * PUSHWOOSH CODE 
                           *    |   |
                           *   _|   |_
                           *   \     /
                           *    \   /
                           *     \_/
                           */
                          Pushwoosh.getInstance.setTags({tagKey: tagValue});
                        }, buttonWidth: 170),
                        SizedBox(width: 16),
                        Expanded(
                          child: CupertinoTextField(
                            placeholder: 'KEY',
                            onChanged: (value) {
                              setState(() {
                                tagKey = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: CupertinoTextField(
                            placeholder: 'VALUE',
                            onChanged: (value) {
                              setState(() {
                                tagValue = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        buildButtonRow('SET LANGUAGE', () {
                          /**
                           * 'setLanguage(String language)' method
                           * 
                           * PUSHWOOSH CODE 
                           *    |   |
                           *   _|   |_
                           *   \     /
                           *    \   /
                           *     \_/
                           */
                          Pushwoosh.getInstance.setLanguage(language);
                        }, buttonWidth: 170),
                        SizedBox(width: 16),
                        Expanded(
                          child: CupertinoTextField(
                            placeholder: 'en',
                            onChanged: (value) {
                              setState(() {
                                language = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    buildButtonRow('GET HWID', () async {
                      showHWID();
                    }),
                    buildButtonRow('GET PUSH TOKEN', () async {
                      showToken();
                    }),
                    buildButtonRow('GET TAGS', () async {
                      /**
                       * Gets tags associated with current device

                       * PUSHWOOSH CODE 
                       *    |   |
                       *   _|   |_
                       *   \     /
                       *    \   /
                       *     \_/
                       */
                      Map<dynamic, dynamic> tags = await Pushwoosh.getInstance.getTags();
                      String tagToString = tags.toString();
                      showAlert(context, 'TAGS', tagToString);
                    }),
                    buildButtonRow('RESET BADGES', () async {
                      /**
                       * PUSHWOOSH CODE 
                       *    |   |
                       *   _|   |_
                       *   \     /
                       *    \   /
                       *     \_/
                       */
                      Pushwoosh.getInstance.setApplicationIconBadgeNumber(0);
                    }),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'FOR HUAWEI DEVICES',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    buildButtonRow('ENABLE HUAWEI NOTIFICATIONS', () async {
                      /**
                       * PUSHWOOSH CODE 
                       *    |   |
                       *   _|   |_
                       *   \     /
                       *    \   /
                       *     \_/
                       */
                      Pushwoosh.getInstance.enableHuaweiNotifications();
                    }),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      notificationsEnabled ? 'UNREGISTER FOR PUSH NOTIFICATIONS' : 'REGISTER FOR PUSH NOTIFICATIONS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value: notificationsEnabled,
                      onChanged: registerForRemoteNotification,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SHOW FOREGROUND ALERT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value: foregroundAlertEnabled,
                      onChanged: showForegroundAlert,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility),
            label: 'Actions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _tabController.index,
        selectedItemColor: Color.fromARGB(255, 25, 14, 184),
        onTap: (index) {
          setState(() {
            _tabController.index = index;
          });
        },
      ),
    );
  }
}
