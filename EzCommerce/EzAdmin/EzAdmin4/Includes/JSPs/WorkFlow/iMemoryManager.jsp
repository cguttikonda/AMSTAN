
<%
	String tag="";
	try
	{
		javax.ejb.Handle myHandle=(javax.ejb.Handle)myParams.getEjbHandle();
		ezc.ezcsm.EzUser myUser= (ezc.ezcsm.EzUser)myHandle.getEJBObject();
		tag=myUser.getConnGroup();
	}
	catch(Exception e)
	{}

	ezc.ezworkflow.client.EzWorkFlowManager manager = new ezc.ezworkflow.client.EzWorkFlowManager();
	java.util.Enumeration enum1 = (manager.WFHash).keys();
	String nextElement=null;
	
	
	System.out.println(">>>>>>>>>>>>>>>>unbindStr:"+unbindStr);
	

	if(unbindStr.equals("Templatesteps"))
	{
		while(enum1.hasMoreElements())
		{
			nextElement = (String)enum1.nextElement();
			
			System.out.println("NEXT ELEMENT : "+nextElement);

			if(nextElement.indexOf("EZCWFTEMPSTEPS"+tag) >= 0)
			{
				(manager.WFHash).remove(nextElement);
				out.println("removed="+nextElement);
				System.out.println("removed="+nextElement);
			}	
		}
	}
	else if(unbindStr.equals("Organograms"))
	{
		while(enum1.hasMoreElements())
		{
			nextElement = (String)enum1.nextElement();

			if(nextElement.indexOf("EZCWFORGANOGRAMS"+tag) >= 0)
				(manager.WFHash).remove(nextElement);
		}
	}
	else if(unbindStr.equals("OrganogramLevels"))
	{
		while(enum1.hasMoreElements())
		{
			nextElement = (String)enum1.nextElement();

			if(nextElement.indexOf("EZCWFORGLEVELS"+tag) >= 0)
				(manager.WFHash).remove(nextElement);
		}
	}

%>