import 'dart:io' show File;

import 'package:mailer/mailer.dart';

import '../remote/email_service.dart';

abstract class IEmailRepository {
  void sendMailFromChefmade(Message message);
}

class EmailRepository implements IEmailRepository {
  @override
  void sendMailFromChefmade(Message message) async {
    EmailService.sendMail(message);
  }

  Message createMessage({
    File? file,
    required String email,
    required String subject,
    required String text,
  }) {
    final _message = Message()
      ..from = const Address('noreply@chefmade.dk', 'chefmade')
      ..recipients.add(email)
      ..subject = subject
      ..text = text;

    if (file != null) {
      _message.attachments = [
        FileAttachment(file)..location = Location.attachment
      ];
    }

    return _message;
  }

  openMail({
    required String subject,
    required String body,
    required String recipient,
  }) async {
    EmailService.mailTo(subject, body, recipient);
  }
}
