<%
	String userRole_C	= (String)session.getValue("UserRole");
	String discCreated_C 	= "";
	boolean applyDisc_C	= true;
	
	//out.println("::userRole_C::"+userRole_C);

	java.util.ArrayList salesRepRes_List = new java.util.ArrayList();
	
	String salesRepRes ="PORTTEST01¤I¥SAMTEST1¤I"; //(String)session.getValue("SALESREPRES");
	String salesRep_C = "";

	//out.println("::salesRepRes::"+salesRepRes);	
	try
	{
		StringTokenizer stEcadVal = new StringTokenizer(salesRepRes,"¥");

		while(stEcadVal.hasMoreTokens())
		{
			String salesRep_A = (String)stEcadVal.nextElement();
			String salesRep_AId = salesRep_A.split("¤")[0];
			
			//out.println("::salesRep_AId::"+salesRep_AId);	
			
			if(!salesRepRes_List.contains(salesRep_AId))
				salesRepRes_List.add(salesRep_AId);

			salesRep_C = salesRep_C+"','"+salesRep_AId;
		}
	}
	catch(Exception e){}
	
	

	
	if(salesRep_C.startsWith("','"))
		salesRep_C = salesRep_C.substring(3);
		
	//out.println("::salesRep_C::"+salesRep_C);		
	
	if("CU".equals(userRole_C) || "CUSR".equals(userRole_C))
		discCreated_C = salesRep_C;	//(String)session.getValue("SALESREPRES");
	else if("CM".equals(userRole_C))
	{
		String lUserId = Session.getUserId();
		if(salesRepRes_List.contains(lUserId))
			discCreated_C = salesRep_C;
		else
			applyDisc_C = false;
	}
	
	//out.println("applyDisc_C:::"+applyDisc_C);
%>