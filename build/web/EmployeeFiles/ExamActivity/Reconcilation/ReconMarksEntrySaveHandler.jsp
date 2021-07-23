<%@ page language="java" import="java.sql.*,tietwebkiosk.*,eba.gethandler.Record, eba.savehandler.SaveHandler"%>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<p>
<%
        DBHandler db = new DBHandler();

		  ResultSet rs = null, rs1=null, rs2=null,rs3=null,rs6=null,rs4=null;

		String qry = "",qry2="",qry1="",qry3="";
        String mMemberID="",mMemberType="",mMemberCode="",StudID="",Fstid="";
        String mDMemberType="",mDMemberID="";
        String mComp="UNIV", mSelf="", mIC="", mEC="", mSC="", mList="", mOrder="", mEvent="", mSE="";
		String mProrataEvent="";
        double mMaxmarks=0;

			double  	mDebarProrata=0,mTotWeig=0;
		double mSumMarksProrata=0;
		double mSProrataMarks=0,mSWeight=0,mProrataWeightage=0,mProrataTotalMarks=0;


/*
	  int mTotRec=0;
        if (session.getAttribute("TotRec")==null)
            mTotRec=0;
        else
            mTotRec=Integer.parseInt(session.getAttribute("TotRec").toString().trim());
*/
        if (session.getAttribute("MemberID")==null)
            mMemberID="";
        else
            mMemberID=session.getAttribute("MemberID").toString().trim();
        if (session.getAttribute("MemberType")==null)
            mMemberType="";
        else
            mMemberType=session.getAttribute("MemberType").toString().trim();
        if (session.getAttribute("MemberCode")==null)
            mMemberCode="";
        else
            mMemberCode=session.getAttribute("MemberCode").toString().trim();
        if(session.getAttribute("Click")!=null)
            mSelf=session.getAttribute("Click").toString().trim();
        else
            mSelf="";
        if(session.getAttribute("InstCode")!=null)
            mIC=session.getAttribute("InstCode").toString().trim();
        else
            mIC="";
        if(session.getAttribute("Exam")!=null)
            mEC=session.getAttribute("Exam").toString().trim();
        else
            mEC="";
        if(session.getAttribute("Subject")!=null)
            mSC=session.getAttribute("Subject").toString().trim();
        else
            mSC="";
        if(session.getAttribute("listorder")!=null)
            mList=session.getAttribute("listorder").toString().trim();
        else
            mList="EnrollNo";
        if(session.getAttribute("order")!=null)
            mOrder=session.getAttribute("order").toString().trim();
        else
            mOrder="";
        if(session.getAttribute("Event")!=null)
            mEvent=session.getAttribute("Event").toString().trim();
        else
            mEvent="";
        if(session.getAttribute("MAXMARKS")!=null)
            mMaxmarks=Double.parseDouble(session.getAttribute("MAXMARKS").toString().trim());
        else
            mMaxmarks=0;

	OLTEncryption enc=new OLTEncryption();
	mDMemberID=enc.decode(mMemberID);

        // Instanciate the eBusiness Applications' class 'SaveHandler'. This class is defined in ebaxmlconverter.jar
        SaveHandler mySaveHandler = new SaveHandler(request, out);

        // Begin by processing the inserts
        Record[] insertRecords = mySaveHandler.getUpdateRecords();
        String mMarks="", mDetained="N",mSMarks="";
	//	System.out.print(insertRecords.length+"insertRecords.length");
        for (int i = 0; i < insertRecords.length; i++)
        //for (int i = 0; i < mTotRec; i++)
        {
            mMarks=insertRecords[i].getField("Marks").toString().trim();

System.out.println(mMarks+" _______"+insertRecords[i].getField("studentid"));


            if(mMarks.equals(""))
            {
                mDetained="N";
                mMarks="";
                try
                {
                qry="Select 'Y' From StudentEventSubjectMarks Where FSTID='"+insertRecords[i].getField("fstid")+"' and EVENTSUBEVENT='"+mEvent+"' and STUDENTID='"+insertRecords[i].getField("studentid")+"'";
                //System.out.println(qry);
                rs=db.getRowset(qry);
                if(!rs.next())
                {
                qry = "Insert Into StudentEventSubjectMarks (FSTID, EVENTSUBEVENT, STUDENTID, MARKSAWARDED1, MARKSAWARDED2, DETAINED, LOCKED, ENTRYDATE, ENTRYBY, DEACTIVE, DETAINED2) VALUES (";
                qry += "'" + insertRecords[i].getField("fstid") + "',";
                qry += "'" + mEvent + "',";
                qry += "'" + insertRecords[i].getField("studentid") + "',";
                qry += "'" + mMarks + "',";
                qry += "'" + mMarks + "',";
                qry += "'" + mDetained + "',";
                qry += "'N',";
                qry += "sysdate,";
                qry += "'" + mDMemberID + "',";
                qry += "'N',";
                qry += "'" + mDetained + "'";
                qry += ") ";
                int Ins=db.insertRow(qry);
                //System.out.println("INSERT - "+qry);
                %><BR><%
                }
                else
                {
                qry="Update StudentEventSubjectMarks set MARKSAWARDED1='"+mMarks+"', MARKSAWARDED2='"+mMarks+"', DETAINED='"+mDetained+"', DETAINED2='"+mDetained+"' Where FSTID='"+insertRecords[i].getField("fstid")+"' and EVENTSUBEVENT='"+mEvent+"' and STUDENTID='"+insertRecords[i].getField("studentid")+"' and nvl( LOCKED,'N')<>'Y'";
                db.update(qry);
                int Upd=db.update(qry);
                //System.out.println("UPDATE - "+qry);%><BR><%
                }
                }
                catch(SQLException e)
                {
                    e.printStackTrace();
                    //System.out.print(e+" - Error");
                }
            }
			  else if(mMarks.equals("P"))
            {
                mDetained=mMarks;
                mMarks="";
                try
                {
                qry="Select 'Y' From StudentEventSubjectMarks Where FSTID='"+insertRecords[i].getField("fstid")+"' and EVENTSUBEVENT='"+mEvent+"' and STUDENTID='"+insertRecords[i].getField("studentid")+"'";
                //System.out.println(qry);
                rs=db.getRowset(qry);
                if(!rs.next())
                {
                qry = "Insert Into StudentEventSubjectMarks (FSTID, EVENTSUBEVENT, STUDENTID, MARKSAWARDED1, MARKSAWARDED2, DETAINED, LOCKED, ENTRYDATE, ENTRYBY, DEACTIVE, DETAINED2) VALUES (";
                qry += "'" + insertRecords[i].getField("fstid") + "',";
                qry += "'" + mEvent + "',";
                qry += "'" + insertRecords[i].getField("studentid") + "',";
                qry += "'" + mMarks + "',";
                qry += "'" + mMarks + "',";
                qry += "'" + mDetained + "',";
                qry += "'N',";
                qry += "sysdate,";
                qry += "'" + mDMemberID + "',";
                qry += "'N',";
                qry += "'" + mDetained + "'";
                qry += ") ";
                int Ins=db.insertRow(qry);
                //System.out.println("INSERT - "+qry);
                %><BR><%
                }
                else
                {
                qry="Update StudentEventSubjectMarks set MARKSAWARDED1='"+mMarks+"', MARKSAWARDED2='"+mMarks+"', DETAINED='"+mDetained+"', DETAINED2='"+mDetained+"' Where FSTID='"+insertRecords[i].getField("fstid")+"' and EVENTSUBEVENT='"+mEvent+"' and STUDENTID='"+insertRecords[i].getField("studentid")+"' and nvl( LOCKED,'N')<>'Y'";
                db.update(qry);
                int Upd=db.update(qry);
                //System.out.println("UPDATE - "+qry);%><BR><%
                }
                }
                catch(SQLException e)
                {
                    e.printStackTrace();
                    //System.out.print(e+" - Error");
                }
            }
            else if(mMarks.equals("A"))
            {
                mDetained=mMarks;
                mMarks="";
                try
                {
                qry="Select 'Y' From StudentEventSubjectMarks Where FSTID='"+insertRecords[i].getField("fstid")+"' and EVENTSUBEVENT='"+mEvent+"' and STUDENTID='"+insertRecords[i].getField("studentid")+"'";
                //System.out.println(qry);
                rs=db.getRowset(qry);
                if(!rs.next())
                {
                qry = "Insert Into StudentEventSubjectMarks (FSTID, EVENTSUBEVENT, STUDENTID, MARKSAWARDED1, MARKSAWARDED2, DETAINED, LOCKED, ENTRYDATE, ENTRYBY, DEACTIVE, DETAINED2) VALUES (";
                qry += "'" + insertRecords[i].getField("fstid") + "',";
                qry += "'" + mEvent + "',";
                qry += "'" + insertRecords[i].getField("studentid") + "',";
                qry += "'" + mMarks + "',";
                qry += "'" + mMarks + "',";
                qry += "'" + mDetained + "',";
                qry += "'N',";
                qry += "sysdate,";
                qry += "'" + mDMemberID + "',";
                qry += "'N',";
                qry += "'" + mDetained + "'";
                qry += ") ";
                int Ins=db.insertRow(qry);
                //System.out.println("INSERT - "+qry);
                %><BR><%
                }
                else
                {
                qry="Update StudentEventSubjectMarks set MARKSAWARDED1='"+mMarks+"', MARKSAWARDED2='"+mMarks+"', DETAINED='"+mDetained+"', DETAINED2='"+mDetained+"' Where FSTID='"+insertRecords[i].getField("fstid")+"' and EVENTSUBEVENT='"+mEvent+"' and STUDENTID='"+insertRecords[i].getField("studentid")+"' and nvl( LOCKED,'N')<>'Y'";
                db.update(qry);
                int Upd=db.update(qry);
                //System.out.println("UPDATE - "+qry);%><BR><%
                }
                }
                catch(SQLException e)
                {
                    e.printStackTrace();
                    //System.out.print(e+" - Error");
                }
            }
            else if(mMarks.equals("D"))
            {
                mDetained=mMarks;
                mMarks="";
                try
                {
                qry="Select 'Y' From StudentEventSubjectMarks Where FSTID='"+insertRecords[i].getField("fstid")+"' and EVENTSUBEVENT='"+mEvent+"' and STUDENTID='"+insertRecords[i].getField("studentid")+"'";
                //System.out.println(qry);
                rs=db.getRowset(qry);
                if(!rs.next())
                {
                qry = "Insert Into StudentEventSubjectMarks (FSTID, EVENTSUBEVENT, STUDENTID, MARKSAWARDED1, MARKSAWARDED2, DETAINED, LOCKED, ENTRYDATE, ENTRYBY, DEACTIVE, DETAINED2) VALUES (";
                qry += "'" + insertRecords[i].getField("fstid") + "',";
                qry += "'" + mEvent + "',";
                qry += "'" + insertRecords[i].getField("studentid") + "',";
                qry += "'" + mMarks + "',";
                qry += "'" + mMarks + "',";
                qry += "'" + mDetained + "',";
                qry += "'N',";
                qry += "sysdate,";
                qry += "'" + mDMemberID + "',";
                qry += "'N',";
                qry += "'" + mDetained + "'";
                qry += ") ";
                int Ins=db.insertRow(qry);
                //System.out.println("INSERT - "+qry);
                %><BR><%
                }
                else
                {
                qry="Update StudentEventSubjectMarks set MARKSAWARDED1='"+mMarks+"', MARKSAWARDED2='"+mMarks+"', DETAINED='"+mDetained+"', DETAINED2='"+mDetained+"' Where FSTID='"+insertRecords[i].getField("fstid")+"' and EVENTSUBEVENT='"+mEvent+"' and STUDENTID='"+insertRecords[i].getField("studentid")+"' and nvl( LOCKED,'N')<>'Y'";
                db.update(qry);
                int Upd=db.update(qry);
                //System.out.println("UPDATE - "+qry);%><BR><%
                }
                }
                catch(SQLException e)
                {
                    e.printStackTrace();
                    //System.out.print(e+" - Error");
                }
            }
else if(mMarks.equals("M"))
            {
                mDetained=mMarks;
                mMarks="";
                try
                {
                qry="Select 'Y' From StudentEventSubjectMarks Where FSTID='"+insertRecords[i].getField("fstid")+"' and EVENTSUBEVENT='"+mEvent+"' and STUDENTID='"+insertRecords[i].getField("studentid")+"'";
                //System.out.println(qry);
                rs=db.getRowset(qry);
                if(!rs.next())
                {
                qry = "Insert Into StudentEventSubjectMarks (FSTID, EVENTSUBEVENT, STUDENTID, MARKSAWARDED1, MARKSAWARDED2, DETAINED, LOCKED, ENTRYDATE, ENTRYBY, DEACTIVE, DETAINED2) VALUES (";
                qry += "'" + insertRecords[i].getField("fstid") + "',";
                qry += "'" + mEvent + "',";
                qry += "'" + insertRecords[i].getField("studentid") + "',";
                qry += "'" + mMarks + "',";
                qry += "'" + mMarks + "',";
                qry += "'" + mDetained + "',";
                qry += "'N',";
                qry += "sysdate,";
                qry += "'" + mDMemberID + "',";
                qry += "'N',";
                qry += "'" + mDetained + "'";
                qry += ") ";
                int Ins=db.insertRow(qry);
                //System.out.println("INSERT - "+qry);
                %><BR><%
                }
                else
                {
                qry="Update StudentEventSubjectMarks set MARKSAWARDED1='"+mMarks+"', MARKSAWARDED2='"+mMarks+"', DETAINED='"+mDetained+"', DETAINED2='"+mDetained+"' Where FSTID='"+insertRecords[i].getField("fstid")+"' and EVENTSUBEVENT='"+mEvent+"' and STUDENTID='"+insertRecords[i].getField("studentid")+"' and nvl( LOCKED,'N')<>'Y'";
                db.update(qry);
                int Upd=db.update(qry);
                //System.out.println("UPDATE - "+qry);%><BR><%
                }
                }
                catch(SQLException e)
                {
                    e.printStackTrace();
                    //System.out.print(e+" - Error");
                }
            }
			else if(mMarks.equals("U"))
            {



				mDetained=mMarks;
                mMarks="";
                try
                {
                qry="Select 'Y' From StudentEventSubjectMarks Where FSTID='"+insertRecords[i].getField("fstid")+"' and EVENTSUBEVENT='"+mEvent+"' and STUDENTID='"+insertRecords[i].getField("studentid")+"'";
                System.out.println(qry);
                rs=db.getRowset(qry);
                if(!rs.next())
                {
                qry = "Insert Into StudentEventSubjectMarks (FSTID, EVENTSUBEVENT, STUDENTID, MARKSAWARDED1, MARKSAWARDED2, DETAINED, LOCKED, ENTRYDATE, ENTRYBY, DEACTIVE, DETAINED2) VALUES (";
                qry += "'" + insertRecords[i].getField("fstid") + "',";
                qry += "'" + mEvent + "',";
                qry += "'" + insertRecords[i].getField("studentid") + "',";
                qry += "'" + mMarks + "',";
                qry += "'" + mMarks + "',";
                qry += "'" + mDetained + "',";
                qry += "'N',";
                qry += "sysdate,";
                qry += "'" + mDMemberID + "',";
                qry += "'N',";
                qry += "'" + mDetained + "'";
                qry += ") ";
                int Ins=db.insertRow(qry);
              System.out.println("INSERT - "+qry);
                %><BR><%
                }
                else
                {
                qry="Update StudentEventSubjectMarks set MARKSAWARDED1='"+mMarks+"', MARKSAWARDED2='"+mMarks+"', DETAINED='"+mDetained+"', DETAINED2='"+mDetained+"' Where FSTID='"+insertRecords[i].getField("fstid")+"' and EVENTSUBEVENT='"+mEvent+"' and STUDENTID='"+insertRecords[i].getField("studentid")+"' and nvl( LOCKED,'N')<>'Y'";
                db.update(qry);
                int Upd=db.update(qry);
          System.out.println("UPDATE - "+qry);%><BR><%
                }
                }
                catch(SQLException e)
                {
                    e.printStackTrace();
                    //System.out.print(e+" - Error");
                }
            }

            else if(Double.parseDouble(mMarks)>=0 && Double.parseDouble(mMarks)<=mMaxmarks)
            {
                mDetained="N";
                mMarks=mMarks;
                try
                {
                qry="Select 'Y' From StudentEventSubjectMarks Where FSTID='"+insertRecords[i].getField("fstid")+"' and EVENTSUBEVENT='"+mEvent+"' and STUDENTID='"+insertRecords[i].getField("studentid")+"'";
                //System.out.println(qry);
                rs=db.getRowset(qry);
                if(!rs.next())
                {
                qry = "Insert Into StudentEventSubjectMarks (FSTID, EVENTSUBEVENT, STUDENTID, MARKSAWARDED1, MARKSAWARDED2, DETAINED, LOCKED, ENTRYDATE, ENTRYBY, DEACTIVE, DETAINED2) VALUES (";
                qry += "'" + insertRecords[i].getField("fstid") + "',";
                qry += "'" + mEvent + "',";
                qry += "'" + insertRecords[i].getField("studentid") + "',";
                qry += "'" + mMarks + "',";
                qry += "'" + mMarks + "',";
                qry += "'" + mDetained + "',";
                qry += "'N',";
                qry += "sysdate,";
                qry += "'" + mDMemberID + "',";
                qry += "'N',";
                qry += "'" + mDetained + "'";
                qry += ") ";
                int Ins=db.insertRow(qry);
                //System.out.println("INSERT - "+qry);
                %><BR><%
                }
                else
                {
                qry="Update StudentEventSubjectMarks set MARKSAWARDED1='"+mMarks+"', MARKSAWARDED2='"+mMarks+"', DETAINED='"+mDetained+"', DETAINED2='"+mDetained+"' Where FSTID='"+insertRecords[i].getField("fstid")+"' and EVENTSUBEVENT='"+mEvent+"' and STUDENTID='"+insertRecords[i].getField("studentid")+"' and nvl( LOCKED,'N')<>'Y'";
                db.update(qry);
                int Upd=db.update(qry);
                //System.out.println("UPDATE - "+qry);%><BR><%
                }



			  }
                catch(SQLException e)
                {
                    e.printStackTrace();
                 //  System.out.print(e+" - Error");
                }


			}

            //System.out.println("After All Options");
        }





/*
       // Continue by processing our updates
        Record[] updateRecords = mySaveHandler.getUpdateRecords();
        for (int i = 0; i < updateRecords.length; i++)
        {
            qry = "UPDATE NitobiEmpMast ";
            qry += "SET ";
            qry += "BasicPay = '" + updateRecords[i].getField("BasicPay") + "' ";
            qry += " WHERE EmployeeID = '" + updateRecords[i].getField("EmployeeID") + "'";
            //System.out.println(qry);
            db.update(qry);
        }
*/
        mySaveHandler.writeToClient("UTF-8",out);
%>
</p>