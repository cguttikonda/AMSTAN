<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ page import="ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>

<jsp:useBean id="BPManager1" class="ezc.client.CEzBussPartnerManager" scope="session"></jsp:useBean>
<jsp:useBean id="AdminUtilsManager" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ page import="java.util.*,ezc.ezparam.*,ezc.ezmisc.params.*,java.sql.*" %>



<%
	String websys="";
	String websyskey=request.getParameter("WebSysKey");
	
	
	if("All".equals(websyskey))
			websys=websyskey;
	
	ReturnObjFromRetrieve ret1 = null;
	
	EzcParams mainParams= new EzcParams(false);
	EziMiscParams miscParams= new EziMiscParams();

	miscParams.setIdenKey("MISC_SELECT");
	String query="SELECT A.EBPC_BUSS_PARTNER,C.ECA_COMPANY_NAME,C.ECA_TELEBOX_NO FROM ezc_buss_partner_config A,EZC_CUSTOMER_ADDR C WHERE ( (A.EBPC_CATALOG_NO=0) AND (0 < (SELECT  COUNT(*) FROM EZC_BUSS_PARTNER_AREAS B  WHERE RTRIM(LTRIM(B.EBPA_BUSS_PARTNER))= RTRIM(LTRIM(A.EBPC_BUSS_PARTNER))  AND B.EBPA_SYS_KEY IN ('"+websyskey+"'))) AND C.eca_no = A.ebpc_buss_partner) OR ((A.EBPC_CATALOG_NO!=0) AND (0 = (SELECT  COUNT(*) FROM EZC_CATALOG_GROUP C WHERE C.ECG_CATALOG_NO=A.EBPC_CATALOG_NO AND C.ECG_SYS_KEY IN ('"+websyskey+"')))) AND C.eca_no = A.ebpc_buss_partner and C.ECA_TELEBOX_NO!='NULL'";
	miscParams.setQuery(query);

	mainParams.setLocalStore("Y");
	mainParams.setObject(miscParams);
	Session.prepareParams(mainParams);
	if((websyskey!=null) && !("All".equals(websyskey))&& !"sel".equals(websyskey))
	{	
		try
		{		
			ret1= (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams);
		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}
	}	
	
	java.util.TreeSet alphaTree = new java.util.TreeSet();
	String alphaName = null;
	String initAlpha = "";
	int deleteCount = 0;
	if(websyskey!=null && !"null".equals(websyskey))
	{
		
		deleteCount = ret1.getRowCount();
		for(int i=0;i<deleteCount;i++)
		{
			alphaName = ret1.getFieldValueString(i,"ECA_COMPANY_NAME");
			alphaTree.add((alphaName.substring(0,1)).toUpperCase());
		}
		if(alphaTree.size()>0)
		initAlpha = (String)alphaTree.first()+"*";
	}	
	String searchPartner=request.getParameter("searchcriteria");
	if(alphaTree.size()>0 && "$".equals(searchPartner))
		searchPartner=(String)alphaTree.first()+"*";
%>
