import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:to_do/commun/TextField.dart';
import 'package:to_do/model/Appstyle.dart';
import 'package:to_do/model/RadioWidget.dart';
import 'package:to_do/provider/DateTimeProvider.dart';
import 'package:to_do/provider/cloudprovider.dart';
import 'package:to_do/provider/radioProvider.dart';
import 'package:to_do/screen/DataTimeWidget.dart';

class EditModel extends ConsumerWidget {
  const EditModel(
      {super.key,
      required this.title_controller,
      required this.description_controller,
      required this.uuid});
  final TextEditingController title_controller;
  final TextEditingController description_controller;
  final String? uuid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateProv = ref.watch(dateProvider);
    final data = ref.watch(cloudServiceProvider);

    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
            child: Text(
              "New Task",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Divider(
            thickness: 1.2,
            color: Colors.grey.shade200,
          ),
          const Gap(12),
          const Text(
            "Title Task",
            style: AppStyle.headingOne,
          ),
          const Gap(6),
          TextFieldWidget(
            textController: title_controller,
            hintText: "Add Task Name.",
            maxLines: 1,
          ),
          const Gap(12),
          const Text(
            "Description",
            style: AppStyle.headingOne,
          ),
          const Gap(6),
          TextFieldWidget(
            textController: description_controller,
            maxLines: 5,
            hintText: "Add Descriptions.",
          ),
          const Gap(12),
          const Text(
            "Category",
            style: AppStyle.headingOne,
          ),
          Row(
            children: [
              Expanded(
                child: RadioWidget(
                  titleRadio: "LRN",
                  categColor: Colors.green,
                  valueInput: 1,
                  OnChangeValue: () =>
                      ref.read(radioProvider.notifier).update((state) => 1),
                ),
              ),
              Expanded(
                child: RadioWidget(
                  titleRadio: "WRK",
                  categColor: Colors.blue.shade700,
                  valueInput: 2,
                  OnChangeValue: () =>
                      ref.read(radioProvider.notifier).update((state) => 2),
                ),
              ),
              Expanded(
                child: RadioWidget(
                  titleRadio: "GEN",
                  categColor: Colors.amberAccent.shade700,
                  valueInput: 3,
                  OnChangeValue: () =>
                      ref.read(radioProvider.notifier).update((state) => 3),
                ),
              ),
            ],
          ),
          //Date and Time Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DateTimeWidget(
                titleText: "Date",
                valueText: dateProv,
                iconSection: CupertinoIcons.calendar,
                onTap: () async {
                  final getValue = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2025),
                  );
                  if (getValue != null) {
                    final format = DateFormat.yMd();
                    ref
                        .read(dateProvider.notifier)
                        .update((state) => format.format(getValue));
                  }
                },
              ),
              const Gap(22),
              DateTimeWidget(
                titleText: "Time",
                valueText: ref.watch(timeProvider),
                iconSection: CupertinoIcons.clock,
                onTap: () async {
                  final getTime = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  if (getTime != null) {
                    ref
                        .read(timeProvider.notifier)
                        .update((state) => getTime.format(context));
                  }
                },
              ),
            ],
          ),
          //Button Section
          const Gap(12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade800,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(
                      color: Colors.blue.shade800,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
              ),
              const Gap(20),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(
                      color: Colors.blue.shade800,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                  ),
                  onPressed: () async {
                    final getRadioValue = ref.read(radioProvider);
                    String category = "";
                    switch (getRadioValue) {
                      case 1:
                        category = "Learning";
                        break;
                      case 2:
                        category = "Working";
                      case 3:
                        category = "General";
                    }
                    data.EditTask(
                        title_controller.text,
                        description_controller.text,
                        dateProv,
                        ref.watch(timeProvider),
                        category,
                        uuid!);
                    Navigator.pop(context);
                  },
                  child: const Text("Edit"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
