import 'package:core/utils/app_logger.dart';
import 'package:fcm/model/type_name.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/properties/properties.dart';
import 'package:model/fcm/fcm_token_dto.dart';
import 'package:tmail_ui_user/features/push_notification/data/datasource/fcm_datasource.dart';
import 'package:tmail_ui_user/features/push_notification/domain/repository/fcm_repository.dart';
import 'package:tmail_ui_user/features/thread/data/datasource/thread_datasource.dart';
import 'package:tmail_ui_user/features/thread/data/model/email_change_response.dart';
import 'package:jmap_dart_client/jmap/core/state.dart' as jmap;
import 'package:tmail_ui_user/features/thread/domain/model/email_response.dart';

class FCMRepositoryImpl extends FCMRepository {

  final FCMDatasource _fcmDatasource;
  final ThreadDataSource _threadDataSource;

  FCMRepositoryImpl(
    this._fcmDatasource,
    this._threadDataSource
  );

  @override
  Future<FCMTokenDto> getFCMToken(String accountId) {
    return _fcmDatasource.getFCMToken(accountId);
  }

  @override
  Future<void> setFCMToken(FCMTokenDto fcmTokenDto) {
    log('FCMRepositoryImpl::setFCMToken(): $fcmTokenDto');
    return _fcmDatasource.setFCMToken(fcmTokenDto);
  }

  @override
  Future<void> deleteFCMToken(String accountId) {
    return _fcmDatasource.deleteFCMToken(accountId);
  }

  @override
  Future<EmailsResponse> getEmailChangesToPushNotification(
    AccountId accountId,
    jmap.State currentState,
    {
      Properties? propertiesCreated,
      Properties? propertiesUpdated
    }
  ) async {
    EmailChangeResponse? emailChangeResponse;
    bool hasMoreChanges = true;
    jmap.State? sinceState = currentState;

    while (hasMoreChanges && sinceState != null) {
      final changesResponse = await _threadDataSource.getChanges(
        accountId,
        sinceState,
        propertiesCreated: propertiesCreated,
        propertiesUpdated: propertiesUpdated
      );

      hasMoreChanges = changesResponse.hasMoreChanges;
      sinceState = changesResponse.newStateChanges;

      if (emailChangeResponse != null) {
        emailChangeResponse.union(changesResponse);
      } else {
        emailChangeResponse = changesResponse;
      }
    }

    if (emailChangeResponse != null) {
      return EmailsResponse(emailList: emailChangeResponse.created ?? []);
    } else {
      return EmailsResponse();
    }
  }

  @override
  Future<bool> storeStateToRefresh(TypeName typeName, jmap.State newState) {
    return _fcmDatasource.storeStateToRefresh(typeName, newState);
  }

  @override
  Future<jmap.State> getStateToRefresh(TypeName typeName) {
    return _fcmDatasource.getStateToRefresh(typeName);
  }

  @override
  Future<bool> deleteStateToRefresh(TypeName typeName) {
    return _fcmDatasource.deleteStateToRefresh(typeName);
  }
}