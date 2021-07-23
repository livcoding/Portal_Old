<!--Modified Date 12 Jan 2019 -->

<%
String  Qryim ="",qry7="" ,xx=""; ResultSet  rsim=null,rsta=null; int  ctim=0;
double tempMarksAwarded2=0,curtaweightage=0;
//mDebarStudID="";
 qry7="Select (nvl(A.WEIGHTAGE,0)) WEIGHTAGE from EXAMEVENTMASTER A WHERE A.INSTITUTECODE= '"+mInst+"' AND A.EXAMCODE='"+mPrevExamCode+"' AND EXAMEVENTTYPE='T'";
rsta=db.getRowset(qry7);
//out.print("qry7"+qry7);
if(rsta.next())
{
curtaweightage=rsta.getDouble("WEIGHTAGE");
}

qry2="select distinct a.institutecode,a.fstid fstid,a.ExamCode,nvl(a.Semester,0)Semester,a.semestertype,a.subjectID, c.studentid studentid,";
qry2=qry2+" c.enrollmentno,nvl( ceil(sum((d.marksawarded2/e.maxmarks)*e.weightage)),0)marksawarded2, ";
qry2=qry2+" c.studentname,nvl(sum(e.weightage),0)weightage, ";
qry2=qry2+"(select NVL (CEIL (SUM ((y.marksawarded2 / z.maxmarks) * z.weightage)),0)||'-'||nvl(SUM (z.weightage), 0) ";
qry2=qry2+" from facultysubjecttagging x ,studenteventsubjectmarks y, ";
qry2=qry2+" exameventsubjecttagging z  where  x.fstid = y.fstid ";
qry2=qry2+" and x.fstid = z.fstid AND y.eventsubevent = z.eventsubevent ";
qry2=qry2+" and x.INSTITUTECODE = '"+mInst+"' And x.examcode = '"+mPrevExamCode+"' and ";
qry2=qry2+" y.eventsubevent like '%TA%' AND x.subjectid = a.subjectid And ";
qry2=qry2+" y.studentid=c.studentid  ) TAMarks " ;
qry2=qry2+" FROM facultysubjecttagging a,  studentmaster c ,studenteventsubjectmarks d, exameventsubjecttagging e WHERE   a.fstid = d.fstid ";
qry2=qry2+" and a.fstid = e.fstid AND d.eventsubevent = e.eventsubevent AND d.studentid = c.studentid ";
qry2=qry2+" And a.fstid IN("+mCheckFstid+") and c.studentid not in (select studentid from debarstudentdetail where examcode='"+mExamCode+"' and  nvl(MEDICALWITHDRAWAL,'N')='Y' AND fstid IN ( "+mCheckFstid+" )) ";
//qry2=qry2+" and (('"+mETOD+"'='N' and a.semestertype<>(select semestertype from semestertype where institutecode='"+mInst+"' ";
//qry2=qry2+" and nvl(ETOD,'N')='Y'))  or ('"+mETOD+"'='E' and a.semestertype<>(select semestertype from semestertype where ";
//qry2=qry2+" institutecode='"+mInst+"' and  nvl(ETOD,'N')='Y'))) ";
qry2=qry2+" and a.examcode='"+mExamCode+"' ";
qry2=qry2+" and a.subjectID='"+mSubjectCode+"'  and nvl(d.DEACTIVE,'N')='N' and ";
qry2=qry2+" nvl(d.LOCKED,'N')='Y' and  nvl(c.DEACTIVE,'N')='N' ";
qry2=qry2+" group by a.institutecode,a.fstid,a.ExamCode,a.Semester,a.semestertype,a.SUBJECTID,c.studentid, ";
qry2=qry2+" c.enrollmentno,c.studentname ";
rs2=db.getRowset(qry2);
//System.out.println("AAA"+qry2);
while(rs2.next())
{
ctim++;
//System.out.println(StudentGradeCalculationMarks+"====="+GradeMasterLowerLimit+"====="+mPrevValueNew);
// if(!mDebarStudID.equals(rs2.getString("studentid")) )
//{
ctr=ctr++;
mMarksawarded2=rs2.getDouble("marksawarded2");
//System.out.println("111111.mMarksawarded2..Medical-----case--"+mMarksawarded2);
mFst=rs2.getString("fstid");
//mDebarWeight=rs2.getString("weightage");
              
     //System.out.println("mMarksawarded2..Medical-----case--"+mMarksawarded2);
    // System.out.println("mDebarWeight..Medical-----case--"+mDebarWeight);
                //--------------------------------- Medical Case Date 24.03.2018 10:45:56 -----------------------------------------------------------------

String firqry="select *from DEBARSTUDENTDETAIL   where INSTITUTECODE = '"+mInst+"' and MEDICALCASE='Y' And examcode = '"+mPrevExamCode+"' and studentid = '"+rs2.getString("studentid")+"' AND    subjectid = '"+mSubjectCode+"' ";
ResultSet rsa=db.getRowset(firqry);
//System.out.println(qry3);

Double mprvMaks=0.0,mprvWEIGHTAGE=0.0,mEndTermWeightage=0.0;
String mprvEVENTSUBEVENT="";

if(rsa.next())
{
    String secqry="Select y.EVENTSUBEVENT ,NVL (CEIL ((y.marksawarded2 / z.maxmarks) * z.weightage),0) marks ,nvl(z.weightage, 0) weightage," +
              "(select NVL(a.EXAMEVENTTYPE,'O') from exameventmaster a where  a.INSTITUTECODE = x.INSTITUTECODE and a.examcode =x.examcode and a.EXAMEVENTCODE =y.EVENTSUBEVENT and  rownum=1) EXAMEVENTTYPE "+
    "   from facultysubjecttagging x ,studenteventsubjectmarks y,  exameventsubjecttagging z  where  x.fstid = y.fstid    and x.fstid = z.fstid" +
            "   AND y.eventsubevent = z.eventsubevent  and x.INSTITUTECODE = '"+mInst+"'  And x.examcode = '"+mPrevExamCode+"' and      " +
            "   y.eventsubevent not like '%TA%' AND    x.subjectid = '"+mSubjectCode+"' And         y.studentid = '"+rs2.getString("studentid")+"'";
    ResultSet rsa2=db.getRowset(secqry);
    System.out.println("Medical-----case--"+secqry);
    while(rsa2.next()){

        mprvEVENTSUBEVENT=rsa2.getString("EXAMEVENTTYPE");
        System.out.println("mprvEVENTSUBEVENT--"+mprvEVENTSUBEVENT);
        if(mprvEVENTSUBEVENT.equalsIgnoreCase("E")){
        mEndTermWeightage=rsa2.getDouble("WEIGHTAGE");
        System.out.println("mEndTermWeightage--"+mEndTermWeightage);
        }else{
        mprvMaks=rsa2.getDouble("MARKS")+mprvMaks;
       System.out.println("mprvMaks--"+mprvMaks);
        mprvWEIGHTAGE=rsa2.getDouble("WEIGHTAGE")+mprvWEIGHTAGE;
        System.out.println("mprvWEIGHTAGE--"+mprvWEIGHTAGE);
        }

    }// closing of while

    //System.out.println("1.mMarksawarded2..Medical-----case--"+mMarksawarded2);

     //System.out.println("2.mEndTermWeightage--"+mEndTermWeightage);

   // System.out.println("3.rs2.getDouble(weightage)--"+rs2.getDouble("weightage"));

   // System.out.println(("rESULT IS"+(mMarksawarded2*mEndTermWeightage)/rs2.getDouble("weightage")));


    //System.out.println("2. mprvMaks--"+mprvMaks);
   
    

    //System.out.println("Math.ceilOJKSDIFIKFG((mMarksawarded2/rs2.getDouble(weightage))*mEndTermWeightage)--"+Math.ceil((mMarksawarded2*mEndTermWeightage)/rs2.getDouble("weightage")));
   // System.out.println("Math.fLOOR((mMarksawarded2/rs2.getDouble(weightage))*mEndTermWeightage)--"+Math.floor((mMarksawarded2/rs2.getDouble("weightage"))*mEndTermWeightage));
    //System.out.println("Math.nORMAL((mMarksawarded2/rs2.getDouble(weightage))*mEndTermWeightage)--"+((mMarksawarded2/rs2.getDouble("weightage"))*mEndTermWeightage));
    mMarksawarded2 =(Math.ceil((mMarksawarded2/rs2.getDouble("weightage"))*mEndTermWeightage))+mprvMaks;
    //System.out.println("mMarksawarded2--"+mMarksawarded2+"rs2.getString(studentid)"+rs2.getString("studentid"));

}
tempMarksAwarded2=mMarksawarded2;

//----------------------------------------End of Medical Case ------------------------------------------------------------------------------------

 TAMarks=rs2.getString("TAMarks").toString();
               TAN=TAMarks.split("-")[0];
                TAN1=TAMarks.split("-")[1];
                // TAN=TAMarks.split("-");
               int i=Integer.parseInt(TAN);
               int j=Integer.parseInt(TAN1);
               double k=(curtaweightage*i)/j;
     mMarksawarded2=mMarksawarded2+k;
     mDebarWeight=rs2.getDouble("weightage")+j;
   // System.out.println("mMarksawarded2AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"+mMarksawarded2+"mDebarWeight"+mDebarWeight+"kkk"+k+"curtaweightage"+curtaweightage+"iiii"+i+"jjjj"+j);


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

qry3="select DECODE(NVL(DETAINED,'N'),'D',1,'A',2,3),nvl(Detained,'N')Detained,enrollmentno  from V#STUDENTEVENTSUBJECTMARKS where institutecode='"+mInst+"' and fstid='"+rs2.getString("fstid")+"' ";
qry3=qry3+" and examcode='"+mExamCode+"' and subjectID='"+mSubjectCode+"' and ";
qry3=qry3+" studentid='"+rs2.getString("studentid")+"' and nvl(LOCKED,'N')='Y' ";
// qry3=qry3+" and nvl(DETAINED,'N')<>'N' and RowNum=1 ";
qry3=qry3+" and nvl(DETAINED,'N') in ('D','A','M') AND STUDENTID NOT IN (SELECT STUDENTID FROM DEBARSTUDENTDETAIL WHERE EXAMCODE='"+mExamCode+"' AND NVL(MEDICALWITHDRAWAL,'N')='Y')  AND STUDENTID   IN (SELECT STUDENTID FROM DEBARSTUDENTDETAIL WHERE EXAMCODE='"+mExamCode+"' and fstid='"+rs2.getString("fstid")+"' )  ORDER BY 1";
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
					qry4="select ParameterValue from Parameters where CompanyCode='JIIT' ";
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
	mWeigh=mDebarWeight;
	GradeMatserStudentIDChecked=Studid+"*****"+StudentGradeCalculationMarks2+"$$$$$F"+"?????"+mWeigh+"#####"+StudentGradeCalculationMarksAwarded1+"/////"+mMassCut+"%%%%%"+mFst;
		GradeMatserStudentIDArray.add(GradeMatserStudentIDChecked);
	}

	if(mDebarGrade.equals("I"))
	{  
	
		StudentGradeCalculationMarks2=""+StudentGradeCalculationMarks;
		mGrad1=rs1.getString("GRADE");
		Studid=rs2.getString("studentid");
		mWeigh=mDebarWeight;
		GradeMatserStudentIDChecked=Studid+"*****"+StudentGradeCalculationMarks2+"$$$$$I"+"?????"+mWeigh+"#####"+StudentGradeCalculationMarksAwarded1+"/////"+mMassCut+"%%%%%"+mFst;
		GradeMatserStudentIDArray.add(GradeMatserStudentIDChecked);
	}
	if(mDetained.equals("D"))
	{
		StudentGradeCalculationMarks2=""+StudentGradeCalculationMarks;
		mGrad1=rs1.getString("GRADE");
		Studid=rs2.getString("studentid");
		mWeigh=mDebarWeight;
		GradeMatserStudentIDChecked=Studid+"*****"+StudentGradeCalculationMarks2+"$$$$$"+mGrad1+"?????"+mWeigh+"#####"+StudentGradeCalculationMarksAwarded1+"/////"+mMassCut+"%%%%%"+mFst;
		GradeMatserStudentIDArray.add(GradeMatserStudentIDChecked);
	}
      

if(!mDebarGrade.equals("F"))
	{
if( !mDebarGrade.equals("I"))
	{
if(!mDetained.equals("D"))
{
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

			mWeigh=mDebarWeight;

//debar students
	
                     //System.out.print("GradeMasterTotalCount="+GradeMasterTotalCount);
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
}}
	//	System.out.println("FFFFFFFFFFFFFFFFFFF"+GradeMatserStudentIDArray);
	session.setAttribute("GRADECHECKED",GradeMatserStudentIDArray);	
}


//System.out.println(GradeMatserStudentIDArray);

if(mDebarGrade.equals("F"))
	{ 
		mGrad1=rs1.getString("GRADE");
		Studid=rs2.getString("studentid");
		mWeigh=mDebarWeight;

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
		mWeigh=mDebarWeight;

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
		mWeigh=mDebarWeight;

		StudentGradeCalculationMarks1=""+StudentGradeCalculationMarks;
		GradeMatserStudentIDInitial=Studid+"*****"+StudentGradeCalculationMarks1+"$$$$$F"+"?????"+mWeigh+"#####"+StudentGradeCalculationMarksAwarded1+"/////"+mMassCut+"%%%%%"+mFst;

	//	GradeMatserStudentIDInitial=Studid+"*****"+StudentGradeCalculationMarks1+"$$$$$F"+"?????"+mWeigh;
		GradeMatserStudentIDArrayInit.add(GradeMatserStudentIDInitial);
	//	out.print(GradeMatserStudentIDInitial);
}
 

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
                 StudentGradeCalculationMarks2=""+StudentGradeCalculationMarks;
		mGrad1="F";
		Studid=rs2.getString("studentid");
                //System.out.println("New ID "+Studid+ "---"+StudentGradeCalculationMarks );
		mWeigh=mDebarWeight;
                GradeMasterTotalCount=GradeMasterTotalCount+1;
		GradeMatserStudentIDInitial=Studid+"*****"+StudentGradeCalculationMarks+"$$$$$F"+"?????"+mWeigh+"#####"+StudentGradeCalculationMarksAwarded1+"/////"+mMassCut+"%%%%%"+mFst;

	//	GradeMatserStudentIDInitial=Studid+"*****"+StudentGradeCalculationMarks1+"$$$$$F"+"?????"+mWeigh;
		GradeMatserStudentIDArrayInit.add(GradeMatserStudentIDInitial);
               // System.out.println("studentid 1 "+Studid+ "---"+StudentGradeCalculationMarks1 );
                }
	}

if(!xx.equals("Y") )
{

//	StudentGradeCalculationMarks=StudentGradeCalculationMarksAwarded1-0;
	
	//out.print(CALVALUEF+"<BR>");

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

// mInitialCount=30.0 ;

}else{

mInitialCount=mInitialCount;
}


	if(StudentGradeCalculationMarksAwarded1>=mInitialCount)
	{
		
		if(StudentGradeCalculationMarksAwarded1<mPrevValue )			
		{
			
		
			Studid=rs2.getString("studentid");
			mWeigh=mDebarWeight;

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

		}
	}
}
	}
	}
}
//System.out.println(GradeMatserStudentIDArrayInit);



//Qryim="  SELECT 'Y' FROM studentltpdetail  WHERE  FSTID IN ("+mCheckFstid+")  and studentid IN  ("+Studid+")       AND nvl(D.IMPROVEMENT,'N')='Y'  " ;
//rsim=db.getRowset(Qryim); 
 
//if(1==1  )
//{

//	ctim++;

//}
 
// ctim++;

// System.out.print("########"+ctim);
session.setAttribute("GRADEUNCHECKED",GradeMatserStudentIDArrayInit);

mDebarStudID=rs2.getString("studentid");
	//}
} // closing of while rs2
%>