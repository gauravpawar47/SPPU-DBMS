db.createCollection('Student');
db.Student.insertMany([
  {'Rno': 1, 'Name': 'Piyush', 'Dept': 'COMP', 'marks': 60},
  {'Rno': 2, 'Name': 'Pradeep', 'Dept': 'CIVIL', 'marks': 45},
  {'Rno': 3, 'Name': 'Abhi', 'Dept': 'AIDS', 'marks': 80},
  {'Rno': 4, 'Name': 'Ashley', 'Dept': 'COMP', 'marks': 40},
  {'Rno': 5, 'Name': 'Vipul', 'Dept': 'Chem', 'marks': 25},
  {'Rno': 6, 'Name': 'Pooja', 'Dept': 'COMP', 'marks': 95},
  {'Rno': 7, 'Name': 'Pawan', 'Dept': 'CIVIL', 'marks': 65},
  {'Rno': 8, 'Name': 'Jitu', 'Dept': 'Chem', 'marks': 85}
]);

db.Student.find({"marks": { $gt: 50 }}).pretty();
db.Student.find({"marks": { $gt: 50, $lt: 80 }}).pretty();
db.Student.find({$and: [{"marks": { $gt: 60 }}, {"Dept": "COMP"}]}).pretty();
db.Student.updateMany({'Dept': 'CIVIL'}, {$set: {'marks': 30}});
db.Student.deleteOne({$and: [{"marks": { $lt: 30 }}, {"Dept": "Chem"}]});