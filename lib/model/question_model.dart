import 'dart:convert';

import 'package:flutter/foundation.dart';

class QuestionModel {
  String question;
  List<String> answers;
  num indexOfCorrect;
  QuestionModel({
    required this.question,
    required this.answers,
    required this.indexOfCorrect,
  });

  QuestionModel copyWith({
    String? question,
    List<String>? answers,
    num? indexOfCorrect,
  }) {
    return QuestionModel(
      question: question ?? this.question,
      answers: answers ?? this.answers,
      indexOfCorrect: indexOfCorrect ?? this.indexOfCorrect,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'answers': answers,
      'indexOfCorrect': indexOfCorrect,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      question: map['question'] as String,
      answers: List<String>.from((map['answers'] as List<dynamic>),),
      indexOfCorrect: map['indexOfCorrect'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) => QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'QuestionModel(question: $question, answers: $answers, indexOfCorrect: $indexOfCorrect)';

  @override
  bool operator ==(covariant QuestionModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.question == question &&
      listEquals(other.answers, answers) &&
      other.indexOfCorrect == indexOfCorrect;
  }

  @override
  int get hashCode => question.hashCode ^ answers.hashCode ^ indexOfCorrect.hashCode;
}
