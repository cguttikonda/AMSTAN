<jsp:useBean id="global" class="ezc.ezbasicutil.EzGlobal" scope="session" />
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ page import = "ezc.ezparam.*,ezc.ezmisc.params.*" %>
<%
	String query_A="";
	String[] salesAreaValues = request.getParameterValues("salesArea");
	String areas ="";
	
	ezc.ezparam.EzcParams mainParams_N=null;
	ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
	ezc.ezparam.ReturnObjFromRetrieve soldTOsListObj=null;

	mainParams_N=new ezc.ezparam.EzcParams(true);
	miscParams.setIdenKey("MISC_SELECT");
	
	if(salesAreaValues!=null && !"null".equals(salesAreaValues) && !"".equals(salesAreaValues))
	{
		for(int sA=0;sA<salesAreaValues.length;sA++)
		{
			if(sA==0)
				areas = salesAreaValues[sA];
			else
				areas = areas+"','"+salesAreaValues[sA];
			//out.print("salesAreaValues::::::"+salesAreaValues[sA]);
		}
		query_A="SELECT DISTINCT(EC_ERP_CUST_NO),ECA_NAME,ECA_CITY,ECA_STATE FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE EC_NO=ECA_NO AND EC_PARTNER_FUNCTION='AG' AND EC_SYS_KEY IN ('"+areas+"')";
	}
	else
	{
		query_A="SELECT DISTINCT(EC_ERP_CUST_NO),ECA_NAME,ECA_CITY,ECA_STATE FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE EC_NO=ECA_NO AND EC_PARTNER_FUNCTION='AG' AND EC_SYS_KEY NOT IN ('999701','999702','999704')";
	}
	miscParams.setQuery(query_A);
	mainParams_N.setLocalStore("Y");
	mainParams_N.setObject(miscParams);
	Session.prepareParams(mainParams_N);
	

	try
	{
		soldTOsListObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_N);
	}
	catch(Exception e)
	{
		System.out.println("ERROR::::::::::::::::::::"+e);
	}	

	ezc.ezparam.EzcParams mainParams_SA=null;
	ezc.ezmisc.params.EziMiscParams miscParams_SA = new ezc.ezmisc.params.EziMiscParams();
	ezc.ezparam.ReturnObjFromRetrieve salesAreaListObj=null;
	
	mainParams_SA=new ezc.ezparam.EzcParams(true);

	miscParams_SA.setIdenKey("MISC_SELECT");
	String query_SA="SELECT * FROM EZC_CAT_AREA_DEFAULTS WHERE ECAD_KEY IN ('DISTRIBUTION','DIVISION','SALESORG') AND ECAD_SYS_KEY NOT IN ('999701','999702','999704')ORDER BY ECAD_SYS_KEY";
	miscParams_SA.setQuery(query_SA);

	mainParams_SA.setLocalStore("Y");
	mainParams_SA.setObject(miscParams_SA);
	Session.prepareParams(mainParams_SA);
	

	try
	{
		salesAreaListObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_SA);
	}
	catch(Exception e)
	{
		System.out.println("ERROR::::::::::::::::::::"+e);
	}	
%>
	