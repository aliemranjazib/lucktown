///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class SelectCountryModelMultidimensional {
/*
{
  "name": "y"
} 
*/

  String? name;

  SelectCountryModelMultidimensional({
    this.name,
  });
  SelectCountryModelMultidimensional.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class SelectCountryModelAnObjList {
/*
{
  "name": "y"
} 
*/

  String? name;

  SelectCountryModelAnObjList({
    this.name,
  });
  SelectCountryModelAnObjList.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class SelectCountryModelAnObj {
/*
{
  "name": "x",
  "age": 18.1
} 
*/

  String? name;
  double? age;

  SelectCountryModelAnObj({
    this.name,
    this.age,
  });
  SelectCountryModelAnObj.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    age = json['age']?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['age'] = age;
    return data;
  }
}

class SelectCountryModel {
/*
{
  "some_snake_case_prop": "",
  "anInt": 1,
  "aDouble": 2.3,
  "aString": "hello",
  "aBool": false,
  "anObj": {
    "name": "x",
    "age": 18.1
  },
  "anObjList": [
    {
      "name": "y"
    }
  ],
  "aStrList": [
    "something"
  ],
  "multidimensional": [
    [
      [
        {
          "name": "y"
        }
      ]
    ]
  ]
} 
*/

  String? someSnakeCaseProp;
  int? anInt;
  double? aDouble;
  String? aString;
  bool? aBool;
  SelectCountryModelAnObj? anObj;
  List<SelectCountryModelAnObjList?>? anObjList;
  List<String?>? aStrList;
  List<List<List<SelectCountryModelMultidimensional?>?>?>? multidimensional;

  SelectCountryModel({
    this.someSnakeCaseProp,
    this.anInt,
    this.aDouble,
    this.aString,
    this.aBool,
    this.anObj,
    this.anObjList,
    this.aStrList,
    this.multidimensional,
  });
  SelectCountryModel.fromJson(Map<String, dynamic> json) {
    someSnakeCaseProp = json['some_snake_case_prop']?.toString();
    anInt = json['anInt']?.toInt();
    aDouble = json['aDouble']?.toDouble();
    aString = json['aString']?.toString();
    aBool = json['aBool'];
    anObj = (json['anObj'] != null)
        ? SelectCountryModelAnObj.fromJson(json['anObj'])
        : null;
    if (json['anObjList'] != null) {
      final v = json['anObjList'];
      final arr0 = <SelectCountryModelAnObjList>[];
      v.forEach((v) {
        arr0.add(SelectCountryModelAnObjList.fromJson(v));
      });
      anObjList = arr0;
    }
    if (json['aStrList'] != null) {
      final v = json['aStrList'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      aStrList = arr0;
    }
    if (json['multidimensional'] != null) {
      final v = json['multidimensional'];
      final arr0 = <List<List<SelectCountryModelMultidimensional>>>[];
      v.forEach((v) {
        final arr1 = <List<SelectCountryModelMultidimensional>>[];
        v.forEach((v) {
          final arr2 = <SelectCountryModelMultidimensional>[];
          v.forEach((v) {
            arr2.add(SelectCountryModelMultidimensional.fromJson(v));
          });
          arr1.add(arr2);
        });
        arr0.add(arr1);
      });
      multidimensional = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['some_snake_case_prop'] = someSnakeCaseProp;
    data['anInt'] = anInt;
    data['aDouble'] = aDouble;
    data['aString'] = aString;
    data['aBool'] = aBool;
    if (anObj != null) {
      data['anObj'] = anObj!.toJson();
    }
    if (anObjList != null) {
      final v = anObjList;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['anObjList'] = arr0;
    }
    if (aStrList != null) {
      final v = aStrList;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['aStrList'] = arr0;
    }
    if (multidimensional != null) {
      final v = multidimensional;
      final arr0 = [];
      v!.forEach((v) {
        final arr1 = [];
        v!.forEach((v) {
          final arr2 = [];
          v!.forEach((v) {
            arr2.add(v!.toJson());
          });
          arr1.add(arr2);
        });
        arr0.add(arr1);
      });
      data['multidimensional'] = arr0;
    }
    return data;
  }
}
