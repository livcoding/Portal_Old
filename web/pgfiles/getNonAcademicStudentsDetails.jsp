<%-- 
    Document   : getNonAcademicStudentsDetails
    Created on : 29 Jun, 2020, 12:20:47 PM
    Author     : anoop.tiwari
--%>

<%@ page import="org.json.JSONObject,java.sql.*,pgwebkiosk.*" errorPage="ExceptionHandler.jsp"%>
<%@ page contentType="application/json" %>
<%@ page pageEncoding="UTF-8" %>

<%try{
//  ============== check condition  And pParameterWithRegCode   = 'Y'




//System.out.println("sjdkjdsldfkfhdfhjkhfjksfsfhsafhsdhjjhhj");


DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs2=null;
ResultSet rs3=null;
ResultSet RsChk=null;
OLTEncryption enc=new OLTEncryption();
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress=session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
String instituteCode=request.getParameter("institutecode")==null?"":request.getParameter("institutecode");
String regCode=request.getParameter("regcode")==null?"":request.getParameter("regcode");
String companyCode=request.getParameter("companycode")==null?"":request.getParameter("companycode");
String memberId=request.getParameter("memberid")==null?"":request.getParameter("memberid");

String enrollmentNo="";
String pParameterWithRegCode="Y"; // this parameter will be come and will be manage according of Y or N
String studentTypeCode="";
String studentID="";
String startSemester="";
String outSemester="";
String errormsg="";
String regAllow="";
String quota="";
String semester="";
String acadyear="";



//System.out.println(memberId+"--------"+instituteCode+"---------"+companyCode+"-----------"+regCode);

if(!memberId.equals("")  && !instituteCode.equals("") &&  !companyCode.equals("") &&  !regCode.equals("")  )
{

 //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
String seqqry="Select WEBKIOSK.ShowLink('416','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
  RsChk= db.getRowset(seqqry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------

String qryStd="select enrollmentno from studentmaster where institutecode='"+instituteCode+"' and studentid='"+memberId+"'";

//System.out.println(qryStd);
	rs3=db.getRowset(qryStd);
	if(rs3.next()){
	enrollmentNo=rs3.getString(1);
	}

String qry="  Select  nvl(A.Studentname,'') studentname,to_char(A.DATEOFBIRTH,'dd/mm/yyyy') dateofbirth ,nvl(A.FATHERNAME,'') fathername ,  Nvl(A.Enrollmentno,A.Rankno) EnrollmentNo, nvl(A.Programcode,'') Program, nvl(A.Rankno,'') rankno, nvl(A.Forinstitute,'') forinstitute, to_char(A.Semester) sem, nvl(A.Programcode,'') progcode,"+
           " nvl(A.Branchcode,'') branchcode, nvl(A.Studentid,'') studentid, nvl(A.Fathername,'') fname, Decode(A.Sex,'M','Boy','F','Girl','UnKnown') SexLabel,    to_char(A.Dateofbirth,'dd-mm-yyyy') Dateofbirth,"+
 "  Decode(nvl(a.Deactive,'N'),'N', 'Active','Deactive') DeactiveDesc, nvl(a.Deactive,'N') deactive,Decode(a.StudentTypeCODE,'F','Foreigner','G','Indian','N','NRI','O','Others', "+
 "  'Not Defined') StudentType, nvl(a.Quota,'') quota,nvl(A.Category,'') cat, nvl(a.AcademicYear,'') acyear,nvl(a.sectioncode,'') sectioncode, nvl(a.subsectioncode,'') subsectioncode,nvl(b.SemesterType,'') semestertype,Nvl(b.RegAllow,'N') RegAllow ,to_char(b.SEMESTER) regforsemester"+
           "  From Studentmaster A, V#SfmStudentRegistration b Where a.Institutecode = '"+instituteCode+"'  And b.CompanyCode= '"+companyCode+"'"+
		   "   And b.InstituteCode    = a.InstituteCode "+
           "  And b.StudentID= a.StudentID  And b.RegCode = '"+regCode+"'   And Nvl(A.EnrollmentNo,Rankno)='"+enrollmentNo+"'"+
           "  And Not Exists    (Select 1 From Blockedsl Where CompanyCode= '"+companyCode+"'  And   Sltype  = 'S' And Slcode = A.Studentid And   Blockflag  Is Not Null) "+
		   "  and A.studentid='"+memberId+"'"+
           " Union all "+
           " Select  nvl(A.Studentname,studentname),to_char(A.DATEOFBIRTH,'dd/mm/yyyy') dateofbirth ,nvl(A.FATHERNAME,'') fathername , nvl( A.Enrollmentno,'') EnrollmentNo , nvl(A.Programcode,'') progcode,nvl(A.Rankno,''), nvl(A.Forinstitute,'') forinstitute, to_char(A.Semester)Semester, nvl(A.Programcode,'') progcode,nvl(A.Branchcode,'') branchcode, nvl(A.Studentid,'') studentid,"+
		   " nvl(A.Fathername,'') fathername,Decode(A.Sex,'M','Boy','F','Girl','UnKnown') SexLabel, to_char(A.Dateofbirth,'dd-mm-yyyy') Dateofbirth,Decode(nvl(a.Deactive,'N'),'N', "+
		   " 'Active','DeActive') DeactiveDesc, nvl(a.Deactive,'N'), Decode(a.StudentTypeCODE,'F','Foreigner','G','Indian','N','NRI','O','Others','Not Defined') StudentType,"+
		   " nvl(a.Quota,'') quota,nvl(a.Category,'') cat,nvl(a.AcademicYear,''),nvl( a.sectioncode,'') sectioncode, nvl(a.subsectioncode,'') subsectioncode, to_char(' ') SemesterType, to_char(' ') RegAllown, to_char(' ') regforsemester From   Studentmaster A Where "+
		   "  a.Institutecode = '"+instituteCode+"'"+
           " And A.EnrollmentNo='"+enrollmentNo+"' And Not Exists (Select 1 From Blockedsl Where CompanyCode='"+companyCode+"' And Sltype  = 'S' And "+
		   "  Slcode = A.Studentid And Blockflag  Is Not Null)"+
		      "  and A.studentid='"+memberId+"'" ;
          // --And pParameterWithRegCode = 'N'
		 // --And pParameterWithRegCode   = 'Y'

//System.out.println(qry);
rs=db.getRowset(qry);

	if(rs.next()){

JSONObject jObj =new JSONObject();

studentTypeCode=rs.getString("StudentType")==null?"":rs.getString("StudentType");
studentID=rs.getString("studentid")==null?"":rs.getString("studentid");
regAllow=rs.getString("RegAllow")==null?"":rs.getString("RegAllow");
quota=rs.getString("quota")==null?"":rs.getString("quota");
semester=rs.getString("sem")==null?"":rs.getString("sem");
acadyear=rs.getString("acyear")==null?"":rs.getString("acyear");
String query1="Select StudentTypeDesc  From StudentTypeMaster Where StudentTypeCode = '"+studentTypeCode+"' And Nvl(Deactive,'N')= 'N'";
               rs2=db.getRowset(query1);
			   if(rs2.next()){
			   studentTypeCode=(rs2.getString(1)==null?"":rs2.getString(1));
			   }
			   else{
			   studentTypeCode="Invalid Type";
			   }
//Start Semester
String query2="Select StartSemester  From StudentInDetail    Where InstituteCode= '"+instituteCode+"' And StudentID= '"+studentID+"' "+
              " And RowNum= 1";
                rs2=db.getRowset(query2);
			   if(rs2.next()){
			   startSemester=rs2.getString(1)==null?"1":rs2.getString(1);
			   }
			   else{
			   startSemester="1";
			   }
//             Exception When No_Data_Found Then
//            :DummyHeader.StartSemester := 1;

//  End Semester
String query3="Select  OutSemester   From  StudentOutDetail Where InstituteCode    = '"+instituteCode+"' And StudentID= '"+studentID+"' "+
              " And RowNum= 1";
			   rs2=db.getRowset(query3);
			   if(rs2.next()){
			   outSemester=rs2.getString(1)==null?"1":rs2.getString(1);
			   }
			   else{
			   outSemester=null;
			   }
//            Exception When No_Data_Found Then
//           :DummyHeader.OutSemester := Null;


if("".equals(studentID) ){
    errormsg="Invalid Student....Unable To Get Student/Student is Blocked.";
   }else if("N".equals(regAllow)){
	 errormsg="Student Not Registered In "+regCode+" ";
   }else if("".equals(quota) ){
   errormsg="Student Quota (GEN, NRI, Foreigner, Others) Is Not Defined In Master...";
   }else if("".equals(semester)){
   errormsg="Student Semester Is Not Defined In Master...";
   } else if( "".equals(acadyear)){
   errormsg ="Student Academic Year Not Defined In Master...";
   }


if(!"".equals(errormsg)){

jObj.put("errormsg",errormsg);

}else{

jObj.put("enrollmentno",rs.getString("EnrollmentNo")==null?"":rs.getString("EnrollmentNo"));
jObj.put("sexlabel",rs.getString("SexLabel")==null?"":rs.getString("SexLabel"));
jObj.put("deactivedesc",rs.getString("DeactiveDesc")==null?"":rs.getString("DeactiveDesc"));
jObj.put("studenttype",studentTypeCode);
jObj.put("quota",quota);
jObj.put("program",rs.getString("Program")==null?"":rs.getString("Program"));
jObj.put("branchcode",rs.getString("branchcode")==null?"":rs.getString("branchcode"));
jObj.put("studentname",rs.getString("studentname")==null?"":rs.getString("studentname"));
jObj.put("fathername",rs.getString("fathername")==null?"":rs.getString("fathername"));
jObj.put("dateofbirth",rs.getString("dateofbirth")==null?"":rs.getString("dateofbirth"));
jObj.put("acyear",acadyear);
jObj.put("sem",semester);
jObj.put("semestertype",rs.getString("semestertype")==null?"":rs.getString("semestertype"));

jObj.put("section",rs.getString("sectioncode")==null?"":rs.getString("sectioncode"));
jObj.put("subsection",rs.getString("subsectioncode")==null?"":rs.getString("subsectioncode"));
jObj.put("regforsemester",rs.getString("regforsemester")==null?"":rs.getString("regforsemester"));

jObj.put("cat",rs.getString("cat")==null?"":rs.getString("cat"));
jObj.put("progcode",rs.getString("progcode")==null?"":rs.getString("progcode"));



}


out.print(jObj);
out.flush();
	}else{

	JSONObject jObj=new JSONObject();
	jObj.put("notfound",true);
out.print(jObj);
out.flush();


	}

 //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
  }
  else
   {
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team.
	<br>	<br>	<br>	<br></P>
   <%
	}
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}


	}
	catch(Exception e){
	System.out.println("this is error");
	System.out.println(e);
	}
%>
