import 'package:dio/dio.dart';
import 'package:quiz_eng/model/question_model.dart';


abstract class QuestionService {
  Dio dio = Dio();
  late Response response;
  String baseurl = "https://6650d71420f4f4c442764720.mockapi.io/questions";

  Future<bool> createNewQues(QuestionModel quiz);

  Future<List<QuestionModel>> getData();
}

  class QuestionServiceImp extends QuestionService {
  @override
  Future<bool> createNewQues(QuestionModel quiz) async {
    try {
      response = await dio.post(baseurl, data: quiz.toMap());
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print(e.message);
      return false;
    }
  }

  @override
  Future<List<QuestionModel>> getData() async {
     List<QuestionModel> mylist = [];
    try {
      response = await dio.get(baseurl);
      print(response.statusCode);

      List<QuestionModel> mylist = List.generate(response.data.length,
          (index) => QuestionModel.fromMap(response.data[index]));
      print(response.statusCode);

      if (response.statusCode == 200) {
        print("listData");
        return mylist;
      } else {
        print("listDataaa");

        return mylist;
      }
    } on DioException catch (e) {
      print(e.message);
      return mylist;
    }
  }
  }

