<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 

<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%

DBHandler db=new DBHandler();
ResultSet rs=null;
OLTEncryption enc=new OLTEncryption();
String qry="", mOldP="", mNewP="",mORAID, mORATYP;
int c=0;
try
{
qry="select ORAPW,ORAID, ORATYP from MemberMaster where nvl(Deactive,'N')='N'";
rs=db.getRowset(qry);
out.print("Wait Chainging password in uppercase...");
while (rs.next())
{
  mOldP=enc.decode(rs.getString(1));
  mORAID=rs.getString(2);
  mORATYP=rs.getString(3);
  mNewP=mOldP.toUpperCase();
  mNewP=enc.encode(mNewP);
  qry="Update MemberMaster set ORAPW='"+mNewP+"' where ORAID='"+mORAID+"' and ORATYP='"+mORATYP+"'";

  c=c+db.update(qry);
}
	out.print("Total "+c+" Membr's Password have been changed....");
}
catch(Exception e)
{
	out.print("Error while Changing password.....");
}
%>
</body>
</html>