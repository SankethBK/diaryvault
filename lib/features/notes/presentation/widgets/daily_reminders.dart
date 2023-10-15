import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/settings_page_theme_extensions.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/data/models/user_config_model.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:dairy_app/features/notes/domain/repositories/notifications_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_accordion/widgets/AccordionHeaderItem.dart';
import 'package:simple_accordion/widgets/AccordionItem.dart';
import 'package:simple_accordion/widgets/AccordionWidget.dart';

// ignore: must_be_immutable
class DailyReminders extends StatelessWidget {
  late INotificationsRepository notificationsRepository;

  DailyReminders({Key? key}) : super(key: key) {
    notificationsRepository = sl<INotificationsRepository>();
  }

  String getSubtitle(bool? isDailyReminderEnabled, TimeOfDay? reminderTime) {
    if (isDailyReminderEnabled == null || isDailyReminderEnabled == false) {
      return "Notifications are not enabled";
    }

    if (reminderTime == null) {
      return "You haven't selected a notification time";
    }

    return "You will be notified at ${UserConfigModel.getTimeOfDayToString(reminderTime)}";
  }

  @override
  Widget build(BuildContext context) {
    final userConfigCubit = BlocProvider.of<UserConfigCubit>(context);

    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    final inactiveTrackColor = Theme.of(context)
        .extension<SettingsPageThemeExtensions>()!
        .inactiveTrackColor;

    final activeColor =
        Theme.of(context).extension<SettingsPageThemeExtensions>()!.activeColor;

    return BlocBuilder<UserConfigCubit, UserConfigState>(
        builder: (context, state) {
      final isDailyReminderEnabled =
          state.userConfigModel?.isDailyReminderEnabled;

      final reminderTime = state.userConfigModel?.reminderTime;

      return SimpleAccordion(
          headerColor: mainTextColor,
          headerTextStyle: TextStyle(
            color: mainTextColor,
            fontSize: 16,
          ),
          children: [
            AccordionHeaderItem(
              title: "Daily Reminders",
              children: [
                AccordionItem(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SwitchListTile(
                          inactiveTrackColor: inactiveTrackColor,
                          activeColor: activeColor,
                          contentPadding: const EdgeInsets.all(0.0),
                          title: Text(
                            "Enable Daily Reminders",
                            style: TextStyle(color: mainTextColor),
                          ),
                          subtitle: Text(
                            "Get daily reminders at your chosen time to keep your journal up to date.",
                            style: TextStyle(color: mainTextColor),
                          ),
                          value: isDailyReminderEnabled ?? false,
                          onChanged: (value) async {
                            try {
                              if (value == true) {
                                if (reminderTime != null) {
                                  await notificationsRepository
                                      .zonedScheduleNotification(reminderTime);
                                }
                              } else {
                                await notificationsRepository
                                    .cancelAllNotifications();
                              }

                              userConfigCubit.setUserConfig(
                                UserConfigConstants.isDailyReminderEnabled,
                                value,
                              );
                            } on Exception catch (e) {
                              showToast(
                                  e.toString().replaceAll("Exception: ", ""));
                            }
                          },
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.only(right: 10.0),
                          title: Text(
                            "Choose Time",
                            style: TextStyle(color: mainTextColor),
                          ),
                          subtitle: Text(
                            getSubtitle(isDailyReminderEnabled, reminderTime),
                            style: TextStyle(color: mainTextColor),
                          ),
                          trailing: Icon(
                            Icons.alarm,
                            color: mainTextColor,
                          ),
                          onTap: () async {
                            TimeOfDay selectedTime = TimeOfDay.now();

                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                            );

                            if (pickedTime != null) {
                              // Handle the selected time
                              userConfigCubit.setUserConfig(
                                UserConfigConstants.reminderTime,
                                UserConfigModel.getTimeOfDayToString(
                                    pickedTime),
                              );

                              // if notifications are enabled, then new schedule new notification at this time
                              notificationsRepository
                                  .zonedScheduleNotification(pickedTime);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ]);
    });
  }
}
