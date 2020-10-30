class UserModel {
  String studId;
  String status;
  String studFio;
  String groupID;
  String groupNum;
  String profileId;
  String profileName;
  String specId;
  String specCode;
  String specName;
  String eduQualif;
  String eduCycle;
  String programForm;
  String competitionType;
  String eduLevel;
  String instId;
  String kafId;
  String instName;
  String kafName;
  String zach;
  String predpr;
  String rukFio;
  String rabTheme;
  String rabProfile;


  UserModel();
  UserModel.fromJson(dynamic data){
    this.studId = data["StudId"];
    this.status = data["Status"];
    this.studFio = data["StudFio"];
    this.groupID = data["GroupID"];
    this.groupNum = data["GroupNum"];
    this.profileId = data["ProfileId"];
    this.profileName = data["ProfileName"];
    this.specId = data["SpecId"];
    this.specCode = data["SpecCode"];
    this.specName = data["SpecName"];
    this.eduQualif = data["EduQualif"];
    this.eduCycle = data["EduCycle"];
    this.programForm = data["ProgramForm"];
    this.competitionType = data["CompetitionType"];
    this.eduLevel = data["EduLevel"];
    this.instId = data["InstId"];
    this.kafId = data["KafId"];
    this.instName = data["InstName"];
    this.kafName = data["KafName"];
    this.zach = data["Zach"];
    this.predpr = data["Predpr"];
    this.rukFio = data["RukFio"];
    this.rabTheme = data["RabTheme"];
    this.rabProfile = data["RabProfile"];
  }

}