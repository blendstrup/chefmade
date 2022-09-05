import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart' show SmtpServer;
import 'package:url_launcher/url_launcher.dart';

class EmailService {
  static final _smtpServer = SmtpServer(
    'smtp.mandrillapp.com',
    port: 587,
    username: 'chefmade',
    password: 'ehXxy9VqdL85rwjSPuH-QA', //TODO Secure API-KEY
  );

  static sendMail(Message message) async {
    try {
      final sendReport = await send(message, _smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Mailer error: $e');
    }
  }

  static mailTo(
    String subject,
    String body,
    String recipient,
  ) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: recipient,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    if (await canLaunchUrl(_emailLaunchUri)) {
      await launchUrl(_emailLaunchUri);
    } else {
      throw 'Could not launch $_emailLaunchUri';
    }
  }
}
