class Strings {
  /// ダイアログ関連
  //  通信エラー時
  static const String CONNECT_ERROR_DIALOG_TITLE = '通信エラー';
  static const String CONNECT_ERROR_DIALOG_DETAIL =
      '通信エラーです。\n通信環境のいい場所で再度お試しください。';

  /// 工場遅延状況セル関連
  //  ボタン
  static const String STATE_NORMAL = '平常';
  static const String STATE_PAUSE = '一時停止\n 〜10分';
  static const String STATE_HALF_AN_HOUR = '〜30分';
  static const String STATE_AN_HOUR = '〜1時間';
  static const String STATE_IMPOSSIBLE = '入庫不可';
  //  セル
  static const String GO_WAREHOUSE_PAGE = '工場詳細ページへ→';
}
