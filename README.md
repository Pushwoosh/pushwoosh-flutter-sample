# FLUTTER SAMPLE 

## To launch and utilize a sample with Pushwoosh SDK integration, clone or download the repository archive.

### iOS
 <img src="https://github.com/Pushwoosh/pushwoosh-flutter-sample/blob/main/Screenshots/iOS_1.png" alt="Alt text" width="300"> <img src="https://github.com/Pushwoosh/pushwoosh-flutter-sample/blob/main/Screenshots/iOS_2.png" alt="Alt text" width="300"> 

### Android
 <img src="https://github.com/Pushwoosh/pushwoosh-flutter-sample/blob/main/Screenshots/Android_1.png" alt="Alt text" width="300"> <img src="https://github.com/Pushwoosh/pushwoosh-flutter-sample/blob/main/Screenshots/Android_2.png" alt="Alt text" width="300">

### 1. Go to 'demoapp' folder and install the package from the command line:

```
$ flutter packages get
```
### 2. Open lib -> Main.dart and add your App ID and FCM Sender ID.

```
/**
 * initialize Pushwoosh SDK.
 * Example params: {"app_id": "application id", "sender_id": "FCM sender id"}
 * 
 * 1. app_id - YOUR_APP_ID
 * 2. sender_id - FCM_SENDER_ID
 */
Pushwoosh.initialize({"app_id": "XXXXX-XXXXX", "sender_id": "XXXXXXXXXXXX"});
```

### 3. Add 'google-services.json' in android -> app folder.
