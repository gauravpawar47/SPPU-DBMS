db.createCollection('Bank');
db.Bank.insertMany([
   { cust_id: 1, cust_name: "John Doe", branch: "Pune", balance: 5000 },
   { cust_id: 2, cust_name: "Jane Smith", branch: "Pune", balance: 7000 },
   { cust_id: 3, cust_name: "Michael Johnson", branch: "Mumbai", balance: 3000 },
   { cust_id: 4, cust_name: "Emily Davis", branch: "Mumbai", balance: 2500 },
   { cust_id: 5, cust_name: "David Brown", branch: "Surat", balance: 10000 }
]);

// Map function to emit branch and balance
var mapFunction = function() {
    emit(this.branch, this.balance);
};

// Reduce function to sum balances for each branch
var reduceFunction = function(key, values) {
    return Array.sum(values);
};

// // Execute the MapReduce function
// db.Bank.mapReduce(mapFunction, reduceFunction, { out: "branch_balances" });
// db.branch_balances.find().pretty();  

// Use aggregation to sum the balances by branch (alt for MapReduce)
db.Bank.aggregate([
    { $group: { _id: "$branch", total_balance: { $sum: "$balance" } } }
]).pretty();