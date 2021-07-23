package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtility
{
  public DBUtility() {}

  private static Connection connection = null;

  public static Connection getConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                return connection;
            }
            String serverName = "172.16.7.156";
            String portNumber = "1521";
            String sid = "cmp11";
            String dbUrl = "jdbc:oracle:thin:@" + serverName + ":" + portNumber + ":" + sid;
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                connection = DriverManager.getConnection(dbUrl, "JIIT16072020", "JIIT16072020");
            } catch (Exception e) {
                e.printStackTrace();
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
          return connection;
  }

  //---------------------------New Method ----------------------------------------
  public static Connection getConnection(Connection con) {

            try {
                if (connection != null && !connection.isClosed()) {
                    return connection;
                } else {
                    String serverName = "172.16.7.156";
                    String portNumber = "1521";
                    String sid = "cmp11";
                    String dbUrl = "jdbc:oracle:thin:@" + serverName + ":" + portNumber + ":" + sid;
                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        connection = DriverManager.getConnection(dbUrl, "JIIT16072020", "JIIT16072020");

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            } catch (SQLException ex) {

            }
    return connection;
  }

  public static void closeConnection(Connection connection)
  {
    try {
      if (getConnection() != null) {
        getConnection().close();
        connection = null;
      }
      if (connection != null) {
        connection.close();
        connection = null;
      }
    }
    catch (Exception e)
    {
      e.getMessage();
    }
  }
}
