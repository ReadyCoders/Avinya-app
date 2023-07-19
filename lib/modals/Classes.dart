class News{
  News({required this.title, required this.desc, required this.isImportant,required this.id,required this.dateposted});
  final String title;
  final String desc;
  final bool isImportant;
  final String id;
  final String dateposted;
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
class Profile{
  final String Username;
  final String desc;
  final int courses;
  final int books;
  final int projects;
  final String Dob;
  final String emailid;
  Profile(
  {required this.Username,required this.desc,required this.courses, required this.books, required this.projects, required this.Dob, required this.emailid,}
      );
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