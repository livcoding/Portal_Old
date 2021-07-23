package tietwebkiosk;
import java.sql.*;
import javax.sql.*;
import javax.sql.rowset.*;
import com.sun.rowset.CachedRowSetImpl;


public class GlobalFunctions{

public static String InstituteCode="TIET";
public static String CompanyCode="TIET";


  public GlobalFunctions() {
  }

  /*
           ' **********************************************************************************************************
           ' *													   *
           '
           ' * File Name:	GlobalFunctions.JSP									   *
           ' * Author:		Ashok Kr. Singh*
           ' * Date:		11th Sep 2006								   *
           ' * Version:		1.0										   *
           ' * Description:	List of Global constant and Public data/valirable
           ' **********************************************************************************************************
           '
           ' **********************************************************************************************************
   */

  public static String NBSPS(int nTimes) {
    String dt = "";
    int i = 0;
    for (i = 1; 1 < nTimes; i++) {
      if (dt.equals(""))
        dt = "&nbsp;";
      else
        dt = dt + "&nbsp;";
    }
    return (dt);
  }



  public static String getFirstName(String tMemberName)
  {
    int pos,pos1=0;
    String mName = "";
    String ttMemberName="";
    pos = tMemberName.trim().indexOf(" ");
    if (pos>0)
    {
      mName = tMemberName.substring(0, pos).toUpperCase();
    }
      else
        mName=tMemberName;

   return(mName);
  }

  public static String getUserName(String tMemberID,String tMemberType) {
    String rName = "";
    ResultSet rs = null;
    DBHandler db = new DBHandler();
    String qry="";
    if (tMemberType.equals("E"))
	    qry = "select nvl(EmployeeName,' ') UserName from  OL#AdminUsers where EmployeeID='" + tMemberID + "'" ;
    else
	    qry = "select nvl(StudentName,' ') UserName from  StudentMaster where StudentID='" + tMemberID + "'" ;
    try
      {
      rs = db.getRowset(qry);

      if (rs.next()==false)
        rName = "";
      else
        rName = rs.getString(1);

      rs.close();
    }
    catch(Exception e)
          {rName="";}
   
    return (rName);

}
  public static String getRemoteTime() {
    String rDateTime = "";
    ResultSet rs = null;
    String mDateTime="";
    DBHandler db = new DBHandler();
    try
    {
      rs = db.getRowset("select Sysdate from dual");
      mDateTime = rs.getString(1);
      rs.close();
    }
    catch(Exception e) {}

    return (mDateTime);

  }

  public static String toTtitleCase(String mSname) {
    int L = 0;
    boolean LastSpace = false;
    String ch = "";
    int i=0;
    if (mSname!=null )
    {
      mSname = mSname.trim();

      L = mSname.length();
      LastSpace = false;

      for (i = 0; i <L; i++) {
       if (i == 0)
          {
                ch = mSname.substring(i,i+1).toUpperCase();
                }
        else if (LastSpace == true)
                {
            ch = ch + mSname.substring(i, i+1).toUpperCase();
            LastSpace = false;
        }
        else
          ch = ch + mSname.substring(i, i+1).toLowerCase();

        if (mSname.substring(i, i+1).equals(" ") || mSname.substring(i, i+1).equals(".") ||
            mSname.substring(i, i+1).equals(","))
          {
                LastSpace = true;
            }
      }
    }
    return (ch);
  }


  public static boolean isValidEmail(String strEmail) {
    String at = "@";

    String dot = ".";
    int lat = strEmail.indexOf(at);
    int lstr = strEmail.length();
    int ldot = strEmail.indexOf(dot);

    if (strEmail.indexOf(at) == -1) {
      //alert("Invalid E-mail ID") ;
      return false;
    }
    if (strEmail.indexOf(at) == -1 || strEmail.indexOf(at) == 0 ||
        strEmail.indexOf(at) == lstr) {
      //alert("Invalid E-mail ID") ;
      return false;
    }

    if (strEmail.indexOf(dot) == -1 || strEmail.indexOf(dot) == 0 ||
        strEmail.indexOf(dot) == lstr) {
//                  alert("Invalid E-mail ID")
      return false;
    }

    if (strEmail.indexOf(at, (lat + 1)) != -1) {
      //                 alert("Invalid E-mail ID")
      return false;
    }
    if (strEmail.substring(lat - 1, lat).equals(dot) || strEmail.substring(lat + 1, lat + 2).equals(dot))
    {
      //                 alert("Invalid E-mail ID")
      return false;
    }
    if (strEmail.indexOf(dot, (lat + 2)) == -1) {
      //                      alert("Invalid E-mail ID")
      return false;
    }
    if (strEmail.indexOf(" ") != -1) {
//                     alert("Invalid E-mail ID")
      return false;
    }

    return true;

  }
  public static boolean isNumeric(String str){
    try
    {
      Integer.parseInt(str);
      return true;
    }
    catch(NumberFormatException e)
    {
      return false;
//	("error");
    }
  }



	public static int hasSingleDoubleQuot(String tStr)

          {

           int i,l,mFlag=0;

           l=tStr.length();

           for (i=0;i<l;i++)
           {
            if (tStr.charAt(i)==39 || tStr.charAt(i)==34)
            {
             mFlag=1;
             i=l;
            }
          }
          return(mFlag);

        }

        public static int hasSingleQuot(String tStr)

          {

           int i,l,mFlag=0;

           l=tStr.length();

           for (i=0;i<l;i++)
           {
            if (tStr.charAt(i)==39)
            {
             mFlag=1;
             i=l;
            }
          }
          return(mFlag);

        }


        public static String replaceSignleQuot(String mStr)

          {

           int i,l,mFlag=0;
           String tStr=mStr.trim(),NewStr="";
           l=tStr.length();

           for (i=0;i<l;i++)
           {
            if (tStr.charAt(i)==39)
             NewStr= NewStr + "'||chr(39)||'" ;
            else
             NewStr=NewStr+tStr.charAt(i);
           }
          return(NewStr);

        }

        public static int hasDoubleQuot(String tStr)

          {

           int i,l,mFlag=0;

           l=tStr.length();

           for (i=0;i<l;i++)
           {

             System.out.print(tStr.charAt(i));
            if (tStr.charAt(i)==34)
            {
             mFlag=1;
             i=l;
            }
          }
          return(mFlag);

        }

public static String getLTPDesc(String mLTP)
{
//fORMAT 't','P'
String str=mLTP.trim();
String x="";
String mNewLTP="";
String mNewL="";
String mNewT="";
String mNewP="";
String newstr="";
int L=0;
int k=1;
int i=0;	

// Sorting of LTP

try
{
L=str.length();
for(i=0;i<L;i++)
{
	if(k==1 && i==0)
	{
		x=str.substring(1,2);
		k++;
	}

	else if(k==2 && L>3)
	{
		x=str.substring(5,6);
		k++;
	}	

	else if(k==3 && L>7)
	{
		x=str.substring(9,10);
		k++;
	}
	
	if(x.equals("L"))	mNewL="Lecture";	  
	if(x.equals("T"))	mNewT="Tutorial";
 	if(x.equals("P"))	mNewP="Practical";
	x="";
  }

if(mNewL.equals("Lecture"))
  {
	newstr="Lecture";
  }
if(mNewT.equals("Tutorial"))
  {
	if (newstr.equals(""))
		newstr="Tutorial";
	else
		newstr=newstr+","+"Tutorial";
 }
if(mNewP.equals("Practical"))
  {
	if (newstr.equals(""))
		newstr="Practical";
	else 
		newstr=newstr+","+"Practical";
 }


}
catch(Exception e)
{
newstr=" ";
}

return(newstr);
}



public static String getLTPDescWSQ(String mLTP)
{
//Format "LT" or "LPT" etc
String str=mLTP.trim();
String x="";
String mNewL="";
String mNewT="";
String mNewP="";
String newstr="";
int L=0;
int i=0;	

// Sorting of LTP

try
{
L=str.length();
for(i=0;i<L;i++)
{
	x=str.substring(i,i+1);	
	if(x.equals("L"))	mNewL="Lecture";	  
	if(x.equals("T")) 	mNewT="Tutorial";
 	if(x.equals("P"))	mNewP="Practical";

	x="";
 }

if(mNewL.equals("Lecture"))
  {
	newstr=mNewL;
  }
if(mNewT.equals("Tutorial"))
  {
	if (newstr.equals(""))
		newstr=mNewT;
	else 
		newstr=newstr+","+mNewT;
 }
if(mNewP.equals("Practical"))
  {
	if (newstr.equals(""))
		newstr=mNewP;
	else 
		newstr=newstr+","+mNewP;
 }
}
catch(Exception e)
{
newstr=" ";
}

return(newstr);

}





public static String getSortedLTPSQ(String mLTP)
{
//Format "�L�,�T�" or "�L�,�P�,�T�" etc
String str=mLTP.trim();
String x="";
String mNewLTP="";
String mNewL="";
String mNewT="";
String mNewP="";
String newstr="";
int L=0;
int k=1;
int i=0;	

// Sorting of LTP

try
{
L=str.length();
for(i=0;i<L;i++)
{
	if(k==1 && i==0)
	{
		x=str.substring(1,2);
		k++;
	}

	else if(k==2 && L>3)
	{
		x=str.substring(5,6);
		k++;
	}	

	else if(k==3 && L>7)
	{
		x=str.substring(9,10);
		k++;
	}
	
	if(x.equals("L"))	mNewL="Lecture";	  
	if(x.equals("T")) mNewT="Tutorial";
 	if(x.equals("P"))	mNewP="Practical";
	x="";
  }

if(mNewL.equals("Lecture"))
  {
	newstr="'L'";
  }
if(mNewT.equals("Tutorial"))
  {
	if (newstr.equals(""))
		newstr="'T'";
	else
		newstr=newstr+","+"'T'";
 }
if(mNewP.equals("Practical"))
  {
	if (newstr.equals(""))
		newstr="'P'";
	else 
		newstr=newstr+","+"'P'";
 }


}
catch(Exception e)
{
newstr=" ";
}

return(newstr);
}



public static String getSordtedLTPWSQ(String mLTP)
{
//Format "LT" or "LPT" etc
String str=mLTP.trim();
String x="";
String mNewL="";
String mNewT="";
String mNewP="";
String newstr="";
int L=0;
int i=0;	

// Sorting of LTP

try
{
L=str.length();
for(i=0;i<L;i++)
{
	x=str.substring(i,i+1);	
	if(x.equals("L"))	mNewL="Lecture";	  
	if(x.equals("T")) mNewT="Tutorial";
 	if(x.equals("P"))	mNewP="Practical";

	x="";
 }

if(mNewL.equals("Lecture"))
  {
	newstr="L";
  }
if(mNewT.equals("Tutorial"))
  {
	if (newstr.equals(""))
		newstr="T";
	else 
		newstr=newstr+","+"T";
 }
if(mNewP.equals("Practical"))
  {
	if (newstr.equals(""))
		newstr="P";
	else 
		newstr=newstr+","+"P";
 }


}
catch(Exception e)
{
newstr=" ";
}

return(newstr);
}


  public static boolean  iSValidDate(String pDate)
  {
//1
    int dn, mn, yn, maxday;
    String mDate = pDate.trim();
    dn = 0;
    mn = 0;
    yn = 0;
    maxday = 0;
    boolean mISValidDate = false;
    if (isNumeric(mDate.substring(0, 2)) && isNumeric(mDate.substring(3, 5)) &&
        isNumeric(mDate.substring(6))) { //2
      if (mDate.trim().length() == 10) {
        //3
        if (mDate.substring(2, 3).equals("-") && mDate.substring(5, 6).equals("-")) { //4
          if (Integer.parseInt(mDate.substring(0,2)) >= 1 &&
              Integer.parseInt(mDate.substring(0,2)) <=31 &&
              Integer.parseInt(mDate.substring(3, 5)) <= 12 &&
              Integer.parseInt(mDate.substring(3, 5)) >= 1 &&
              Integer.parseInt(mDate.substring(6)) >= 1900 &&
              Integer.parseInt(mDate.substring(6)) <= 3000) { //5
            dn = Integer.parseInt(mDate.substring(0, 2));
            mn = Integer.parseInt(mDate.substring(3,5));
            yn = Integer.parseInt(mDate.substring(6));
            if (mn == 4 || mn == 6 || mn == 9 || mn == 11)
              maxday = 30;
            else if (mn == 1 || mn == 3 || mn == 5 || mn == 7 || mn == 8 ||
                     mn == 10 || mn == 12)
              maxday = 31;
            else if (mn == 2 && (yn % 4 == 0 || yn % 400 == 0))
              maxday = 29;
            else
              maxday = 28;

            if (mn > 0 && mn <= 12 && dn > 0 && dn <= maxday)
              mISValidDate =true;
          } //5

        } //4
      } //3
    } //2
  return (mISValidDate);
}

public static boolean  isAValidDate(String pDate)
{
//1
  int dn, mn, yn, maxday;
  String mDate = pDate.trim();
  dn = 0;
  mn = 0;
  yn = 0;
  maxday = 0;
  boolean mISValidDate = false;
  if (isNumeric(mDate.substring(8)) && isNumeric(mDate.substring(5, 7)) &&
      isNumeric(mDate.substring(0,4))) { //2
    if (mDate.trim().length() == 10) {
      //3
      if (mDate.substring(4,5).equals("-") && mDate.substring(7,8).equals("-")) { //4
        if (Integer.parseInt(mDate.substring(8)) >= 1 &&
            Integer.parseInt(mDate.substring(8)) <=31 &&
            Integer.parseInt(mDate.substring(5,7)) <= 12 &&
            Integer.parseInt(mDate.substring(5,7)) >= 1 &&
            Integer.parseInt(mDate.substring(0,4)) >= 1900 &&
            Integer.parseInt(mDate.substring(0,4)) <= 3000) { //5
          dn = Integer.parseInt(mDate.substring(8));
          mn = Integer.parseInt(mDate.substring(5,7));
          yn = Integer.parseInt(mDate.substring(0,4));
          if (mn == 4 || mn == 6 || mn == 9 || mn == 11)
            maxday = 30;
          else if (mn == 1 || mn == 3 || mn == 5 || mn == 7 || mn == 8 ||
                   mn == 10 || mn == 12)
            maxday = 31;
          else if (mn == 2 && (yn % 4 == 0 || yn % 400 == 0))
            maxday = 29;
          else
            maxday = 28;

          if (mn > 0 && mn <= 12 && dn > 0 && dn <= maxday)
            mISValidDate =true;
        } //5

      } //4
    } //3
  } //2
return (mISValidDate);
}

public double getRound(double mAmt, int mPos)
{
	
      double mOutAmt;
      String qry="select webkiosk.getRound(" + mAmt + "," + mPos + ") amt from dual";
      ResultSet rs = null;
      DBHandler db = new DBHandler();
      try
      {
      rs = db.getRowset(qry);
      rs.next();
      mOutAmt= rs.getDouble(1);
      rs.close();
    }
    catch(Exception e) 
{
mOutAmt=0;
}

    return (mOutAmt);


}



  } //end of class
