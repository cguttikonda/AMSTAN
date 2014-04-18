<%@page import="java.util.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%	
	
	int myRetCnt1 = 0;
	
	String[] collRfqNo = request.getParameterValues("chk1");
	
	String colNums = "";
	
	for(int c=0;c<collRfqNo.length;c++)
	{
		if(c==0)
			colNums = collRfqNo[c];
		else	
			colNums = colNums+"$"+collRfqNo[c];
		
	}
	
	if(collRfqNo.length==1)
	{
	 	response.sendRedirect("ezPOCreateData.jsp?collectiveRFQNo="+colNums);	
	}
	
	

	ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager 	= new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams ezcparams				     		= new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQHeaderParams ezirfqheaderparams 	= new ezc.ezpreprocurement.params.EziRFQHeaderParams();
	
	ezc.ezparam.ReturnObjFromRetrieve[] myRet1 = new ezc.ezparam.ReturnObjFromRetrieve[collRfqNo.length];	
	
	for(int i=0;i<collRfqNo.length;i++)
	{
		ezirfqheaderparams.setCollectiveRFQNo(collRfqNo[i]);	
		ezirfqheaderparams.setExt1("QCS");	
		ezcparams.setObject(ezirfqheaderparams);
		ezcparams.setLocalStore("Y");
		Session.prepareParams(ezcparams);

		try
		{
			myRet1[i] = (ezc.ezparam.ReturnObjFromRetrieve)ezrfqmanager.ezGetRFQList(ezcparams);
			
			
		}
		catch(Exception e)
		{
			System.out.println("Exception Occured while getting QCFs List:"+e);
		}
	}
	
	
	java.util.Vector firstQcfVec = new java.util.Vector();
	for(int k=0;k<myRet1[0].getRowCount();k++)
	{
		if(("R".equals(myRet1[0].getFieldValueString(k,"RELEASE_INDICATOR").trim())))
		{
			firstQcfVec.addElement(myRet1[0].getFieldValueString(k,"VENDOR")+"#"+myRet1[0].getFieldValueString(k,"PLANT"));
		}
	}
	
	
	
	boolean flag = false;

	java.util.Vector commonVendors = new java.util.Vector();
	//java.util.Set commonVendors = new java.util.HashSet();
	//java.util.Set rfqNumbers = new java.util.HashSet();
		
	
		
	for(int j=1;j<2;j++)
	{
		for(int k=0;k<myRet1[j].getRowCount();k++)
		{
			if(("R".equals(myRet1[j].getFieldValueString(k,"RELEASE_INDICATOR").trim())))
			{
				boolean b = firstQcfVec.contains(myRet1[j].getFieldValueString(k,"VENDOR")+"#"+myRet1[j].getFieldValueString(k,"PLANT"));
				 if(b)
				 {
				 	commonVendors.addElement(myRet1[j].getFieldValueString(k,"VENDOR")+"#"+myRet1[j].getFieldValueString(k,"PLANT"));
				 }
			}
		}
	}
	
	if(collRfqNo.length==2)
	{
		if(commonVendors.size()>0)
		{
			response.sendRedirect("ezPOCreateData.jsp?collectiveRFQNo="+colNums);	
		}	
	}
	
	
	if(commonVendors.size()==1)
	{
		if(collRfqNo.length>2)
		{
			int matchCnt = 0;
			String firstVendor = (String)commonVendors.get(0);
			out.println(firstVendor);
			for(int j=2;j<collRfqNo.length;j++)
			{
				for(int k=0;k<myRet1[j].getRowCount();k++)
				{
					if(("R".equals(myRet1[j].getFieldValueString(k,"RELEASE_INDICATOR").trim())))
					{
						 if(firstVendor.equals(myRet1[j].getFieldValueString(k,"VENDOR")+"#"+myRet1[j].getFieldValueString(k,"PLANT")))
						 {
							flag = true;
							matchCnt++;
							break;
						 }
					}
				}
			}
			if(flag && collRfqNo.length==(2+matchCnt))
				response.sendRedirect("ezPOCreateData.jsp?collectiveRFQNo="+colNums);	
		}	
	}
	
	if(commonVendors.size()==2)
	{
		if(collRfqNo.length>2)
		{
			String firstVendor = (String)commonVendors.get(0);
			String secondVendor = (String)commonVendors.get(1);
			int matchCnt1 = 0;
			int matchCnt2 = 0;
			for(int j1=2;j1<collRfqNo.length;j1++)
			{
				for(int k=0;k<myRet1[j1].getRowCount();k++)
				{
					if(("R".equals(myRet1[j1].getFieldValueString(k,"RELEASE_INDICATOR").trim())))
					{
						 if(firstVendor.equals(myRet1[j1].getFieldValueString(k,"VENDOR")+"#"+myRet1[j1].getFieldValueString(k,"PLANT")))
						 {
							flag = true;
							matchCnt1++;
							break;
						 }
					}
				}
			}
			
			if(flag && collRfqNo.length==(2+matchCnt1))
				response.sendRedirect("ezPOCreateData.jsp?collectiveRFQNo="+colNums);	
			
			for(int j2=2;j2<collRfqNo.length;j2++)
			{
				for(int k=0;k<myRet1[j2].getRowCount();k++)
				{
					if(("R".equals(myRet1[j2].getFieldValueString(k,"RELEASE_INDICATOR").trim())))
					{
						 if(secondVendor.equals(myRet1[j2].getFieldValueString(k,"VENDOR")+"#"+myRet1[j2].getFieldValueString(k,"PLANT")))
						 {
							flag = true;
							matchCnt2++;
							break;
						 }
					}
				}
			}
			
			if(flag && collRfqNo.length==(2+matchCnt2))
				response.sendRedirect("ezPOCreateData.jsp?collectiveRFQNo="+colNums);	
		}	
	}
	
	
	if(commonVendors.size()==3)
	{
		if(collRfqNo.length>2)
		{
			String firstVendor = (String)commonVendors.get(0);
			String secondVendor = (String)commonVendors.get(1);
			String thirdVendor = (String)commonVendors.get(2);
			
			int matchCnt1 = 0;
			int matchCnt2 = 0;
			int matchCnt3 = 0;
			
			for(int j1=2;j1<collRfqNo.length;j1++)
			{
				for(int k=0;k<myRet1[j1].getRowCount();k++)
				{
					if(("R".equals(myRet1[j1].getFieldValueString(k,"RELEASE_INDICATOR").trim())))
					{
						 if(firstVendor.equals(myRet1[j1].getFieldValueString(k,"VENDOR")+"#"+myRet1[j1].getFieldValueString(k,"PLANT")))
						 {
							flag = true;
							matchCnt1++;
							break;
						 }
					}
				}
			}
			
			if(flag && collRfqNo.length==(2+matchCnt1))
				response.sendRedirect("ezPOCreateData.jsp?collectiveRFQNo="+colNums);
			
			
			
			for(int j2=2;j2<collRfqNo.length;j2++)
			{
				for(int k=0;k<myRet1[j2].getRowCount();k++)
				{
					if(("R".equals(myRet1[j2].getFieldValueString(k,"RELEASE_INDICATOR").trim())))
					{
						 if(secondVendor.equals(myRet1[j2].getFieldValueString(k,"VENDOR")+"#"+myRet1[j2].getFieldValueString(k,"PLANT")))
						 {
							flag = true;
							matchCnt2++;
							break;
						 }
					}
				}
			}
			
			if(flag && collRfqNo.length==(2+matchCnt2))
				response.sendRedirect("ezPOCreateData.jsp?collectiveRFQNo="+colNums);
			
			
			
			
			for(int j3=2;j3<collRfqNo.length;j3++)
			{
				for(int k=0;k<myRet1[j3].getRowCount();k++)
				{
					if(("R".equals(myRet1[j3].getFieldValueString(k,"RELEASE_INDICATOR").trim())))
					{
						 if(thirdVendor.equals(myRet1[j3].getFieldValueString(k,"VENDOR")+"#"+myRet1[j3].getFieldValueString(k,"PLANT")))
						 {
							flag = true;
							matchCnt3++;
							break;
						 }
					}
				}
			}
			
			if(flag && collRfqNo.length==(2+matchCnt3))
				response.sendRedirect("ezPOCreateData.jsp?collectiveRFQNo="+colNums);
			
		}	
	}
	
	
	
	response.sendRedirect("../Rfq/ezCommonVndrMsg.jsp");	

%>	