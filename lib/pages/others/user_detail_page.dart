import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:yipl/services/models/userlist_data_model.dart';

class UserDetailsPage extends StatelessWidget {
  final User user;

  const UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[
            const Center(
                child: CircleAvatar(
              child: Icon(
                Icons.person,
                size: 30,
              ),
            )),
            const SizedBox(
              height: 20,
            ),
            Text(
              ' ${user.username}',
              style: const TextStyle(color: Colors.deepOrange),
            ),
            const SizedBox(
              height: 35,
            ),
            Text(
              'FullName: ${user.name}',
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () async {
                  String email = Uri.encodeComponent(user.email);
                  String subject = Uri.encodeComponent("Hello Flutter");
                  String body =
                      Uri.encodeComponent("Hi! I'm Flutter Developer");

                  Uri mail =
                      Uri.parse("mailto:$email?subject=$subject&body=$body");
                  if (await launchUrl(mail)) {
                    //email app opened
                  } else {}
                },
                child: Text(
                  "Email : ${user.email}",
                  style: const TextStyle(color: Colors.black),
                )),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () async {
                  Uri phoneno = Uri.parse('tel:${user.phone},');
                  if (await launchUrl(phoneno)) {
                    //dialer opened
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Dailer can' 't be launched.'),
                      ),
                    );
                  }
                },
                child: Text(
                  'Phone: ${user.phone}',
                  style: const TextStyle(color: Colors.black),
                )),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              child: Text(
                'Website: ${user.website}',
                style: const TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                String url = user.website;
                var urllaunchable = await canLaunchUrlString(url);
                if (urllaunchable) {
                  await launchUrlString(url);
                } else {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Url can' 't be launched.'),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
