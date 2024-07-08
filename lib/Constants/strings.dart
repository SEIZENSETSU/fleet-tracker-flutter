class Strings {
  /// ダイアログ関連
  //  シンプルな二つボタンダイアログ
  static const String BACK_BUTTON_TEXT = '戻る';
  static const String SUBMIT_BUTTON_TEXT = '決定';

  //  通信エラー時ダイアログ
  static const String CONNECT_ERROR_DIALOG_TITLE = '通信エラー';
  static const String CONNECT_ERROR_DIALOG_DETAIL =
      '通信エラーです。\n通信環境のいい場所で再度お試しください。';

  /// 工場遅延状況セル関連
  //  ボタン
  static const String STATE_NORMAL_TITLE = '平常';
  static const String STATE_NORMAL_DETAIL = '現在、遅延に関する情報はありません。';
  static const String STATE_PAUSE_TITLE = '一時停止\n 〜10分';
  static const String STATE_PAUSE_DETAIL = '一時停止などの情報が出ております。';
  static const String STATE_HALF_HOUR_TITLE = '〜30分';
  static const String STATE_HALF_HOUR_DETAIL = '最大30分ほどの遅延情報が出ております。';
  static const String STATE_AN_HOUR_TITLE = '〜1時間';
  static const String STATE_AN_HOUR_DETAIL = '最大1時間ほどの遅延情報が出ております。';
  static const String STATE_IMPOSSIBLE_TITLE = '入庫不可';
  static const String STATE_IMPOSSIBLE_DETAIL = '現在、入庫不可の情報が出ております。';

  //  セル
  static const String GO_WAREHOUSE_PAGE = '工場詳細ページへ→';

  // ホーム
  static const String CURRENT_LOCATION_AND_TIME = '現在地・現在時刻';
  static const String NEAR_BY_AREAS = '現在地から一番近くのエリア';
  static const String WEATHER_OF_AREAS = 'エリアの天気';
  static const String APP_FUNCTION = '機能';

  // 倉庫検索
  static const String SEARCH_WITH_KEYWORD = 'キーワードから探す';
  static const String SEARCH_WITH_REGION = '地方から探す';
  static const String SEARCH_WITH_FAVORITE = 'お気に入りから探す';
  static const String WAREHOUSE_LIST = '倉庫一覧';

  // 遅延状況登録
  static const String DELAY_STATUS = '遅延状況';
  static const String OPERATION_ACTIONS = '操作';
  static const String TWEET_ABOUT_FACTORY = 'この工場に関するつぶやき';

  // 交通情報

  // 設定
  static const String SETTING_ACOUNT_INFO = 'アカウント設定';
  static const String SETTING_NOTIFICATION = '通知・位置情報設定';
  static const String SETTING_OTHER = 'その他';

  // Androidへの通知
  static const String ANDROID_NOTIFICATION_TITLE = 'バックグラウンド処理';
  static const String ANDROID_NOTIFICATION_MESSAGE = 'バックグラウンド処理を実行中';
}
