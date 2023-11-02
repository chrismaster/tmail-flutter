
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';
import 'package:model/mailbox/presentation_mailbox.dart';

class MailboxConstants {
  static final List<Role> defaultMailboxRoles = [
    PresentationMailbox.roleInbox,
    PresentationMailbox.roleOutbox,
    PresentationMailbox.roleDrafts,
    PresentationMailbox.roleSent,
    PresentationMailbox.roleTrash,
    PresentationMailbox.roleSpam,
    PresentationMailbox.roleTemplates,
  ];
}