<%@ page import ="ezc.ezsap.V31H.generated.*" %>
<%@ page import ="ezc.ezparam.*" %>
<%@ page import ="ezc.ezutil.FormatDate.*"%>
<%@ include file="../../Lib/PurchaseBean.jsp"%>
<%@ page import="ezc.ezpurcontract.csb.*" %>
<jsp:useBean id="PoManager" class="ezc.client.EzPurContractManager" scope="page">
</jsp:useBean>

<%
	final String contract = "CONTRACT";
	//final String contrdesc = "CONTRACTDESCRIPTION";
	final String contrdate = "CONTRACTDATE";
	final String expdate = "EXPIRYDATE";
	final String effectiveDate = "EFFECTIVEDATE";
	//final String contrstatus = "CONTRACTSTATUS";
	//final String recrdststus = "RECORDSTATUS";
	final String nAmount="NETAMOUNT";

	EzPurchCtrHdrXML purchctrhdr =null;
	EzPSIInputParameters iparams = new EzPSIInputParameters();
	ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
	String searchFlag=request.getParameter("SearchFlag");
	ezc.ezpurcontract.params.EziPurchaseInputParams testParams = new ezc.ezpurcontract.params.EziPurchaseInputParams();
	String fromDate=request.getParameter("FromDate");
	String orderType=request.getParameter("OrderType");
	iparams.setMaterial("");
	if (searchFlag==null || "".equals(searchFlag))
	{
		System.out.println("searchFlag is \n\n\n\n"+searchFlag);
		searchFlag="AllPurchaseContracts";
	}

	if (searchFlag.equals("DCnoSearch"))
	{
		String vendor= (String)session.getValue("SOLDTO");
		System.out.println("Vendor No is ***********************"+vendor);
		EzcParams params=new EzcParams(true);
		String dcno=request.getParameter("DCNO");
		dcno = "*"+dcno+"*"; // DELETE THIS STATEMENT. SOMA.

		System.out.println("Delivery Challan No is ***********************"+dcno);
		ezc.ezshipment.params.EziSearchInputStructure inStruct=new ezc.ezshipment.params.EziSearchInputStructure();
		inStruct.setBase("DCSA");
		inStruct.setVendor(vendor);
		inStruct.setDocnum(dcno);

		params.setObject(inStruct);
		Session.prepareParams(params);
		ezc.ezshipment.client.EzShipmentManager Manager=new ezc.ezshipment.client.EzShipmentManager();
		purchctrhdr=(EzPurchCtrHdrXML) Manager.ezGetPOListForDCNumber(params);
		//hdrXML=(ReturnObjFromRetrieve)Manager.ezGetPOListForDCNumber(params);
	}
	else if(searchFlag.equals("AllPurchaseContracts"))
	{
		System.out.println("orderType is\n\n\n\n\n "+orderType);
		if(orderType!=null)
		{
			orderType=orderType.trim();
			if(orderType==null || orderType.equals("All"))
			{
				newParams.createContainer();
				newParams.setObject(iparams);
				newParams.setObject(testParams);
				Session.prepareParams(newParams);
				purchctrhdr = (EzPurchCtrHdrXML)PoManager.getPurchaseContractList(newParams);
			}
			if( orderType.equals("Open"))
			{
				System.out.println("OPEN");
				newParams.createContainer();
				newParams.setObject(testParams);
				newParams.setObject(iparams);
				Session.prepareParams(newParams);
				purchctrhdr = (EzPurchCtrHdrXML)PoManager.ezOpenPurchaseContractList(newParams);
			}
			if( orderType.equals("Closed"))
			{
				System.out.println("Last Call");
				newParams.createContainer();
				newParams.setObject(testParams);
				newParams.setObject(iparams);
				Session.prepareParams(newParams);
				purchctrhdr = (EzPurchCtrHdrXML)PoManager.ezClosedPurchaseContractList(newParams);
			}
			if( orderType.equals("New"))
			{
				System.out.println("Testing new Contracts List");
				newParams.createContainer();
				newParams.setObject(testParams);
				newParams.setObject(iparams);
				Session.prepareParams(newParams);
				//purchctrhdr = (EzPurchCtrHdrXML)PoManager.getNewPurchaseContractList(newParams);
				java.util.Vector newContracts = null;
				if (session.getValue("NewContracts") != null)
					newContracts = (java.util.Vector) 
				session.getValue("NewContracts");
				if ( (newContracts != null) && ( newContracts.size() > 0) )
				{
					purchctrhdr = (EzPurchCtrHdrXML)PoManager.ezOpenPurchaseContractList(newParams);
					for(int i=purchctrhdr.getRowCount()-1; i>=0 ; i--)
 					{
						if (newContracts.contains(purchctrhdr.getFieldValueString(i,contract))){
						}
						else{
							purchctrhdr.deleteRow(i);
 						}
 					}
				}
				else{
					purchctrhdr = new EzPurchCtrHdrXML();
				}
			}

		}
		else
		{
			newParams.createContainer();
			newParams.setObject(iparams);
			newParams.setObject(testParams);
			Session.prepareParams(newParams);
			purchctrhdr = (EzPurchCtrHdrXML)PoManager.getPurchaseContractList(newParams);
		}
	}
	int contractRows = purchctrhdr.getRowCount();
%>

