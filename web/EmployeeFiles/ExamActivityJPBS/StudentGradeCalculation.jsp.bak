<%
//System.out.print("*****#####***********");
//mDebarStudID="";
ktm++;
qry2="select distinct b.LTP LTP , a.institutecode,a.fstid fstid,a.ExamCode,nvl(a.Semester,0)Semester,a.semestertype,a.subjectID, a.studentid studentid,";
qry2=qry2+" a.enrollmentno, NVL (c.Masscuts, 0) Masscuts,  NVL ( ( (CEIL (SUM ( (a.marksawarded2 / a.maxmarks) * b.weightage))) - (CASE                     WHEN (c.TATOTAL - c.Masscuts) < 0 THEN c.TATOTAL  ELSE c.Masscuts   END)), 0 ) marksawarded2, ";
qry2=qry2+" a.studentname,nvl(sum(b.weightage),0)weightage from V#STUDENTEVENTSUBJECTMARKS a, ";
qry2=qry2+" V#EXAMEVENTSUBJECTTAGGING b , STUDENTGRADEMASSCUTS c where  ";
qry2=qry2+" a.fstid in("+mCheckFstid+") and A.studentid not in (select studentid from debarstudentdetail where examcode='"+mExamCode+"' and  nvl(MEDICALWITHDRAWAL,'N')='Y' AND fstid IN ( "+mCheckFstid+" )) ";
//qry2=qry2+" and (('"+mETOD+"'='N' and a.semestertype<>(select semestertype from semestertype where institutecode='"+mInst+"' ";
//qry2=qry2+" and nvl(ETOD,'N')='Y'))  or ('"+mETOD+"'='E' and a.semestertype<>(select semestertype from semestertype where ";
//qry2=qry2+" institutecode='"+mInst+"' and  nvl(ETOD,'N')='Y'))) ";
qry2=qry2+" and a.examcode='"+mExamCode+"' and a.examcode=b.examcode and a.eventsubevent=b.eventsubevent and ";
qry2=qry2+" a.studentid=b.studentid ";
qry2=qry2+" and a.subjectID='"+mSubjectCode+"'  and nvl(a.DEACTIVE,'N')='N' and ";
qry2=qry2+" nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID and nvl(a.DEACTIVE,'N')='N' ";
qry2=qry2+" and a.fstid=b.fstid  AND c.studentid = a.studentid           AND c.fstID = a.FstID ";
qry2=qry2+" group by b.LTP,a.institutecode,a.fstid,a.ExamCode,a.Semester,a.semestertype,A.SUBJECTID,a.studentid, ";
qry2=qry2+" a.enrollmentno,a.studentname,   c.Masscuts,       c.TATOTAL ";
rs2=db.getRowset(qry2);
// System.out.println(ktm+"AAA"+qry2);
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


qrym="select nvl(MASSCUTS,0)MASSCUTS from EX#STUDENTMASSCUTS where fstid='"+rs2.getString("fstid")+"' and studentid='"+rs2.getString("studentid")+"' and nvl(DEACTIVE,'N')='N' ";
rsm=db.getRowset(qrym);
//System.out.println(qrym);
if(rsm.next())
{
	mMassCut=rsm.getDouble("MASSCUTS");
}
else
{
	mMassCut=0;
}
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

StudentGradeCalculationMarks=StudentGradeCalculationMarksAwarded1-mMassCut;

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
	/*
	if(GradeMasterLowerLimit==0.0)
		GradeMasterLowerLimit=8000;
	else
		GradeMasterLowerLimit=GradeMasterLowerLimit;
*/
//out.print(StudentGradeCalculationMarks+"=="+GradeMasterLowerLimit+"<br>");
	
	/*
if(GradeMasterLowerLimit==0){
GradeMasterLowerLimit=StudentGradeCalculationMarks;
}
else{
GradeMasterLowerLimit=GradeMasterLowerLimit;
}*/

/*


if(ctim==1 && mPrevValueNew==1000)
	{
GradeMasterLowerLimit=StudentGradeCalculationMarks;
mPrevValueNew=StudentGradeCalculationMarks+1;
	}*/

//System.out.println(StudentGradeCalculationMarks+"====="+GradeMasterLowerLimit+"====="+mPrevValueNew);

	if(StudentGradeCalculationMarks>=GradeMasterLowerLimit)  
	//if(1==1)
	{
		
		
    	if(StudentGradeCalculationMarks<mPrevValueNew)	
			
				{
//System.out.print(StudentGradeCalculationMarks+"=="+GradeMasterLowerLimit+"=="+mPrevValueNew+"<br>");
	
			mGrad1=rs1.getString("GRADE");
			StudentGradeCalculationMarks2=""+StudentGradeCalculationMarks;
		
			Studid=rs2.getString("studentid");
if(mGrad1.equals("A")){




											if(StudidOL.equals("''") )
												StudidOL="'"+rs2.getString("studentid")+"'";
											else
												StudidOL=StudidOL+",'"+rs2.getString("studentid")+"' ";

			//StudidOL=StudidOL+","+rs2.getString("studentid");

}


if(mGrad1.equals("A+")){

			//StudidOLAP=StudidOLAP+"'"+","+rs2.getString("studentid")+"'";



											if(StudidOLAP.equals("''") )
												StudidOLAP="'"+rs2.getString("studentid")+"'";
											else
												StudidOLAP=StudidOLAP+",'"+rs2.getString("studentid")+"' ";


//StudidOLAP=StudidOLAP+"'"+rs2.getString("studentid")+"' , ";





}

			mWeigh=rs2.getString("weightage");

//debar students
	
	//out.print(GradeMasterTotalCount+"HELOooo");
			GradeMasterTotalCount=GradeMasterTotalCount+1;
			GradeMatserStudentIDChecked=Studid+"*****"+StudentGradeCalculationMarks2+"$$$$$"+mGrad1+"?????"+mWeigh+"#####"+StudentGradeCalculationMarksAwarded1+"/////"+mMassCut+"%%%%%"+mFst;

		GradeMatserStudentIDArray.add(GradeMatserStudentIDChecked);
		//System.out.println("AAAAAAA"+GradeMatserStudentIDArray);
		}
		//System.out.println("BBBBBBBBBBBB"+GradeMatserStudentIDArray);
	}
		//System.out.println("CCCCCCCCCCCCCC"+GradeMatserStudentIDArray);

	}
		//	System.out.println("DDDDDDDDDDDD"+GradeMatserStudentIDArray);
}
		//System.out.println("EEEEEEEEEEEEEE"+GradeMatserStudentIDArray);
}
	//	System.out.println("FFFFFFFFFFFFFFFFFFF"+GradeMatserStudentIDArray);
	session.setAttribute("GRADECHECKED",GradeMatserStudentIDArray);	
}

//out.print("*888888888888*");
//System.out.println(GradeMatserStudentIDArray);

if(mDebarGrade.equals("F"))
	{
		mGrad1=rs1.getString("GRADE");
		Studid=rs2.getString("studentid");
		mWeigh=rs2.getString("weightage");

		StudentGradeCalculationMarks1=""+StudentGradeCalculationMarks;
	GradeMatserStudentIDInitial=Studid+"*****"+StudentGradeCalculationMarks1+"$$$$$F"+"?????"+mWeigh+"#####"+StudentGradeCalculationMarksAwarded1+"/////"+mMassCut+"%%%%%"+mFst;

	//	GradeMatserStudentIDInitial=Studid+"*****"+StudentGradeCalculationMarks1+"$$$$$F"+"?????"+mWeigh;
		GradeMatserStudentIDArrayInit.add(GradeMatserStudentIDInitial);
	//	out.print(GradeMatserStudentIDInitial);

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

	//	GradeMatserStudentIDInitial=Studid+"*****"+StudentGradeCalculationMarks1+"$$$$$F"+"?????"+mWeigh;
		GradeMatserStudentIDArrayInit.add(GradeMatserStudentIDInitial);
	//	out.print(GradeMatserStudentIDInitial);
}
//System.out.print(mDebarGrade+"########"+ctim);
if(!mDebarGrade.equals("F") )
	{
if( !mDebarGrade.equals("I"))
	{
if(!mDetained.equals("D") )
{
//	StudentGradeCalculationMarks=StudentGradeCalculationMarksAwarded1-0;
	
	// out.print(CALVALUEF+"<BR>************************");

if(rs1.getString("GRADE").equals("D")){


String s = new Integer(CALVALUEF).toString(); 

 mInitialCount=Double.parseDouble(s);


//String FARZI = Integer.toString(CALVALUEF);

//String FARZI = Integer.toString(CALVALUEF);


//mInitialCount=double
//CALVALUEF =intiger
//FARZI =String

  //mInitialCount = (double)CALVALUEF;
   //mInitialCount = CALVALUEF; 

 //mInitialCount = Double.parseDouble(CALVALUEF); 
//out.print(mInitialCount+"ZZZZZ"+s+"AAAAAAAA"+CALVALUEF+"BBBBBBB"+mInitialCount+"<BR>");
//out.print("************345345345************");
// mInitialCount=30.0 ;

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

//out.print(Studid+"AA"+mGrad1);
		
				InitialCount=InitialCount+1;
				 //out.print(StudentGradeCalculationMarksAwarded1+"XXXXXXX"+mGrad1+"KKKKKKKKKKKKKKK"+InitialCount+"YYYYYYY"+mPrevValue+"FFFFFFF"+mInitialCount+" <br>");

		

GradeMatserStudentIDInitial=Studid+"*****"+StudentGradeCalculationMarks1+"$$$$$"+mGrad1+"?????"+mWeigh+"#####"+StudentGradeCalculationMarksAwarded1+"/////"+mMassCut+"%%%%%"+mFst;

//	GradeMatserStudentIDInitial=Studid+"*****"+StudentGradeCalculationMarks1+"$$$$$"+mGrad1+"?????"+mWeigh;
		GradeMatserStudentIDArrayInit.add(GradeMatserStudentIDInitial);
		
		//session.setAttribute("GRADEUNCHECKED",GradeMatserStudentIDArrayInit);
	/*--------------------------
			Grade of Students Grade Master
	-----------------------------*/
//out.print(InitialCount+"222<br>");
//out.print("*666463*");
		}
	}
}
	}
	}

	//end out.print("*77777755777777*");
//System.out.println(GradeMatserStudentIDArrayInit);



//Qryim="  SELECT 'Y' FROM studentltpdetail  WHERE  FSTID IN ("+mCheckFstid+")  and studentid IN  ("+Studid+")       AND nvl(D.IMPROVEMENT,'N')='Y'  " ;
//rsim=db.getRowset(Qryim);
 
//if(1==1  )
//{

//	ctim++;

//}
 
// ctim++;

  
session.setAttribute("GRADEUNCHECKED",GradeMatserStudentIDArrayInit);

mDebarStudID=rs2.getString("studentid");
	//}
} // closing of while rs2
%>