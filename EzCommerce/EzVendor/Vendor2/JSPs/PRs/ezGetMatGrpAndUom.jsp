<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>
<%

	JCO.Function function = null;
	JCO.Client client = null;

	String systemKey 		= (String)session.getValue("SYSKEY");
	String site = (String)session.getValue("Site");
	String connStr 		= "642~999";
	if(systemKey!=null)
		connStr = site+"~"+systemKey.substring(0,3);

	
	String material = request.getParameter("material");
	String plant = request.getParameter("plant");
	String matGrp="",matUom="";
	//if(material!=null)
	//{
	//	material = "000000000000000000"+material;
	//	material = material.substring((material.length()-18),material.length());
	//}

	
	try
	{

		function = EzSAPHandler.getFunction("BAPI_MATERIAL_GET_DETAIL",connStr);
		client = EzSAPHandler.getSAPConnection(connStr);
		JCO.ParameterList sapPreProc = function.getImportParameterList();

		sapPreProc.setValue(material, "MATERIAL");
		sapPreProc.setValue(plant, "PLANT");
		
		try
		{
			client.execute(function);
		}catch(Exception e){
			System.out.println("Exception while executing RFC call BAPI_MATERIAL_GET_DETAIL"+e);
		}			

		JCO.ParameterList expParam = function.getExportParameterList();
		JCO.Structure matDetSt = expParam.getStructure("MATERIAL_GENERAL_DATA");
		matGrp = (String)matDetSt.getValue("MATL_GROUP");
		matUom = (String)matDetSt.getValue("BASE_UOM");
		

	}
	catch(Exception e1)
	{
		System.out.println("Exception while preparing RFC call BAPI_MATERIAL_GET_DETAIL"+e1);
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

	out.print(matGrp+"¥"+matUom);
%>