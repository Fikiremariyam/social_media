import 'package:flutter/material.dart';
import 'package:social_media/views/Home/utils/config.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatefulWidget {
  const CallPage({
    super.key,
    required this.callID,
    required this.userId,
    required this.username
    });
  final   String callID; //call id that allow two parties join
  final String userId;// user id of other guy
  final  String username;
  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: appId, 
      appSign: appsign, 
      callID: widget.callID, 
      userID: widget.userId, 
      userName: widget.username, 
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
      
      );
  }
}