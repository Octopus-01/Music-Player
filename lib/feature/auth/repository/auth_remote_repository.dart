import 'dart:convert';

import 'package:client/core/failure/app_failure.dart';
import 'package:client/feature/auth/model/user/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepository{
  Future<Either<AppFailure,UserModel>> signup({
    required String name,
    required String email,
    required String password,
}) async{
   try{
     final response = await http.post(Uri.parse('http://192.168.247.121:8000/auth/signup'),
       headers:{
         'Content-Type': 'application/json; charset=UTF-8',
       },
       body: jsonEncode({
         'name': name,
         'email': email,
         'password': password
       }
       ),
     );
     final resBodyMap = jsonDecode(response.body) as Map<String,dynamic>;
     if(response.statusCode != 201){
      return Left(AppFailure(resBodyMap['detail']));
     }

     return Right(UserModel.fromJson(resBodyMap));
   }catch(e){
     return Left(AppFailure(e.toString()));
   }
  }
  Future<Either<AppFailure,UserModel>> login({
    required String email,
    required String password,
})async{
    try{
      final response = await http.post(Uri.parse('http://192.168.247.121:8000/auth/login'),
        headers:{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': email,
          'password': password
        }
        ),
      );
      final resBodyMap = jsonDecode(response.body) as Map<String,dynamic>;
      if(response.statusCode != 200){
        return Left(AppFailure(resBodyMap['detail']));
      }

      return Right(UserModel.fromJson(resBodyMap));
    }
    catch(e){
      return Left(AppFailure(e.toString()));
    }
  }
}