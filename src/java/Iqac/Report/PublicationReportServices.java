/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Iqac.Report;

import java.util.Map;
import tietwebkiosk.*;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.util.ArrayList;
import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.ResponseBuilder;



@Path("/PublicationReportServices")
public class PublicationReportServices {
  String qry;
  ResultSet rs;
  StringBuilder sb=new StringBuilder();
  DBHandler db=new DBHandler();

    @GET
    @Path("institute")
    @Produces(MediaType.APPLICATION_JSON)
    public String getInstitute(@QueryParam("company") String company) throws SQLException {
       qry="select instituteid,INSTITUTECODE,INSTITUTENAME from INSTITUTEMASTER ";
        rs = db.getRowset(qry);
        while (rs.next()) {
         sb.append("\"" + rs.getString("INSTITUTECODE") + "\":\"" + rs.getString("INSTITUTENAME")+"-"+ rs.getString("INSTITUTECODE")+ "\",");
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
     }

    @GET
    @Path("publicyear")
    @Produces(MediaType.APPLICATION_JSON)
    public String getPublicyear(@QueryParam("company") String company) throws SQLException {
       qry="select distinct nvl(publicationyear,' ') pulbicationyear from ap#arpublicationtrn where companyid='"+company+"' order by pulbicationyear desc";
        rs = db.getRowset(qry);
        while (rs.next()) {
         sb.append("\"" + rs.getString("pulbicationyear") + "\":\"" + rs.getString("pulbicationyear")+"\",");
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
     }

    @GET
    @Path("department")
    @Produces(MediaType.APPLICATION_JSON)
    public String getDepartment(@QueryParam("company") String company,@QueryParam("publicyear") String publicyear) throws SQLException {
       qry="select distinct nvl(a.department,'') department,nvl(a.departmentcode,'') departmentcode from departmentmaster a,ap#arpublicationtrn b,ap#arpublicationtrnauthor c where b.companyid='"+company+"' and b.publicationyear='"+publicyear+"' and c.departmentcode = a.departmentcode and b.companyid = c.COMPANYID and b.PUBLICATIONID=c.PUBLICATIONID  order by departmentcode desc";
        rs = db.getRowset(qry);
        while (rs.next()) {
         sb.append("\"" + rs.getString("departmentcode") + "\":\"" + rs.getString("department")+"\",");
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
     }
   @GET
    @Path("publicationid")
    @Produces(MediaType.APPLICATION_JSON)
    public String getDepartment(@QueryParam("company") String company,@QueryParam("publicyear") String publicyear,@QueryParam("department") String department) throws SQLException {
       qry="select distinct nvl(a.publicationid,'') publicationid,nvl(a.publicationcode,'') publicationcode," +
                            " nvl(a.title,'') title  from ap#publicationmaster a,ap#arpublicationtrnauthor b,ap#arpublicationtrn c where " +
                            " a.publicationid = b.publicationid  AND a.publicationcode = b.publicationcode " +
                            " AND a.companyid = b.companyid  and a.companyid=c.companyid  and a.companyid='"+company+"'" +
                            " and b.DEPARTMENTCODE='"+department+"'  and c.PUBLICATIONYEAR='"+publicyear+"'   " +
                            " ORDER BY publicationcode";
        sb.append("\"ALL\":\"ALL\",");
       rs = db.getRowset(qry);
        while (rs.next()) {
         sb.append("\"" + rs.getString("publicationid") + "\":\"" + rs.getString("publicationcode")+"\",");
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
     }



      @GET
    @Path("publicationreport")
   public String getPublicationreport(@QueryParam("company") String company,@QueryParam("institute") String institute,@QueryParam("publicyear") String publicyear,@QueryParam("publication") String publication,@QueryParam("department") String department) throws SQLException
      {
       String fromdate="",todate="",qry1="",qry2="",qry3="",qry4="",departmentinfo="";
       ResultSet rs1=null,rs2=null,rs3=null,rs4=null;
       int i=0;
       String author="",completereference="",publicationtype="",impactfactor="",indexbody="",hIndex="",cdate="";
        
 qry="select to_char(sysdate,'dd-mm-yyyy') currentdate from dual ";
            rs=db.getRowset(qry);
            if(rs.next())
            {
            cdate=rs.getString("currentdate") ;
            }

        publication= publication.equals("ALL")?"":" and a.PUBLICATIONID='"+publication.toUpperCase()+"'";
        qry1="SELECT distinct (select department from departmentmaster where DEPARTMENTCODE=b.DEPARTMENTCODE) department,(select distinct nvl(employeename,'') employeename from v#staff where employeeid= b.STAFFID  )  author," +
                "nvl(a.TITLE,'') TITLE,(select nvl(APPUBLICATIONTYPEDESCRIPTION,'') typeofpublication  from ap#publicationtypemaster where a.APPUBLICATIONTYPECODE= APPUBLICATIONTYPECODE and a.APPUBLICATIONTYPEID=APPUBLICATIONTYPEID)  typeofpublication,  " +
                " nvl(a.IMPACTFACTOR,'') ImpactFactor,(select nvl(INDEXINGBODYDESCRIPTION,'') indexingbody from  AP#INDEXINGBODYMASTER " +
                "where  a.INDEXINGBODYID= INDEXINGBODYID) indexingbody,(select distinct nvl(hindex,'') hindex from  AP#INDEXINGBODYdetail where " +
                " a.INDEXINGBODYID= INDEXINGBODYID) hindex FROM AP#ARPUBLICATIONTRN a,AP#ARPUBLICATIONTRNAUTHOR b where a.COMPANYID='"+company+"' " +
                "and a.COMPANYID=b.COMPANYID and a.TRANSACTIONID=b.TRANSACTIONID and a.TRANSACTIONDATE=b.TRANSACTIONDATE and " +
                "a.APPUBLICATIONTYPEID=b.APPUBLICATIONTYPEID and a.APPUBLICATIONTYPECODE=b.APPUBLICATIONTYPECODE and a.PUBLICATIONID=b.PUBLICATIONID" +
                " and a.PUBLICATIONCODE=b.PUBLICATIONCODE and a.title=b.title "+publication+" and b.departmentcode ='"+department+"'  and a.PUBLICATIONYEAR='"+publicyear+"' ";

        rs1=db.getRowset(qry1);
        rs2=db.getRowset(qry1);
        if(rs1.next())
        {
                sb.append("<br><div style='width: 60%; padding: 10px ;border: .2em solid;margin-left:20%;' id=report>");
                sb.append("<table id='reporttable' style='z-index:5%' >");
                sb.append("<tr><td style='text-align:right;width:100%;height:20%;' colspan='2' ><font size='2' >QA-AR-Form 1<br>Frequency-Every Semester <br>Date-"+cdate+"<br></font></td><td></td></tr>");
                sb.append("<tr><td style='text-align:center;width:100%;height:20%;' colspan='2' ><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Academic (Research)<br>Summary of  Publications</u><br><br></font></td><td></td></tr>");
                sb.append("</table>");
               /* qry="select department from departmentmaster where departmentcode='0002'";
                rs=db.getRowset(qry);
                if(rs.next())
                {
                departmentinfo=rs.getString("department");
                }*/

                sb.append("<center><font size=2>Name of the Department: "+rs1.getString("department")+"</font></center><br><br>");
                sb.append("<center><font size=2><u>Publication Wise</u></font></center><br><br>");

                sb.append("<table width='100%' rules='all' border='2' border-color='black'>");
                sb.append("<tr><th align='left'><font size=2>S. No.</font></th><th align='left'><font size=2>Author(s)</font></th>" +
                        "<th align='left'><font size=2>Complete Reference </font></th><th align='left'><font size=2>Type of   publication*</font></th>" +
                        "<th align='left'><font size=2>Impact Factor JCR/ SJR</font></th><th align='left'><font size=2>Indexing body</font></th>" +
                        "<th align='left'><font size=2>H Index of Journal/Conference <br>proceeding (SJR: http://www.scimagojr.com )</font></th></tr>");

        while(rs2.next()){
            i++;
            sb.append("<tr><td align='right'><font size=2>" + i + "</font></td>");
            sb.append("<td align='left'><font size=2>" + rs2.getString("author") + "</font></td>");
            sb.append("<td align='left'><font size=2>" + rs2.getString("TITLE") + "</font></td>");
            sb.append("<td align='left'><font size=2>" +rs2.getString("typeofpublication")+ "</font></td>");
            sb.append("<td align='left'><font size=2>" + (rs2.getString("ImpactFactor").equals("J")?"JCR":"SJR") + "</font></td>");
            sb.append("<td align='left'><font size=2>" + rs2.getString("indexingbody")  + "</font></td>");
            sb.append("<td align='right'><font size=2>" + rs2.getString("hindex")+ "</td></font></tr>");
             }
            sb.append("</table>");
            sb.append("<font size=2><br><br><br>* International Journal,National Journal,International Conference,National Conference etc");
            sb.append("<br>(**) (i)Refereed Journals: 15/Publication,(ii)Non refereed Journal but having ISBN/ISSN number : 10/Publication (iii) Conference proceeding  as a full paper per publication:International Conference(IC) 10,National Conference(NC):08,Regional Conference/Local Conference(LC):06,International/National Conference-Presented but not published (PN):04,Only abstract(OA):02");
            sb.append("<br><br>(a) Augment above score as under:<br>&nbsp;(i) Paper published in indexed journals /conference by 05 points; (ii) paper with impact factor between 5 and 10 by 25 points.<br>(b)For Joint Publications,API points will be distributed as under:<br>First/Principal Author and Corresponding Author and Corresponding Author/Supervisor/Mentor would share equally 60% points and remaining 40% points would be shared equally by all other authors.<br>(b)Additional score of 10 may be awarded for delivering invited lecture in an Int..Conference.</font>");


            sb.append("<br><br><br><br><br><font size='2' >(Name and signature)<br><br></font>");
            sb.append("</div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");

        }else
        {
        sb.append("<center><font color='red' size='2'> There is no report for this criteria ,Please choose another</center>");
        }
                
    return sb.toString();

      }



      @GET
    @Path("faculty")
    @Produces(MediaType.APPLICATION_JSON)
    public String getfaculty(@QueryParam("company") String company,@QueryParam("department") String department) throws SQLException {
       qry="SELECT distinct a.employeeid, a.employeename, a.employeecode  FROM v#staff a," +
               " ap#arpublicationtrnauthor b where a.EMPLOYEEID=b.staffid and b.companyid='"+company+"'" +
               " and b.DEPARTMENTCODE='"+department+"' order by EMPLOYEENAME";
       sb.append("\"ALL\":\"ALL\",");
       rs = db.getRowset(qry);
        while (rs.next()) {
         sb.append("\"" + rs.getString("employeeid") + "\":\"" + rs.getString("employeename")+"-"+rs.getString("employeecode")+"\",");
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
     }

   @GET
    @Path("facultyreport")
   public String getFacultyreport(@QueryParam("company") String company,@QueryParam("institute") String institute,@QueryParam("publicyear") String publicyear,@QueryParam("faculty") String faculty,@QueryParam("department") String department) throws SQLException
      {
       String fromdate="",todate="",qry1="",qry2="",qry3="",qry4="",qryx="",departmentinfo="";
       ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rsx=null;
       int i=0,j=0,k=0,l=0,m=0,n=0,o=0,p=0,q=0,hindex=0,apiscore=0;
       String author="",completereference="",publicationtype="",impactfactor="",indexbody="",hIndex="",cdate="";

       
        qry="select to_char(sysdate,'dd-mm-yyyy') currentdate from dual ";
            rs=db.getRowset(qry);
            if(rs.next())
            {
            cdate=rs.getString("currentdate") ;
            }

        faculty= faculty.equals("ALL")?"":" and a.staffid='"+faculty.toUpperCase()+"'";

        qry1="SELECT distinct (SELECT employeename  FROM v#staff WHERE employeeid = a.staffid) facultyname,nvl(a.staffid,'') staffid," +
                "nvl(b.INDEXINGBODYID,'') INDEXINGBODYID,nvl(b.APPUBLICATIONTYPEID,'') APPUBLICATIONTYPEID " +
                " FROM ap#arpublicationtrnauthor a,ap#arpublicationtrn b where a.COMPANYid=b.COMPANYID and a.companyid=b.COMPANYID" +
                " and a.DEPARTMENTCODE='"+department+"' and b.PUBLICATIONYEAR='"+publicyear+"' and  b.companyid='"+company+"' "+faculty+" ";

        rs1=db.getRowset(qry1);
        rs2=db.getRowset(qry1);
        if(rs1.next())
                {
                sb.append("<br><div style='width: 70%; padding: 10px ;border: .2em solid;margin-left:15%;' id=report>");
                sb.append("<table id='reporttable' style='z-index:5%' >");
                sb.append("<tr><td style='text-align:right;width:100%;height:20%;' colspan='2' ><font size='2' >QA-AR-Form 1<br>Frequency-Every Semester <br>Date-"+cdate+"<br></font></td><td></td></tr>");
                sb.append("<tr><td style='text-align:center;width:100%;height:20%;' colspan='2' ><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Academic (Research)<br>Summary of  Publications</u><br><br></font></td><td></td></tr>");
                sb.append("</table>");
               qry="select department from departmentmaster where departmentcode='"+department+"'";
                rs=db.getRowset(qry);
                if(rs.next())
                {
                departmentinfo=rs.getString("department");
                }

                sb.append("<center><font size=2>Name of the Department: "+departmentinfo+"</font></center><br><br>");
                sb.append("<center><font size=2><u>Faculty Wise</u></font></center><br><br>");

                sb.append("<table width='100%' rules='all' border='2' border-color='black'>");
                sb.append("<tr><th align='left'><font size=2>S. No.</font></th><th align='left'><font size=2>Faculty Name</font></th>" +
                        "<th align='left'><font size=2>No. of <br>publications in Journals with IF/SCI,Scopus or DBLP indexed</font></th><th align='left'><font size=2>No. of publications<br>in journals having <br>ISSS/ISBN number <br>but not indexed</font></th>" +
                        "<th align='left'><font size=2>No. of publications in Indexed Conferences(Scopus/Web of Science/DBLP)</font></th><th align='left'><font size=2>No. of publications in<br> non indexed <br>conferences <br>whose Proceeding have ISBN/ISSN no.</font></th>" +
                        "<th align='left'><font size=2>No. of other <br>categories <br>publications </font></th><th align='left'><font size=2>H Index of<br>categories<br>publications </font></th><th align='left'><font size=2>API Score** </font></th></tr>");

        while(rs2.next()){
            i++;
            sb.append("<tr><td align='right'><font size=2>" + i + "</font></td>");
            sb.append("<td align='left' nowrap><font size=2>" + rs2.getString("facultyname") + "</font></td>");

         qry="select distinct 'Y' scopusordblp_indexed from ap#indexingbodymaster where INDEXINGBODYID='"+rs2.getString("INDEXINGBODYID")+"' and upper(INDEXINGBODYDESCRIPTION)='SCOPUS' or upper(INDEXINGBODYDESCRIPTION)='DBLP'";
         rs=db.getRowset(qry);
         while(rs.next())
         {
         if(rs.getString("scopusordblp_indexed").equals("Y"))
         {
         j++;
         }
         }
         sb.append("<td align='right'><font size=2>" + j+ "</font></td>");
        j=0;
        qry=" SELECT DISTINCT 'Y' notindex_having  FROM ap#indexingbodymaster a, ap#publicationmaster b " +
                " WHERE a.indexingbodyid = '"+rs2.getString("INDEXINGBODYID")+"' AND UPPER (a.indexingbodydescription) = UPPER('NOT INDEXED') " +
                " and (b.ISBNNO is not null or  b.ISSNNO is not null) and b.publicationid='"+rs2.getString("APPUBLICATIONTYPEID")+"' ";
         rs=db.getRowset(qry);
         while(rs.next())
         {
         if(rs.getString("notindex_having").equals("Y"))
         {
         k++;
         }
         }
     
         sb.append("<td align='right'><font size=2>" + k + "</font></td>");
         k=0;
          qry=" select distinct 'Y' scopus_webof from ap#indexingbodymaster " +
              " where INDEXINGBODYID='"+rs2.getString("INDEXINGBODYID")+"' and upper(INDEXINGBODYDESCRIPTION)='SCOPUS'" +
              " or upper(INDEXINGBODYDESCRIPTION)='DBLP' or upper(INDEXINGBODYDESCRIPTION)='WEB OF SCIENCE' ";
         rs=db.getRowset(qry);
         while(rs.next())
         {
         if(rs.getString("scopus_webof").equals("Y"))
         {
         l++;
         }
         }
         sb.append("<td align='right'><font size=2>" +l+ "</font></td>");
         l=0;
        qry=" SELECT DISTINCT 'Y' notindex_having  FROM ap#indexingbodymaster a, ap#publicationmaster b " +
                " WHERE a.indexingbodyid = '"+rs2.getString("INDEXINGBODYID")+"' AND UPPER (a.indexingbodydescription) = UPPER('NOT INDEXED') " +
                " and (b.ISBNNO =null or  b.ISSNNO = null) and b.publicationid='"+rs2.getString("APPUBLICATIONTYPEID")+"' ";
         rs=db.getRowset(qry);
         while(rs.next())
         {
         if(rs.getString("notindex_having").equals("Y"))
         {
         m++;
         }
         }
         sb.append("<td align='right'><font size=2>" + m + "</font></td>");
         m=0;
        qry=" select distinct 'Y' scopus_webofscience from ap#indexingbodymaster " +
              " where INDEXINGBODYID='"+rs2.getString("INDEXINGBODYID")+"' and upper(INDEXINGBODYDESCRIPTION)<>'SCOPUS'" +
              " or upper(INDEXINGBODYDESCRIPTION)<>'DBLP' or upper(INDEXINGBODYDESCRIPTION)<>'WEB OF SCIENCE' ";
         rs=db.getRowset(qry);
         while(rs.next())
         {
         if(rs.getString("scopus_webofscience").equals("Y"))
         {
         n++;
         }
         }
         sb.append("<td align='right'><font size=2>" +n+ "</font></td>");
         n=0;
        /*qry=" ";
         rs=db.getRowset(qry);
         while(rs.next())
         {
         if(rs.getString("scopus_webofscience_DBLP_indexed").equals("Y"))
         {
         n++;
         }
         }*/
        // sb.append("<td align='left'><font size=2>" +n+ "</font></td>");
        
         qry=" select sum(HINDEX) HINDEX,sum(apiscore) apiscore from ap#indexingbodydetail where indexingbodyid in " +
             "(SELECT b.indexingbodyid  FROM ap#arpublicationtrnauthor a,ap#arpublicationtrn b WHERE a.staffid = '"+rs2.getString("staffid")+"' and a.PUBLICATIONID=b.PUBLICATIONID and a.TRANSACTIONID=b.TRANSACTIONID) ";
           rs=db.getRowset(qry);
           if(rs.next())
           {
         hindex=Integer.parseInt(rs.getString("HINDEX"));
         apiscore=Integer.parseInt(rs.getString("apiscore"));
           }
         sb.append("<td align='right'><font size=2>" +hindex+ "</font></td>");
         sb.append("<td align='right'><font size=2>" + apiscore + "</font></td>");
         hindex=0;
         apiscore=0;
         /* sb.append("<td align='left'><font size=2>" + rs2.getString("indexingbody")  + "</font></td>");
            sb.append("<td align='right'><font size=2>" + rs2.getString("hindex")+ "</td></font></tr>");
            */ }
            sb.append("</table>");
            sb.append("<font size=2><br><br><br>* International Journal,National Journal,International Conference,National Conference etc");
            sb.append("<br>(**) (i)Refereed Journals: 15/Publication,(ii)Non refereed Journal but having ISBN/ISSN number : 10/Publication (iii) Conference proceeding  as a full paper per publication:International Conference(IC) 10,National Conference(NC):08,Regional Conference/Local Conference(LC):06,International/National Conference-Presented but not published (PN):04,Only abstract(OA):02");
            sb.append("<br><br>(a) Augment above score as under:<br>&nbsp;(i) Paper published in indexed journals /conference by 05 points; (ii) paper with impact factor between 5 and 10 by 25 points.<br>(b)For Joint Publications,API points will be distributed as under:<br>First/Principal Author and Corresponding Author and Corresponding Author/Supervisor/Mentor would share equally 60% points and remaining 40% points would be shared equally by all other authors.<br>(b)Additional score of 10 may be awarded for delivering invited lecture in an Int..Conference.</font>");


            sb.append("<br><br><br><br><br><font size='2' >(Name and signature)<br><br></font>");
            sb.append("</div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");

        }else
        {
        sb.append("<center><font color='red' size='2'> There is no report for this criteria ,Please choose another</center>");
        }

    return sb.toString();

      }




}
