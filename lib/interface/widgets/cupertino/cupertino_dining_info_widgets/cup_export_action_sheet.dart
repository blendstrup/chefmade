import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/dining_model.dart';
import '../../../../data/repositories/email_repository.dart';
import '../../../../state/repository_providers.dart';
import '../../../../state/restaurant_providers.dart';
import '../../../../utils/file_utilities.dart';

class CupExportActionSheet extends ConsumerWidget {
  const CupExportActionSheet({Key? key, required this.dining})
      : super(key: key);

  final Dining dining;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String _date = FileUtilities.formatDate(dining.eventDate);

    final _user = ref.watch(authRepositoryProvider).getCurrentUser();
    final _restaurant = ref.watch(restaurantProvider).value;
    final _emailRepository = ref.watch(emailRepositoryProvider);

    return CupertinoActionSheet(
      title: const Text('Export dining information'),
      message: const Text(
          'The information will be exported in the chosen format and then sent to your email.'),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          child: const Text('Send .csv to email'),
          onPressed: () => sendFile(
            context,
            email: _user!.email!,
            subject:
                'Your exported file from chefmade: Private Dining - $_date',
            text:
                'Hello ${_restaurant!.name}\n\nAttached to this email you\'ll find a .csv file with information about the dining:\nDining - $_date\n\nThis email cannot be replied. If you have any questions please contact chefmade at: info@chefmade.dk\n\nKind regards\nchefmade',
            emailRepository: _emailRepository,
            isCsv: true,
          ),
        ),
        CupertinoActionSheetAction(
          child: const Text('Send .txt to email'),
          onPressed: () => sendFile(
            context,
            email: _user!.email!,
            subject:
                'Your exported file from chefmade: Private Dining - $_date',
            text:
                'Hello ${_restaurant!.name}\n\nAttached to this email you\'ll find a .txt file with information about the dining:\nDining - $_date\n\nThis email cannot be replied. If you have any questions please contact chefmade at: info@chefmade.dk\n\nKind regards\nchefmade',
            emailRepository: _emailRepository,
            isCsv: false,
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text('Cancel'),
        onPressed: Navigator.of(context).pop,
      ),
    );
  }

  void sendFile(
    BuildContext context, {
    required String email,
    required String subject,
    required String text,
    required EmailRepository emailRepository,
    required bool isCsv,
  }) async {
    String _date = FileUtilities.formatDate(dining.eventDate);

    final _csv = FileUtilities.writeDiningCsvFile(
      fileName: 'Private Dining - $_date',
      dining: dining,
    );
    final _txt = FileUtilities.writeDiningTxtFile(
      fileName: 'Private Dining - $_date',
      dining: dining,
    );

    final message = emailRepository.createMessage(
      subject: subject,
      email: email,
      text: text,
      file: isCsv ? await _csv : await _txt,
    );

    emailRepository.sendMailFromChefmade(message);
    Navigator.of(context).pop(true);
  }
}
