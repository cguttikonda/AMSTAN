<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/MailGroupBean.jsp" %>

<%
	String[] groups=request.getParameterValues("chk1");
	String groupIds="'"+groups[0]+"'";
	for(int i=1;i<groups.length;i++)
	{
		groupIds += ",'"+groups[i]+"'";
	}


	EzcParams eParams = new EzcParams(false);

	EziMailGroupStructure struct = new EziMailGroupStructure();
	struct.setMailGroupId(groupIds);

	eParams.setObject(struct);
	Session.prepareParams(eParams);
	Mail.ezDeleteMailGroups(eParams);

	try
	{
		javax.ejb.Handle myHandle=(javax.ejb.Handle)eParams.getEjbHandle();
		ezc.ezcsm.EzUser myUser= (ezc.ezcsm.EzUser)myHandle.getEJBObject();

		String connStr="";
		String connGrp=myUser.getConnGroup();
		for(int i=0;i<groups.length;i++)
		{
			connStr=groups[i]+"_"+connGrp;

			if(ezc.ezmail.EzMail.htable.get(connStr) != null)
				ezc.ezmail.EzMail.htable.remove(connStr);
		}

	} catch(Exception e)
	{
		out.println(e);
	}



	response.sendRedirect("ezListMailGroups.jsp");
%>
