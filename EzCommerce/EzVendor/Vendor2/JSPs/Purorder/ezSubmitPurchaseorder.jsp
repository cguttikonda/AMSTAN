<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%@ page import ="ezc.ezparam.*,java.util.*,ezc.ezutil.*" %>
<jsp:useBean id="Session" class ="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="AppManager" class ="ezc.ezvendorapp.client.EzVendorAppManager" scope="page"></jsp:useBean>
<jsp:useBean id="EzWorkFlow" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" /> 
<%
		String actionCode = "100066";
    		String actionDesc = "";
		if(request.getParameter("actionCode") != null)
			actionCode = request.getParameter("actionCode");
		if("100066".equals(actionCode))
			actionDesc = "SUBMITTED";
		else if("100068".equals(actionCode))
			actionDesc = "REJECTED";
			
		String attachDocType = "";	
		
		String sysKey = (String)session.getValue("SYSKEY");
		String soldTo = (String)session.getValue("SOLDTO");
		String Offline= (String)session.getValue("OFFLINE");
		String[] poNums = request.getParameterValues("chk1");
		String prevStatus = request.getParameter("prevStatus");
		String attachString = request.getParameter("attachString");
		
		String isDelegate = request.getParameter("isDelegate");
		
		String ordType = request.getParameter("type");
		String rejectToUser 	= 	request.getParameter("rejectToUser");
		String subjText = "",pocon = "";
		
		ezc.ezparam.EzcParams ezcParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFParams eziWfparams 		= new ezc.ezworkflow.params.EziWFParams();
	 	ezc.ezworkflow.params.EziWFDocHistoryParams eziWfDocHis = new ezc.ezworkflow.params.EziWFDocHistoryParams();

		String sessionRole	=	(String)session.getValue("ROLE");
		String userRole 	  = (String)session.getValue("USERROLE");	
		String template		  = (String)session.getValue("TEMPLATE");
		String userGroup	  =	(String)session.getValue("USERGROUP");	
		String nextPart 	= 	request.getParameter("nextPart");
   		String userId 		  =	Session.getUserId();
   		String POs 		      = "";
   		
   		if("".equals(nextPart) || nextPart == null || "null".equals(nextPart))
			nextPart = userGroup;
    		
    		eziWfparams.setRole(sessionRole);
    		eziWfparams.setParticipant(userGroup);
		eziWfDocHis.setSysKey(sysKey);
		eziWfDocHis.setTemplateCode(template);

		if(rejectToUser != null && (!"null".equals(rejectToUser)) && (!"".equals(rejectToUser)))
		{
			try{
				StringTokenizer userToken = new StringTokenizer(rejectToUser,"¥");
				eziWfDocHis.setNextParticipantStep(userToken.nextToken());
				eziWfDocHis.setNextParticipantRole(userToken.nextToken());
				eziWfDocHis.setNextParticipant(userToken.nextToken());
				eziWfDocHis.setNextParticipantType(userToken.nextToken());
			}catch(Exception ex){System.out.println("Exception while setting tokens in rejection");}	

		}
		
		
	
		String ordertype = "";
		String fileName = "";
		if("Contract".equals(ordType))
		{
			eziWfDocHis.setAuthKey("CON_RELEASE");			
			pocon = "CON";
			attachDocType = "CONT";
			ordertype = "Contract";
			if("Y".equals(Offline))
				fileName = "ezListOfflineBlockedContracts.jsp";
     			else
				fileName = "ezListBlockedContracts.jsp";
			subjText = "Contract";
		}	
		else
		{
			eziWfDocHis.setAuthKey("PO_RELEASE");
			pocon = "PO";
			attachDocType = "PO";
			ordertype = "Amend";
			if("Y".equals(Offline))
				fileName = "ezListOfflineBlockedPOs.jsp";
			else
				fileName = "ezListBlockedPOs.jsp";
			subjText = "Purchase Order";
		}	
		eziWfDocHis.setStatus(actionDesc);
		eziWfDocHis.setModifiedBy(userId);
		eziWfDocHis.setCreatedBy(userId);
		eziWfDocHis.setAction(actionCode);
		eziWfDocHis.setSoldTo(soldTo+"#"+isDelegate);
		eziWfDocHis.setRef2(prevStatus);
		eziWfDocHis.setParticipant(nextPart);
		ezc.ezparam.ReturnObjFromRetrieve retPoWorkFlow = null;
		
		for(int i=0;i<poNums.length;i++)
		{
			eziWfDocHis.setDocId(poNums[i]);
			ezcParams.setObject(eziWfparams);
			ezcParams.setObject(eziWfDocHis);
			Session.prepareParams(ezcParams);
			
			try
			{				
				retPoWorkFlow = (ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.updateWFDoc(ezcParams);					
			}
			catch(Exception e)
			{
				System.out.println("Exception Occured in EZSUBMITPURCHASEORDER:"+e);
			}
			POs=POs+"<br>"+poNums[i];
		}
	
		String dispMessage	= "";
		String msgText		= "";
		String msgSubject	= "";
		String sendToUser	= "";
		String partType 	= "";
		String delPart 		= "";
		String delPartType 	= "";
		String status 		= "";
		
		String lnk 		= "";


		String roleL   = "";
		String sysKeyL = "";
		String templateL = "";
		String participantL = "";
		String userGroupL  = "";
	
	
	
		
		if(retPoWorkFlow!=null)
		{
			sendToUser 	= retPoWorkFlow.getFieldValueString(0,"PARTICIPANT");
			partType 	= retPoWorkFlow.getFieldValueString(0,"PARTICIPANT_TYPE");
			delPart 	= retPoWorkFlow.getFieldValueString(0,"DELPARTICIPANT");
			delPartType 	= retPoWorkFlow.getFieldValueString(0,"DELPARTICIPANTTYPE");
			status 		= retPoWorkFlow.getFieldValueString(0,"STATUS");
			actionCode 	= retPoWorkFlow.getFieldValueString(0,"ACTIONCODE");

			roleL   = retPoWorkFlow.getFieldValueString(0,"PARTICIPANT");	
			sysKeyL = retPoWorkFlow.getFieldValueString(0,"SYSKEY");
			templateL = retPoWorkFlow.getFieldValueString(0,"TEMPLATE");
			participantL = retPoWorkFlow.getFieldValueString(0,"PARTICIPANT");
			
			
			
			String reason = request.getParameter("reasons");
			reason = replaceString(reason,"'","`");
			
			String poconCommentNo = request.getParameter("qcsCommentNo");
			String poNumber = request.getParameter("PurchaseOrder");
			

			ezc.ezpreprocurement.client.EzPreProcurementManager qcfManager = new ezc.ezpreprocurement.client.EzPreProcurementManager();
			ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
			mainParams.setLocalStore("Y");
			ezc.ezpreprocurement.params.EziQcfCommentParams qcfParams= new ezc.ezpreprocurement.params.EziQcfCommentParams();
			qcfParams.setQcfCode(poNumber);
			qcfParams.setCommentNo(poconCommentNo);
			qcfParams.setQcfUser(userId);
			qcfParams.setQcfComments(reason);
			qcfParams.setQcfType("COMMENTS");
			qcfParams.setQcfDestUser(userId);
			qcfParams.setQcfExt1("$$");
			mainParams.setObject(qcfParams);
			Session.prepareParams(mainParams);
			qcfManager.addQcfComment(mainParams);
			
			if(attachString != null)
			{
				if(!"".equals(attachString))
				{
					String objNo 		= poNumber;
					String documentType 	= attachDocType;
			
%>
					<%@ include file="../UploadFiles/ezSaveAttachFiles.jsp" %>
<%
				}
			}
			
		}
		String extId ="";
		
		
		
		if("G".equals(partType))
		{
		 	ezc.ezworkflow.params.EziWorkGroupUsersParams wgParams = new ezc.ezworkflow.params.EziWorkGroupUsersParams();
	 	
		    	if("G".equals(delPartType))
		    	{	
		    		wgParams.setGroupId("'"+sendToUser+"','"+delPart+"'");
		    	}
		    	else
		    	{
				ezc.ezworkflow.params.EziWorkGroupsParams wgParams1 = new ezc.ezworkflow.params.EziWorkGroupsParams();
				wgParams1.setUserId(delPart);
				ezc.ezparam.EzcParams wgMainParams1 = new ezc.ezparam.EzcParams(false);
				wgMainParams1.setObject(wgParams1);
				Session.prepareParams(wgMainParams1);
				ezc.ezparam.ReturnObjFromRetrieve wgRet =(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkGroupsList(wgMainParams1);
		    		wgParams.setGroupId("'"+sendToUser+"','"+wgRet.getFieldValueString(0,"GROUP_ID")+"'");
		    	}
		    	
		    	ezc.ezparam.EzcParams wgMainParams = new ezc.ezparam.EzcParams(false);
		    	wgMainParams.setObject(wgParams);
		    	Session.prepareParams(wgMainParams);
		    	ezc.ezparam.ReturnObjFromRetrieve wgRet =(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkGroupUsers(wgMainParams);
		    	sendToUser = "";
		    	if(sysKeyL.equals(wgRet.getFieldValueString(0,"SYSKEY")))
			{
				userGroupL  =wgRet.getFieldValueString(0,"GROUP_ID");
				sendToUser 	= wgRet.getFieldValueString(0,"USERID");
				extId 	= wgRet.getFieldValueString(0,"EMAIL");

				if(extId == null && "null".equals(extId) && "".equals(extId.trim()))
					sendToUser += "," + extId;
			}		
			for(int j=1;j<wgRet.getRowCount();j++)
			{
				if(sysKeyL.equals(wgRet.getFieldValueString(j,"SYSKEY")))
				{
					sendToUser += "," + wgRet.getFieldValueString(j,"USERID");

					extId = wgRet.getFieldValueString(j,"EMAIL");
					if(extId == null && "null".equals(extId) && "".equals(extId.trim()))
						sendToUser += "," + extId;
				}		
			}
				
    		}	
		
		if("R".equals(partType))
		{
			ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
			ezc.ezworkflow.params.EziWorkGroupsParams params= new ezc.ezworkflow.params.EziWorkGroupsParams();
			params.setRoleNo(sendToUser);
			mainParams.setObject(params);
			Session.prepareParams(mainParams);
			ezc.ezparam.ReturnObjFromRetrieve listRet=(ReturnObjFromRetrieve)EzWorkFlow.getWorkGroupsList(mainParams);
			sendToUser="";
			if(listRet != null)
			{
				for(int i=0;i<listRet.getRowCount();i++)
				{
					String groupId = "'"+listRet.getFieldValueString(i,"GROUP_ID")+"'";
					ezc.ezworkflow.params.EziWorkGroupUsersParams wgParams = new ezc.ezworkflow.params.EziWorkGroupUsersParams();
					wgParams.setGroupId(groupId);
					ezc.ezparam.EzcParams wgMainParams = new ezc.ezparam.EzcParams(false);
					wgMainParams.setObject(wgParams);
					Session.prepareParams(wgMainParams);
					ezc.ezparam.ReturnObjFromRetrieve wgRet =(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkGroupUsers(wgMainParams);
					if(sysKeyL.equals(wgRet.getFieldValueString(0,"SYSKEY")))
					{
						userGroupL  	= wgRet.getFieldValueString(0,"GROUP_ID");
						sendToUser 	= wgRet.getFieldValueString(0,"USERID");
						extId 	= wgRet.getFieldValueString(0,"EMAIL");
						if(extId == null && "null".equals(extId) && "".equals(extId.trim()))
							sendToUser += "," + extId;
					}		
					for(int j=1;j<wgRet.getRowCount();j++)
					{
						if(sysKeyL.equals(wgRet.getFieldValueString(j,"SYSKEY")))
						{
							sendToUser += "," + wgRet.getFieldValueString(j,"USERID");
							extId = wgRet.getFieldValueString(j,"EMAIL");
							if(extId == null && "null".equals(extId) && "".equals(extId.trim()))
								sendToUser += "," + extId;
						}		
					}		
				}	
			}
		}		
		
		if(sendToUser.startsWith(","))
			sendToUser = sendToUser.substring(1);
		
		if("Contract".equals(ordType))
		{ 
			if("100066".equals(actionCode))	
				dispMessage="Contract submitted successfully ";
			else if	("100068".equals(actionCode))
				dispMessage="Contract returned ";
		}	
		else
		{
			if("100066".equals(actionCode))
				dispMessage="Purchase Order submitted successfully ";
			else if("100068".equals(actionCode))
				dispMessage="Purchase Order returned ";
		}	
		
		dispMessage += " to "+sendToUser;
		/*if("U".equals(delPartType))
			dispMessage += " and delegated to " + delPart;*/
		
		String link= "";
		
		//dispMessage="PO Number(s) has been submitted Successfully. ";//+retPoWorkFlow.getFieldValueString(0,"PARTICIPANT");
		
		//link = "http://"+request.getServerName()+"/j2ee/ezPrePostPOCon.jsp?POCON="+pocon;
		link = "http://"+request.getServerName()+"/j2ee/EzCommerce/EzVendor/Offline/JSPs/ezOfflineLogin.jsp?DEFAULT_PAGE="+pocon;
		//link = "http://"+request.getServerName()+"/j2ee/EzCommerce/EzVendor/Offline/POCON/ezPrePostPOCON.jsp?TEMPLATE="+template+"&SYSKEY="+sysKey+"&SOLDTO="+soldTo+"&POCON="+pocon;
		link = "<br><a href="+link+" target=_blank>Click here  to process the Document.</a>";
		String disp = "Please click on the following link for details. ";	
		
		msgSubject = subjText+" has been submitted for further Release";
		msgText = "Dear Sir/Madam<br>"+subjText+"&nbsp;"+POs+"<br> has been submitted for further Release.<br>";
		msgText = msgText+"<BR>"+disp+"<BR>"+link;
		msgText += "<br>Regards,<br>"+Session.getUserId();
		
		
		String inboxPath="";
	 	
		
%>	
<%@ include file="../Purorder/ezSendMail.jsp" %>
<%
	if("Y".equals(Offline))
		response.sendRedirect("../Misc/ezOfflineMessage.jsp?MESSAGE="+dispMessage+"&DEFAULT_PAGE="+pocon);
%>
<html>
<head>

<title>Purchase Orders</title>
<script>
var tabHeadWidth=96
var tabHeight="65%"
</script>
<script src="../../Library/JavaScript/ezTabScroll.js"></script>
<script>
	function funOk()
	{
		document.myForm.action="ezListSubmitPo.jsp";
		document.myForm.submit();
	}
	function sendBack()
	{
		document.myForm.action="<%=fileName%>";
		document.myForm.submit();
	}

	function reLoad(action)
	{
		if(action == 'Y')
		{
			sendBack();
		}	
		else
		{
			setTimeout("reLoad('Y')",1000);
		}

	}
	
</script>
<script language="Javascript1.2">
	am = "This function is disabled!";
	bV  = parseInt(navigator.appVersion)
	bNS = navigator.appName=="Netscape"
	bIE = navigator.appName=="Microsoft Internet Explorer"
	function nrc(e) 
	{
	   if (bNS && e.which > 1)
	   {
	      alert(am)
	      return false
	   } 
	   else if (bIE && (event.button >1)) 
	   {
	     alert(am)
	     return false;
	   }
	}
	document.onmousedown = nrc;
	if (document.layers) window.captureEvents(Event.MOUSEDOWN);
	if (bNS && bV<5) window.onmousedown = nrc;
</script>

</head>
<body onLoad="reLoad('N')">
		<%
			String display_header = "";
		%>	
		
				<%@ include file="../Misc/ezDisplayHeader.jsp"%>

		<form name="myForm" method="post">
		<input type=hidden name=type value='<%=ordertype%>'>
 		<div id="nocount" style="position:absolute;top:0%;width:100%">
			
			<br><br><br><br>
			<TABLE width="50%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			<tr align="center">
			<th>
		       	<%=dispMessage%>
			</th>
			</tr></table>
		</div>
		
	<Div align=center style="position:absolute;top:70%;visibility:visible;width:100%">
 <%
	//butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
	//butActions.add("sendBack()");
	//out.println(getButtons(butNames,butActions));
 %>
 
		</Div>	
	</form>	
	<Div id="MenuSol"></Div>
	</body>
</html>		




		

