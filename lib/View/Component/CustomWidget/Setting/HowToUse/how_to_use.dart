import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:flutter/material.dart';

class HowToUseView extends StatefulWidget {
  const HowToUseView({super.key});

  @override
  _HowToUseViewState createState() => _HowToUseViewState();
}

class _HowToUseViewState extends State<HowToUseView> {
  final List<Map<String, dynamic>> sections = [
    {
      'title': '1. ホーム',
      'items': [
        '工場ごとの混雑状況を表示しています',
        'それぞれの工場の詳細として工場の位置やつぶやきを見ることができます。',
        '工場ごとの混雑状況を集計しています',
      ],
    },
    {
      'title': '2. 倉庫検索',
      'items': [
        'キーワードから倉庫を検索できます。',
        '地方ごとの倉庫を検索できます。',
        '地方のエリアごとに工場を検索できます。'
            'お気に入りから検索できます。',
      ],
    },
    {
      'title': '3. 交通状況',
      'items': [
        '各地方ごとの高速道路が検索できます。',
        '高速道路から道路の渋滞情報とSAPA情報が検索できます。',
        '渋滞情報として状態範囲と距離を表示しています。',
        'SAPA情報として混雑状況、乗用車の駐車状況、トラックの駐車状況を表示しています。'
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '使い方',
        isBackButton: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              _buildSection(sections[index]['title'], sections[index]['items']),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(String title, List<dynamic> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...items.map((item) {
          if (item is String) {
            return _buildItem(item, 16, '•');
          } else if (item is List<String>) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  item.map((subItem) => _buildItem(subItem, 32, '-')).toList(),
            );
          }
          return const SizedBox.shrink();
        }).toList(),
      ],
    );
  }

  Widget _buildItem(String text, double leftPadding, String bullet) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding, top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$bullet ',
              style: TextStyle(fontSize: leftPadding == 16 ? 16 : 14)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: leftPadding == 16 ? 16 : 14),
            ),
          ),
        ],
      ),
    );
  }
}
