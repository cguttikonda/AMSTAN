<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ page import ="ezc.ezparam.*,java.util.*,ezc.ezpreprocurement.params.*" %>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>




<%
	String searchType="DESC";
	String matDescription = "cam"; 
	String selPlant = "BP01" ;
	String myIndex = "0";
	String material = "";
	String maxRows = "0";
	String SAP ="Y";
	
	if(maxRows==null || "null".equals(maxRows)|| "".equals(maxRows))
	maxRows="10";
	
	String systemKey 		= (String)session.getValue("SYSKEY");
	String site = (String)session.getValue("Site");
	String connStr 		= "642~999";
	if(systemKey!=null)
		connStr = site+"~"+systemKey.substring(0,3);
	
	
	
	int materialsCount = 0;
	ReturnObjFromRetrieve retMaterialsList =null;
	EzcParams ezContainer  = new EzcParams(true);
	 
	String MATN0="MAT_CODE";
	String MATDESC="MAT_DESC";
	retMaterialsList=new ReturnObjFromRetrieve(new String[]{"MAT_CODE","MAT_DESC"});

	JCO.Function function = null;
	JCO.Client client = null;
	try
	{

		function = EzSAPHandler.getFunction("BAPI_MATERIAL_GETLIST",connStr);
		client = EzSAPHandler.getSAPConnection(connStr);
		JCO.ParameterList sapPreProc = function.getImportParameterList();
		JCO.ParameterList sapTabParam = function.getTableParameterList();
		JCO.Table ScrSelection = sapTabParam.getTable("MATNRSELECTION");
		JCO.Table DescSelection = sapTabParam.getTable("MATERIALSHORTDESCSEL");
		JCO.Table PlantSelection = sapTabParam.getTable("PLANTSELECTION");

		if(maxRows != null)
		    sapPreProc.setValue(maxRows, "MAXROWS");
		
		PlantSelection.appendRow();
		PlantSelection.setValue("I", "SIGN");
		PlantSelection.setValue("EQ", "OPTION");
		PlantSelection.setValue(selPlant, "PLANT_LOW");
		    
		if("DESC".equals(searchType))
		{
			DescSelection.appendRow();
			DescSelection.setValue("I", "SIGN");
			DescSelection.setValue("CP", "OPTION");
			DescSelection.setValue("*"+matDescription+"*", "DESCR_LOW");
		
		
		}
		else
		{
			ScrSelection.appendRow();
			ScrSelection.setValue("I", "SIGN");
			ScrSelection.setValue("CP", "OPTION");
			ScrSelection.setValue("*"+material+"*", "MATNR_LOW");
			//ScrSelection.appendRow();
			//ScrSelection.setValue("I", "SIGN");
			//ScrSelection.setValue("CP", "OPTION");
			//ScrSelection.setValue(material, "MATNR_LOW");
		}
		try
		{
			client.execute(function);
		}catch(Exception e){
			System.out.println("Exception while executing RFC call BAPI_MATERIAL_GETLIST"+e);
		}			


		JCO.ParameterList expParam = function.getExportParameterList();
		JCO.Table retOut = function.getTableParameterList().getTable("MATNRLIST");
		int count = retOut.getNumRows();
		//out.println("selPlant>>>>"+selPlant+retOut.toString());

		if(count>0)
		{
			do
			{
				retMaterialsList.setFieldValue("MAT_CODE",retOut.getValue("MATERIAL"));
				retMaterialsList.setFieldValue("MAT_DESC",retOut.getValue("MATL_DESC"));
				retMaterialsList.addRow();
			}
			while(retOut.nextRow());
		}



	}
	catch(Exception e1)
	{
		System.out.println("Exception while preparing RFC call BAPI_MATERIAL_GETLIST"+e1);
	}
	finally
	{
		if (client!=null)
		{
			System.out.println("R E L E A S I N G   C L I E N T .... ");
			JCO.releaseClient(client);
			client = null;
			function=null;
		}
	}
	
	if(retMaterialsList!=null)
	{
		materialsCount = retMaterialsList.getRowCount();
	}
%>



<html>
<head>
<Title>Search Result</Title>
<base target="_self">
<Script src="../../Library/JavaScript/ezTrim.js"></Script>
<Script>
	var tabHeadWidth=95
	var tabHeight="75%"
</Script>
<Script>
	
	
	
	
</Script>	
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body scroll="no" onLoad='scrollInit(10)' onResize='scrollInit(10)'>
<form name='myForm'>
<%
  
	if(materialsCount > 0)
	{
		
		
		for(int i=0;i<materialsCount;i++)
		{
		
		//out.println(retMaterialsList.toEzcString());
		out.println("desc=="+retMaterialsList.getFieldValueString(i,MATDESC).trim()+"\n");
		
		}
		
		

	}

%>	
<input type="hidden" name="matCode" value="<%=material%>">
<input type="hidden" name="matDesc" value="<%=matDescription%>">
<input type="hidden" name="searchType" value="<%=searchType%>">
<input type="hidden" name="myIndex" value="<%=myIndex%>">
<input type="hidden" name="selPlant" value="<%=selPlant%>">


</form>
<Div id="MenuSol"></Div>
</body>
</html>