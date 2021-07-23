<%@ page language="java" import="java.sql.*,jpalumni.*" %>


<%
        try {

            %>
            <html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>Counselling</title>
 <script language="JavaScript" type ="text/javascript">

        if(window.history.forward(1) != null)
            window.history.forward(1);
    </script>

    <meta http-equiv="Page-Enter" content="revealTrans(Duration=1.0,Transition=1)">

    <link href="../Resources/CSS/style.css" rel="stylesheet" type="text/css" />
   </head>
<BODY   rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0  >
<form>



    <%
            DBHandler db = new DBHandler();
            PublicDataFunction pb=new PublicDataFunction();
            
            ResultSet Rs = null;
            ResultSet rss = null;
            ResultSet rss1 = null;
            ResultSet rsa = null;
            ResultSet rs1 = null;
			 ResultSet rschk = null;
            int aa = 0;
            String qrys = "";
            String qrys1 = "";
            String qrya = "";
            String qry = "", str1 = "", qry1 = "";
            String mValue = "";
                     
            String mFName = "", mMName = "", mLName = "", mSex = "";
            String mDOB_DD = "", mDOB_MM = "", mDOB_YYYY = "";
            String mAIEEEROLL = "", mADDRESS1 = "", mADDRESS2 = "", mADDRESS3 = "", mCITY = "", mPIN = "";
            String mQYear = "", mCATEGORY = "", mFatherName = "", mMotherName = "";
            String mDISTRICT = "",   mSTDCODE = "", mPHONENO = "";
            String mMOBILE = "", mSTATE = "", mStateName = "", mNationality = "";
            String mDDAMT = "", mDDNO = "", mMOBILE11 = "";
            String mDD_DD = "", mBANK = "", mDD_MM = "", mDD_YYYY = "", mchkDeclare = "";
            String DOB = "", DDDate = "", mHOUSENO = "", mSTREET = "", mTEHSIL = "", mCSTATE = "", mPSTATE = "", mEMAIL = "", mHIMACHAL = "";

            String mCouns = "2009";
            String mAppID = "", mLoginID = "", mOTHERCAT = "", mAppIDSlno = "", mINST = "";
            String mAPPLID = "", mAPPLNO = "", mInst="";
            String mJIIT="",mJUIT="",qrychk="";

            int mFlag = 0, mUpFlag = 0;


            if (session.getAttribute("LoginID") == null) {
                mLoginID = "";
            } else {
                mLoginID = session.getAttribute("LoginID").toString().trim();
            }

if(request.getParameter("Institute")==null)
     mInst="";
else
     mInst=request.getParameter("Institute").toString().trim();
//out.print(mInst+"sasas");
%>
<input type="hidden" name="Institute" id="Institute" value="<%=mInst%>">
<%

         

            if (request.getParameter("FirstName") == null) {
                mFName = "";
            } else {
                mFName = request.getParameter("FirstName").toString().trim();
                mFName= pb.replaceSignleQuot(mFName);
            }


        

            if (request.getParameter("MiddleName") == null) {
                mMName = "";
            } else {
                mMName = request.getParameter("MiddleName").toString().trim();
                 mMName= pb.replaceSignleQuot(mMName);
            }
                

            if (request.getParameter("LastName") == null) {
                mLName = "";
            } else {
                mLName = request.getParameter("LastName").toString().trim();
                 mLName= pb.replaceSignleQuot(mLName);
            }

            if (request.getParameter("HOUSENO") == null) {
                mHOUSENO = "";
            } else {
                mHOUSENO = request.getParameter("HOUSENO").toString().trim();
                  mHOUSENO= pb.replaceSignleQuot(mHOUSENO);
            }

            if (request.getParameter("STREET") == null) {
                mSTREET = "";
            } else {
                mSTREET = request.getParameter("STREET").toString().trim();
                 mSTREET= pb.replaceSignleQuot(mSTREET);
            }

            if (request.getParameter("TEHSIL") == null) {
                mTEHSIL = "";
            } else {
                mTEHSIL = request.getParameter("TEHSIL").toString().trim();
                 mTEHSIL= pb.replaceSignleQuot(mTEHSIL);
            }

            if (request.getParameter("Gender") == null) {
                mSex = "";
            } else {
                mSex = request.getParameter("Gender").toString().trim();
                 
            }

            if (request.getParameter("DOB_DD") == null) {
                mDOB_DD = "";
            } else {
                mDOB_DD = request.getParameter("DOB_DD").toString().trim();

            }

            if (request.getParameter("DOB_MM") == null) {
                mDOB_MM = "";
            } else {
                mDOB_MM = request.getParameter("DOB_MM").toString().trim();
            }

            if (request.getParameter("DOB_YYYY") == null) {
                mDOB_YYYY = "";
            } else {
                mDOB_YYYY = request.getParameter("DOB_YYYY").toString().trim();
            }


            if (request.getParameter("QYear") == null) {
                mQYear = "";
            } else {
                mQYear = request.getParameter("QYear").toString().trim();
            }

            if (request.getParameter("Category") == null) {
                mCATEGORY = "";
            } else {
                mCATEGORY = request.getParameter("Category").toString().trim();
                 mCATEGORY= pb.replaceSignleQuot(mCATEGORY);
            }

            if (request.getParameter("FatherName") == null) {
                mFatherName = "";
            } else {
                mFatherName = request.getParameter("FatherName").toString().trim();
                 mFatherName= pb.replaceSignleQuot(mFatherName);
            }
            if (request.getParameter("MotherName") == null) {
                mMotherName = "";
            } else {
                mMotherName = request.getParameter("MotherName").toString().trim();
                 mMotherName= pb.replaceSignleQuot(mMotherName);
            }
            if (request.getParameter("AIEEEROLL") == null) {
                mAIEEEROLL = "";
            } else {
                mAIEEEROLL = request.getParameter("AIEEEROLL").toString().trim();
                 mAIEEEROLL= pb.replaceSignleQuot(mAIEEEROLL);
            }
            
            if (request.getParameter("CITY") == null) {
                mCITY = "";
            } else {
                mCITY = request.getParameter("CITY").toString().trim();
                 mCITY= pb.replaceSignleQuot(mCITY);
            }

            if (request.getParameter("PIN") == null) {
                mPIN = "";
            } else {
                mPIN = request.getParameter("PIN").toString().trim();
            }

            if (request.getParameter("DISTRICT") == null) {
                mDISTRICT = "";
            } else {
                mDISTRICT = request.getParameter("DISTRICT").toString().trim();
                 mDISTRICT= pb.replaceSignleQuot(mDISTRICT);
            }

           
            
         
            if (request.getParameter("STDCODE") == null) {
                mSTDCODE = "";
            } else {
                mSTDCODE = request.getParameter("STDCODE").toString().trim();
            }
            if (request.getParameter("PHONENO") == null) {
                mPHONENO = "";
            } else {
                mPHONENO = request.getParameter("PHONENO").toString().trim();
                  mPHONENO= pb.replaceSignleQuot(mPHONENO);
            }
            if (request.getParameter("MOBILENO") == null) {
                mMOBILE = "";
            } else {
                mMOBILE = request.getParameter("MOBILENO").toString().trim();
                  mMOBILE= pb.replaceSignleQuot(mMOBILE);
            }


            if (request.getParameter("CSTATE") == null) {
                mCSTATE = "";
            } else {
                mCSTATE = request.getParameter("CSTATE").toString().trim();
            }

            if (request.getParameter("PSTATE") == null) {
                mPSTATE = "";
            } else {
                mPSTATE = request.getParameter("PSTATE").toString().trim();
            }




            if (request.getParameter("HIMACHAL") == null) {
                mHIMACHAL = "N";
            } else {
                mHIMACHAL = request.getParameter("HIMACHAL").toString().trim();
            }
			
			if(mHIMACHAL.equals("Y"))
			{
				mOTHERCAT="HP";
			}
			else
			{
				mOTHERCAT="";
			}





            if (request.getParameter("EMAIL") == null) {
                mEMAIL = "";
            } else {
                mEMAIL = request.getParameter("EMAIL").toString().trim();
                  mEMAIL= pb.replaceSignleQuot(mEMAIL);
            }

            if (request.getParameter("APPNO") == null) {
                mAPPLNO = "";
            } else {
                mAPPLNO = request.getParameter("APPNO").toString().trim();
            }

        

            if (request.getParameter("APPID") == null) {
                mAppID = "";
            } else {
                mAppID = request.getParameter("APPID").toString().trim();
            }



            DOB = mDOB_DD + "-" + mDOB_MM + "-" + mDOB_YYYY;


//----------------
            String my = mDOB_YYYY;
            String mM = mDOB_MM;
            String mD = mDOB_DD;
            int mMaxday = 0;

            if (mM.equals("04") || mM.equals("06") || mM.equals("09") || mM.equals("11")) {
                mMaxday = 30;
            } else if (mM.equals("01") || mM.equals("03") || mM.equals("05") || mM.equals("07") || mM.equals("08") || mM.equals("10") || mM.equals("12")) {
                mMaxday = 31;
            } else if (Integer.parseInt(my) % 4 == 0 && mM.equals("02")) {
                mMaxday = 29;
            } else {
                mMaxday = 28;
            }




            if (Integer.parseInt(mD) <= mMaxday) {
                //--------------------
                if (!mFName.equals("") && !mAIEEEROLL.equals("") && !mHOUSENO.equals("") && !mCITY.equals("") && !mDISTRICT.equals(""))
                {

                    String mStr = mDOB_YYYY + mDOB_MM + mDOB_DD;

                    if (Long.parseLong(mStr) >= 19881001) 
						
					{

                        

                         if(mInst.equals("J"))
                              {
                                mJIIT = "Y";
                                mJUIT= "N";
                               }
                            else if(mInst.equals("E"))
                            {
                                mJUIT= "Y";
                                mJIIT = "N";
                            }
                            else if(mInst.equals("B"))
                            {
                                mJIIT = "Y";
                                mJUIT= "Y";
                            }
                 
                      
                        String mOut = "", mAppNo = "", mPrefix = "";

                            
                 /* qrychk="select 'Y' from C#APPLICATIONMASTERDETAIL where APPLICATIONID ='"+mAppID+"' and COUNSELLINGID= '" + mCouns + "' and  ROLLNOOFAIEEE='" + mAIEEEROLL + "' ";
				rschk=db.getRowset(qrychk);
				if(!rschk.next())
				{*/      


                        qrys = "select 'Y' from C#APPLICATIONMASTER where COUNSELLINGID='" + mCouns + "' ";
                        qrys = qrys + " and APPLICATIONID='" + mAppID + "'";
                        rss = db.getRowset(qrys);
                       // out.print(qrys + "qryqrqy");


                        if (!rss.next()) {
                            //---1
                           
                                                 
                             qry1="UPDATE C#ONLINEAPPLICATIONDETAIL SET APPLYINJIIT = '"+mJIIT+"' ," +
                                "APPLYINJUITJIET = '"+mJUIT+"' WHERE  LOGINID = '" + mLoginID + "' ";
                              //out.print(qry1);

                              int g = db.update(qry1);
                                if(g>0)
                                {
                                    mFlag = 1;
                                }
                                else
                                {
                                mFlag = 2;
                                }

                    

                         //Procedure GetAppNO(pCounsID Varchar2 , pPrefix Varchar2 , mOut out Varchar2)

                            mAppNo = "TEMP";
                            mAppID = db.GetAppID(mCouns, mOut);
                            //  out.print(mAppID + "mAppID");
                            qry = "INSERT INTO C#APPLICATIONMASTER (COUNSELLINGID,APPLICATIONID, APPLICATIONNO, FIRSTNAME,MIDDLENAME, LASTNAME, FATHERNAME," +
                                    " MOTHERNAME, HOUSEBDLGNO, STREETAREA,VILLAGECITY, POLICESTATION, DISTRICT,CSTATECODE, PSTATECODE, PIN," +
                                    " RAILSTATION, STDCODE, PHONENO, MOBILENO, EMAIL, INDIAN, SEX, DATEOFBIRTH, YEAROFQUALIFYINGEXAM," +
                                    " QUALIFIEDEXAMFROMHP, CATEGORYCODE, OTHERCATEGORY, ENTRYBY, ENTRYDATE, MODIFIEDBY, MODIFIEDDATE, " +
                                    " DEACTIVE)VALUES( '" + mCouns + "','" + mAppID + "','" + mAppNo + "' ,'" + mFName + "' ,'" + mMName + "' ,'" + mLName + "' , '" + mFatherName + "','" + mMotherName + "', " +
                                    " '" + mHOUSENO + "','" + mSTREET + "' ,'" + mCITY + "' ,'" + mTEHSIL + "','" + mDISTRICT + "' , '" + mCSTATE + "','" + mPSTATE + "' ,'" + mPIN + "' ," +
                                    " null ,'" + mSTDCODE + "','" + mPHONENO + "' ,'" + mMOBILE + "' ,'" + mEMAIL + "', 'Y' ,'" + mSex + "' ,to_date('" + DOB + "','dd-mm-yyyy') ," +
                                    " '" + mQYear + "' ,'" + mHIMACHAL + "' ,'" + mCATEGORY + "' ,'" + mOTHERCAT + "'  ,'USER' ,Sysdate ,NULL ,NULL ,'N')";


                            int n = db.insertRow(qry);
                            if (n > 0) {
                                
                                         qry1="UPDATE C#ONLINEAPPLICATIONDETAIL SET applicationid= '"+mAppID+"'  WHERE  LOGINID = '" + mLoginID + "' ";
                                         int x=db.update(qry1);
                         //out.print(qry1);




                                mFlag = 1;
                            } else {
                                 mFlag = 2;
                            }
                            // ---- AppMasterDetail
                             qry1 = "delete   FROM C#APPLICATIONMASTERDETAIL WHERE" +
                                "  COUNSELLINGID='" + mCouns + "'  AND APPLICATIONID='" + mAppID + "' and NVL(ONLINECONFIRMATION,'N') ='N' ";
                        //out.print(qry);
                               int g1 = db.update(qry1);
							
							    if (mInst.equals("B") || mInst.equals("J")  )
                                {

                                    
                                    String qryi = "INSERT INTO C#APPLICATIONMASTERDETAIL (COUNSELLINGID, APPLICATIONID, " +
                                            " APPLICATIONSLNO, APPLIEDINSTITUTECODE, SUBJECTINAIEEE, ROLLNOOFAIEEE, RANKINAIEEE, " +
                                            " RANKINJIIT, REJECTED, REMARK, ONLINECONFIRMATION, WRONGAIEEEROLL, PHOTOFORMRECVD, PERMIT," +
                                            " ENTRYBY, ENTRYDATE)  VALUES ('" + mCouns + "','" + mAppID + "',null,'JIIT' , null," +
                                            " '" + mAIEEEROLL + "', null ,null ,  null , null , null , null , null, null ,'USER',sysdate )";
                                    //   out.print(qryi);
                                    int m = db.insertRow(qryi);

                                    if (m > 0 ) {
                                        mFlag = 1;

                                    } else {
                                        mFlag = 2;
                                    }
                                }
                            if (mInst.equals("B") ||mInst.equals("E")   ) {
                                    String qryj = "INSERT INTO C#APPLICATIONMASTERDETAIL (COUNSELLINGID, APPLICATIONID, " +
                                            " APPLICATIONSLNO, APPLIEDINSTITUTECODE, SUBJECTINAIEEE, ROLLNOOFAIEEE, RANKINAIEEE, " +
                                            " RANKINJIIT, REJECTED, REMARK, ONLINECONFIRMATION, WRONGAIEEEROLL, PHOTOFORMRECVD, PERMIT," +
                                            " ENTRYBY, ENTRYDATE)  VALUES ('" + mCouns + "','" + mAppID + "',null,'JUIT' , null," +
                                            " '" + mAIEEEROLL + "', null ,null ,  null , null , null , null , null, null ,'USER',sysdate )";
                                    //   out.print(qryi);
                                    int j = db.insertRow(qryj);
                                    if (j > 0) {
                                        mFlag = 1;
                                    } else {
                                        mFlag = 2;
                                    }
                                } 
						
                               

                            } 

                       


                        else
                        {//--------------------update page --------------------
                                  

                                   qry1="UPDATE C#ONLINEAPPLICATIONDETAIL SET APPLYINJIIT = '"+mJIIT+"' ," +
                                   "APPLYINJUITJIET = '"+mJUIT+"' WHERE  LOGINID = '" + mLoginID + "' ";
                                  // out.print(qry1);
                                   int g = db.update(qry1);
                                    if(g>0)
                                      {
                                         mUpFlag = 1;
                                      }
                                      else
                                      {
                                       mUpFlag = 2;
                                      }
                              
                                       
                            qry = "UPDATE C#APPLICATIONMASTER SET  " +
                                    " FIRSTNAME = '" + mFName + "', " +
                                    "MIDDLENAME= '" + mMName + "' , " +
                                    "  LASTNAME   ='" + mLName + "'," +
                                    " FATHERNAME = '" + mFatherName + "' ," +
                                    "  MOTHERNAME    ='" + mMotherName + "' ," +
                                    "   HOUSEBDLGNO  = '" + mHOUSENO + "' ," +
                                    "   STREETAREA    ='" + mSTREET + "' ," +
                                    "   VILLAGECITY   ='" + mCITY + "' ," +
                                    "  POLICESTATION   = '" + mTEHSIL + "' ," +
                                    "    DISTRICT     = '" + mDISTRICT + "'," +
                                    "    CSTATECODE       = '" + mCSTATE + "'," +
                                    "   PSTATECODE      = '" + mPSTATE + "'," +
                                    "    PIN          = '" + mPIN + "' ," +
                                    "   STDCODE          = '" + mSTDCODE + "'," +
                                    "  PHONENO    = '" + mPHONENO + "' ," +
                                    "   MOBILENO     = '" + mMOBILE + "' ," +
                                    "   EMAIL     = '" + mEMAIL + "',INDIAN='Y' , " +
                                    "   SEX     = '" + mSex + "' ," +
                                    "   DATEOFBIRTH          = to_date('" + DOB + "','dd-mm-yyyy')," +
                                    "   YEAROFQUALIFYINGEXAM = '" + mQYear + "' ," +
                                    "    QUALIFIEDEXAMFROMHP  = '" + mHIMACHAL + "' ," +
                                    "  CATEGORYCODE         = '" + mCATEGORY + "'," +
                                    "   OTHERCATEGORY        = '" + mOTHERCAT + "' ," +
                                    " MODIFIEDBY           = 'USER' ," +
                                    "  MODIFIEDDATE         = sysdate " +
                                    " WHERE  COUNSELLINGID        =  '" + mCouns + "' " +
                                    "AND    APPLICATIONID        = '" + mAppID + "' and APPLICATIONNO='" + mAPPLNO + "'";
                            //  out.print(qry);
                            int u = db.update(qry);
                            if (u > 0) 
							{
                                     qry1 = "delete   FROM C#APPLICATIONMASTERDETAIL WHERE" +
                                "  COUNSELLINGID='" + mCouns + "'  AND APPLICATIONID='" + mAppID + "' and NVL(ONLINECONFIRMATION,'N') ='N' ";
                                    //out.print(qry);
                               int g1 = db.update(qry1);

							    if (mInst.equals("B") || mInst.equals("J")  )
                                {


                                    String qryi = "INSERT INTO C#APPLICATIONMASTERDETAIL (COUNSELLINGID, APPLICATIONID, " +
                                            " APPLICATIONSLNO, APPLIEDINSTITUTECODE, SUBJECTINAIEEE, ROLLNOOFAIEEE, RANKINAIEEE, " +
                                            " RANKINJIIT, REJECTED, REMARK, ONLINECONFIRMATION, WRONGAIEEEROLL, PHOTOFORMRECVD, PERMIT," +
                                            " ENTRYBY, ENTRYDATE)  VALUES ('" + mCouns + "','" + mAppID + "',null,'JIIT' , null," +
                                            " '" + mAIEEEROLL + "', null ,null ,  null , null , null , null , null, null ,'USER',sysdate )";
                                     //  out.print(qryi);
                                    int m = db.insertRow(qryi);

                                    if (m > 0 ) {
                                        mFlag = 1;

                                    } else {
                                        mFlag = 2;
                                    }
                                }
                            if (mInst.equals("B") ||mInst.equals("E")   ) {
                                    String qryj = "INSERT INTO C#APPLICATIONMASTERDETAIL (COUNSELLINGID, APPLICATIONID, " +
                                            " APPLICATIONSLNO, APPLIEDINSTITUTECODE, SUBJECTINAIEEE, ROLLNOOFAIEEE, RANKINAIEEE, " +
                                            " RANKINJIIT, REJECTED, REMARK, ONLINECONFIRMATION, WRONGAIEEEROLL, PHOTOFORMRECVD, PERMIT," +
                                            " ENTRYBY, ENTRYDATE)  VALUES ('" + mCouns + "','" + mAppID + "',null,'JUIT' , null," +
                                            " '" + mAIEEEROLL + "', null ,null ,  null , null , null , null , null, null ,'USER',sysdate )";
                                       //out.print(qryj);
                                    int j = db.insertRow(qryj);
                                    if (j > 0) {
                                        mFlag = 1;
                                    } else {
                                        mFlag = 2;
                                    }
                                }
							/*}
						else
							{
								out.print("<font color=red size=3><b>AIEEE Roll Number Already Exists ..</b></font>");
							}*/

                                /*if (mFlag == 1) {
                                    session.setAttribute("APPLICATIONID", mAppID);
                                    session.setAttribute("LoginID", mLoginID);
                                   response.sendRedirect("PaymentMode.jsp?Institute="+mInst+" ");
                                     //out.print("<font color=GREEN size=3><b>Record Update !</b></font>");
                                } else {
                                    out.print("<font color=red size=3><b>Error while updating record..</b></font>");
                                }*/


                            } else {
                                out.print("<font color=red size=3><b>Error while updating record..</b></font>");
                            }


                        }

						 if (mFlag == 1) {
                                    session.setAttribute("APPLICATIONID", mAppID);
                                    session.setAttribute("LoginID", mLoginID);
                                    
                                   response.sendRedirect("PaymentMode.jsp?Institute="+mInst+" ");
                                    out.print("<font color=Green size=3><b>Rercord Saved Sucessfully</b></font>");
                                } else if (mFlag == 2) {
                                    out.print("<font color=red size=3><b>Error while saving record..</b></font>");
                                }

                    } else {
                        out.print("<font color=red size=3><b>Please enter correct Date of Birth!</b></font>");
                    }                      // closing of --1

                } else {
                    out.print("<font color=red size=3><b>Kindly fill all the mandatory items..</b><br></font>");
                }

            } else {
                out.print("<font color=red size=3><b>Please enter correct Date of Birth!</b></font>");
            }

%>



</form>


</body>
</html>
<%

                                  } catch (Exception e) {
            //out.print(e);
        }

%>