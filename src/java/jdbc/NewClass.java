/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package jdbc;
/*
Public class DBUtility
{
  public DBUtility() {}

  private static Connection connection = null;

  public static Connection getConnection() {
    if (connection != null) {
      return connection;
    }

    String serverName = "172.16.68.45";
    String portNumber = "1521";
    String sid = "campus";
    String dbUrl = "jdbc:oracle:thin:@" + serverName + ":" + portNumber + ":" + sid;

    try
    {
      Class.forName("oracle.jdbc.driver.OracleDriver");

      connection = DriverManager.getConnection(dbUrl, "alumni", "hash1#alumni#");
    }
    catch (Exception e) {
      e.printStackTrace();
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

*/