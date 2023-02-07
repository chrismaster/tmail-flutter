import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';
import 'package:tmail_ui_user/features/mailbox/domain/model/mailbox_subscribe_action_state.dart';
import 'package:tmail_ui_user/features/mailbox/domain/model/mailbox_subscribe_state.dart';

class SubscribeMailboxRequest with EquatableMixin {

  final MailboxId mailboxId;
  final MailboxSubscribeState newState;
  final MailboxSubscribeAction mailboxSubscribeStateAction;

  SubscribeMailboxRequest(
    this.mailboxId, 
    this.newState, 
    this.mailboxSubscribeStateAction);
  
  @override
  List<Object?> get props => [mailboxId, newState, mailboxSubscribeStateAction];
}