import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_button.dart';
import 'package:inspirelymd_patient/core/common/widgets/text_field/app_text_field.dart';
import 'package:inspirelymd_patient/core/common/widgets/snackbar/app_snackbar.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/features/dashboard/presentation/controllers/dashboard_controller.dart';

class BookAppointmentSheet extends StatefulWidget {
  const BookAppointmentSheet({super.key});

  @override
  State<BookAppointmentSheet> createState() => _BookAppointmentSheetState();
}

class _BookAppointmentSheetState extends State<BookAppointmentSheet> {
  final doctorController = TextEditingController();
  final specialtyController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay selectedTime = const TimeOfDay(hour: 10, minute: 0);

  @override
  void initState() {
    super.initState();
    doctorController.text = 'Dr. Robert Carter';
    specialtyController.text = 'Neurologist';
    dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    timeController.text = '10:00 AM';
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final controller = Get.find<DashboardController>();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.dashboard.bookApptTitle,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: controller.navigateBack,
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: AppStrings.dashboard.doctorNameLabel,
              controller: doctorController,
              hintText: AppStrings.dashboard.doctorNameHint,
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: AppStrings.dashboard.specialtyLabel,
              controller: specialtyController,
              hintText: AppStrings.dashboard.specialtyHint,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedDate = picked;
                          dateController.text = DateFormat('yyyy-MM-dd').format(picked);
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: AppTextField(
                        label: AppStrings.dashboard.dateLabel,
                        controller: dateController,
                        readOnly: true,
                        suffix: const Icon(Icons.calendar_today_rounded, size: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                      );
                      if (picked != null) {
                        setState(() {
                          selectedTime = picked;
                          final hourStr = picked.hourOfPeriod.toString();
                          final minuteStr = picked.minute.toString().padLeft(2, '0');
                          final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
                          timeController.text = '$hourStr:$minuteStr $period';
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: AppTextField(
                        label: AppStrings.dashboard.timeLabel,
                        controller: timeController,
                        readOnly: true,
                        suffix: const Icon(Icons.access_time_rounded, size: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            AppButton.filled(
              text: AppStrings.dashboard.confirmBookingButton,
              onPressed: () {
                final doc = doctorController.text.trim();
                final spec = specialtyController.text.trim();
                if (doc.isEmpty || spec.isEmpty) {
                  AppSnackbar.destructive(AppStrings.dashboard.fillRequiredFields);
                  return;
                }

                final parsedDateTime = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );

                controller.navigateBack();
                controller.bookAppointment(
                  doctorName: doc,
                  specialty: spec,
                  dateTime: parsedDateTime,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    doctorController.dispose();
    specialtyController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }
}
