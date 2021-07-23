/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Iqac.Form;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import tietwebkiosk.*;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
/**
 *
 * @author Gyanendra.Bhatt
 */

@Path("/IQACFormServices")
public class IQACFormServices {
  DBHandler db = new DBHandler();
  StringBuilder sb = new StringBuilder();
  String qry,qry1,qry2,qry3,qryy,TRANSDATE="",DataQry="";
  ResultSet rs = null,rs1=null,rs2=null,rs3=null,rsData=null;
  ObjectMapper mapper = new ObjectMapper();
  List list=new ArrayList();
  List ratingList1=new ArrayList();
  List ratingList2=new ArrayList();
  List ratingList3=new ArrayList();
  int d=0;
    @GET
    @Path("/feedback")
    @Produces(MediaType.APPLICATION_JSON)
    public String getFeedback() throws SQLException {
    Map hm  = new HashMap();
      String res = "";

        qry = "select  nvl(B.FEEDBACKID,' ') FEEDBACKID,nvl(B.FEEDBACKCODE,' ') FEEDBACKCODE," +
                " nvl(B.FEEDBACKDESC,' ')  FEEDBACKNAME  from AP#SHFEEDBACKMASTER b where FEEDBACKCODE='FC000011' and nvl(B.DEACTIVE,'N')='N'" +
                " ";
        rs = db.getRowset(qry);
        while (rs.next()) {
            hm.put(rs.getString("FEEDBACKID") , rs.getString("FEEDBACKCODE")+"-"+rs.getString("FEEDBACKNAME"));
           
        }
       try {
        res = mapper.writeValueAsString(hm);
      } catch (Exception e) {
          e.printStackTrace();
      }
        return res;
    }


  /*---------------------------Student Validation(Start)----------------------*/
    @GET
    @Path("/studentvalidation")
    @Produces(MediaType.APPLICATION_JSON)
    public String getstudentValid(@QueryParam("jdata") String jdata) throws SQLException, UnsupportedEncodingException {
      
        jdata = java.net.URLDecoder.decode(jdata, "UTF-8");
        //jdata=jdata.replace("opencurly","{");
       // jdata=jdata.replace("closecurly","}");
    List grid=new ArrayList();
    Map hm  = new HashMap();
    Map studdata  = new HashMap();
    ObjectMapper mapper = new ObjectMapper();
    try {
            grid = mapper.readValue(jdata, new TypeReference<ArrayList>() {});
        }catch(Exception e){
            e.printStackTrace();
        }

    String result="";
    String enroll="",dob="",res="";
   try{
       studdata=(HashMap)grid.get(0);
    
    qry= "select distinct 'Y' Y ,nvl(INSTITUTECODE||studentid,'') studidandins from studentmaster where enrollmentno='"+studdata.get("enroll")+"' and " +
        " TO_CHAR (dateofbirth, 'DDMMYYYY') =TO_CHAR (TO_DATE ('"+studdata.get("dob")+"', 'DD-MM-YYYY'), 'ddmmyyyy') ";
    rs2=db.getRowset(qry);
	if(!rs2.next()) {
		    hm.put("result","Invalid Combination of Date of Birth & Enrollment No. \n Or  You don't have permission to view this link.");
        }
    else
    {
             hm.put("result",rs2.getString("Y"));
             hm.put("studentid",rs2.getString("studidandins"));
    }
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
    try {
        res = mapper.writeValueAsString(hm);
      } catch (Exception e) {
          e.printStackTrace();
      }
        return res;
}



  /*-------------------------Student Validation(End)-------------------------*/
@GET
    @Path("/student")
    @Produces(MediaType.APPLICATION_JSON)
    public String getStudent(@QueryParam("studentid") String studentid) throws SQLException {
    Map hm  = new HashMap();
      String res = "";
         qry = "select nvl(S.STUDENTID,' ') STUDENTID,nvl(S.STUDENTNAME,' ') STUDENTNAME,nvl(S.ENROLLMENTNO,' ') ENROLLMENTNO" +
                "  from studentmaster s where studentid='"+studentid+"' " +
                " ";
        rs = db.getRowset(qry);
        while (rs.next()) {
            hm.put(rs.getString("STUDENTID") , rs.getString("ENROLLMENTNO")+"-"+rs.getString("STUDENTNAME"));
            //sb.append("\"" + rs.getString("COMPANYCODE") + "\":\"" + rs.getString("COMPANYNAME") + "\",");
        }
       try {
        res = mapper.writeValueAsString(hm);
      } catch (Exception e) {
          e.printStackTrace();
      }
        return res;
    }



    @GET
    @Path("/studAcaddetails")
    @Produces(MediaType.APPLICATION_JSON)
    public String getstudAcaddetails(@QueryParam("studentid") String student) throws SQLException {
    Map hm  = new HashMap();
  
    String res = "";
         qry =   " select nvl((select distinct a.programname from programmaster a where a.programcode=s.programcode and a.institutecode=s.institutecode),' ') programname, " +
                 " nvl(s.programcode,' ') programcode,nvl(s.academicyear,' ') academicyear,nvl(s.INSTITUTECODE,' ') institute, " +
                 " nvl(to_char(s.programcompletiondate,'YYYY'),' ') programcomdate,nvl(s.semester,'1') semester from  " +
                 " studenTMASTER s WHERE s.STUDENTID='"+student+"' ";
        rs = db.getRowset(qry);
        if (rs.next()) {
            hm.put("institute" , rs.getString("institute"));
            hm.put("programname" , rs.getString("programname"));
            hm.put("programcode",rs.getString("programcode"));
            hm.put("academicyear",rs.getString("academicyear"));
            hm.put("programcomdate",rs.getString("programcomdate"));
            hm.put("semester",rs.getString("semester"));
         }
        DataQry="SELECT distinct nvl(to_char(a.TRANSACTIONdate,'dd-mm-yyyy'),' ') transdate,NVL (a.apfeedbackfirstremarks, ' ') firstremarks,NVL (a.apfeedbacklastremarks, ' ') lastremarks" +
                ",nvl(APPASSINGYEAR,' ') passoutyear  FROM ap#parentfeedbackheader a,ap#parentfeedbackdetail b WHERE a.apstudentid = '"+student+"' and a.COMPANYID=b.COMPANYID" +
                " and a.instituteid=b.INSTITUTEID and a.transactionid=b.TRANSACTIONID";
         rsData=db.getRowset(DataQry);
         while(rsData.next())
         {
         hm.put("firstremarks",rsData.getString("firstremarks").trim());
         hm.put("lastremarks",rsData.getString("lastremarks").trim());
         hm.put("passoutyear",rsData.getString("passoutyear").trim());
         hm.put("transdate",rsData.getString("transdate").trim());

         }


       try {
        res = mapper.writeValueAsString(hm);
      } catch (Exception e) {
          e.printStackTrace();
      }
        return res;
    }

    @GET
    @Path("/QuesGridParent")
    @Produces(MediaType.APPLICATION_JSON)
    public String getQuesGridParent(@QueryParam("feedback") String feedback,@QueryParam("studentid") String studentid) throws SQLException {
    Map hm  = new HashMap();
      String res = "";
         qry =  " SELECT nvl(qh.HEADID,' ') HEADID,nvl(qh.PARENTHEADID,' ') PARENTHEADID,nvl(qh.SEQID,0) SEQID" +
                 " FROM AP#SHQUESTIONHEAD qh where qh.FEEDBACKID='"+feedback+"' and qh.Componenttype='R' " +
                 "order by qh.SEQID ";
        rs = db.getRowset(qry);
        while (rs.next()) {
         ratingList1=new ArrayList();
         ratingList2=new ArrayList();
         hm  = new HashMap();
         hm.put("headid",rs.getString("HEADID"));
         hm.put("parentheadid",rs.getString("PARENTHEADID"));
         hm.put("SEQID", rs.getString("SEQID"));

         qry1="select nvl(questionid,' ') questionid,nvl(questionbody,' ') questionbody,nvl(ratingid,' ') ratingid,nvl(MANDATORYQUESTION,'N')  mendatoryques  from AP#SHQUESTIONMASTER where" +
              " HEADID='"+rs.getString("HEADID")+"' and feedbackid='"+feedback+"' ";
         rs1=db.getRowset(qry1);
         if(rs1.next()){
           hm.put("questionid", rs1.getString("questionid"));
           hm.put("questionbody", rs1.getString("questionbody"));
           hm.put("ratingid", rs1.getString("ratingid"));
           hm.put("mendatoryques", rs1.getString("mendatoryques"));


         qry2=" select nvl(Ratingcode,' ') Ratingcode,nvl(subjective,' ') subjective from AP#SHRATINGMASTER where ratingid='"+rs1.getString("ratingid")+"' and feedbackid='"+feedback+"'";
         rs2=db.getRowset(qry2);
         if(rs2.next())
         {
         hm.put("ratingcode", rs2.getString(1));
         hm.put("subjective", rs2.getString(2));
        
         qry3="select distinct nvl(Rating,'') Rating,nvl(RatingDesc,' ') RatingDesc,nvl(ratingid,' ') Ratingid,nvl(SEQID,'1') SEQID from AP#SHRATINGDETAIL where ratingid='"+rs1.getString("ratingid")+"'  and feedbackid='"+feedback+"' order by SEQID DESC";
        rs3=db.getRowset(qry3);
        while(rs3.next())
        {
         ratingList1.add(rs3.getString(1));
         ratingList2.add(rs3.getString(2));
        ratingList3.add(rs3.getString(3));

         }
        hm.put("ratinglist1",ratingList1);
        hm.put("ratinglist2",ratingList2);
        hm.put("ratinglist3",ratingList3);
         }
        DataQry="SELECT NVL (a.apfeedbackfirstremarks, ' ') firstremarks,NVL (a.apfeedbacklastremarks, ' ') lastremarks," +
                "nvl(b.APFEEDBACKRATING,'') APFEEDBACKRATING,nvl(b.APFEEDBACKITEMREMARKS,' ') APFEEDBACKITEMREMARKS ,nvl(b.APFEEDBACKUSERREMARKS,' ') userremarks  FROM " +
                "ap#parentfeedbackheader a,ap#parentfeedbackdetail b WHERE a.apstudentid = '"+studentid+"' and b.APFEEDBACKITEMID='"+rs1.getString("questionid")+"' and a.COMPANYID=b.COMPANYID" +
                " and a.instituteid=b.INSTITUTEID and a.transactionid=b.TRANSACTIONID ";
         rsData=db.getRowset(DataQry);
         if(rsData.next())
         {
         hm.put("APFEEDBACKRATING",rsData.getString("APFEEDBACKRATING")==null?"":rsData.getString("APFEEDBACKRATING"));
         hm.put("APFEEDBACKITEMREMARKS",rsData.getString("APFEEDBACKITEMREMARKS")==null?"":rsData.getString("APFEEDBACKITEMREMARKS"));
         hm.put("userremarks",rsData.getString("userremarks")==null?"":rsData.getString("userremarks").toString().trim());

         }
 }
 list.add(hm);
 }
       try {
        res = mapper.writeValueAsString(list);
          // System.out.println(res);
       } catch (Exception e)
      {
          e.printStackTrace();
      }

        return res;
    }


    @PUT
    @Path("/saverecords")
    @Produces(MediaType.APPLICATION_JSON)
    public String saveGridData(@QueryParam("griddata") String g) throws SQLException, IOException {
      //  g=g.replaceAll("opencurly","{");
       // g=g.replaceAll("closecurly","}");
        g = java.net.URLDecoder.decode(g, "UTF-8");
        List grid  = new ArrayList();
        ObjectMapper mapper = new ObjectMapper();
          Map hm  = new HashMap();
     
        try {
            grid = mapper.readValue(g, new TypeReference<ArrayList>() {});
        }catch(Exception e){
            e.printStackTrace();
        }
      int i=0,l=0,h=0;
     Map griddata=new HashMap();
     Map commgriddata=new HashMap();
      String res ="",TRANSID="",msg="";
commgriddata=(HashMap)grid.get(0);
qryy="select nvl(TRANSACTIONID,' ') transid,nvl(to_char(TRANSACTIONDATE,'dd-mm-yyyy'),' ') transdate from AP#PARENTFEEDBACKHEADER where APFEEDBACKID='"+commgriddata.get("feedback")+"' and " +
        "APSTUDENTID='"+commgriddata.get("studentid")+"' and COMPANYID='"+commgriddata.get("institute")+"' and " +
        "INSTITUTEID='"+commgriddata.get("institute")+"'  ";
rs1=db.getRowset(qryy);
if(!rs1.next())
{

      qry=" select 'PARF'|| lpad(nvl(max(substr(TRANSACTIONID,5)),0)+1,6,0) TRANSID  from  AP#PARENTFEEDBACKHEADER  ";
		rs=db.getRowset(qry);
		if(rs.next())
			{
			TRANSID=rs.getString("TRANSID").trim();
			}
    

       

      qry =   "INSERT INTO AP#PARENTFEEDBACKHEADER (COMPANYID, INSTITUTEID, TRANSACTIONID, TRANSACTIONDATE, " +
              " APFEEDBACKID, APSTUDENTID, APACADEMICYEAR, APPASSINGYEAR, PROGRAMCODE, APSEMESTER, APFEEDBACKFIRSTREMARKS, " +
              " APFEEDBACKLASTREMARKS, ENTRYBY, ENTRYDATE) VALUES ( '"+commgriddata.get("institute")+"','"+commgriddata.get("institute")+"' ,'"+TRANSID+"' ,to_date('"+commgriddata.get("transdate")+"','dd-mm-yyyy'), " +
              "'"+commgriddata.get("feedback")+"','"+commgriddata.get("studentid")+"','"+commgriddata.get("acadyear")+"','"+commgriddata.get("yearofPass")+"', " +
              "'"+commgriddata.get("programcode")+"','"+commgriddata.get("semester")+"','"+commgriddata.get("firstyearremarks")+"'," +
              "'"+commgriddata.get("lastyearremarks")+"','"+commgriddata.get("studentid")+"',sysdate)";
         i= db.insertRow(qry);
       
      qry =""; 
        for(l=1;l<grid.size();l++){
            griddata=(HashMap)grid.get(l);
           if(griddata.get("ratingCombo")==null)
            {
            griddata.put("ratingCombo",0);
            }
            if(griddata.get("ratingtext")==null)
            {
            griddata.put("ratingtext","");
            }
            qry="INSERT INTO AP#PARENTFEEDBACKDETAIL (COMPANYID, INSTITUTEID, TRANSACTIONID,TRANSACTIONDATE, APFEEDBACKID, APFEEDBACKITEMID, " +
                "APFEEDBACKITEMREMARKS, APFEEDBACKRATINGID, APFEEDBACKRATING, APFEEDBACKUSERREMARKS, ENTRYBY, ENTRYDATE) " +
                "VALUES ('"+commgriddata.get("institute")+"' ,'"+commgriddata.get("institute")+"','"+TRANSID+"' ," +
                "to_date('"+commgriddata.get("transdate")+"','dd-mm-yyyy'),'"+commgriddata.get("feedback")+"','"+griddata.get("questid")+"' " +
                ",'"+griddata.get("itemRemarks")+"','"+griddata.get("ratingid")+"' ,'"+griddata.get("ratingCombo")+"' ,'"+griddata.get("ratingtext")+"' ," +
                " '"+commgriddata.get("studentid")+"',sysdate)";
     
         i= db.insertRow(qry);
        if(i>0)
        {
         h++;
        }
        }
}
else  
{
    TRANSID=rs1.getString("TRANSID").trim();
    TRANSDATE=rs1.getString("transdate").trim();
 for(l=1;l<grid.size();l++){
      griddata=(HashMap)grid.get(l);

       if(griddata.get("ratingCombo")==null)
            {
            griddata.put("ratingCombo",0);
            }
            if(griddata.get("ratingtext")==null)
            {
            griddata.put("ratingtext","");
            }
qry="UPDATE AP#PARENTFEEDBACKDETAIL SET APFEEDBACKITEMREMARKS = '"+griddata.get("itemRemarks")+"'," +
        "APFEEDBACKRATINGID = '"+griddata.get("ratingid")+"',APFEEDBACKUSERREMARKS='"+griddata.get("ratingtext")+"',APFEEDBACKRATING      ='"+griddata.get("ratingCombo")+"' , ENTRYDATE =sysdate WHERE  COMPANYID='"+commgriddata.get("institute")+"' AND " +
        "INSTITUTEID='"+commgriddata.get("institute")+"' AND TRANSACTIONID='"+TRANSID+"'   AND    APFEEDBACKID='"+commgriddata.get("feedback")+"'  AND    " +
        "APFEEDBACKITEMID ='"+griddata.get("questid")+"' and TRANSACTIONDATE=to_date('"+TRANSDATE+"','dd-mm-yyyy')";
//System.out.println(qry);
i=db.update(qry);
if(i>0)
        {
         h++;
        }
}
    qry="UPDATE AP#PARENTFEEDBACKHEADER SET APFEEDBACKFIRSTREMARKS = '"+commgriddata.get("firstyearremarks")+"'," +
          "APFEEDBACKLASTREMARKS  = '"+commgriddata.get("lastyearremarks")+"'," +
          "ENTRYDATE= sysdate WHERE  COMPANYID= '"+commgriddata.get("institute")+"' " +
          "AND INSTITUTEID= '"+commgriddata.get("institute")+"' AND    TRANSACTIONID = '"+TRANSID+"' AND " +
          "    APFEEDBACKID  = '"+commgriddata.get("feedback")+"' " +
         " and APSTUDENTID  = '"+commgriddata.get("studentid")+"' and TRANSACTIONDATE = to_date('"+commgriddata.get("transdate")+"','dd-mm-yyyy') ";
i=db.update(qry);


}
        if(h>0) {
      hm.put("msg","Record has been saved successfully ");
         }
       try {
        res = mapper.writeValueAsString(hm);
      } catch (Exception e) {
          e.printStackTrace();
      }
       return res;
}


   





}
