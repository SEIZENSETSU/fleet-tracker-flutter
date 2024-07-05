enum RemoteConfigKeys {
  release,
  enableTrafficInformation,
  debugNotification,
  debugDurationInterval
}

/**
 * release: bool -> falseのときは起動を拒否
 * enableTrafficInformation: bool -> falseのときは交通情報タブ遷移後にエラー表示
 * debugNotification: bool -> trueのときはデバッグ通知を表示
 * debugDurationInterval: bool -> デバッグ通知の表示間隔15秒か？
 */