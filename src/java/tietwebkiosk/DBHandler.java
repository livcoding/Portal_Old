package tietwebkiosk;
import java.sql.*;
import java.util.Properties;
import java.util.Enumeration;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.*;
import javax.sql.*;
import javax.sql.rowset.*;
import com.sun.rowset.CachedRowSetImpl;
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;
public class DBHandler{
  Connection con=null;
  Statement stmt = null;  // Or PreparedStatement if needed
  ResultSet rs = null;
  DataSource ds=null;

//--------For  Dev  Srever-------------------------//
  public DBHandler()
  {
    try{
    Context initContext = new InitialContext();
    Context envContext  = (Context)initContext.lookup("java:/comp/env"); 
    ds = (DataSource)envContext.lookup("jdbc/webkioskdb");
    }catch(Exception e){e.printStackTrace();}
  }
  

  //---------------------------For live Server(Start)----------------------------------------//
/*public DBHandler() {
        try {
            InitialContext initContext = new InitialContext();
            this.ds = (DataSource)initContext.lookup("java:jboss/datasource/webkioskdb");
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    } */
  //---------------------------For live Server(end)----------------------------------------//
  public DBHandler(Properties props) throws SQLException,
      ClassNotFoundException {
    String password=props.getProperty("password");
    String driverName=props.getProperty("driverName");
    String userName=props.getProperty("userName");
    String dsnSID=props.getProperty("dsnSID");
    String portNumber=props.getProperty("portNumber");
    String serverName=props.getProperty("serverName");
    if(driverName.endsWith("JdbcOdbcDriver")){
      this.con= new DBHandler(dsnSID).con ;

    }else if(driverName.endsWith("OracleDriver")){
      new DBHandler(driverName,serverName,portNumber,dsnSID,userName,password);
    }else if(driverName.endsWith("SQLServerDriver")){
      new DBHandler(driverName,serverName,portNumber,userName,password);

    }

  }
  public DBHandler(String dsn) throws ClassNotFoundException, SQLException {
   
    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
    con = DriverManager.getConnection("jdbc:odbc:"+dsn);
  }
  public DBHandler(String driver,String url) throws ClassNotFoundException,
      SQLException {

    Class.forName(driver);
    con=DriverManager.getConnection(url);
  }

  public DBHandler(String driver,String url,String userName,String password) throws
      ClassNotFoundException, SQLException {
    Class.forName(driver);
    con=DriverManager.getConnection(url,userName,password);
  }


  public DBHandler(String driver,String serverName,String port,String SID,String userName,String password) throws
      ClassNotFoundException, SQLException {
    Class.forName(driver);
    String url="jdbc:oracle:thin:@"+serverName+":"+port+":"+SID;
    con=DriverManager.getConnection(url,userName,password);
  }
  public DBHandler(String driver,String serverName,String port,String userName,String password) throws
      ClassNotFoundException, SQLException {
    Class.forName(driver);
    String url="jdbc:microsoft:sqlserver://"+serverName+":"+port+";"+"user="+userName+";"+"password="+password;
    con = DriverManager.getConnection(url);
  }

  public ResultSet execute(String qry) throws SQLException {

      Statement stmt=con.createStatement();
    ResultSet rs=stmt.executeQuery(qry);
    return rs;
  }
  public boolean insert(String qry) throws SQLException {
    Statement stmt=con.createStatement();
    boolean retval=stmt.execute(qry) ;
    return retval;
  }
  public int update(String sql) throws SQLException {
    int retval=0;
    try{
    con=ds.getConnection();
    Statement stmt=con.createStatement();
    retval=stmt.executeUpdate(sql) ;
    stmt.close();
    stmt = null;
    con.close(); // Return to connection pool
    con = null;  // Make sure we don't close it twice
  } catch (SQLException e) {
    e.printStackTrace();
  } finally {
// Always make sure result sets and statements are closed,
// and the connection is returned to the pool

    if (stmt != null) {
      try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
      stmt = null;
    }
    if (con != null) {
      try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
      con = null;
    }
  }//end of finally block

  return retval;
    }




    public int insertRow(String sql) throws SQLException {
    int retval=0;
    try{
    con=ds.getConnection();
    Statement stmt=con.createStatement();
    retval=stmt.executeUpdate(sql) ;
    stmt.close();
    stmt = null;
    con.close(); // Return to connection pool
    con = null;  // Make sure we don't close it twice
  } catch (SQLException e) {
    e.printStackTrace();
  } finally {
// Always make sure result sets and statements are closed,
// and the connection is returned to the pool

    if (stmt != null) {
      try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
      stmt = null;
    }
    if (con != null) {
      try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
      con = null;
    }
  }//end of finally block

  return retval;
    }




    public void closeConnection() throws SQLException {
      con.close();
    }
    public ResultSet getRowset(String qry){
      CachedRowSet crs=null;
      try{

          //System.out.println(qry);
        con = ds.getConnection();
        stmt = con.createStatement();
        rs = stmt.executeQuery(qry);
        crs=new CachedRowSetImpl();
        crs.populate(rs);

        rs.close();
        rs = null;
        stmt.close();
        stmt = null;
        con.close(); // Return to connection pool
        con = null;  // Make sure we don't close it twice
      } catch (SQLException e) {
        e.printStackTrace();
      } finally {
        // Always make sure result sets and statements are closed,
        // and the connection is returned to the pool
        if (rs != null) {
          try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
          rs = null;

        }
        if (stmt != null) {
          try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
          stmt = null;
        }
        if (con != null) {
          try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
          con = null;
        }
      }//end of finally block
      return (ResultSet)crs;

    }

//


//----
public void saveLogEntry(String tMemberID , String tMemberType, String tMACAddress , String tIPAddress)
{
   CallableStatement proc=null;
  try{
    con = ds.getConnection();
    proc= con.prepareCall("{call WEBKIOSK.LogEntry(?, ?, ?, ?)}");
    proc.setString(1,tMemberID );
    proc.setString(2, tMemberType);
    proc.setString(3, tMACAddress );
    proc.setString(4, tIPAddress );
    proc.execute();
    proc.close();
    proc = null;
    con.close(); // Return to connection pool
    con = null;  // Make sure we don't close it twice
   }
    catch (SQLException e)
    {
    e.printStackTrace();
    }
finally
{
     if (proc != null)
     {
       try { proc.close(); }
       catch (SQLException e)
       {
           e.printStackTrace();
       }
       proc = null;
     }
     if (con != null)
     {
       try
       { con.close();
       }
       catch (SQLException e)
       { e.printStackTrace();
       }
       con = null;
     }

    }
}
//--



//--

//Procedure MemberSignp(pMemberID in varchar2, pMemberCode in varchar2, pMemberType  IN Varchar2 , pMemberRole IN Varchar2, pPass IN Varchar2)

public void memberSignp(String  pMemberID ,String  pMemberCode , String pMemberType  ,String pMemberRole , String pPass)
{
   CallableStatement proc=null;
  try{
    con = ds.getConnection();
    proc= con.prepareCall("{call WEBKIOSK.MemberSignp(?, ?, ?, ?, ?)}");
    proc.setString(1,pMemberID);
    proc.setString(2, pMemberCode);
    proc.setString(3, pMemberType);
    proc.setString(4, pMemberRole );
    proc.setString(5, pPass );
    proc.execute();
    proc.close();
    proc = null;
    con.close(); // Return to connection pool
    con = null;  // Make sure we don't close it twice
   }
    catch (SQLException e)
    {
    e.printStackTrace();
    }
finally
{
     if (proc != null)
     {
       try { proc.close(); }
       catch (SQLException e)
       {
           e.printStackTrace();
       }
       proc = null;
     }
     if (con != null)
     {
       try
       { con.close();
       }
       catch (SQLException e)
       { e.printStackTrace();
       }
       con = null;
     }

    }
}

//--

//Procedure SaveTransLog(tInstituteCode IN cHAR , tMemberID in varchar2, tMemberType in varchar2, tTransType  IN Varchar2 , tTransDetail IN Varchar2, tMACAddress IN Varchar2, tIPAddress  In Varchar2)
public void saveTransLog(String tInstituteCode, String  tMemberID ,String  tMemberType , String tTransType, String tTransDetail , String tMACAddress , String tIPAddress)
{
   CallableStatement proc=null;
  try{
    con = ds.getConnection();
    proc= con.prepareCall("{call WEBKIOSK.SaveTransLog( ?, ?, ?, ?, ?, ?, ?)}");
    proc.setString(1, tInstituteCode);
    proc.setString(2, tMemberID);
    proc.setString(3, tMemberType);
    proc.setString(4, tTransType);
    proc.setString(5, tTransDetail );
    proc.setString(6, tMACAddress );
    proc.setString(7, tIPAddress );
    proc.execute();
    proc.close();
    proc = null;
    con.close(); // Return to connection pool
    con = null;  // Make sure we don't close it twice
   }
    catch (SQLException e)
    {
    e.printStackTrace();
    }
finally
{
     if (proc != null)
     {
       try { proc.close(); }
       catch (SQLException e)
       {
           e.printStackTrace();
       }
       proc = null;
     }
     if (con != null)
     {
       try
       { con.close();
       }
       catch (SQLException e)
       { e.printStackTrace();
       }
       con = null;
     }

    }
}


  public String GenerateFSTID(String pInstCode)
{
String mRetFSTID="";
   CallableStatement proc=null;
  try{
    con = ds.getConnection();
    proc= con.prepareCall("{call WEBKIOSK.GenerateFSTID( ?, ?)}");
    proc.setString(1, pInstCode);
    proc.registerOutParameter( 2, Types.VARCHAR);
    proc.execute();
    mRetFSTID=proc.getString(2);
    proc.close();
    proc = null;
    con.close(); // Return to connection pool
    con = null;  // Make sure we don't close it twice
   }
    catch (SQLException e)
    {
    e.printStackTrace();
    }
finally
{
     if (proc != null)
     {
       try { proc.close(); }
       catch (SQLException e)
       {
           e.printStackTrace();
       }
       proc = null;
     }
     if (con != null)
     {
       try
       { con.close();
       }
       catch (SQLException e)
       { e.printStackTrace();
       }
       con = null;
     }

    }
return(mRetFSTID);
}
public String AutoReconciliation(String pFileName,String pForReporting ,String pInstituteCod ,String pExamCode,String pSubjectid,String pEventSubEvent ,String pEmployeeID ,String pForEventSubEvent ,String pUsername)
{
String mRetID="";
   CallableStatement proc=null;
  try{
    con = ds.getConnection();
    proc= con.prepareCall("{call AutoReconciliation( ?,?,?,?,?,?,?,?,?,?)}");
    proc.setString(1, pFileName);
    proc.setString(2, pForReporting);
    proc.setString(3, pInstituteCod);
    proc.setString(4, pExamCode);
    proc.setString(5, pSubjectid);
    proc.setString(6, pEventSubEvent);
    proc.setString(7, pEmployeeID);
    proc.setString(8, pForEventSubEvent);
    proc.setString(9, pUsername);


    proc.registerOutParameter( 10, Types.VARCHAR);
    proc.execute();
    mRetID=proc.getString(10);
    proc.close();
    proc = null;
    con.close(); // Return to connection pool
    con = null;  // Make sure we don't close it twice
   }
    catch (SQLException e)
    {
    e.printStackTrace();
    }
finally
{
     if (proc != null)
     {
       try { proc.close(); }
       catch (SQLException e)
       {
           e.printStackTrace();
       }
       proc = null;
     }
     if (con != null)
     {
       try
       { con.close();
       }
       catch (SQLException e)
       { e.printStackTrace();
       }
       con = null;
     }

    }
return(mRetID);
}


//    public void WeekReg4JSP(String AccFdate ,String AccTDate, String pUserID , String pUserType , String CompCode, String pLoginCardIDTime, String LWPInclude ,String ODInclude ,String WInclude ,String AbsentInclude, String LeaveInclude ,String PresentInclude, String HoliDayInclude, String VacationInclude , String InstCode, String PresentWhenOneSwap)
//{
//   CallableStatement proc=null;
//  try{
//    con = ds.getConnection();
//    proc= con.prepareCall("{call ATTENDANCE.WeekReg4ASP(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
//    proc.setString(1,AccFdate);
//    proc.setString(2, AccTDate);
//	proc.setString(3, pUserID);
//	proc.setString(4, pUserType);
//    proc.setString(5, CompCode );
//	proc.setString(6, pLoginCardIDTime );
//	proc.setString(7, LWPInclude );
//	proc.setString(8, ODInclude );
//	proc.setString(9, WInclude );
//	proc.setString(10, AbsentInclude );
//	proc.setString(11, LeaveInclude );
//	proc.setString(12, PresentInclude );
//	proc.setString(13, HoliDayInclude );
//	proc.setString(14, VacationInclude );
//	proc.setString(15, InstCode );
//    proc.setString(16, PresentWhenOneSwap );
//    proc.execute();
//    proc.close();
//    proc = null;
//    con.close(); // Return to connection pool
//    con = null;  // Make sure we don't close it twice
//   }
//    catch (SQLException e)
//    {
//    e.printStackTrace();
//    }
//finally
//{
//     if (proc != null)
//     {
//       try { proc.close(); }
//       catch (SQLException e)
//       {
//           e.printStackTrace();
//       }
//       proc = null;
//     }
//     if (con != null)
//     {
//       try
//       { con.close();
//       }
//       catch (SQLException e)
//       { e.printStackTrace();
//       }
//       con = null;
//     }// clsoing of if
//
//    }// clsoing of finnaly
//}



  public String WeekReg4JSP(String CompCode, String InstCode, String pUserID, String pUserType, String AccFdate, String AccTDate)
  {
    String vSeqid = "";
    CallableStatement proc = null;
    try {
      con = ds.getConnection();
      proc = con.prepareCall("{call WEBKIOSKATTEND (?, ?, ?, ?, ?, ?, ?)}");
      proc.setString(1, CompCode);
      proc.setString(2, InstCode);
      proc.setString(3, pUserID);
      proc.setString(4, pUserType);
      proc.setString(5, AccFdate);
      proc.setString(6, AccTDate);
      proc.registerOutParameter(7, 12);
      proc.execute();
      vSeqid = proc.getString(7);
      proc.close();
      proc = null;
      con.close();
      con = null;
    }
    catch (SQLException e)
    {
      e.printStackTrace();
    }
    finally
    {
      if (proc != null) {
        try {
          proc.close();
        }
        catch (SQLException e) {
          e.printStackTrace();
        }
        proc = null;
      }
      if (con != null)
      {
        try {
          con.close();
        }
        catch (SQLException e) {
          e.printStackTrace();
        }
        con = null;
      }
    }

    return vSeqid;
  }


    public void WeekReg4JSPAll(String AccFdate, String AccTDate, String pDeptCode, String CompCode, String pLoginCardIDTime, String LWPInclude, String ODInclude, String WInclude, String AbsentInclude, String LeaveInclude, String PresentInclude, String HoliDayInclude, String VacationInclude, String InstCode, String PresentWhenOneSwap) {
       CallableStatement proc=null;
        try {
            con = ds.getConnection();
            proc = con.prepareCall("{call ATTENDANCE.WeekReg4ASPAll(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
            proc.setString(1, AccFdate);
            proc.setString(2, AccTDate);
            proc.setString(3, pDeptCode);
            proc.setString(4, CompCode);
            proc.setString(5, pLoginCardIDTime);
            proc.setString(6, LWPInclude);
            proc.setString(7, ODInclude);
            proc.setString(8, WInclude);
            proc.setString(9, AbsentInclude);
            proc.setString(10, LeaveInclude);
            proc.setString(11, PresentInclude);
            proc.setString(12, HoliDayInclude);
            proc.setString(13, VacationInclude);
            proc.setString(14, InstCode);
            proc.setString(15, PresentWhenOneSwap);
            proc.execute();
            proc.close();
            proc = null;
            con.close();
            con = null;
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            if (proc != null) {
                try {
                    proc.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                proc = null;
            }
            if (con != null) {
                try {
                    con.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                con = null;
            }
        }
    }

    public void AttSummary(String AccFdate, String AccTDate, String CompCode, String InstCode, String pLoginCardIDTime, String GuestInclude, String PresentWhenOneSwap) {
        CallableStatement proc = null;
        try {
            con = ds.getConnection();
            proc = con.prepareCall("{call ATTENDANCE.AttSummary(?, ?, ?, ?, ?, ?, ?)}");
            proc.setString(1, AccFdate);
            proc.setString(2, AccTDate);
            proc.setString(3, CompCode);
            proc.setString(4, InstCode);
            proc.setString(5, pLoginCardIDTime);
            proc.setString(6, GuestInclude);
            proc.setString(7, PresentWhenOneSwap);
            proc.execute();
            proc.close();
            proc = null;
            con.close();
            con = null;
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            if (proc != null) {
                try {
                    proc.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                proc = null;
            }
            if (con != null) {
                try {
                    con.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                con = null;
            }
        }
    }

    public void WeekReg(String AccFdate, String AccTDate, String CompCode, String pLoginCardIDTime, String LWPInclude, String ODInclude, String WInclude, String AbsentInclude, String LeaveInclude, String PresentInclude, String HoliDayInclude, String VacationInclude, String InstCode, String GuestInclude, String PresentWhenOneSwap) {
       CallableStatement proc = null;
        try {
            con = ds.getConnection();
            proc = con.prepareCall("{call ATTENDANCE.WeekReg(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
            proc.setString(1, AccFdate);
            proc.setString(2, AccTDate);
            proc.setString(3, CompCode);
            proc.setString(4, pLoginCardIDTime);
            proc.setString(5, LWPInclude);
            proc.setString(6, ODInclude);
            proc.setString(7, WInclude);
            proc.setString(8, AbsentInclude);
            proc.setString(9, LeaveInclude);
            proc.setString(10, PresentInclude);
            proc.setString(11, HoliDayInclude);
            proc.setString(12, VacationInclude);
            proc.setString(13, GuestInclude);
            proc.setString(14, pLoginCardIDTime);
            proc.setString(15, PresentWhenOneSwap);
            proc.execute();
            proc.close();
            proc = null;
            con.close();
            con = null;
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            if (proc != null) {
                try {
                    proc.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                proc = null;
            }
            if (con != null) {
                try {
                    con.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                con = null;
            }
        }
    }

    //--------------------------------------------------Faculty FeedBack Summary Report Procedure(Start)-----------------------------------------------------------------//
    public void FacultyFeedbackSummary(String instcode, String feedbackid, String examcode,String userid) {

        CallableStatement proc = null;
        try {
            con = ds.getConnection();
            proc = con.prepareCall("{call IQACfeedbacksummary(?, ?, ?, ?)}");
            proc.setString(1, instcode);
            proc.setString(2, feedbackid);
            proc.setString(3, examcode);
            proc.setString(4, userid);
            proc.execute();
            proc.close();
            proc = null;
            con.close(); // Return to connection pool
            con = null;  // Make sure we don't close it twice
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (proc != null) {
                try { 
                    proc.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                proc = null;
            } 
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                con = null;
            }
        }

    }


//----------------------------------------------------------Faculty FeedBack Summary Report Procedure(End)--------------------------------------//


    public String GetRequestID(String pCompanyCode, String pInstituteCode, String pWfCode) {
        String mGetRequestID = "";
      CallableStatement proc = null;
        try {
            con = ds.getConnection();
            proc = con.prepareCall("{call WEBKIOSK.RequestID(?, ?, ?, ?)}");
            proc.setString(1, pCompanyCode);
            proc.setString(2, pInstituteCode);
            proc.setString(3, pWfCode);
            proc.registerOutParameter(4, 12);
            proc.execute();
            mGetRequestID = proc.getString(4);
            proc.close();
            proc = null;
            con.close();
            con = null;
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            if (proc != null) {
                try {
                    proc.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                proc = null;
            }
            if (con != null) {
                try {
                    con.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                con = null;
            }
        }
        return mGetRequestID;
    }

    public String PopulateElectiveRunning(String mInst, String mPreventcode, String mExam, String mHODMemberID) {
        String status = "";
      CallableStatement proc = null;
        try {
            con = ds.getConnection();
            proc = con.prepareCall("{call PopulateElectiveRunning(?, ?, ?, ?,?)}");
            proc.setString(1, mInst);
            proc.setString(2, mPreventcode);
            proc.setString(3, mExam);
            proc.setString(4, mHODMemberID);
            proc.registerOutParameter(5, 12);
            proc.execute();
            status = proc.getString(5);
            proc.close();
            proc = null;
            con.close();
            con = null;
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            if (proc != null) {
                try {
                    proc.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                proc = null;
            }
            if (con != null) {
                try {
                    con.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                con = null;
            }
        }
        return status;
    }

    public String PopulateElectiveRunning_FIFS(String mInst, String mPreventcode, String mExam, String mHodMemberID) {
        String flag = "";
        CallableStatement cst = null;
        try {
            con = ds.getConnection();
            cst = con.prepareCall("{call PopulateElectiveRunning_FIFS(?,?,?,?,?)}");
            cst.setString(1, mInst);
            cst.setString(2, mPreventcode);
            cst.setString(3, mExam);
            cst.setString(4, mHodMemberID);
            cst.registerOutParameter(5, 12);
            cst.execute();
            flag = cst.getString(5);
            cst.close();
            cst = null;
            con.close();
            con = null;
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            if (cst != null) {
                try {
                    cst.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                cst = null;
            }
            if (con != null) {
                try {
                    con.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                con = null;
            }
        }
        return flag; 
    }


    public String PopEleRunning_CGPA(String mInst, String mPreventcode, String mExam, String mHODMemberID) {
        String status = "";
       CallableStatement proc = null;
        try {
            con = ds.getConnection();
            proc = con.prepareCall("{call PopEleRunning_CGPANew(?, ?, ?, ?,?)}");
            proc.setString(1, mInst);
            proc.setString(2, mPreventcode);
            proc.setString(3, mExam);
            proc.setString(4, mHODMemberID);
           // proc.setString(5, Academicyear);
            proc.registerOutParameter(5, 12);
            proc.execute();
            status = proc.getString(5);
            proc.close();
            proc = null;
            con.close();
            con = null;
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            if (proc != null) {
                try {
                    proc.close();
                }
                catch (SQLException e) { 
                    e.printStackTrace();
                }
                proc = null;
            }
            if (con != null) {
                try {
                    con.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                con = null;
            }
        }
        return status;
    }
 /******************************************Procedure for Academic Year(Start)***********************************************************************/
    public String PopEleRunning_CGPAAY(String mInst, String mPreventcode, String mExam, String mHODMemberID) {
        String status = "";
       CallableStatement proc = null;
        try {
            con = ds.getConnection();
            proc = con.prepareCall("{call PopEleRunning_CGPAAY(?, ?, ?, ?,?)}");
            proc.setString(1, mInst);
            proc.setString(2, mPreventcode);
            proc.setString(3, mExam);
            proc.setString(4, mHODMemberID);
           // proc.setString(5, Academicyear);
            proc.registerOutParameter(5, 12);
            proc.execute();
            status = proc.getString(5);
            proc.close();
            proc = null;
            con.close();
            con = null;
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            if (proc != null) {
                try {
                    proc.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                proc = null;
            }
            if (con != null) {
                try {
                    con.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                con = null;
            }
        }
        return status;
    }
//******************************************Procedure for Academic Year(end)***********************************************************************//

    public String GenerateGradeModificationNo(String pInstCode) {
        String mRetGenGrade = "";
        CallableStatement proc = null;
        try {
            con = ds.getConnection();
            proc = con.prepareCall("{call EXAM.GenerateGradeModificationNo( ?, ?)}");
            proc.setString(1, pInstCode);
            proc.registerOutParameter(2, 12);
            proc.execute();
            mRetGenGrade = proc.getString(2);
            proc.close();
            proc = null;
            con.close();
            con = null;
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            if (proc != null) {
                try {
                    proc.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                proc = null;
            }
            if (con != null) {
                try {
                    con.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                con = null;
            }
        }
        return mRetGenGrade;
    }

    public String Gettabuniqueid(String Pyear) {
        String mRetGetUniqid = "";
        CallableStatement proc = null;
        try {
            con = ds.getConnection();
            proc = con.prepareCall("{call  CampusTool.Gettabuniqueid(?, ?)}");
            proc.setString(1, Pyear);
            proc.registerOutParameter(2, 12);
            proc.execute();
            mRetGetUniqid = proc.getString(2);
            proc.close();
            proc = null;
            con.close();
            con = null;
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            if (proc != null) {
                try {
                    proc.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                proc = null;
            }
            if (con != null) {
                try {
                    con.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                con = null;
            }
        }
        return mRetGetUniqid;
    }

    public void PopulateStudSubjAttendance(String pSessionID, String mUV, String pInstCode, String pExamCode, String pSubjectID, String pSection, String pSubsection) {
        CallableStatement proc = null;
        try {
            con = ds.getConnection();
            proc = con.prepareCall("{call WEBKIOSK.PopulateStudSubjAttendance(?, ?, ?, ?, ?, ?, ?)}");
            proc.setString(1, pSessionID);
            proc.setString(2, mUV);
            proc.setString(3, pInstCode);
            proc.setString(4, pExamCode);
            proc.setString(5, pSubjectID);
            proc.setString(6, pSection);
            proc.setString(7, pSubsection);
            proc.execute();
            proc.close();
            proc = null;
            con.close();
            con = null;
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            if (proc != null) {
                try {
                    proc.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                proc = null;
            }
            if (con != null) {
                try {
                    con.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                con = null;
            }
        }
    }

    public void PopulateAttendanceData(String Inst, String ExamCode, String SubjectID, String Program, String LTP, String T1date, String T2date, String T3date) {
        CallableStatement proc = null;
        try {
            con = ds.getConnection();
            proc = con.prepareCall("{call webkiosk.PopulateAttendanceData(?, ?, ?, ?, ?, ?, ?, ?)}");
            proc.setString(1, Inst);
            proc.setString(2, ExamCode);
            proc.setString(3, SubjectID);
            proc.setString(4, Program);
            proc.setString(5, LTP);
            proc.setString(6, T1date);
            proc.setString(7, T2date);
            proc.setString(8, T3date);
            proc.execute();
            proc.close();
            proc = null;
            con.close();
            con = null;
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            if (proc != null) {
                try {
                    proc.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                proc = null;
            }
            if (con != null) {
                try {
                    con.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                con = null;
            }
            if (rs != null) {
                try {
                    rs.close();
                }
                catch (SQLException ignore) {}
            }
            if (con != null) {
                try {
                    con.close();
                }
                catch (SQLException ignore) {}
            }
        }

        

    }

    public String myprocedure(String[] myarr) {
        CallableStatement st = null;
        String  mRetGetUniqid="";
        try {
            ArrayDescriptor ad = ArrayDescriptor.createDescriptor("STUDENTMARKS_TAB_TYPE", con);
             ARRAY mya=new ARRAY(ad,con,myarr);
             st = con.prepareCall("call Reconcilation.Fun2(?)");

			// Passing an array to the procedure -
			st.setArray(1, mya);

			//st.registerOutParameter(2, Types.INTEGER);
			//st.registerOutParameter(3,OracleTypes.ARRAY,"SchemaName.ARRAY_INT");
			st.execute();
                         mRetGetUniqid = st.getString(2);
            st.close();
            st = null;
            con.close();
            con = null;
        }catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            if (st != null) {
                try {
                    st.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                st = null;
            }
            if (con != null) {
                try {
                    con.close();
                }
                catch (SQLException e) {
                    e.printStackTrace();
                }
                con = null;
            }
        } 
        return mRetGetUniqid;
    }

 //Update data of transaction tables if fee paid successfully
public String PostPGNAFee(String pInstituteCode,String pGlobalCompany,String pAcademicYear,String pStudentID,String pEnrollmentNo,double pTotalFeeAmount,
        double pTotalFeePaidAmount,String pFeeheads,Date pTransDateTime,String pCurrencyCode,String pPGTransactionID )

{
String mreturnStr="";
   CallableStatement proc=null;
  try{
    con = ds.getConnection();
    proc= con.prepareCall("{call SMSPG.PostPGNAFee(?,?,?,?,?,?,?,?,?,?,?,?)}");
    proc.setString(1, pInstituteCode);
    proc.setString(2,pGlobalCompany );
    proc.setString(3, pAcademicYear);
    proc.setString(4, pStudentID);
    proc.setString(5, pEnrollmentNo);
    proc.setDouble(6,pTotalFeeAmount);
    proc.setDouble(7,pTotalFeePaidAmount );
    proc.setString(8,pFeeheads);
    proc.setDate(9,pTransDateTime );
    proc.setString(10,pCurrencyCode );
    proc.setString(11,pPGTransactionID );
    proc.registerOutParameter(12, Types.VARCHAR);
    proc.execute();
    mreturnStr=proc.getString(12);
    proc.close();
    proc = null;
    con.close(); // Return to connection pool
    con = null;  // Make sure we don't close it twice
   }
    catch (SQLException e)
    {
    e.printStackTrace();
    }
finally
{
     if (proc != null)
     {
       try { proc.close(); }
       catch (SQLException e)
       {
           e.printStackTrace();
       }
       proc = null;
     }
     if (con != null)
     {
       try
       { con.close();
       }
       catch (SQLException e)
       { e.printStackTrace();
       }
       con = null;
     }

    }
return(mreturnStr);
}

       
    
}
