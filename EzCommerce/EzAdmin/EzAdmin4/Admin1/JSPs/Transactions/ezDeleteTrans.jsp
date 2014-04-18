<%
	ezc.eztrans.EzTransactionParams trParams=new ezc.eztrans.EzTransactionParams();
	String key=request.getParameter("chk1");
	String values[]=new String[3];
	trParams.setOpType("CLEAR");
	trParams.setClearMode("SITEOBJECTKEY");
	out.println(key);
	java.util.StringTokenizer st=new java.util.StringTokenizer(key,",");
	int i=0;
	while(st.hasMoreTokens())
	{
		values[i]=(String)st.nextToken();
		i++;
	}
	trParams.setSite(values[0]);
	trParams.setObject(values[1]);
	trParams.setKey(values[2]);
	ezc.eztrans.EzTransaction eztrans=new ezc.eztrans.EzTransaction();
	eztrans.ezTrans(trParams);
	response.sendRedirect("ezTransListBySite.jsp");
%>