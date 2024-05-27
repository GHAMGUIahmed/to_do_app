import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:to_do/model/TaskModel.dart';
import 'package:to_do/provider/TitleProvider.dart';
import 'package:to_do/provider/auth_provider.dart';
import 'package:to_do/provider/cloudprovider.dart';
import 'package:to_do/screen/EditScreen.dart';

class CardWidget extends ConsumerWidget {
  final ToDoModel note;

  const CardWidget({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cloud = ref.watch(cloudServiceProvider);
    final auth = ref.watch(authServiceProvider);
    Color categoryColor = Colors.white;
    final getCategory = note.Category;
    switch (getCategory) {
      case "Learning":
        categoryColor = Colors.green;
        break;
      case "Working":
        categoryColor = Colors.blue.shade700;
        break;
      case "General":
        categoryColor = Colors.amber.shade700;
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: categoryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: IconButton(
                      icon: const Icon(CupertinoIcons.delete),
                      onPressed: () {
                        cloud.deleteNote(note.docID!);
                      },
                    ),
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      note.TitleTask,
                      style: TextStyle(
                        decoration:
                            note.isDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Text(note.Description),
                    trailing: Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        activeColor: Colors.blue.shade800,
                        shape: const CircleBorder(),
                        value: note.isDone,
                        onChanged: (value) {
                          cloud.update(value!, note.docID!);
                        },
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -12),
                    child: Column(
                      children: [
                        Divider(
                          thickness: 1.5,
                          color: Colors.grey.shade200,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(note.DateTask),
                            const Gap(12),
                            Text(note.TimeTask),
                            const Gap(12),
                            ElevatedButton(
                              onPressed: () => showModalBottomSheet(
                                isScrollControlled: true,
                                useRootNavigator: auth.user != null,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                context: context,
                                builder: (context) => EditModel(
                                  title_controller:
                                      ref.read(titleControllerProvider),
                                  description_controller:
                                      ref.read(descControllerProvider),
                                  uuid: note.docID,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: categoryColor,
                                foregroundColor: Colors.black,
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: SizedBox(
                                width: 60,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                          height: 15,
                                          child:
                                              Image.asset("assets/edit.png")),
                                      const Gap(12),
                                      const SizedBox(
                                        width: 30,
                                        child: Text(
                                          "Edit",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
