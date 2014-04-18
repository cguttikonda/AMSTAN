<jsp:useBean id="global" class="ezc.ezbasicutil.EzGlobal" scope="session" />
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ page import = "ezc.ezparam.*,ezc.ezmisc.params.*" %>
<%
	String query_A="";
	String[] salesAreaValues = request.getParameterValues("salesArea");
	String areas ="";
	
	ezc.ezparam.EzcParams mainParams_N=null;
	ezc.eznews.params.EziNewsParams newsParam = null;
	ezc.eznews.client.EzNewsManager newsManager = null;
	ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
	ezc.ezparam.ReturnObjFromRetrieve repUsersObj=null;

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
		query_A=" SELECT DISTINCT  EU_ID,EU_FIRST_NAME,EU_MIDDLE_INITIAL,EU_LAST_NAME,EU_TYPE,EU_EMAIL  FROM EZC_USERS, EZC_USER_DEFAULTS WHERE EUD_USER_ID=EU_ID AND EUD_KEY='REPAGECODE' AND EUD_VALUE IN ('"+areas+"') AND EU_BUSINESS_PARTNER='22394' ORDER BY EU_FIRST_NAME";
	}
	else
	{
		query_A="SELECT DISTINCT  EU_ID,EU_FIRST_NAME,EU_MIDDLE_INITIAL,EU_LAST_NAME,EU_TYPE,EU_EMAIL  FROM EZC_USERS, EZC_USER_DEFAULTS WHERE EUD_USER_ID=EU_ID AND EU_BUSINESS_PARTNER='22394' ORDER BY EU_FIRST_NAME";
	}
	miscParams.setQuery(query_A);
	mainParams_N.setLocalStore("Y");
	mainParams_N.setObject(miscParams);
	Session.prepareParams(mainParams_N);
	

	try
	{
		repUsersObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_N);
	}
	catch(Exception e)
	{
		System.out.println("ERROR::::::::::::::::::::"+e);
	}	

%>
	