class News{
  News({required this.title, required this.desc, required this.isImportant,required this.id});
  final String title;
  final String desc;
  final bool isImportant;
  final String id;
}
class Events{
  final String EventName;
  final String Details;
  final bool isonline;
  final String lastdate;
  final String registereddate;
  final bool registered;
  final String id;

  Events({required this.EventName, required this.Details, required this.isonline, required this.lastdate, required this.registereddate, required this.registered, required this.id});

}

class Projects{
  final String ProjectName;
  final String Details;
  final String Description;
  final String ImageUrl;
  final String Websiteurl;
  final String id;
  Projects({required this.ProjectName, required this.Details, required this.Description, required this.ImageUrl, required this.Websiteurl,required this.id});
}
class Users{
  final String Username;
  final String emailid;
  final String Dob;
  final String role;
  final String id;

  Users({required this.Username, required this.emailid, required this.Dob, required this.role,required this.id});

}