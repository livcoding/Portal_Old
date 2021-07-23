<%
qry2="select a.institutecode,a.fstid fstid,a.ExamCode,a.Semester,a.semestertype,a.subjectID, a.studentid studentid,";
qry2=qry2+" a.enrollmentno,round(sum((a.marksawarded2/a.maxmarks)*b.weightage),2)marksawarded2, ";
qry2=qry2+" a.studentname,sum(b.weightage)weightage from V#STUDENTEVENTSUBJECTMARKS a, ";
qry2=qry2+" V#EXAMEVENTSUBJECTTAGGING b where  ";
qry2=qry2+" a.fstid in("+mCheckFstid+") ";
qry2=qry2+" and (('"+mETOD+"'='N' and a.semestertype<>(select semestertype from semestertype where institutecode='"+mInst+"' ";
qry2=qry2+" and nvl(ETOD,'N')='Y'))  or ('"+mETOD+"'='E' and a.semestertype<>(select semestertype from semestertype where ";
qry2=qry2+" institutecode='"+mInst+"' and  nvl(ETOD,'N')='Y'))) ";
qry2=qry2+" and a.examcode='"+mExamCode+"' and a.examcode=b.examcode and a.eventsubevent=b.eventsubevent and ";
qry2=qry2+" a.studentid=b.studentid ";
qry2=qry2+" and a.subjectID='"+mSubjectCode+"'  and nvl(a.DEACTIVE,'N')='N' and ";
qry2=qry2+" nvl(a.LOCKED,'N')='Y' and a.subjectID=b.subjectID and nvl(a.DEACTIVE,'N')='N' ";
qry2=qry2+" and a.fstid=b.fstid ";
qry2=qry2+" group by a.institutecode,a.fstid,a.ExamCode,a.Semester,a.semestertype,A.SUBJECTID,a.studentid, ";
qry2=qry2+" a.enrollmentno,a.studentname ";
rs2=db.getRowset(qry2);

while(rs2.next())
{
		ctr=ctr++;

		mMarksawarded2=rs2.getDouble("marksawarded2");
		mFst=rs2.getString("fstid");

qrym="select nvl(MASSCUTS,0)MASSCUTS from EX#STUDENTMASSCUTS where fstid='"+rs2.getString("fstid")+"' and studentid='"+rs2.getString("studentid")+"' and nvl(DEACTIVE,'N')='N' ";
rsm=db.getRowset(qrym);
if(rsm.next())
{
	mMassCut=rsm.getDouble("MASSCUTS");
}
else
{
	mMassCut=0;
}
/*
qry3="select nvl(Detained,'N')Detained  from V#STUDENTEVENTSUBJECTMARKS where institutecode='"+mInst+"' ";
qry3=qry3+" and examcode='"+mExamCode+"' and subjectID='"+mSubjectCode+"' and ";
qry3=qry3+" studentid='"+rs2.getString("studentid")+"' and nvl(LOCKED,'N')='Y' ";
qry3=qry3+" and nvl(DETAINED,'N')<>'N' and RowNum=1 ";
*/
qry3="select DECODE(NVL(DETAINED,'N'),'D',1,'A',2,3),nvl(Detained,'N')Detained,enrollmentno  from V#STUDENTEVENTSUBJECTMARKS where institutecode='"+mInst+"' ";
qry3=qry3+" and examcode='"+mExamCode+"' and subjectID='"+mSubjectCode+"' and ";
qry3=qry3+" studentid='"+rs2.getString("studentid")+"' and nvl(LOCKED,'N')='Y' ";
// qry3=qry3+" and nvl(DETAINED,'N')<>'N' and RowNum=1 ";
qry3=qry3+" and nvl(DETAINED,'N') in ('D','A','M') ORDER BY 1";
rs3=db.getRowset(qry3);
	
rs3=db.getRowset(qry3);
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
					qry4="select ParameterValue from Parameters where CompanyCode='JIIT' ";
					qry4=qry4+" and ModuleName='SIS' and ParameterID='C1.3' and ";
					qry4=qry4+" RowNum=1 ";
					rs4=db.getRowset(qry4);
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

			}  // closing of mDeatined 'M'
		}
		else
		{
			mDetained="N";
			StudentGradeCalculationMarksAwarded1=mMarksawarded2;
		}
// -------------------------Masscuts    
StudentGradeCalculationMarks=StudentGradeCalculationMarksAwarded1-mMassCut;
// *****************************************
if(mCheckRadio.equals("Y"))
{
	if(mDetained.equals("D"))
	{
		StudentGradeCalculationMarks2=""+StudentGradeCalculationMarks;
		mGrad1=rs1.getString("GRADE");
		Studid=rs2.getString("studentid");
		mWeigh=rs2.getString("weightage");
		GradeMatserStudentIDChecked=Studid+"*****"+StudentGradeCalculationMarks2+"$$$$$F"+"?????"+mWeigh+"#####"+StudentGradeCalculationMarksAwarded1+"/////"+mMassCut+"%%%%%"+mFst;
		GradeMatserStudentIDArray.add(GradeMatserStudentIDChecked);
	}
if(!mDetained.equals("D"))
{
	/*
	if(GradeMasterLowerLimit==0.0)
		GradeMasterLowerLimit=8000;
	else
		GradeMasterLowerLimit=GradeMasterLowerLimit;
*/
//out.print(StudentGradeCalculationMarks+"=="+GradeMasterLowerLimit+"<br>");
	if(StudentGradeCalculationMarks>=GradeMasterLowerLimit)
	{
    	if(StudentGradeCalculationMarks<mPrevValueNew)			
		{
//out.print(StudentGradeCalculationMarks+"=="+GradeMasterLowerLimit+"=="+mPrevValueNew+"<br>");

			GradeMasterTotalCount=GradeMasterTotalCount+1;
			StudentGradeCalculationMarks2=""+StudentGradeCalculationMarks;
			mGrad1=rs1.getString("GRADE");
			Studid=rs2.getString("studentid");
			mWeigh=rs2.getString("weightage");

		GradeMatserStudentIDChecked=Studid+"*****"+StudentGradeCalculationMarks2+"$$$$$"+mGrad1+"?????"+mWeigh+"#####"+StudentGradeCalculationMarksAwarded1+"/////"+mMassCut+"%%%%%"+mFst;

		GradeMatserStudentIDArray.add(GradeMatserStudentIDChecked);
		}
	}
	}
	session.setAttribute("GRADECHECKED",GradeMatserStudentIDArray);	
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

if(!mDetained.equals("D"))
{
//	StudentGradeCalculationMarks=StudentGradeCalculationMarksAwarded1-0;
	if(StudentGradeCalculationMarksAwarded1>=mInitialCount)
	{
		
		if(StudentGradeCalculationMarksAwarded1<mPrevValue)			
		{
			InitialCount=InitialCount+1;
			mGrad1=rs1.getString("GRADE");
			Studid=rs2.getString("studentid");
			mWeigh=rs2.getString("weightage");

		StudentGradeCalculationMarks1=""+StudentGradeCalculationMarks;
		GradeMatserStudentIDInitial=Studid+"*****"+StudentGradeCalculationMarks1+"$$$$$"+mGrad1+"?????"+mWeigh+"#####"+StudentGradeCalculationMarksAwarded1+"/////"+mMassCut+"%%%%%"+mFst;

//	GradeMatserStudentIDInitial=Studid+"*****"+StudentGradeCalculationMarks1+"$$$$$"+mGrad1+"?????"+mWeigh;
		GradeMatserStudentIDArrayInit.add(GradeMatserStudentIDInitial);
		
		//session.setAttribute("GRADEUNCHECKED",GradeMatserStudentIDArrayInit);
	/*--------------------------
			Grade of Students Grade Master
	-----------------------------*/
//out.print(InitialCount+"222<br>");

		}
	}
}
//System.out.println(GradeMatserStudentIDArrayInit);
session.setAttribute("GRADEUNCHECKED",GradeMatserStudentIDArrayInit);
} // closing of while rs2
%>