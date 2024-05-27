import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:to_do/provider/TitleProvider.dart';
import 'package:to_do/provider/auth_provider.dart';
import 'package:to_do/provider/cloudprovider.dart';
import 'package:to_do/screen/CardWidget.dart';
import 'package:to_do/screen/ShowModel.dart';
import 'package:to_do/services/cloud_services.dart';

class HomePage extends ConsumerWidget {
  final String? userName;
  HomePage({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final format = DateFormat.yMMMd();
    final cloud = ref.watch(cloudServiceProvider);
    final auth = ref.watch(authServiceProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.amber.shade200,
            radius: 25,
            child: Image.asset("assets/profile.jpg"),
          ),
          title: Text(
            "Hello, I'm ",
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
          subtitle: Text(
            userName ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.bell),
                ),
                IconButton(
                  onPressed: () {
                    auth.singOut();
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Today's Task",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        format.format(DateTime.now()),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white70,
                      foregroundColor: Colors.blue.shade800,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () => showModalBottomSheet(
                      isScrollControlled: true,
                      useRootNavigator: auth.user != null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      context: context,
                      builder: (context) => ShowModel(
                        title_controller: ref.read(titleControllerProvider),
                        description_controller:
                            ref.read(descControllerProvider),
                      ),
                    ),
                    child: const Text(
                      "+ New Task",
                    ),
                  ),
                ],
              ),
              const Gap(20),
              StreamBuilder<QuerySnapshot>(
                  stream: CloudService().stream(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    final notelist = cloud.getNotes(snapshot);
                    if (notelist.isEmpty) {
                      return const CircularProgressIndicator();
                    }
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final note = notelist[index];
                        return CardWidget(note: note);
                      },
                      itemCount: notelist.length,
                      shrinkWrap: true,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
