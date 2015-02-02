package vanier.assignment;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

public class DBManager {

    private static final String DB_DRIVER = "oracle.jdbc.driver.OracleDriver";
    private static final String DB_CONNECTION = "jdbc:oracle:thin:@localhost:1521:XE";

    private static final String DB_USER = "scott";
    private static final String DB_PASSWORD = "tiger";

    private Connection dbConnection;

    public DBManager() {

        dbConnection = null;

        try {

            Class.forName(DB_DRIVER);

        } catch (ClassNotFoundException e) {

            System.out.println(e.getMessage());

        }

        try {

            dbConnection = DriverManager.getConnection(
                    DB_CONNECTION, DB_USER, DB_PASSWORD);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public boolean isValidAdminLogin(UserBean user) throws SQLException {
        boolean more = false;
        ResultSet rs;
        Statement stmt = null;

        String searchQuery = "select * from A2_USER where username='"
                + user.getUsername()
                + "' AND password='"
                + user.getPassword()
                + "' AND admin=1";
        try { //connect to DB 
            stmt = dbConnection.createStatement();
            rs = stmt.executeQuery(searchQuery);
            more = rs.next();

        } catch (SQLException e) {

            System.out.println(e.getMessage());

        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }

        }
        return more;
    }

    public boolean isValidUserLogin(UserBean user) throws SQLException {
        boolean more = false;
        ResultSet rs;
        Statement stmt = null;

        String searchQuery = "select * from A2_USER where username='"
                + user.getUsername()
                + "' AND password='"
                + user.getPassword()
                + "' AND admin is null";
        try { //connect to DB 
            stmt = dbConnection.createStatement();
            rs = stmt.executeQuery(searchQuery);
            more = rs.next();

        } catch (SQLException e) {

            System.out.println(e.getMessage());

        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }

        }
        return more;
    }

    public ArrayList<String> getProduct(int id) throws SQLException {
        ResultSet rs = null;
        Statement stmt;
        ArrayList<String> row = null;

        String query = "select PRODUCT_ID, DESCRIPTION, PRICE, QUANTITY from A2_PRODUCT "
                + "WHERE PRODUCT_ID = " + id;

        try {
            stmt = dbConnection.createStatement();
            rs = stmt.executeQuery(query);
            int numcols = rs.getMetaData().getColumnCount();

            while (rs.next()) {
                row = new ArrayList<>(numcols); // new list per row
                int i = 1;
                while (i <= numcols) {
                    row.add(rs.getString(i++));
                }
            }

        } catch (SQLException e) {

            System.out.println(e.getMessage());

        }

        return row;
    }

    public void updateProduct(int id, String description, double price, int quantity) throws SQLException {
        String query = "UPDATE A2_PRODUCT P "
                + "SET P.DESCRIPTION = '" + description + "',"
                + "P.PRICE = " + price + ","
                + "P.QUANTITY = " + quantity + " "
                + "WHERE P.PRODUCT_ID = " + id;

        Statement stmt;

        try {
            stmt = dbConnection.createStatement();
            stmt.executeQuery(query);
        } catch (SQLException e) {

        }
    }

    public void deleteProduct(int id) {
        String query = "DELETE FROM A2_PRODUCT WHERE PRODUCT_ID = " + id;

        Statement stmt;

        try {
            stmt = dbConnection.createStatement();
            stmt.executeQuery(query);
        } catch (SQLException e) {

        }
    }

    public void addProduct(String description, double price, int quantity) throws SQLException {
        String query = "INSERT INTO A2_PRODUCT (DESCRIPTION, PRICE, QUANTITY) "
                + "VALUES ('" + description + "', " + price + ", " + quantity + ")";

        Statement stmt;

        try {
            stmt = dbConnection.createStatement();
            stmt.executeQuery(query);
        } catch (SQLException e) {

        }
    }

    public void createUser(String username, String password, String fullname) {
        String query2 = "INSERT INTO A2_USER (USERNAME, PASSWORD, FULLNAME) "
                + "VALUES ('" + username + "', '" + password + "', '" + fullname + "')";

        Statement stmt;
        ResultSet rs;

        try {
            stmt = dbConnection.createStatement();
            rs = stmt.executeQuery(query2);
        } catch (SQLException e) {

        }
    }

    public void createOrder(UserBean userBean, HashMap<Integer, Integer> cart) {
        for (int id : cart.keySet()) {
            String username = userBean.getUsername();
            String query = "SELECT * FROM A2_USER WHERE USERNAME = '" + username + "'";
            int userid = 0;

            Statement stmt;
            ResultSet rs;

            try {
                Random rand = new Random();

                stmt = dbConnection.createStatement();
                rs = stmt.executeQuery(query);
                int numcols = rs.getMetaData().getColumnCount();

                ArrayList<String> row = new ArrayList<>(numcols);
                rs.next();
                userid = Integer.parseInt(rs.getString("USER_ID"));

                String query2 = "INSERT INTO A2_ORDER_PRODUCT (ORDER_PRODUCT_ID, USER_ID, PRODUCT_ID, ORDERED_QUANTITY) "
                        + "VALUES (" + rand.nextInt(999999999) + ", " + userid + ", " + id + ", " + cart.get(id) + ")";

                try {
                    stmt = dbConnection.createStatement();
                    rs = stmt.executeQuery(query2);

                    String query3 = "UPDATE A2_PRODUCT SET QUANTITY = QUANTITY - " + cart.get(id) + " "
                            + "WHERE PRODUCT_ID = " + id;

                    try {
                        stmt = dbConnection.createStatement();
                        rs = stmt.executeQuery(query3);
                    } catch (SQLException e) {

                    }
                } catch (SQLException e) {

                }
            } catch (SQLException e) {

            }
        }
    }

    public ArrayList<ArrayList<String>> getAllProducts() throws SQLException {
        ArrayList<ArrayList<String>> myArray = new ArrayList<>();
        ResultSet rs = null;
        Statement stmt;

        String searchQuery = "select PRODUCT_ID, DESCRIPTION, PRICE, QUANTITY from A2_PRODUCT";

        try {
            stmt = dbConnection.createStatement();
            rs = stmt.executeQuery(searchQuery);
            int numcols = rs.getMetaData().getColumnCount();

            while (rs.next()) {
                ArrayList<String> row = new ArrayList<>(numcols); // new list per row
                int i = 1;
                while (i <= numcols) {
                    row.add(rs.getString(i++));
                }
                myArray.add(row);
            }

        } catch (SQLException e) {

            System.out.println(e.getMessage());

        }
        return myArray;

    }

    public ArrayList<ArrayList<String>> getAllUsers() throws SQLException {
        ArrayList<ArrayList<String>> myArray = new ArrayList<>();
        ResultSet rs = null;
        Statement stmt;

        String searchQuery = "select USERNAME, FULLNAME, ADDRESS, ADMIN from A2_USER";

        try {
            stmt = dbConnection.createStatement();
            rs = stmt.executeQuery(searchQuery);
            int numcols = rs.getMetaData().getColumnCount();

            while (rs.next()) {
                ArrayList<String> row = new ArrayList<>(numcols); // new list per row
                int i = 1;
                while (i <= numcols) {
                    row.add(rs.getString(i++));
                }
                myArray.add(row);
            }

        } catch (SQLException e) {

            System.out.println(e.getMessage());

        }
        return myArray;

    }

    public ArrayList<ArrayList<String>> getAllOrders() throws SQLException {
        ArrayList<ArrayList<String>> myArray = new ArrayList<>();
        ResultSet rs = null;
        Statement stmt;

        String searchQuery = "select "
                + "(select FULLNAME from A2_USER U where U.USER_ID = O.USER_ID) BUYER,"
                + "(select DESCRIPTION from A2_PRODUCT P where P.PRODUCT_ID = O.PRODUCT_ID) PRODUCT, "
                + "ORDERED_QUANTITY from A2_ORDER_PRODUCT O";

        try {
            stmt = dbConnection.createStatement();
            rs = stmt.executeQuery(searchQuery);
            int numcols = rs.getMetaData().getColumnCount();

            while (rs.next()) {
                ArrayList<String> row = new ArrayList<>(numcols); // new list per row
                int i = 1;
                while (i <= numcols) {
                    row.add(rs.getString(i++));
                }
                myArray.add(row);
            }

        } catch (SQLException e) {

            System.out.println(e.getMessage());
        }
        return myArray;

    }
}
