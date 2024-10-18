import 'package:flutter/material.dart';
import 'package:flutter_application_1/Utilities/utilities.dart';
import 'package:flutter_application_1/model/profile_model.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //
  // Map<String, dynamic> pData = {};
  ProfileModel? pData;
  void loadProfileData() async {
    // pData = await Utilities.getUserDetails();
    var data = await Utilities.getUserDetails();
    setState(() {
      pData = ProfileModel.fromJson(data);
    });
  }

  @override
  void initState() {
    loadProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return pData != null
        ? Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(pData!.image!),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    decoration: InputDecoration(
                      enabled: false,
                      border: const OutlineInputBorder(),
                      hintText: pData!.firstName,
                      //hintText : pData['firstName']
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      enabled: false,
                      border: const OutlineInputBorder(),
                      hintText: pData!.lastName,
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
