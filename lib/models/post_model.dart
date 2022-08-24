class PostModel
{
  String? name;
  String? uid;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;

  PostModel({
    this.name,this.uid,this.text,this.dateTime,
    this.image,this.postImage,
  });

  PostModel.fromJson(Map<String,dynamic>json)
  {
    name = json['name'];
    uid = json['uid'];
    image = json['image'];
    postImage = json['postImage'];
    text = json['text'];
    dateTime = json['dateTime'];

  }

  Map<String,dynamic> toMap()
  {
    return{
      'name' : name,
      'uid' : uid,
      'image' : image,
      'postImage' : postImage,
      'text' : text,
      'dateTime' : dateTime,
    };
  }
}