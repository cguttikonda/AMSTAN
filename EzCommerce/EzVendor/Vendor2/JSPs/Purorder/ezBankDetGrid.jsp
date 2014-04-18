<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Purorder/iBankDet.jsp"%>
<%
	out.println("<?xml version=\"1.0\"?>");
	out.println("<rows>");

	if(count>0)
	{
		String bankNo 	= "";
		String bankName = "";
		String bankType = "";
		String bankAddr = "";
		String bankAcct = "";
		String acctType = "";

		i=0;
		while (i++ < count)
		{
			bankNo   = (String)suppacct.getFieldValue(i-1,bank)==null || "null".equals((String)suppacct.getFieldValue(i-1,bank))?" ":(String)suppacct.getFieldValue(i-1,bank);
			bankName = (String)suppacct.getFieldValue(i-1,name);
			bankType = (String)suppacct.getFieldValue(i-1,type);
			bankAddr = (String)suppacct.getFieldValue(i-1,addr);
			bankAcct = (String)suppacct.getFieldValue(i-1,acct);
			acctType = (String)suppacct.getFieldValue(i-1,atyp);
			out.println("<row id='"+bankNo+"_"+i+"'><cell>"+bankNo+"</cell><cell>"+bankName+"</cell><cell>"+bankType+"</cell><cell>"+bankAddr+"</cell><cell>"+bankAcct+"</cell><cell>"+acctType+"</cell></row>");
		}
	}
	else
	{
		out.println("<row id='"+count+"'></row>");
	}
	out.println("</rows>");
%>