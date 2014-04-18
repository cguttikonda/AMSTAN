<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>
<%@page import="ezc.ezutil.*,ezc.ezparam.*,ezc.ezpreprocurement.params.*"%>
<jsp:useBean id="Manager" class="ezc.ezpreprocurement.client.EzPreProcurementManager" />	
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%
	//Create PO
	
	JCO.Client client = null;
	JCO.Function function = null;
	String createdPONum = "";
	boolean poCreated = false;
	
	java.util.Hashtable compht = (java.util.Hashtable)session.getValue("COMP_CODE");
	String compCode = (String)compht.get(session.getValue("SYSKEY"));
	
	String purchOrg = (String)Session.getUserPreference("PURORG");
	
	String systemKey = (String)session.getValue("SYSKEY");
	java.util.Hashtable purgrphash	=  (java.util.Hashtable)session.getValue("PURGROUPS");
	String purGrp = "";	
	if(purgrphash!=null)
		purGrp = (String)purgrphash.get(systemKey);
	String docType = "UB";
	String siteNo = (String)session.getValue("Site");
	
	ReturnObjFromRetrieve outRet = new ReturnObjFromRetrieve(new String[] {
		            "PO_NUM", "TYPE", "ID", "NUMBER", "MESSAGE", "LOG_NO", "LOG_MSG_NO", "MESSAGE_V1", "MESSAGE_V2", "MESSAGE_V3", 
		            "MESSAGE_V4", "PARAMETER", "ROW", "FIELD", "SYSTEM"
	        });
	         String retMessage ="";
				boolean closing=false;
	boolean prclose=true;
	
	String supp_Plant = "";
	String itemDesc = "";
	String itmMaterial = "";
	String itmPlant = "";
	String itmQty = "";
	String delvDate = "";
	String qty = "";
	
	
	supp_Plant  = request.getParameter("suppPlant");
	itemDesc    = request.getParameter("matDesc0");  		
	itmMaterial = request.getParameter("matNumber0");
	itmPlant    = request.getParameter("recPlant");	
	delvDate    = request.getParameter("delvDate0");	
	qty 	    = request.getParameter("poQty");
	//out.println(delvDate);
	delvDate = delvDate.replaceAll("\\.","/");
	//out.println(delvDate);
	
	
	/*out.println("::supp_Plant::"+supp_Plant);
	out.println("::itemDesc::"+itemDesc);
	out.println("::itmMaterial::"+itmMaterial);
	out.println("::itmPlant::"+itmPlant);
	out.println("::itmQty::"+itmQty);
	out.println("::delvDate::"+delvDate);
	out.println("::qty::"+qty);
	
	supp_Plant 	= "BP01";
	itemDesc 	= "Control card";
	itmMaterial 	= "MD-4300";
	itmPlant 	= "BP02";
	itmQty 		= "156";
	delvDate 	= "05/31/2013";
	qty 		= "15";*/
	
	
	
	
	
	
	
	String oDate = "04/23/2013";
	//java.util.Date ordDate = (java.util.Date)dtlXML.getFieldValue(0,"ORDERDATE");
	java.util.Date ordDate = new Date(oDate);
	
try
{
	
	client   = EzSAPHandler.getSAPConnection(siteNo+"~999");
	function = EzSAPHandler.getFunction("BAPI_PO_CREATE1");
        JCO.ParameterList sapImpParam = function.getImportParameterList();
        JCO.ParameterList sapTabParam = function.getTableParameterList();
        JCO.Structure PoHeader = sapImpParam.getStructure("POHEADER");
        JCO.Structure PoHeaderx = sapImpParam.getStructure("POHEADERX");
        JCO.Table PoItem = sapTabParam.getTable("POITEM");
        JCO.Table PoItemx = sapTabParam.getTable("POITEMX");
        JCO.Table PoSchedule = sapTabParam.getTable("POSCHEDULE");
        JCO.Table PoSchedulex = sapTabParam.getTable("POSCHEDULEX");
        
         /*out.println(":compCode::"+compCode);
         out.println(":docType::"+docType);
         out.println(":ordDate::"+ordDate);
         out.println(":purchOrg::"+purchOrg);
         out.println(":compCode::"+compCode);*/
                
        PoHeader.setValue(compCode, "COMP_CODE");
        PoHeaderx.setValue("X", "COMP_CODE");
        
        PoHeader.setValue(docType, "DOC_TYPE");
        PoHeaderx.setValue("X", "DOC_TYPE");
        
        PoHeader.setValue(ordDate, "CREAT_DATE");
	PoHeaderx.setValue("X", "CREAT_DATE");
       
        PoHeader.setValue(purchOrg, "PURCH_ORG");
        PoHeaderx.setValue("X", "PURCH_ORG");
        
        PoHeader.setValue(purGrp, "PUR_GROUP");
        PoHeaderx.setValue("X", "PUR_GROUP");
        
	PoHeader.setValue(ordDate, "DOC_DATE");
	PoHeaderx.setValue("X", "DOC_DATE");

	PoHeader.setValue("BP01", "SUPPL_PLNT");
	PoHeaderx.setValue("X", "SUPPL_PLNT"); 
	
	
        
        
        ezc.ezcommon.EzLog4j.log("***compCode***"+compCode,"I");
        ezc.ezcommon.EzLog4j.log("***purchOrg***"+purchOrg,"I");
        ezc.ezcommon.EzLog4j.log("***purGrp***"+purGrp,"I");
        ezc.ezcommon.EzLog4j.log("***docType***"+docType,"I");
        
       
        //    for(int i = 0; i < Count; i++)
        //    {
               
                PoItem.appendRow();
                PoItemx.appendRow();
       
               
                PoItem.setValue(10, "PO_ITEM");
                PoItemx.setValue(10, "PO_ITEM");
                
                PoItemx.setValue("X", "PO_ITEMX");
                
                PoItem.setValue(itemDesc, "SHORT_TEXT");
		PoItemx.setValue("X", "SHORT_TEXT");
		
		PoItem.setValue(itmMaterial, "MATERIAL");
		PoItemx.setValue("X", "MATERIAL");
              
		PoItem.setValue(itmPlant, "PLANT");
		PoItemx.setValue("X", "PLANT");
		
		PoItem.setValue(itmQty, "QUANTITY");
		PoItemx.setValue("X", "QUANTITY");
              
       	//}
       
             
                PoSchedule.appendRow();
                PoSchedulex.appendRow();
               // String delvDate = FormatDate.getStringFromDate((java.util.Date)retObj.getFieldValue(j,"DLVDATE"),"/",Integer.parseInt((String)session.getValue("DATEFORMAT")));
               // ezc.ezcommon.EzLog4j.log("**ezPurchaseOrderDeliverySchedule** ezJCOPOCreate.jsp delvDate"+delvDate,"I");
               
                PoSchedule.setValue(10, "PO_ITEM");
                PoSchedulex.setValue(10, "PO_ITEM"); 
                 
                PoSchedule.setValue(1, "SCHED_LINE");
                PoSchedulex.setValue(1, "SCHED_LINE");
                
                PoSchedule.setValue(delvDate, "DELIVERY_DATE"); 
                PoSchedulex.setValue("X", "DELIVERY_DATE");
                
                PoSchedule.setValue(qty, "QUANTITY");
                PoSchedulex.setValue("X", "QUANTITY");
                
                java.util.Date statDate = new Date(delvDate);
                
                PoSchedule.setValue(statDate, "STAT_DATE");
                PoSchedulex.setValue("X", "STAT_DATE");
                
                
               PoSchedulex.setValue("X", "PO_ITEMX");
               PoSchedulex.setValue("X", "SCHED_LINEX");
                
               
                //k++;
        
        try
        {
		client.execute(function);
		EzSAPHandler.commit(client);		
	}
	catch(Exception e)
	{
		ezc.ezcommon.EzLog4j.log("ERROR OCCURED IN EXECUTING BAPI_PO_CREATE1 FUNCTION"+e,"W");
	}

        
        ezc.ezcommon.EzLog4j.log("***Output***","I");
        
	ezc.ezcommon.EzLog4j.log("***retOut***","I");
	try
	{
	    com.sap.mw.jco.JCO.Table retOut = function.getTableParameterList().getTable("RETURN");
	    ezc.ezcommon.EzLog4j.log("***retOut***"+retOut,"I");
	    String createdPO = "";
	    com.sap.mw.jco.JCO.ParameterList expParam = function.getExportParameterList();
	    createdPO = (String)expParam.getValue("EXPPURCHASEORDER");
	    ezc.ezcommon.EzLog4j.log("createdPO==***"+createdPO,"I");
	    ezc.ezcommon.EzLog4j.log("***retOut***"+retOut,"I");
	    
	    int poCount = retOut.getNumRows();
	    if(poCount > 0)
		do
		{
		    outRet.setFieldValue("PO_NUM", createdPO);
		    outRet.setFieldValue("TYPE", retOut.getValue("TYPE"));
		    outRet.setFieldValue("ID", retOut.getValue("ID"));
		    outRet.setFieldValue("NUMBER", retOut.getValue("NUMBER"));
		    outRet.setFieldValue("MESSAGE", retOut.getValue("MESSAGE"));
		    outRet.setFieldValue("LOG_NO", retOut.getValue("LOG_NO"));
		    outRet.setFieldValue("LOG_MSG_NO", retOut.getValue("LOG_MSG_NO"));
		    outRet.setFieldValue("MESSAGE_V1", retOut.getValue("MESSAGE_V1"));
		    outRet.setFieldValue("MESSAGE_V2", retOut.getValue("MESSAGE_V2"));
		    outRet.setFieldValue("MESSAGE_V3", retOut.getValue("MESSAGE_V3"));
		    outRet.setFieldValue("MESSAGE_V4", retOut.getValue("MESSAGE_V4"));
		    outRet.setFieldValue("PARAMETER", retOut.getValue("PARAMETER"));
		    outRet.setFieldValue("ROW", retOut.getValue("ROW"));
		    outRet.setFieldValue("FIELD", retOut.getValue("FIELD"));
		    outRet.setFieldValue("SYSTEM", retOut.getValue("SYSTEM"));
		    outRet.addRow();
		} while(retOut.nextRow());
	ezc.ezcommon.EzLog4j.log("PO created==ezJCOPOCreate.jsp*"+outRet.toEzcString(),"I");
	}
	catch(Exception e)
	{
	    ezc.ezcommon.EzLog4j.log("Exception in:convertCreatePO"+e,"I");
        }
%>
<html>
<body>
<br><br><br>
<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:60%;left:2%">
<Table id="InnerBox1Tab" width=60% align=center  borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
        boolean flag =false;
        
        if(outRet.getRowCount()>0)
        {
        	int cnt=1;
        	for(int abc=0;abc<outRet.getRowCount();abc++)
        	{
        		String errorType = outRet.getFieldValueString(abc,"TYPE");
        		
        		retMessage = retMessage+cnt+". "+errorType+" : " + outRet.getFieldValueString(abc,"MESSAGE")+"<br>";
        		cnt++;
			flag = true;
			closing=true;     		
        		if("S".equalsIgnoreCase(errorType))
        		{
        			poCreated = true;
        			createdPONum = outRet.getFieldValueString(abc,"PO_NUM");
        		}
        		
        		
        		
        	}
        }
%>
<Div id="MenuSol"></Div>
</table>
</DIV>
</body>
</html>
<%
        
}
catch(Exception e)
{
	ezc.ezcommon.EzLog4j.log("ERROR OCCURS IN EXECUTING FUNCTION"+e,"W");
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

ezc.ezcommon.EzLog4j.log("PO Created True/False "+poCreated,"I");


%>
<html>
<head>
<title>
Message
</title>
<%@ include file="../../../Includes/JSPs/Misc/iblockcontrol.jsp" %>
</script>
</head>
<body bgcolor="#FFFFF7">
<Form>

<br>
<br>
<br>
<table width="70%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
  <tr align="center">
    <th align="left"><%=retMessage%></th>
  </tr>
</table>
<br><br>
<Div id="MenuSol"></Div>
</Form>
</body>
</html>