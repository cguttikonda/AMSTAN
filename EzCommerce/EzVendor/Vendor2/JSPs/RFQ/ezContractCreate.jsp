<%@include file="../../Library/Globals/errorPagePath.jsp"%>
<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>
<%@page import="com.sap.mw.jco.JCO"%>
<%@page import="ezc.ezutil.*"%>
<jsp:useBean id="Manager" class="ezc.ezpreprocurement.client.EzPreProcurementManager" />
<%@ include file="../../../Includes/JSPs/Misc/iEzDateConvertion.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@include file="../../../Includes/JSPs/Rfq/iListRFQByCollectiveRFQ.jsp"%>
<%
	/*
		conValue   = "10";
		docType	   = "WK"; 
		headerText = "Header Test";
		itemText   = "Item Test";

		vendor	   = "2200000245";
		material   = "0.005CCB";
		quantity   = "100";
		price	   = "15.00";

		compCode   = "1000";
		purOrg     = "4000";
		purGrp     = "102";
	*/	
	java.util.Vector rfqNos=new java.util.Vector(); 
	int count = myRet.getRowCount();
	for(int i=count-1;i>=0;i--)
	{
		rfqNos.add(myRet.getFieldValueString(i,"RFQ_NO"));
		if(!("R".equals(myRet.getFieldValueString(i,"RELEASE_INDICATOR").trim())))
			myRet.deleteRow(i);
	
	}
	
	String compCode= (String)Session.getUserPreference("COMPCODE");
	String purOrg  = (String)Session.getUserPreference("PURORG");
	String purGrp  = (String)Session.getUserPreference("PURGRP");
    
    	String docType	 = request.getParameter("docType");
    	String conValue  = request.getParameter("conValue");
    	String startDate = request.getParameter("startDate");
	String endDate   = request.getParameter("endDate");
	String valType   = request.getParameter("valType");
    	String headerText= request.getParameter("headerText");
	String itemText  = request.getParameter("itemText");

	String vendors	= request.getParameter("vendors");
	
	java.util.Vector vendCode=new java.util.Vector();
	java.util.Vector vendQty=new java.util.Vector();
	if(vendors!=null)
	{
		java.util.StringTokenizer venDetStr = new java.util.StringTokenizer(vendors,"§"); 
		while(venDetStr.hasMoreTokens())
		{
			String vendStr=(String)venDetStr.nextToken();
			java.util.StringTokenizer venDetStk = new java.util.StringTokenizer(vendStr,"¥"); 
			if(venDetStk.countTokens()>1){
				vendCode.add(venDetStk.nextToken());
				vendQty.add(venDetStk.nextToken());
			}
			
		}
	}
	
	ezc.ezparam.ReturnObjFromRetrieve finalRet= new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"OBJ","VENDOR"});
	String material="",price="",vendor="",quantity="";
	
	int myRetCount  = myRet.getRowCount();	
	for(int i=0;i<myRetCount;i++)	
	{
		vendor   = (String)vendCode.get(i);
		quantity = (String)vendQty.get(i);
		
		//vendor   = myRet.getFieldValueString(0,"VENDOR");
		//quantity = myRet.getFieldValueString(0,"QUANTITY");
		
		material = myRet.getFieldValueString(i,"MATERIAL");
		price	 = myRet.getFieldValueString(i,"PRICE");   

		try
    		{    
			JCO.Function function		= EzSAPHandler.getFunction("Z_EZ_PURCHASE_CONTRACT_CREATE");
			JCO.ParameterList sapImpParam 	= function.getImportParameterList();
			JCO.ParameterList sapTabParam	= function.getTableParameterList();
			JCO.Structure SAHeader		= sapImpParam.getStructure("AGMTHEADER");
			JCO.Structure POHeader		= sapImpParam.getStructure("POHEADER");
			JCO.Table PoItem  		= function.getTableParameterList().getTable("POITEMS");

			String headerText1 = "";
			if(headerText.length() > 40)
			{
				headerText1 = headerText.substring(40,headerText.length());
				headerText  = headerText.substring(0,39);
			}

			SAHeader.setValue(docType,"EVART");
			SAHeader.setValue(headerText,"LTEX1");
			SAHeader.setValue(headerText1,"LTEX2");

			int mm=Integer.parseInt(startDate.substring(3,5));
			int dd=Integer.parseInt(startDate.substring(0,2));
			int yy=Integer.parseInt(startDate.substring(6,10));

			GregorianCalendar g=new GregorianCalendar(dd,mm-1,yy);
			Date sDate=g.getTime();

			int mm1=Integer.parseInt(endDate.substring(3,5));
			int dd1=Integer.parseInt(endDate.substring(0,2));
			int yy1=Integer.parseInt(endDate.substring(6,10));

			GregorianCalendar g1=new GregorianCalendar(dd1,mm1-1,yy1);
			Date eDate=g1.getTime();


			POHeader.setValue(compCode,"BUKRS"); 	//"1000"
			POHeader.setValue(purOrg,"EKORG");	//"4000"	
			POHeader.setValue(purGrp,"EKGRP"); 	//"102"
			POHeader.setValue(vendor,"LIFNR");	//"2200000245"	
			POHeader.setValue(sDate,"KDATB");  
			POHeader.setValue(eDate,"KDATE");
			POHeader.setValue(conValue,"KTWRT");

			PoItem.appendRow();
			PoItem.setValue(material,"EMATN");
			PoItem.setValue(itemText,"TXZ01");
			PoItem.setValue(price,"NETPR");

			if("MK".equals(docType))
			{
				PoItem.setValue(quantity,"KTMNG");
			}

			JCO.Client client = EzSAPHandler.getSAPConnection();
			client.execute(function);
			JCO.Table retOut = function.getTableParameterList().getTable("MESSTAB");			 
			ezc.ezparam.ReturnObjFromRetrieve outRet= null;
			int retOutCount = 0 ;
			if(retOut != null)
				retOutCount = retOut.getNumRows();

			outRet = new  ezc.ezparam.ReturnObjFromRetrieve(new String[]{"MSGV2","MSGTYP","MSGV1","MSGID","MSGSPRA","FLDNAME","DYNAME","MSGNR"});
			try
			{
				if(retOutCount>0)
				{
					do
					{
						outRet.setFieldValue("MSGV2",retOut.getValue("MSGV2"));
						outRet.setFieldValue("MSGTYP", retOut.getValue("MSGTYP"));
						outRet.setFieldValue("MSGV1",retOut.getValue("MSGV1"));
						outRet.setFieldValue("MSGID",retOut.getValue("MSGID"));
						outRet.setFieldValue("MSGSPRA",retOut.getValue("MSGSPRA"));
						outRet.setFieldValue("FLDNAME",retOut.getValue("FLDNAME"));
						outRet.setFieldValue("DYNAME",retOut.getValue("DYNAME"));
						outRet.setFieldValue("MSGNR",retOut.getValue("MSGNR"));
						outRet.addRow();
					}
					while(retOut.nextRow());
				}
			}catch (Exception e)
			{
				System.out.println("Exception in EzPreProcurementOutputConversion:::convertCreateContract");
			}
			finalRet.setFieldValue("OBJ",outRet);
			finalRet.setFieldValue("VENDOR",vendor);
			finalRet.addRow();
			if (client!=null)
			{
				JCO.releaseClient(client);
				client = null;
				function=null;
			}
		}
		catch(Exception e)
	    	{
			System.out.println(e);
			e.printStackTrace();
		}
	}

	String retMessage ="";
	boolean closing=false;
	for(int x=0;x<finalRet.getRowCount();x++)
	{
		String vend = finalRet.getFieldValueString(x,"VENDOR");		
		boolean flag =false;
		int cnt =1;

		ezc.ezparam.ReturnObjFromRetrieve ret = (ezc.ezparam.ReturnObjFromRetrieve )finalRet.getFieldValue(x,"OBJ");	

		retMessage += "Vendor: " +vend +"<br>";	
		for(int pc=0;pc<ret.getRowCount();pc++)
		{
			String errorType = ret.getFieldValueString(pc,"MSGTYP");
			if("E".equalsIgnoreCase(errorType))
			{
				retMessage = retMessage+cnt+"."+ret.getFieldValueString(pc,"MSGV1")+"<br>";
				cnt++;
				flag = false;
			}
			else if("S".equalsIgnoreCase(errorType))
			{
				retMessage = retMessage + ret.getFieldValueString(pc,"MSGV1");
				retMessage = retMessage + " Successfully"+"<br>";
				flag = true;
				closing=true;
			}
		}
	}	

/*
	String retMsg = "Error in Creating Contract";
	if(outRet != null)
	{
		for(int i=0;i<outRet.getRowCount();i++)
		{
			if("E".equals(outRet.getFieldValueString(i,"MSGTYP")))	
			{
				retMsg = "Error occured in Contract Creation";
				break;
			}
			else if("S".equals(outRet.getFieldValueString(i,"MSGTYP")))	
			{
				retMsg = outRet.getFieldValueString(i,"MSGV1") +" created under the number "+outRet.getFieldValueString(i,"MSGV2")+" Sucessfully ";
			}
		}
	}
*/
	if(closing)
	{
%>		<%@include file="../../../Includes/JSPs/Rfq/iCloseQCF.jsp"%>			
<%	}
	response.sendRedirect("../Shipment/ezMessage.jsp?Msg="+retMessage);
%>