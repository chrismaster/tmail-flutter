
import 'package:flutter/material.dart';
import 'package:model/mailbox/presentation_mailbox.dart';
import 'package:tmail_ui_user/features/destination_picker/presentation/destination_picker_bindings.dart';
import 'package:tmail_ui_user/features/destination_picker/presentation/destination_picker_view.dart';
import 'package:tmail_ui_user/features/destination_picker/presentation/model/destination_picker_arguments.dart';
import 'package:tmail_ui_user/features/mailbox_creator/presentation/mailbox_creator_bindings.dart';
import 'package:tmail_ui_user/features/mailbox_creator/presentation/mailbox_creator_view.dart';
import 'package:tmail_ui_user/features/mailbox_creator/presentation/model/mailbox_creator_arguments.dart';
import 'package:tmail_ui_user/features/mailbox_creator/presentation/model/new_mailbox_arguments.dart';
import 'package:tmail_ui_user/main/routes/route_navigation.dart';

mixin ViewAsDialogActionMixin {

  void showDialogDestinationPicker({
    required BuildContext context,
    required DestinationPickerArguments arguments,
    required Function(PresentationMailbox) onSelectedMailbox
  }) {
    DestinationPickerBindings().dependencies();

    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        barrierColor: Colors.black.withAlpha(24),
        pageBuilder: (context, animation, secondaryAnimation) {
          return DestinationPickerView.fromArguments(
              arguments,
              onDismissCallback: () {
                DestinationPickerBindings().dispose();
                popBack();
              },
              onSelectedMailboxCallback: (destinationMailbox) {
                DestinationPickerBindings().dispose();
                popBack();

                if (destinationMailbox is PresentationMailbox) {
                  onSelectedMailbox.call(destinationMailbox);
                }
              });
        });
  }

  void showDialogMailboxCreator({
    required BuildContext context,
    required MailboxCreatorArguments arguments,
    required Function(NewMailboxArguments) onCreatedMailbox
  }) {
    MailboxCreatorBindings().dependencies();

    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        barrierColor: Colors.black.withAlpha(24),
        pageBuilder: (context, animation, secondaryAnimation) {
          return MailboxCreatorView.fromArguments(
              arguments,
              onDismissCallback: () {
                MailboxCreatorBindings().dispose();
                popBack();
              },
              onCreatedMailboxCallback: (arguments) {
                MailboxCreatorBindings().dispose();
                popBack();

                if (arguments is NewMailboxArguments) {
                  onCreatedMailbox.call(arguments);
                }
              });
        });
  }
}