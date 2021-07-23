<%
//System.out.print("*****#####***********");
//// Masscut changes  26.10.2018
//mDebarStudID="";
String  xx="";
double tempMarksAwarded2=0;
ktm++;
qry2="select distinct a.LTP LTP , a.institutecode,a.fstid fstid,a.ExamCode,nvl(a.Semester,0)Semester,a.semestertype,a.subjectID, b.studentid studentid,";
qry2=qry2+" b.enrollmentno, NVL ( (CEIL (SUM ( (d.marksawarded2 / e.maxmarks) * e.weightage))), 0) marksawarded2, b.studentname, NVL (SUM (e.weightage), 0) weightage";
 // to remove TA exam from previous exam 22-10-2019---start
//qry2=qry2+" ,(select NVL (CEIL (SUM ((y.marksawarded2 / z.maxmarks) * z.weightage)),0)||'-'||nvl(SUM (z.weightage), 0)  ||'='||nvl(SUM (v.MASSCUTS)/count(*), 0) ";
//qry2=qry2+" from facultysubjecttagging x ,studenteventsubjectmarks y, exameventsubjecttagging z ,studentgrademasscuts v where  x.fstid = y.fstid ";
//qry2=qry2+" and x.fstid = z.fstid AND y.eventsubevent = z.eventsubevent and x.INSTITUTECODE = '"+mInst+"' And x.examcode = '"+mPREVEXAMCODE+"' and";
//qry2=qry2+" y.eventsubevent like '%TA%' AND x.subjectid = a.subjectid And y.studentid = b.studentid  AND y.studentid = v.studentid AND v.fstid = x.fstid  ) TAMarks                                             ";
 // to remove TA exam from previous exam 22-10-2019---end
qry2=qry2+" FROM facultysubjecttagging a,  studentmaster b ,studenteventsubjectmarks d, exameventsubjecttagging e  where  ";
qry2=qry2+"  a.fstid = d.fstid  and a.fstid = e.fstid  AND d.eventsubevent = e.eventsubevent AND d.studentid = b.studentid and a.fstid in("+mCheckFstid+") and b.studentid not in (select studentid from debarstudentdetail where examcode='"+mExamCode+"' and  nvl(MEDICALWITHDRAWAL,'N')='Y' AND fstid IN ( "+mCheckFstid+" )) ";
//qry2=qry2+" and (('"+mETOD+"'='N' and a.semestertype<>(select semestertype from semestertype where institutecode='"+mInst+"' ";
//qry2=qry2+" and nvl(ETOD,'N')='Y'))  or ('"+mETOD+"'='E' and a.semestertype<>(select semestertype from semestertype where ";
//qry2=qry2+" institutecode='"+mInst+"' and  nvl(ETOD,'N')='Y'))) ";
qry2=qry2+" and a.examcode='"+mExamCode+"' ";
qry2=qry2+" and a.subjectID='"+mSubjectCode+"'  and nvl(a.DEACTIVE,'N')='N' and nvl(b.DEACTIVE,'N')='N' ";
qry2=qry2+" group by a.LTP,a.institutecode,a.fstid,a.ExamCode,a.Semester,a.semestertype,A.SUBJECTID,b.studentid, ";
qry2=qry2+" b.enrollmentno,b.studentname ";
rs2=db.getRowset(qry2);
System.out.println(ktm+"AAA"+qry2);
while(rs2.next())
{

ctim++;

//System.out.print("**********************************( Mohit )**********************************************");

//System.out.println(StudentGradeCalculationMarks+"====="+GradeMasterLowerLimit+"====="+mPrevValueNew);


// if(!mDebarStudID.equals(rs2.getString("studentid")) )
//	{

		ctr=ctr++;




//out.print("*3333*");
mMarksawarded2=rs2.getDouble("marksawarded2");
mFst=rs2.getString("fstid");
mDebarWeight=rs2.getString("weightage");


//--------------------------------- Medical Case Date 24.03.2018 10:45:56 -----------------------------------------------------------------

String firqry="select *from DEBARSTUDENTDETAIL   where INSTITUTECODE = '"+mInst+"' and MEDICALCASE='Y' And examcode = '"+mPREVEXAMCODE+"' and studentid = '"+rs2.getString("studentid")+"' AND    subjectid = '"+mSubjectCode+"' ";
ResultSet rsa=db.getRowset(firqry);
//System.out.println(qry3);

Double mprvMaks=0.0,mprvWEIGHTAGE=0.0,mEndTermWeightage=0.0;
String mprvEVENTSUBEVENT="";

if(rsa.next())
{
    String secqry="Select y.EVENTSUBEVENT ,NVL (CEIL ((y.marksawarded2 / z.maxmarks) * z.weightage),0) marks ,nvl(z.weightage, 0) weightage" +
    "   from facultysubjecttagging x ,studenteventsubjectmarks y,  exameventsubjecttagging z  where  x.fstid = y.fstid    and x.fstid = z.fstid" +
            "   AND y.eventsubevent = z.eventsubevent  and x.INSTITUTECODE = '"+mInst+"'  And x.examcode = '"+mPREVEXAMCODE+"' and      " +
            //"   y.eventsubevent not like '%TA%' AND "; // to remove TA exam from previous exam 22-10-2019
            "   x.subjectid = '"+mSubjectCode+"' And         y.studentid = '"+rs2.getString("studentid")+"'";
    ResultSet rsa2=db.getRowset(secqry);
    while(rsa2.next()){

        mprvEVENTSUBEVENT=rsa2.getString("EVENTSUBEVENT");
        if(mprvEVENTSUBEVENT.equalsIgnoreCase("ENDTERM")){
        mEndTermWeightage=rsa2.getDouble("WEIGHTAGE");
        }else{
        mprvMaks=rsa2.getDouble("MARKS")+mprvMaks;
        mprvWEIGHTAGE=rsa2.getDouble("WEIGHTAGE")+mprvWEIGHTAGE;
        }

    }// closing of while

    mMarksawarded2 =(Math.ceil((mMarksawarded2/rs2.getDouble("weightage"))*mEndTermWeightage))+mprvMaks;

}
tempMarksAwarded2=mMarksawarded2;

//----------------------------------------End of Medical Case ------------------------------------------------------------------------------------
 // to remove TA exam from previous exam 22-10-2019--start
/*
TMKS=rs2.getString("TAMARKS");

int fpos=TMKS.indexOf("-");
int spos=TMKS.indexOf("=");
int lenght=TMKS.length();


String fmks=TMKS.substring(0,fpos);
String smks=TMKS.substring(fpos+1,spos);
String tmks=TMKS.substring(spos+1,lenght);


Double thiredmks;


if(fmks!=null && smks!=null ){

  Double firstmks=Double.valueOf(fmks);
     if(tmks!=null && !tmks.equalsIgnoreCase("")){
     thiredmks=Double.valueOf(tmks);
     }else{
     thiredmks=0.0;
     }


    mMarksawarded2=mMarksawarded2+firstmks-thiredmks;

    mMassCut=thiredmks;

    //out.print("mMarksawarded2 "+mMarksawarded2+"firstmks "+firstmks+"thiredmks "+thiredmks);


    //mMarksawarded2=mMarksawarded2-thiredmks;


    Integer secmks=Integer.valueOf(smks);
    secmks=Integer.valueOf(mDebarWeight)+secmks;

    mDebarWeight=String.valueOf(secmks);


   // out.print("--"+mMarksawarded2+"="+mDebarWeight);
}*/

 // to remove TA exam from previous exam 22-10-2019--end


//out.print("*44*");
/*

			else
			//if(1==1)
	{*/

/*
qry3="select nvl(Detained,'N')Detained  from V#STUDENTEVENTSUBJECTMARKS where institutecode='"+mInst+"' ";
qry3=qry3+" and examcode='"+mExamCode+"' and subjectID='"+mSubjectCode+"' and ";
qry3=qry3+" studentid='"+rs2.getString("studentid")+"' and nvl(LOCKED,'N')='Y' ";
qry3=qry3+" and nvl(DETAINED,'N')<>'N' and RowNum=1 ";
*/


qry4=" select distinct NVL(A.GRADE,'N')GRADE,A.studentid from DEBARSTUDENTDETAIL A WHERE a.EXAMCODE='"+mExamCode+"'   and a.INSTITUTECODE='"+mInst+"' and a.fstid='"+rs2.getString("fstid")+"' and a.studentid='"+rs2.getString("studentid")+"' AND A.SUBJECTID='"+mSubjectCode+"'  AND NVL(A.PRORATA,'N')='N'  and nvl(a.DEACTIVE,'N')='N' AND (NVL(A.MEDICALCASE,'Y')='Y'    OR  NVL(A.ABSENTCASE,'N')='N' OR NVL(A.UFM,'N')='N' ) AND A.GRADE IS NOT NULL and A.studentid not in (select studentid from debarstudentdetail where examcode='"+mExamCode+"' and  nvl(MEDICALWITHDRAWAL,'N')='Y' AND fstid='"+rs2.getString("fstid")+"') ";
				 		//out.print(qry4);
			rs4=db.getRowset(qry4);
			if(rs4.next())
			{
			mDebarGrade=rs4.getString("GRADE");


			StudentGradeCalculationMarksAwarded1=mMarksawarded2;


			}
			else
		{
			mDebarGrade="N";
			StudentGradeCalculationMarksAwarded1=mMarksawarded2;
		}
//out.print("*44555555*");
qry3="select DECODE(NVL(DETAINED,'N'),'D',1,'A',2,3),nvl(Detained,'N')Detained,enrollmentno  from V#STUDENTEVENTSUBJECTMARKS where institutecode='"+mInst+"' and fstid='"+rs2.getString("fstid")+"' ";
qry3=qry3+" and examcode='"+mExamCode+"' and subjectID='"+mSubjectCode+"' and ";
qry3=qry3+" studentid='"+rs2.getString("studentid")+"' and nvl(LOCKED,'N')='Y' ";
// qry3=qry3+" and nvl(DETAINED,'N')<>'N' and RowNum=1 ";
qry3=qry3+" and nvl(DETAINED,'N') in ('D','A','M') AND STUDENTID NOT IN (SELECT STUDENTID FROM DEBARSTUDENTDETAIL WHERE EXAMCODE='"+mExamCode+"' AND NVL(MEDICALWITHDRAWAL,'N')='Y') ORDER BY 1";
rs3=db.getRowset(qry3);
//System.out.println(qry3);
if(rs3.next())
	{
			mDetained=rs3.getString("Detained");

			if(mDetained.equals("D"))
			{
			//	Rejected++;
			StudentGradeCalculationMarksAwarded1=mMarksawarded2;
			}
			else
			{
			if(mDetained.equals("A"))
				{
					StudentGradeCalculationMarksAwarded1=mMarksawarded2;
				}
			}
			if(mDetained.equals("M"))
			{
					qry4="select nvl(ParameterValue,0)ParameterValue  from Parameters where CompanyCode='JIIT' ";
					qry4=qry4+" and ModuleName='SIS' and ParameterID='C1.3' and ";
					qry4=qry4+" RowNum=1 ";
					rs4=db.getRowset(qry4);


					///out.print(qry4);
					if(rs4.next())
					{
						mLimit=rs4.getDouble(1);

						if(mMarksawarded2>mLimit)
						{
							mLimit=mLimit;
						}
						else
						{
							mLimit=mMarksawarded2;
						}
					} // closing of rs4
					else
					{
						mLimit=mMarksawarded2;
					}

					StudentGradeCalculationMarksAwarded1=mLimit;

					}//closing of mDeatined 'M'
		}
		else
		{
		mDetained="N";
		StudentGradeCalculationMarksAwarded1=mMarksawarded2;
		}


		//out.print("*7777777*");
//-------------------->>  Masscuts  <<-------------------

StudentGradeCalculationMarks=StudentGradeCalculationMarksAwarded1;//-mMassCut;

//out.print("DKS--- "+StudentGradeCalculationMarks+"StudentGradeCalculationMarksAwarded1 "+StudentGradeCalculationMarksAwarded1+"mMassCut "+mMassCut);

//******************>>  Masscuts  <<***********************

//System.out.println("*********************"+mCheckRadio);






if(mCheckRadio.equals("Y"))
{


if(mDebarGrade.equals("F")  )
	{

	StudentGradeCalculationMarks2=""+StudentGradeCalculationMarks;
	mGrad1=rs1.getString("GRADE");
	Studid=rs2.getString("studentid");
	mWeigh=rs2.getString("weightage");
	GradeMatserStudentIDChecked=Studid+"*****"+StudentGradeCalculationMarks2+"$$$$$F"+"?????"+mWeigh+"#####"+StudentGradeCalculationMarksAwarded1+"/////"+mMassCut+"%%%%%"+mFst;
		GradeMatserStudentIDArray.add(GradeMatserStudentIDChecked);
	}

	if(mDebarGrade.equals("I"))
	{

		StudentGradeCalculationMarks2=""+StudentGradeCalculationMarks;
		mGrad1=rs1.getString("GRADE");
		Studid=rs2.getString("studentid");
		mWeigh=rs2.getString("weightage");
		GradeMatserStudentIDChecked=Studid+"*****"+StudentGradeCalculationMarks2+"$$$$$I"+"?????"+mWeigh+"#####"+StudentGradeCalculationMarksAwarded1+"/////"+mMassCut+"%%%%%"+mFst;
		GradeMatserStudentIDArray.add(GradeMatserStudentIDChecked);
	}
	if(mDetained.equals("D"))
	{
		StudentGradeCalculationMarks2=""+StudentGradeCalculationMarks;
		mGrad1=rs1.getString("GRADE");
		Studid=rs2.getString("studentid");
		mWeigh=rs2.getString("weightage");
		GradeMatserStudentIDChecked=Studid+"*****"+StudentGradeCalculationMarks2+"$$$$$"+mGrad1+"?????"+mWeigh+"#####"+StudentGradeCalculationMarksAwarded1+"/////"+mMassCut+"%%%%%"+mFst;
		GradeMatserStudentIDArray.add(GradeMatserStudentIDChecked);
	}
if(!mDebarGrade.equals("F"))
	{
if( !mDebarGrade.equals("I"))
	{
if(!mDetained.equals("D"))
{
    //-------------------------New Condition (Supply Fail) Added 24.03.2018-------------------------------------------------------------------
    xx="N";
        if(tempMarksAwarded2<rs2.getDouble("weightage")/5)
	{
            xx="Y";
              if (rs1.getString("GRADE").equals("F"))
	       {
                StudentGradeCalculationMarks2=""+StudentGradeCalculationMarks;
		mGrad1="F";
		Studid=rs2.getString("studentid");
		mWeigh=mDebarWeight;
               // GradeMasterTotalCount=GradeMasterTotalCount+1;
		GradeMatserStudentIDChecked=Studid+"*****"+StudentGradeCalculationMarks2+"$$$$$"+mGrad1+"?????"+mWeigh+"#####"+StudentGradeCalculationMarksAwarded1+"/////"+mMassCut+"%%%%%"+mFst;
		GradeMatserStudentIDArray.add(GradeMatserStudentIDChecked);
                //System.out.println("studentid 2 "+Studid);
                }
	}

if(!xx.equals("Y") )
{
	if(StudentGradeCalculationMarks>=GradeMasterLowerLimit)
	//if(1==1)
	{
    	if(StudentGradeCalculationMarks<mPrevValueNew)
        {
        mGrad1=rs1.getString("GRADE");
	StudentGradeCalculationMarks2=""+StudentGradeCalculationMarks;
	Studid=rs2.getString("studentid");
        if(mGrad1.equals("A")){
	if(StudidOL.equals("''") )
	StudidOL="'"+rs2.getString("studentid")+"'";
	else
	StudidOL=StudidOL+",'"+rs2.getString("studentid")+"' ";
                              }
        if(mGrad1.equals("A+")){
	if(StudidOLAP.equals("''") )
	StudidOLAP="'"+rs2.getString("studentid")+"'";
	else
	StudidOLAP=StudidOLAP+",'"+rs2.getString("studentid")+"' ";

                                }
        mWeigh=rs2.getString("weightage");

       	GradeMasterTotalCount=GradeMasterTotalCount+1;
	GradeMatserStudentIDChecked=Studid+"*****"+StudentGradeCalculationMarks2+"$$$$$"+mGrad1+"?????"+mWeigh+"#####"+StudentGradeCalculationMarksAwarded1+"/////"+mMassCut+"%%%%%"+mFst;
	//out.print("ooooo"+GradeMatserStudentIDChecked);
        GradeMatserStudentIDArray.add(GradeMatserStudentIDChecked);
	}
	}

    }

	}
}
}
	session.setAttribute("GRADECHECKED",GradeMatserStudentIDArray);
}
if(mDebarGrade.equals("F"))
	{
		mGrad1=rs1.getString("GRADE");
		Studid=rs2.getString("studentid");
		mWeigh=rs2.getString("weightage");
		StudentGradeCalculationMarks1=""+StudentGradeCalculationMarks;
        	GradeMatserStudentIDInitial=Studid+"*****"+StudentGradeCalculationMarks1+"$$$$$F"+"?????"+mWeigh+"#####"+StudentGradeCalculationMarksAwarded1+"/////"+mMassCut+"%%%%%"+mFst;
        	GradeMatserStudentIDArrayInit.add(GradeMatserStudentIDInitial);

	}

if(mDebarGrade.equals("I"))
	{
		mGrad1=rs1.getString("GRADE");
		Studid=rs2.getString("studentid");
		mWeigh=rs2.getString("weightage");

		StudentGradeCalculationMarks1=""+StudentGradeCalculationMarks;
		GradeMatserStudentIDInitial=Studid+"*****"+StudentGradeCalculationMarks1+"$$$$$I"+"?????"+mWeigh+"#####"+StudentGradeCalculationMarksAwarded1+"/////"+mMassCut+"%%%%%"+mFst;

	//	GradeMatserStudentIDInitial=Studid+"*****"+StudentGradeCalculationMarks1+"$$$$$F"+"?????"+mWeigh;
		GradeMatserStudentIDArrayInit.add(GradeMatserStudentIDInitial);
	//	out.print(GradeMatserStudentIDInitial);
	}

if(mDetained.equals("D"))
{
		mGrad1=rs1.getString("GRADE");
		Studid=rs2.getString("studentid");
		mWeigh=rs2.getString("weightage");

		StudentGradeCalculationMarks1=""+StudentGradeCalculationMarks;
		GradeMatserStudentIDInitial=Studid+"*****"+StudentGradeCalculationMarks1+"$$$$$F"+"?????"+mWeigh+"#####"+StudentGradeCalculationMarksAwarded1+"/////"+mMassCut+"%%%%%"+mFst;
        	GradeMatserStudentIDArrayInit.add(GradeMatserStudentIDInitial);

}
//System.out.print(mDebarGrade+"########"+ctim);
if(!mDebarGrade.equals("F") )
	{
if( !mDebarGrade.equals("I"))
	{
if(!mDetained.equals("D") )
{
        xx="N";
        if(tempMarksAwarded2<rs2.getDouble("weightage")/5)
	{
            xx="Y";
              if (rs1.getString("GRADE").equals("F"))
	       {
                StudentGradeCalculationMarks1=""+StudentGradeCalculationMarks;
		mGrad1="F";
		Studid=rs2.getString("studentid");
		mWeigh=mDebarWeight;
		GradeMatserStudentIDInitial=Studid+"*****"+StudentGradeCalculationMarks1+"$$$$$"+mGrad1+"?????"+mWeigh+"#####"+StudentGradeCalculationMarksAwarded1+"/////"+mMassCut+"%%%%%"+mFst;
		//out.print("AAA"+GradeMatserStudentIDInitial);
                GradeMatserStudentIDArrayInit.add(GradeMatserStudentIDInitial);
                }
	}
if(!xx.equals("Y") )
{
if(rs1.getString("GRADE").equals("D")){
String s = new Integer(CALVALUEF).toString();
 mInitialCount=Double.parseDouble(s);
}else{
mInitialCount=mInitialCount;
}
	if(StudentGradeCalculationMarksAwarded1>=mInitialCount)
	{
        	if(StudentGradeCalculationMarksAwarded1<mPrevValue )
		{
			Studid=rs2.getString("studentid");
			mWeigh=rs2.getString("weightage");
		        StudentGradeCalculationMarks1=""+StudentGradeCalculationMarks;
                        mGrad1=rs1.getString("GRADE");
         		InitialCount=InitialCount+1;
                        GradeMatserStudentIDInitial=Studid+"*****"+StudentGradeCalculationMarks1+"$$$$$"+mGrad1+"?????"+mWeigh+"#####"+StudentGradeCalculationMarksAwarded1+"/////"+mMassCut+"%%%%%"+mFst;
                        //out.print("BBBB"+GradeMatserStudentIDInitial);
                        GradeMatserStudentIDArrayInit.add(GradeMatserStudentIDInitial);

		}
	}
}
   }// End Of D Condtion
     }
	}

session.setAttribute("GRADEUNCHECKED",GradeMatserStudentIDArrayInit);
mDebarStudID=rs2.getString("studentid");
} // closing of while rs2
%>