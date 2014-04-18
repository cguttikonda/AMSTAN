<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<%@ include file="../Misc/iCheckQuery.jsp" %>
<%!
	private  java.util.Hashtable getSAPRecords(ezc.session.EzSession Session,String POCON,String defCatArea)
	{
		java.util.Hashtable poHash = new java.util.Hashtable();
		String poconNumber = "",vendorNo="",orderDate="",isAmmend="";
		String poconDocStatus = "";
		ezc.ezvendorapp.client.EzVendorAppManager AppManager = new ezc.ezvendorapp.client.EzVendorAppManager();
		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
		mainParams.setLocalStore("Y");
		ezc.ezvendorapp.params.EziPurchaseOrderParams iParams =  new ezc.ezvendorapp.params.EziPurchaseOrderParams();
		iParams.setSysKey(defCatArea);
		mainParams.setObject(iParams);
		Session.prepareParams(mainParams);
		ezc.ezparam.ReturnObjFromRetrieve allAckPOs= (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezGetPOAcknowledgement(mainParams);		
		if(allAckPOs != null)
		{
			int poCount = allAckPOs.getRowCount(); 
			for(int i=0;i<poCount;i++)
			{
				poconDocStatus  = (allAckPOs.getFieldValueString(i,"DOCSTATUS")).trim();
				if("B".equals(poconDocStatus) || "M".equals(poconDocStatus))
				{
					poconNumber 	= (allAckPOs.getFieldValueString(i,"DOCNO")).trim();
					vendorNo	= (allAckPOs.getFieldValueString(i,"EXT1")).trim();
					orderDate	= (allAckPOs.getFieldValueString(i,"DOCDATE")).trim();
					isAmmend	= (allAckPOs.getFieldValueString(i,"EXT3")).trim();
					poHash.put(poconNumber,vendorNo+"¥"+orderDate+"¥"+isAmmend);
				}	
			}
		}	
		return poHash; 
	}
	
	private String checkDetails(ezc.session.EzSession Session,String collNo,String syskey,String authKey)
	{
		ezc.ezworkflow.client.EzWorkFlowManager ezWorkFlowManager = new ezc.ezworkflow.client.EzWorkFlowManager();
		ezc.ezparam.EzcParams wfMainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFDocHistoryParams wfParams= new ezc.ezworkflow.params.EziWFDocHistoryParams();
		wfParams.setAuthKey(authKey);
		wfParams.setSysKey(syskey);
		wfParams.setDocId(collNo);
		wfParams.setSoldTo("0");
		wfMainParams.setObject(wfParams);
		Session.prepareParams(wfMainParams);
		ezc.ezparam.ReturnObjFromRetrieve wfDetailsRet=(ezc.ezparam.ReturnObjFromRetrieve)ezWorkFlowManager.getWFDocDetails(wfMainParams);
		String user=(Session.getUserId()).trim();
		String status = "Blocked";
		if(wfDetailsRet != null)
		{	
			for(int i=wfDetailsRet.getRowCount()-1;i>=0;i--)
			{	
				if(user.equals(wfDetailsRet.getFieldValueString(i,"ACTIONBY").trim()))
				{
					status = wfDetailsRet.getFieldValueString(i,"STATUS");
					break;					
				}
			}
		}
		return status;
	}	
	
	private String modifyDate(String dateString)
	{
		String modDate = "";
		try{
			modDate = dateString.substring(0,10);
			java.util.StringTokenizer stoken = new java.util.StringTokenizer(modDate,"-");
			String token1 = stoken.nextToken();
			String token2 = stoken.nextToken();
			String token3 = stoken.nextToken();
			modDate = token3+"."+token2+"."+token1;
		}
		catch(Exception ex)
		{
			modDate = dateString;
		}
		return modDate;
	}
%>
<%@ include file="../Misc/iGetUserName.jsp"%>
<%
	ezc.ezparam.ReturnObjFromRetrieve globalForm = null;	
	java.util.Hashtable remHash = new java.util.Hashtable();
	remHash.put("Q","Sent Query");
	remHash.put("R","Reply Rcvd");
	remHash.put("N","No Queries");
	
	java.util.Hashtable auditHash = new  java.util.Hashtable();
	auditHash.put("PO","PURCHASE ORDER");
	auditHash.put("CON","CONTRACT");
	
	java.util.Enumeration enum = auditHash.keys();	
	
	String keyId = "",keyValue="";
	
	String scrollInit = "";
	String loginType = (String)session.getValue("OFFLINE");
	if(loginType != null && "Y".equals(loginType))
		scrollInit="10";
	else
	scrollInit="100";
	
	String pocon 		= request.getParameter("POCON");
	String authKey 		= "";
	String display_header 	= "List Of Purchase Orders";
	String colHead = "";
	String selected = "";
		
	String sysKey = (String)session.getValue("SYSKEY");
	String template=(String)session.getValue("TEMPLATE");
	
	String participant	= (String)session.getValue("USERGROUP");
	String userRole 	= (String)session.getValue("USERROLE");
	String wfRole 		= (String)session.getValue("ROLE");
	String userName 	= (String)Session.getUserId();
	String chkPrvStatus	= "";
	
	
	java.util.Vector sessionVector = null;
	
	String tempString = "";
	String docNo = "",qrySts="";
	String vendor = "",orderDate = "",isAmmend="&nbsp;";
	StringTokenizer stoken = null;
	int wfCount = 0;
	java.util.Hashtable poHash = null;
	ezc.ezparam.ReturnObjFromRetrieve retobj = null;
	if(pocon != null)
	{
		if("PO".equals(pocon))
		{
			authKey = "PO_RELEASE";
			display_header 	= "List Of Purchase Orders";
			colHead = "PO Number";
			sessionVector = (java.util.Vector)session.getValue("amendPosSess");
		}	
		if("CON".equals(pocon))
		{
			authKey = "CON_RELEASE";
			display_header 	= "List Of Contracts";
			colHead = "Contract Number";
			sessionVector = (java.util.Vector)session.getValue("amendConsSess");
		}	
		
		System.out.println("asdfasdfasdfasdfasdf:::::::::"+authKey);
		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFDocHistoryParams params= new ezc.ezworkflow.params.EziWFDocHistoryParams();
		params.setAuthKey("'"+authKey+"'");
		params.setSysKey("'"+sysKey+"'");
		params.setTemplateCode(template);
		params.setStatus("'Blocked','SUBMITTED'");
		mainParams.setObject(params);
		Session.prepareParams(mainParams);
		retobj=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWFDocList(mainParams);
		if(retobj!=null)
		{
			wfCount = retobj.getRowCount();
			poHash = getSAPRecords(Session,pocon,sysKey);
			for(int i=wfCount-1;i>=0;i--)
			{
				docNo = retobj.getFieldValueString(i,"DOCID");
				if(poHash.get(docNo) == null)
				{
					retobj.deleteRow(i);	
				}
			}
			wfCount = retobj.getRowCount();
			retobj.addColumn("VENDOR");
			retobj.addColumn("DATE");
			retobj.addColumn("QRYSTATUS");
			retobj.addColumn("ISAMMEND");
			retobj.addColumn("WFSTATUS");
			for(int i=0;i<wfCount;i++)
			{
				docNo = retobj.getFieldValueString(i,"DOCID");
				if(poHash.get(docNo) != null)
				{
					//qrySts 		= (String)remHash.get(checkQueries(Session,docNo,Session.getUserId()));
					chkPrvStatus 	= checkDetails(Session,retobj.getFieldValueString(i,"DOCID"),sysKey,authKey);
					if("REJECTED".equals(chkPrvStatus.trim()))
						retobj.setFieldValueAt("WFSTATUS","RESUBMITTED",i);
					else
						retobj.setFieldValueAt("WFSTATUS",retobj.getFieldValueString(i,"STATUS").toUpperCase(),i);					

						
					tempString 	= (String)poHash.get(docNo);
					stoken		= new StringTokenizer(tempString,"¥");
					vendor 		= stoken.nextToken();
					orderDate 	= stoken.nextToken();
					if(stoken.hasMoreTokens())
						isAmmend	= stoken.nextToken();
					if("U".equals(isAmmend.trim()))
						isAmmend = "<a href=\"javascript:getAmndPODtl('"+docNo+"')\">Click</a>";
					else
						isAmmend = "&nbsp;";
					retobj.setFieldValueAt("VENDOR",vendor,i);
					retobj.setFieldValueAt("DATE",modifyDate(orderDate),i);
					retobj.setFieldValueAt("QRYSTATUS",qrySts,i);
					retobj.setFieldValueAt("ISAMMEND",isAmmend,i);
				}
			}
			retobj.sort(new String[]{"DATE"},false);
			ezc.ezcommon.EzLog4j log4j= new ezc.ezcommon.EzLog4j();
			log4j.log("retobjretobj"+retobj.toEzcString(),"W");
			java.util.Vector types = new java.util.Vector();
       			types.addElement("date");
       			EzGlobal.setColTypes(types);
			java.util.Vector names = new java.util.Vector();
			names.addElement("MODIFIEDON");
			EzGlobal.setColNames(names);
			
			if(retobj.getRowCount()>0)
			globalForm = EzGlobal.getGlobal(retobj);
		}	
	}
%>

