<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,ezc.ezsfa.params.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />


<%!
	public String dateFormat(String str)
	{
		String finalStr="";
		
		if("00000000".equals(str) || "".equals(str.trim()))	
			finalStr="01/01/1900";
		else
			finalStr = str.substring(4,6)+"/"+str.substring(6,8)+"/"+str.substring(0,4);
			
		return finalStr;	
	}

	
%>

<%

	String hierarchyFile=request.getParameter("hierarchyFile");
	String priceFile=request.getParameter("priceFile");
	String productFile=request.getParameter("productFile");
	String filePath="F:\\ora9ias\\EzRemoteSales\\SampleFiles\\Product\\";
		
	
	String systemNo=request.getParameter("sysno");
	String catalog=request.getParameter("catalog");	

	long start=System.currentTimeMillis();

	if(hierarchyFile != null && !"".equals(hierarchyFile.trim()))	
	{
		hierarchyFile = filePath+hierarchyFile;
	}
	
	if(priceFile != null && !"".equals(priceFile.trim()))	
	{
		priceFile = filePath+priceFile;
	}
	if(productFile != null && !"".equals(productFile.trim()))	
	{
		productFile = filePath+productFile;
	}
	ezc.ezbasicutil.Ez3PLProductMassSynch massSynch = new ezc.ezbasicutil.Ez3PLProductMassSynch();
	massSynch.setSession(Session);
	massSynch.setDefaults(systemNo,catalog);
	System.out.println("Befor Sync  kpkpkpkpkkpkpkpk");
	massSynch.doSynch(hierarchyFile,priceFile,productFile);
	System.out.println("After Sync  kpkpkpkpkkpkpkpk");

	long end=System.currentTimeMillis();
	out.println("Total Time====================="+(end-start));	




	response.sendRedirect("ezPostSyncProducts.jsp");
	
	
%>	