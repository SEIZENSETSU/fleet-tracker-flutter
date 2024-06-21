class DelayTimeDetail {
  final String delayState;
  final int answerCount;

  DelayTimeDetail({
    required this.delayState,
    required this.answerCount,
  });

  factory DelayTimeDetail.fromJson(Map<String, dynamic> json) {
    return DelayTimeDetail(
      delayState: json['delay_state'],
      answerCount: json['answer_count'],
    );
  }
}
