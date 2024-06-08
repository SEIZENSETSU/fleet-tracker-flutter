import 'package:flutter/material.dart';

import '../../Controller/bottom_navigation_bar_controller.dart';
import '../../Route/router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 画面遷移のサンプル
            /// 新たにブランチの概念が出てきて細かく挙動が変わっているため、
            /// このサンプルで色々試してみてください

            /// Case1: ブランチを移動する
            /// ブランチの状態は保持されているため、
            /// 【倉庫検索ブランチ】内で最後に居たページへ遷移する。
            /// デフォルトでは「倉庫検索」ページが表示される
            ElevatedButton(
              onPressed: () {
                BottomNavigationBarController().goBranch(1);
              },
              child: const Text('ブランチを変更'),
            ),

            /// Case2: 別ブランチ配下のページへ遷移する
            /// 「倉庫詳細」ページは【倉庫検索ブランチ】内にあるため、
            /// ボトムタブも自動で【倉庫検索ブランチ】に切り替わった上で
            /// 「倉庫詳細」ページへ遷移する
            ElevatedButton(
              onPressed: () {
                const WarehouseDetailRoute().go(context);
              },
              child: const Text('倉庫詳細ページ'),
            ),

            /// Case3: ブランチを移動してからページへ遷移する
            /// 【倉庫検索ブランチ】へ移動した上で「倉庫検索」ページへ遷移する
            ElevatedButton(
              onPressed: () {
                BottomNavigationBarController().goBranch(1);
                const WarehouseSearchTopRoute().go(context);
              },
              child: const Text('ブランチを変更して倉庫検索'),
            ),

            /// 画面遷移自体のメソッドはRouter.go()のほうが勝手が良さそうに見えるけど、
            /// スタック状況などが不透明なので、.push()も合わせてテストが必要そう？
          ],
        ),
      ),
    );
  }
}
