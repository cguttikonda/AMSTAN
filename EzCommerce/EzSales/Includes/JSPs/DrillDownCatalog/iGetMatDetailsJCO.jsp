
<%@ page import ="ezc.ezparam.*,ezc.ezsap.*" %>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>
<%!
	public String eliminateDecimals(String str)
	{
		String remainder="";
		if(str.indexOf(".")!=-1)
			str = str.substring(0,str.indexOf("."));
		return str;	
	}
%>
<%
	
	
	ezc.ezparam.ReturnObjFromRetrieve outRet = new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"MATNR","MFRPN","MFRNR","NAME","LBKUM","STPRS","PEINH"});
	
	int retCount1 =0;
	JCO.Function function = null;
	JCO.Client client = null;
	String siteNo = (String)session.getValue("Site");

	java.util.Hashtable matDetails = new java.util.Hashtable();
	java.util.Hashtable matTxtDet = new java.util.Hashtable();
	String matKey="",matProps="",manuNum="",manuName="",manuStk="",mattxt="",matTxtFlg="";
	try
	{
		client 	  = EzSAPHandler.getSAPConnection(siteNo+"~999");
		function  = EzSAPHandler.getFunction("Z_EZ_MATERIAL_LIST",siteNo+"~999");		
		JCO.ParameterList sapTabParam = function.getTableParameterList();
		
		//For material Text
		JCO.ParameterList importParam = function.getImportParameterList();
		importParam.setValue("X","WITH_LONG_TEXT");
		
		JCO.Table MaterialTab	= sapTabParam.getTable("MATERIALS");		
		String strMaterial	= "";
		

		for(int i=0;i<ret.getRowCount();i++)
		{
			strMaterial = ret.getFieldValueString(i,"EMM_NO");
			MaterialTab.appendRow();
			MaterialTab.setValue(strMaterial,"MATNR");
		}

		try{
			client.execute(function);
			EzSAPHandler.commit(client);		
		}
		catch(Exception e)
		{
			System.out.println("ERROR OCCURS IN EXECUTING FUNCTION");
		}
		
		
		try{
			 JCO.Table retOut = function.getTableParameterList().getTable("MATERIALS");
			 
			 //retOut.toString();	
			// ezc.ezcommon.EzLog4j.log("TXTFLGGGGGGGGGGGGG"+retOut.toString(),"I");
			 int matCount = retOut.getNumRows();	
			 
			// System.out.println("matCount>>>>>>>>>>>>>>>>>>"+matCount);
			 if(matCount>0)
			 {
				do
				{
					/*
					outRet.setFieldValue("MATNR", retOut.getValue("MATNR"));
					outRet.setFieldValue("MFRPN",retOut.getValue("MFRPN"));
					outRet.setFieldValue("MFRNR",retOut.getValue("MFRNR"));
					outRet.setFieldValue("NAME",retOut.getValue("NAME"));
					outRet.setFieldValue("LBKUM",retOut.getValue("LBKUM"));
					outRet.setFieldValue("STPRS",retOut.getValue("STPRS"));
					outRet.setFieldValue("PEINH",retOut.getValue("PEINH"));
					outRet.addRow();
					*/
					matKey	= (String)retOut.getValue("MATNR");
					manuName= (String)retOut.getValue("NAME");
					try{
					matTxtFlg  = (String)retOut.getValue("TEXT_EXISTS");
					}catch(Exception e){ matTxtFlg="Y"; }
					manuStk	= (String)retOut.getValue("LBKUM");
					
					ezc.ezcommon.EzLog4j.log("manNum>>:"+matKey+" stock>>:"+manuStk,"I");
					
					//ezc.ezcommon.EzLog4j.log("TXTFLGGGGGGGGGGGGG"+matTxtFlg,"I");
					 
					try
					{
						manuNum = (Integer.parseInt((String)retOut.getValue("MFRPN")))+"";	
					}
					catch(Exception e)
					{
						manuNum = (String)retOut.getValue("MFRPN");
					}
					if(manuNum==null || "".equals(manuNum) || "null".equals(manuNum)) 
						manuNum = "&nbsp;";
					if(manuName==null || "".equals(manuName) || "null".equals(manuName))	
						manuName = "&nbsp;";
					if(manuStk==null || "".equals(manuStk) || "null".equals(manuStk))	
						manuStk = "0";
					if(matTxtFlg==null || "".equals(matTxtFlg) || "null".equals(matTxtFlg))	
						mattxt = "N";
					else if("Y".equals(matTxtFlg))	
						mattxt = "Y";	
						
					matProps= manuNum + "@@@" + manuName + "@@@" + eliminateDecimals(manuStk)+ "@@@" +mattxt;
					
					matDetails.put(matKey,matProps);
					
				}
				while(retOut.nextRow());
			  }
			 
			  
			  
			  
			  
		}
		catch (Exception e)
		{
			ezc.ezcommon.EzLog4j.log("Exception in out conversion","W");
		}
	}
	catch(Exception eifs)
	{
	 	ezc.ezcommon.EzLog4j.log("ERROR OCCURS IN EXECUTING FUNCTION","W");
	}
	finally
	{
	 	if (client!=null)
	 	{
			ezc.ezcommon.EzLog4j.log("R E L E A S I N G   C L I E N T .... ","W");
			JCO.releaseClient(client);
			client = null;
			function = null;
		}
	}
	
%>
<%--

MATNR -     Material Number		MATNR ----> Field Value : 000000000001000034
MFRPN -     Manufacturer part number	MFRPN ----> Field Value : SECA22S
MFRNR -     Manufacturer number		MFRNR ----> Field Value : 0000100673
NAME  -     Name of vendor		NAME ----> Field Value : Service Ideas
LBKUM -     Total valuated stock	LBKUM ----> Field Value : 9.000
STPRS -     Standard price		STPRS ----> Field Value : 33.49
PEINH -     Price unit			PEINH ----> Field Value : 1

--%>