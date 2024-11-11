Download Oracle JDBC Driver:

Go to Oracle’s official website and download the JDBC driver (Oracle JDBC Thin Driver) that corresponds to your Oracle version:
Oracle JDBC Driver Download
Extract the .jar file, typically ojdbc8.jar or ojdbc7.jar.
Set Up JDBC Driver in Eclipse:

Step 1: In Eclipse, create a new Java project or open an existing one.
Step 2: Right-click on the project in the Project Explorer and select Properties.
Step 3: Under Java Build Path, go to the Libraries tab and click Add External JARs.
Step 4: Navigate to where you saved ojdbc8.jar and select it. Click OK.
Configure Oracle Database:

Ensure that you have the Oracle database running on your machine or a remote database with the correct connection details (hostname, port, SID/Service name).
Make sure the Oracle listener is up and running (use tnsping to test the connection).
Update the jdbc:oracle:thin:@127.0.0.1:1521:xe URL if necessary (replace xe with your actual database SID or service name).
Run the Program:

Once everything is set up, click Run in Eclipse. If the connection is successful, your program should execute the SQL commands (like table creation, insertions, updates) on the Oracle database and display results in the console.
Sample Output:
After running the program, you should see something like this in the console:

python
Copy code
Executed successfully
lmn 2 21
abc 3 25
xyz 4 22
def 5 27
This indicates that the records were successfully inserted and selected from the conndemo table. If you then update a record and drop the table, those changes should also be reflected in the database.





code:: 


package session;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Connect {
    public static void main(String[] args) {
        try {
            // Load the Oracle JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Establish the connection to the database
            Connection con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@127.0.0.1:1521:xe",  // JDBC URL (XE is the default DB name)
                    "SYSTEM",                             // Oracle username
                    "SYSTEM123");                         // Oracle password

            // Create a statement object to send SQL queries
            Statement st = con.createStatement();

            // DDL and DML Operations (executing SQL commands)
            // Create table
            st.executeUpdate("CREATE TABLE conndemo(name VARCHAR(25), roll INT, marks INT)");

            // Insert records into the table
            st.executeUpdate("INSERT INTO conndemo VALUES('lmn', 2, 21)");
            st.executeUpdate("INSERT INTO conndemo VALUES('abc', 3, 25)");
            st.executeUpdate("INSERT INTO conndemo VALUES('xyz', 4, 22)");
            st.executeUpdate("INSERT INTO conndemo VALUES('def', 5, 27)");

            // Select records from the table
            ResultSet rs = st.executeQuery("SELECT * FROM conndemo");
            System.out.println("Executed successfully");
            while (rs.next()) {
                System.out.println(rs.getString("name") + " " + rs.getInt("roll") + " " + rs.getInt("marks"));
            }

            // Update operation
            st.executeUpdate("UPDATE conndemo SET name = 'tina' WHERE roll = 3");

            // Drop the table
            st.executeUpdate("DROP TABLE conndemo");

            // Close the statement and connection
            st.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Error: " + ex);
        }
    }
}
----------------------------------------------------------------



CREATE TABLE Employee (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(50),
    emp_salary NUMBER
);
import java.sql.*;
import java.util.Scanner;

public class OracleDBNavigation {

    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe"; // Modify as per your DB
    private static final String USER = "your_username";
    private static final String PASS = "your_password";

    private Connection connection;
    private Scanner scanner;

    public OracleDBNavigation() {
        try {
            // Establish database connection
            connection = DriverManager.getConnection(DB_URL, USER, PASS);
            System.out.println("Connected to Oracle database.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        scanner = new Scanner(System.in);
    }

    // Method to add a new employee
    public void addEmployee() {
        try {
            System.out.print("Enter Employee ID: ");
            int empId = scanner.nextInt();
            scanner.nextLine(); // Consume newline
            System.out.print("Enter Employee Name: ");
            String empName = scanner.nextLine();
            System.out.print("Enter Employee Salary: ");
            double empSalary = scanner.nextDouble();

            String sql = "INSERT INTO Employee (emp_id, emp_name, emp_salary) VALUES (?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, empId);
            preparedStatement.setString(2, empName);
            preparedStatement.setDouble(3, empSalary);

            int rows = preparedStatement.executeUpdate();
            if (rows > 0) {
                System.out.println("Employee added successfully.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to update employee details
    public void updateEmployee() {
        try {
            System.out.print("Enter Employee ID to update: ");
            int empId = scanner.nextInt();
            scanner.nextLine(); // Consume newline
            System.out.print("Enter New Employee Name: ");
            String empName = scanner.nextLine();
            System.out.print("Enter New Employee Salary: ");
            double empSalary = scanner.nextDouble();

            String sql = "UPDATE Employee SET emp_name = ?, emp_salary = ? WHERE emp_id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, empName);
            preparedStatement.setDouble(2, empSalary);
            preparedStatement.setInt(3, empId);

            int rows = preparedStatement.executeUpdate();
            if (rows > 0) {
                System.out.println("Employee updated successfully.");
            } else {
                System.out.println("Employee not found.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to delete an employee
    public void deleteEmployee() {
        try {
            System.out.print("Enter Employee ID to delete: ");
            int empId = scanner.nextInt();

            String sql = "DELETE FROM Employee WHERE emp_id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, empId);

            int rows = preparedStatement.executeUpdate();
            if (rows > 0) {
                System.out.println("Employee deleted successfully.");
            } else {
                System.out.println("Employee not found.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to list all employees
    public void listEmployees() {
        try {
            String sql = "SELECT * FROM Employee";
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);

            System.out.println("Employee List:");
            while (resultSet.next()) {
                System.out.println("ID: " + resultSet.getInt("emp_id") +
                                   ", Name: " + resultSet.getString("emp_name") +
                                   ", Salary: " + resultSet.getDouble("emp_salary"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Main method to run the program
    public static void main(String[] args) {
        OracleDBNavigation dbNav = new OracleDBNavigation();
        Scanner scanner = new Scanner(System.in);

        while (true) {
            System.out.println("\nChoose an operation:");
            System.out.println("1. Add Employee");
            System.out.println("2. Update Employee");
            System.out.println("3. Delete Employee");
            System.out.println("4. List Employees");
            System.out.println("5. Exit");
            System.out.print("Enter choice: ");
            int choice = scanner.nextInt();

            switch (choice) {
                case 1:
                    dbNav.addEmployee();
                    break;
                case 2:
                    dbNav.updateEmployee();
                    break;
                case 3:
                    dbNav.deleteEmployee();
                    break;
                case 4:
                    dbNav.listEmployees();
                    break;
                case 5:
                    System.out.println("Exiting...");
                    System.exit(0);
                    break;
                default:
                    System.out.println("Invalid choice. Try again.");
            }
        }
    }
}