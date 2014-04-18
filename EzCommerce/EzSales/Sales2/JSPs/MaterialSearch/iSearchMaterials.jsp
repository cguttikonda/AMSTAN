<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>

<%@ page import="java.util.Date" %>
<%@ page import="ezc.ezparam.*" %>
<% 
	
	String className 	= request.getParameter("className");
	if(className==null)
	className="";
	String classType = "001";
	String maxRows 	 = "1000";
	
	ezc.ezparam.EzcParams   myParams	=new ezc.ezparam.EzcParams(true);
	ezc.ezmaterialsearch.client.EzMaterialSearchManager msManager	=new ezc.ezmaterialsearch.client.EzMaterialSearchManager();
	ezc.ezmaterialsearch.params.EziMaterialSearchParams msParams	=new ezc.ezmaterialsearch.params.EziMaterialSearchParams();
	msParams.setClassType(classType);
	msParams.setMaxRows(maxRows);
	msParams.setKeyDate(new Date());
	myParams.setObject(msParams);
	Session.prepareParams(myParams);

	System.out.println("111111111111111111111111111111111111111111111");
	
	ReturnObjFromRetrieve retClassList = (ezc.ezparam.ReturnObjFromRetrieve)msManager.ezGetClassList(myParams);
	
	System.out.println("222222222222222222222222222222222");
	
	
	
/**********************
com.sap.mw.jco.JCO.Function function 		= EzSAPHandler.getFunction("BAPI_CLASS_GETLIST","541~999");
com.sap.mw.jco.JCO.ParameterList parameterlist 	= function.getImportParameterList();

JCO.Client client = null;

java.util.Date date = new java.util.Date();

String classType = "001";
String maxRows 	 = "1000";

parameterlist.setValue(classType, "CLASSTYPE_IMP");
parameterlist.setValue(date, "KEYDATE");
parameterlist.setValue(maxRows, "MAXROWS");

try{
	
	client = EzSAPHandler.getSAPConnection("541~999");
	client.execute(function);
	
}
catch(Exception err)
{
	System.out.println("=====>"+err);
}
 
ReturnObjFromRetrieve retClassList = new ReturnObjFromRetrieve(new String[]{"CLASSNAME", "CLASSTYPE", "DESCRIPTION", "STATUS"});

try
{
        com.sap.mw.jco.JCO.Table table = function.getTableParameterList().getTable("CLASSLIST");
        int i = 0;
        if(table != null)
                 i = table.getNumRows();
        if(i > 0)
	        do
	        if(table.getValue("CLASSNAME") != null)
	        {
	                   retClassList.setFieldValue("CLASSNAME", table.getValue("CLASSNAME"));
	                   retClassList.setFieldValue("CLASSTYPE", table.getValue("CLASSTYPE"));
	                   retClassList.setFieldValue("DESCRIPTION", table.getValue("DESCRIPTION"));
	                   retClassList.setFieldValue("STATUS", table.getValue("STATUS"));
	                   retClassList.addRow();
	        }
	        while(table.nextRow());
}
catch(Exception exception)
{
       System.out.println("Exception in EzMaterialSearchOutputConversion:::ezGetClassList");       
}
finally
{
	if(client!=null)
	{
		JCO.releaseClient(client);
		client = null;
		function=null;
	}
}
//out.println(retClassList.toEzcString());	
**********************/			


		
	int retClassListCount=0;
	if(retClassList!=null) 
		retClassListCount = retClassList.getRowCount();
	//out.println("retClassListCount@@::"+retClassListCount);			

	/*
		Getting Class Characters and Class Values
	*/

	ReturnObjFromRetrieve retClassCharacters =null;
	ReturnObjFromRetrieve retClassValues     =null;
	ReturnObjFromRetrieve retMaterialList    =null;

	int retClassCharactersCount=0;
	int retClassValuesCount=0;
	int retMaterialListCount=0;

	if((className != null) && !("".equals(className)))
	{
		msParams.setClassNum(className);
		msParams.setWithValues("X");
		ezc.ezparam.ReturnObjFromRetrieve retCharactersMain	 = (ezc.ezparam.ReturnObjFromRetrieve)msManager.ezGetClassCharacters(myParams);

		//retClassValues		 = (ezc.ezparam.ReturnObjFromRetrieve)msManager.ezGetClassValues(myParams);

		if(retCharactersMain!=null)
		{
			retClassCharacters  =(ezc.ezparam.ReturnObjFromRetrieve)retCharactersMain.getFieldValue("CHARACTERISTICS");
			retClassValues  =(ezc.ezparam.ReturnObjFromRetrieve)retCharactersMain.getFieldValue("CHAR_VALUES");

			if(retClassCharacters!=null) retClassCharactersCount =retClassCharacters.getRowCount();
			if(retClassValues!=null) retClassValuesCount 	=retClassValues.getRowCount();
		}	

	}
%>	