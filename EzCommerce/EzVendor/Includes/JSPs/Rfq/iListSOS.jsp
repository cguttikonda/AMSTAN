<%@ page import = "ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO,ezc.ezparam.*,ezc.ezutil.*" %>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="ezadminutilsmanager" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session"></jsp:useBean>
<%
	String backChk=request.getParameter("backChk");
	String purchReq=request.getParameter("purchaseHidden");
	String matNo="",plant="",delDate="";
	String qty = "",uom="",matDesc="",reqNo="",itmNo="",valType="";
	

	java.util.StringTokenizer st =new java.util.StringTokenizer(purchReq,"$$");
	try
	{
		matNo	= st.nextToken();
		plant	= st.nextToken();
		delDate	= st.nextToken();
		qty 	= st.nextToken();
		uom 	= st.nextToken();
		matDesc = st.nextToken();
		reqNo   = st.nextToken();
		itmNo   = st.nextToken();
		valType = st.nextToken();
	}
	catch(Exception e)
	{
	}
	
	
	
	ezc.ezcommon.EzLog4j.log("st "+st,"I");
	ezc.ezcommon.EzLog4j.log("matNo "+matNo,"I");
	ezc.ezcommon.EzLog4j.log("plant "+plant,"I");
	ezc.ezcommon.EzLog4j.log("delDate "+delDate,"I");
	ezc.ezcommon.EzLog4j.log("qty "+qty,"I");
	ezc.ezcommon.EzLog4j.log("uom "+uom,"I");
	ezc.ezcommon.EzLog4j.log("matDesc "+matDesc,"I");
	ezc.ezcommon.EzLog4j.log("reqNo "+reqNo,"I");
	ezc.ezcommon.EzLog4j.log("itmNo "+itmNo,"I");
	ezc.ezcommon.EzLog4j.log("valType "+valType,"I");
	
	if(delDate!=null)
		delDate = delDate.substring(3,5)+"/"+delDate.substring(0,2)+"/"+delDate.substring(6,10);
	ezc.ezcommon.EzLog4j.log("delDate "+delDate,"I");
	
	//String addZrs = "000000000000000000"+matNo.trim();
	//matNo = addZrs.substring(addZrs.length()-18,addZrs.length());
	
	JCO.Client client = null;
	JCO.Function function = null;
	
	
	String siteNo = "640";
	client   = EzSAPHandler.getSAPConnection(siteNo+"~999");
	ReturnObjFromRetrieve myRet = new ReturnObjFromRetrieve(new String[] {
				    "VENDOR", "VENDOR_NAME", "SUPPLY_PLANT", "AGREEMENT", "AGMT_ITEM", "INFO_REC", "DOC_CAT", "PO_UNIT", "ITEM_CAT", "PO_UNIT_ISO"
				});
		Hashtable vendHash = new Hashtable();
	
	try
	{
	
		try
		{
			function = EzSAPHandler.getFunction("Z_EZ_SOURCEDETERMIN_GETSOS");
			JCO.ParameterList sapPreProc = function.getImportParameterList();
			JCO.ParameterList sapTabParam = function.getTableParameterList();
			JCO.Table matTable = sapTabParam.getTable("MATERIALS");



			try
			{

			}
			catch(Exception exception) { }

			String purchOrg = (String)Session.getUserPreference("PURORG");
			java.util.Date delivDate = new java.util.Date(delDate);

			sapPreProc.setValue(purchOrg, "PURCH_ORG");
			sapPreProc.setValue(delivDate, "DELIV_DATE");

			matTable.appendRow();
			matTable.setValue(matNo, "MATERIAL");
			if(!"NA".equals(plant))
				matTable.setValue(plant.trim(), "PLANT");

			try
			{
				ezc.ezcommon.EzLog4j.log("=Before function purchOrg="+purchOrg,"I");
				ezc.ezcommon.EzLog4j.log("=Before function delivDate="+delivDate,"I");
				ezc.ezcommon.EzLog4j.log("=Before function matNo="+matNo,"I");
				ezc.ezcommon.EzLog4j.log("=Before function plant="+plant,"I");

				ezc.ezcommon.EzLog4j.log("=Before function execution="+function,"I");
				client.execute(function);
				EzSAPHandler.commit(client);
				ezc.ezcommon.EzLog4j.log("=After function execution="+function,"I");
			}
			catch(Exception e)
			{
				ezc.ezcommon.EzLog4j.log("ERROR OCCURED IN EXECUTING Z_EZ_SOURCEDETERMIN_GETSOS FUNCTION"+e,"W");
			}
		}
		catch(Exception e)
		{
			ezc.ezcommon.EzLog4j.log("**Exception occured in executing FM Z_EZ_SOURCEDETERMIN_GETSOS "+e,"I");
		}
	
		
		try
		{
			JCO.Table sos = function.getTableParameterList().getTable("SOS");
			JCO.Table vendAdd = function.getTableParameterList().getTable("VEND_ADD");
			int vendCount = vendAdd.getNumRows();
			if(vendCount > 0)
			do
			    vendHash.put(vendAdd.getValue("LIFNR"), vendAdd.getValue("NAME1"));
			while(vendAdd.nextRow());

			int poCount = sos.getNumRows();
			if(poCount > 0)
			do
			{
			    myRet.setFieldValue("VENDOR", sos.getValue("FIXED_VEND"));
			    myRet.setFieldValue("VENDOR_NAME", vendHash.get(sos.getValue("FIXED_VEND")));
			    myRet.setFieldValue("SUPPLY_PLANT", sos.getValue("SUPPL_PLNT"));
			    myRet.setFieldValue("AGREEMENT", sos.getValue("AGREEMENT"));
			    myRet.setFieldValue("AGMT_ITEM", sos.getValue("AGMT_ITEM"));
			    myRet.setFieldValue("INFO_REC", sos.getValue("INFO_REC"));
			    myRet.setFieldValue("DOC_CAT", sos.getValue("DOC_CAT"));
			    myRet.setFieldValue("PO_UNIT", sos.getValue("PO_UNIT"));
			    myRet.setFieldValue("ITEM_CAT", sos.getValue("ITEM_CAT"));
			    myRet.setFieldValue("PO_UNIT_ISO", sos.getValue("PO_UNIT_ISO"));
			    myRet.addRow();
			} while(sos.nextRow());
		}
		catch(Exception e)
		{
		    ezc.ezcommon.EzLog4j.log("**Exception occured in OUTPUT CONVERSION OF FM Z_EZ_SOURCEDETERMIN_GETSOS iListSOS.jsp"+e,"I");
		}
	}
	
	catch(Exception e)
	{
		ezc.ezcommon.EzLog4j.log("ERROR OCCURS IN EXECUTING FUNCTION iListSOS.jsp "+e,"W");
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
	
	
	/*ezc.ezpreprocurement.client.EzPreProcurementManager PreProcurementManager=new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezpreprocurement.params.EziPreProcurementParams param=new ezc.ezpreprocurement.params.EziPreProcurementParams();

	ezc.ezpreprocurement.params.EziPOItemTable  	matTable1 = new ezc.ezpreprocurement.params.EziPOItemTable();
	ezc.ezpreprocurement.params.EziPOItemTableRow matTableRow = null;  

	param.setDelivDate(delDate);

	matTableRow =  new ezc.ezpreprocurement.params.EziPOItemTableRow();
	matTableRow.setMaterial(matNo);
	if(!"NA".equals(plant))
	matTableRow.setPlant(plant.trim());
	matTable1.appendRow(matTableRow);

	ezc.ezparam.EzcParams mainParams=new ezc.ezparam.EzcParams(true);
	mainParams.setObject(param);
	mainParams.setObject(matTable1);
	Session.prepareParams(mainParams);
	myRet = (ezc.ezparam.ReturnObjFromRetrieve)PreProcurementManager.ezGetSourceDetermine(mainParams);*/
	
	
		
	//ezc.ezparam.ReturnObjFromRetrieve myRet = null;
	ezc.ezparam.ReturnObjFromRetrieve agentsList = null;
	ezc.ezparam.ReturnObjFromRetrieve sapvendRet = null;
	
	
	/*ezc.ezparam.EzcParams ezcparams	= new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziAgentParams eziagentparams= new ezc.ezpreprocurement.params.EziAgentParams();
	eziagentparams.setMatCode(matNo);
	ezcparams.setObject(eziagentparams);
	ezcparams.setLocalStore("Y");
	Session.prepareParams(ezcparams);
	ezc.ezparam.ReturnObjFromRetrieve agentsList = (ezc.ezparam.ReturnObjFromRetrieve)PreProcurementManager.ezGetAgentsList(ezcparams);
	agentsList.sort(new String[]{"EVA_AGENT_CODE"},true);
	
	ezc.ezparam.EzcParams ezcparamsven	= new ezc.ezparam.EzcParams(false);
	ezc.ezadmin.ezadminutils.params.EziAdminUtilsParams params = new ezc.ezadmin.ezadminutils.params.EziAdminUtilsParams();
	params.setPartnerFunction("VN");
	params.setPartnerValue("11%");
	ezcparamsven.setObject(params);
	ezcparamsven.setLocalStore("Y");
	Session.prepareParams(ezcparamsven);
	ezc.ezparam.ReturnObjFromRetrieve sapvendRet = (ezc.ezparam.ReturnObjFromRetrieve)ezadminutilsmanager.getPartnerPartners(ezcparamsven);
	*/
	
	int myRetCount  =0;
	int sapvendRetCount  =0;
	int agentsCount =0;
	
	if(myRet!=null)
		myRetCount=myRet.getRowCount();
	
	if(sapvendRet!=null)
		sapvendRetCount=sapvendRet.getRowCount();
		
	String vendorCode=null;

	if(myRet!=null && sapvendRet!=null & agentsList!= null)
	{
		for(int j=0;j<myRetCount;j++)
		{
			vendorCode = myRet.getFieldValueString(j,"VENDOR");

			for(int i=sapvendRet.getRowCount()-1;i>=0;i--)
			{
				if(vendorCode.equals(sapvendRet.getFieldValueString(i,"EC_ERP_CUST_NO")) )
				{
					sapvendRet.deleteRow(i);
				}
			}
			/*
			for(int i=agentsList.getRowCount()-1;i>=0;i--)
			{
				if(vendorCode.equals(agentsList.getFieldValueString(i,"EVA_VENDOR_CODE")) )
				{
					 //agentsList.deleteRow(i);
				}
			}
			*/
		}
	}	
	if(myRet!=null)
		myRetCount=myRet.getRowCount();
	if(sapvendRet!=null)
		sapvendRetCount=sapvendRet.getRowCount();
	if(agentsList!= null)
		agentsCount = agentsList.getRowCount();
%>
