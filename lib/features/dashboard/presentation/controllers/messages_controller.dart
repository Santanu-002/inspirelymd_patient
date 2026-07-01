import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:intl/intl.dart';

class MessagesController extends GetxController {
  final textController = TextEditingController();
  final scrollController = ScrollController();
  final messagesList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _seedInitialMessages();
  }

  void _seedInitialMessages() {
    messagesList.assignAll([
      {
        'sender': 'doctor',
        'text': AppStrings.messages.initialMsg,
        'time': '9:14 AM',
      },
      {
        'sender': 'patient',
        'text': AppStrings.messages.sentMsg,
        'time': '9:31 AM',
      },
      {
        'sender': 'doctor',
        'text': AppStrings.messages.replyMsg,
        'time': '9:40 AM',
      },
    ]);
  }

  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    final nowStr = DateFormat.jm().format(DateTime.now());
    messagesList.add({'sender': 'patient', 'text': text, 'time': nowStr});
    textController.clear();
    _scrollToBottom();

    // Mock doctor automatic reply
    Future.delayed(const Duration(milliseconds: 1500), () {
      final replyTime = DateFormat.jm().format(DateTime.now());
      messagesList.add({
        'sender': 'doctor',
        'text':
            'I will review this right away and check in with you if needed. Keep up the great work!',
        'time': replyTime,
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
