/*
STEP 1 : Downlod the Jar Far from Below Link
https://dev.mysql.com/downloads/connector/j/

STEP 2 : Extract The Zip File

STEP 3 : In IntelliJ, Locate the Jar FIle
Go to File -> Project Structure -> Dependencies ->  Click on + icon -> Navigate to Jar file Directory

STEP 4 : In MY SQL, Copy Paste the Following Code

CREATE DATABASE StudentDB;

USE StudentDB;

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    major VARCHAR(50)
);

SELECT *FROM students;

STEP 5 : In IntelliJ, Create Class 'StudentDatabaseApp' and Run the File along with Code
 */

import java.sql.*;
import java.util.Scanner;

public class StudentDatabaseApp {

    // JDBC URL, username, and password of MySQL server
    static final String DB_URL = "jdbc:mysql://localhost:3306/StudentDB";
    static final String USER = "root";
    static final String PASS = "Feeld@nce143";

    // JDBC variables for opening and managing connections
    private Connection conn;

    public StudentDatabaseApp() {
        try {
            // Open a connection
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            System.out.println("Connected to the database.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to add a new student
    public void addStudent(String name, int age, String major) {
        String query = "INSERT INTO students (name, age, major) VALUES (?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, name);
            pstmt.setInt(2, age);
            pstmt.setString(3, major);
            pstmt.executeUpdate();
            System.out.println("Student added successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to view all students
    public void viewStudents() {
        String query = "SELECT * FROM students";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                System.out.println("ID: " + rs.getInt("id"));
                System.out.println("Name: " + rs.getString("name"));
                System.out.println("Age: " + rs.getInt("age"));
                System.out.println("Major: " + rs.getString("major"));
                System.out.println("-------------------");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to update a student's information
    public void updateStudent(int id, String name, int age, String major) {
        String query = "UPDATE students SET name = ?, age = ?, major = ? WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, name);
            pstmt.setInt(2, age);
            pstmt.setString(3, major);
            pstmt.setInt(4, id);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Student updated successfully.");
            } else {
                System.out.println("Student not found.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to delete a student
    public void deleteStudent(int id) {
        String query = "DELETE FROM students WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Student deleted successfully.");
            } else {
                System.out.println("Student not found.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Main method with user navigation
    public static void main(String[] args) {
        StudentDatabaseApp app = new StudentDatabaseApp();
        Scanner scanner = new Scanner(System.in);

        while (true) {
            System.out.println("Select an operation:");
            System.out.println("1. Add Student");
            System.out.println("2. View Students");
            System.out.println("3. Update Student");
            System.out.println("4. Delete Student");
            System.out.println("5. Exit");
            int choice = scanner.nextInt();
            scanner.nextLine(); // Consume newline

            switch (choice) {
                case 1:
                    System.out.print("Enter name: ");
                    String name = scanner.nextLine();
                    System.out.print("Enter age: ");
                    int age = scanner.nextInt();
                    scanner.nextLine(); // Consume newline
                    System.out.print("Enter major: ");
                    String major = scanner.nextLine();
                    app.addStudent(name, age, major);
                    break;

                case 2:
                    app.viewStudents();
                    break;

                case 3:
                    System.out.print("Enter student ID to update: ");
                    int id = scanner.nextInt();
                    scanner.nextLine(); // Consume newline
                    System.out.print("Enter new name: ");
                    name = scanner.nextLine();
                    System.out.print("Enter new age: ");
                    age = scanner.nextInt();
                    scanner.nextLine(); // Consume newline
                    System.out.print("Enter new major: ");
                    major = scanner.nextLine();
                    app.updateStudent(id, name, age, major);
                    break;

                case 4:
                    System.out.print("Enter student ID to delete: ");
                    id = scanner.nextInt();
                    app.deleteStudent(id);
                    break;

                case 5:
                    System.out.println("Exiting program.");
                    scanner.close();
                    return;

                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }
}
