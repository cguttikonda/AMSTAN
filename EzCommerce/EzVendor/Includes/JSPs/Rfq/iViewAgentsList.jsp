<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%
		ezc.ezpreprocurement.client.EzPreProcurementManager agentManager = new ezc.ezpreprocurement.client.EzPreProcurementManager();
		ezc.ezparam.EzcParams ezcparams	= new ezc.ezparam.EzcParams(false);
		ezc.ezpreprocurement.params.EziAgentParams eziagentparams= new ezc.ezpreprocurement.params.EziAgentParams();
		String matNo   = request.getParameter("matNo");
		
		eziagentparams.setMatCode("AM2-200");
		ezcparams.setObject(eziagentparams);
		ezcparams.setLocalStore("Y");
		Session.prepareParams(ezcparams);
		
		ezc.ezparam.ReturnObjFromRetrieve agentsList = null;	
		try
		{
			agentsList = (ezc.ezparam.ReturnObjFromRetrieve)agentManager.ezGetAgentsList(ezcparams);
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		int agentsCount =0;
		if(agentsList!= null)
		{
			agentsCount = agentsList.getRowCount();
		}
	

%>