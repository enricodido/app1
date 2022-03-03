import 'dart:convert';

import 'package:agros_app/model/boxes_type.dart';
import 'package:agros_app/model/team.dart';
import 'package:agros_app/repositories/repository.dart';

import '../model/label.dart';


class TeamRepository {
  late Repository repository;
  TeamRepository(this.repository);

  Future<List<TeamModel>> get() async {
    final response = await repository.http!.get(
      url: 'get/teams', );
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<TeamModel> teams = [];
      data['teams'].forEach((team) {
        teams.add(TeamModel.fromData(team));
      });
      return teams;
    }

    throw RequestError(data);
  }
}