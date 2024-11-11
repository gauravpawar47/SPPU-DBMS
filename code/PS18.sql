To run the provided MongoDB-based Java program in Eclipse, follow these steps:

### Step-by-Step Guide:

#### 1. **Install Prerequisites**:
   - **JDK (Java Development Kit)**: Make sure Java is installed on your system. You can check by running `java -version` in the terminal.
   - **Eclipse IDE**: Download and install Eclipse IDE for Java Developers if it's not already installed.
   - **MongoDB**: Install MongoDB and ensure it’s running locally on the default port `27017`. You can check this by typing `mongo` in the terminal to open the Mongo shell.
   - **MongoDB Java Driver (`mongo-java-driver-2.12.2.jar`)**: Download the MongoDB Java driver from [MongoDB official website](https://mongodb.github.io/mongo-java-driver/) or from Maven repositories.

#### 2. **Create Java Project in Eclipse**:
   1. Open **Eclipse IDE**.
   2. Click on **File** -> **New** -> **Java Project**.
   3. Provide the **Project Name** (e.g., `MongoDBExample`) and click **Finish**.

#### 3. **Create a New Java Class**:
   1. In the **Project Explorer**, right-click on `src` -> **New** -> **Class**.
   2. Provide the **Class Name** (e.g., `B4` or `MDB` as per your code) and check the box for **public static void main(String[] args)**.
   3. Click **Finish**.

#### 4. **Add MongoDB Java Driver (`.jar` file)**:
   1. Right-click on your project in the **Project Explorer** -> **Build Path** -> **Configure Build Path**.
   2. In the **Java Build Path** window, go to the **Libraries** tab.
   3. Click on **Add External JARs...** and select the `mongo-java-driver-2.12.2.jar` file that you downloaded earlier.
   4. Click **Apply and Close**.

#### 5. **Write the Code**:
   Paste your Java code (`B4.java` or `MDB.java`) into the class that you created. Ensure that you import the correct MongoDB libraries:

   ```java
   import com.mongodb.*;
   import java.net.UnknownHostException;
   import java.util.Scanner;
   ```

   **For B4.java** (example):
   ```java
   public class B4 {
       public static void main(String args[]) {
           try {
               MongoClient mongoClient = new MongoClient("localhost", 27017);
               DB db = mongoClient.getDB("ajk");
               System.out.println("Connected to database successfully");

               DBCollection col1 = db.createCollection("st2", new BasicDBObject());
               System.out.println("Collection created");

               BasicDBObject doc1 = new BasicDBObject();
               doc1.put("Rno", "1");
               doc1.put("Name", "AJK");
               doc1.put("Marks", "75");

               BasicDBObject doc2 = new BasicDBObject();
               doc2.put("Rno", "2");
               doc2.put("Name", "QWE");
               doc2.put("Marks", "80");

               col1.insert(new BasicDBObject[] { doc1, doc2 });
           } catch (Exception e) {
               System.err.println(e.getClass().getName() + ": " + e.getMessage());
           }
       }
   }
   ```

   **For MDB.java** (Menu Driven Example):
   ```java
   public class MDB {
       private static void choice_input() {
           System.out.println("\n1.insert \n2.update \n3.delete \n4.show \n5.Exit");
       }

       public static void main(String[] args) {
           String key, value;
           Scanner scanner = new Scanner(System.in);
           int choice;
           try {
               Mongo mongo = new Mongo("localhost", 27017);
               DB db = mongo.getDB("AJK_MDB");
               DBCollection collection = db.getCollection("Student_mdb");

               do {
                   choice_input();
                   System.out.println("Enter your choice: ");
                   choice = scanner.nextInt();

                   switch (choice) {
                       case 1:
                           BasicDBObject document = new BasicDBObject();
                           String ch;
                           do {
                               System.out.println("Enter key: ");
                               key = scanner.next();
                               System.out.println("Enter value: ");
                               value = scanner.next();
                               document.put(key, value);
                               System.out.println("Do you want to enter more (y/n)? ");
                               ch = scanner.next();
                           } while (!ch.equals("n"));
                           collection.insert(document);
                           break;
                       case 2:
                           BasicDBObject searchObj = new BasicDBObject();
                           System.out.println("Enter searched key: ");
                           key = scanner.next();
                           System.out.println("Enter searched value: ");
                           value = scanner.next();
                           searchObj.put(key, value);

                           BasicDBObject newObj = new BasicDBObject();
                           System.out.println("Enter new key: ");
                           key = scanner.next();
                           System.out.println("Enter new value: ");
                           value = scanner.next();
                           newObj.put(key, value);
                           collection.update(searchObj, newObj);
                           break;
                       case 3:
                           System.out.println("Enter removable key: ");
                           key = scanner.next();
                           System.out.println("Enter removable value: ");
                           value = scanner.next();
                           BasicDBObject removableObj = new BasicDBObject();
                           removableObj.put(key, value);
                           collection.remove(removableObj);
                           break;
                       case 4:
                           DBCursor cursorDoc = collection.find();
                           while (cursorDoc.hasNext()) {
                               System.out.println(cursorDoc.next());
                           }
                           break;
                       case 5:
                           System.exit(0);
                           break;
                   }
               } while (choice != 6);
           } catch (UnknownHostException | MongoException e) {
               e.printStackTrace();
           }
       }
   }
   ```

#### 6. **Run the Program**:
   - Right-click on the Java class you want to run (e.g., `B4` or `MDB`) -> **Run As** -> **Java Application**.

#### 7. **Verify in MongoDB**:
   After running the program:
   - Open **MongoDB Shell** (`mongo`) and switch to the database you specified in the program (`ajk` or `AJK_MDB`).
   - Use the `show collections` command to verify that the collections were created.
   - You can use the `db.st2.find().pretty()` command (or any other collection name) to see the inserted documents.

   Example:
   ```bash
   use ajk
   show collections
   db.st2.find().pretty();
   ```

### Notes:
- Ensure MongoDB is running on `localhost:27017` (the default port). You can start MongoDB with the command `mongod` in the terminal.
- Ensure you have the required MongoDB Java driver `.jar` in your build path for connecting to MongoDB from Java.
- The program uses basic CRUD operations (insert, update, delete, find) in MongoDB.

This setup will let you run MongoDB operations from a Java application in Eclipse.