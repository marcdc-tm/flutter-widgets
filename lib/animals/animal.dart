class Animal {
  String name;
  String scienceName;
  String type;
  String image;
  String info;
  String habitat;

  Animal(List items, String imageMap) {
    items.forEach((item) {
      if (item[0]=="name") name = item[1];
      if (item[0]=="sciencename") scienceName = item[1];
      if (item[0]=="type") type = item[1];
      if (item[0]=="image") image = imageMap + "/" + item[1];
      if (item[0]=="info") info = item[1];
      if (item[0]=="habitat") habitat = item[1];
    });
  }
}