<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@page import="ezc.ezparam.*,ezc.ezpreprocurement.params.*,ezc.ezworkflow.params.*,ezc.ezutil.*" %>
<jsp:useBean id="Session" 	class="ezc.session.EzSession" scope = "session" />
<jsp:useBean id="PreProManager" class="ezc.ezpreprocurement.client.EzPreProcurementManager" scope="session" />
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="page"></jsp:useBean>
<%@ include file="../../../Includes/Jsps/Misc/iGetVendorDesc.jsp"%>
<%
	
	
	String defCatArea  = (String)session.getValue("SYSKEY");
	String userId 		=	Session.getUserId();
	String userRole    = (String)session.getValue("USERROLE");
	String userGroup   = (String)session.getValue("USERGROUP");
	String wfCheckName =  userId+"','"+userGroup+"','"+userRole;	
	EzcParams ezcContainer= null;
	EziRFQHeaderParams rfqHeaderParams =null;
	EziWFDocHistoryParams wfparams=null;
	ReturnObjFromRetrieve rfqListRetObj =null;
	ReturnObjFromRetrieve globalRet = null;

	int retObjCount=0;
	
	Vector types = new Vector();
	types.addElement("date");
	//types.addElement("date");
	EzGlobal.setColTypes(types);
	EzGlobal.setDateFormat("dd.MM.yyyy hh:mm");

	Vector colNames = new Vector();
	colNames.addElement("ERH_RFQ_DATE");
	//colNames.addElement("ERH_VALID_UPTO");
	EzGlobal.setColNames(colNames);
	
	
	ezc.ezutil.FormatDate fD=new ezc.ezutil.FormatDate();
	
	ezcContainer=new EzcParams(false);
	rfqHeaderParams 	= new EziRFQHeaderParams();
	wfparams		= new EziWFDocHistoryParams();
	rfqHeaderParams.setExt1("RFQEDITLIST");	
	rfqHeaderParams.setSysKey(defCatArea);
	wfparams.setAuthKey("QCF_RELEASE");
	wfparams.setParticipant(wfCheckName);
	wfparams.setStatus("SUBMITTED','REJECTED");
	ezcContainer.setObject(rfqHeaderParams);
	ezcContainer.setObject(wfparams);
	ezcContainer.setLocalStore("Y");
	Session.prepareParams(ezcContainer);
	rfqListRetObj =(ReturnObjFromRetrieve)PreProManager.ezGetRFQList(ezcContainer);
	
	
	
	if(rfqListRetObj!=null)
	{
		retObjCount = rfqListRetObj.getRowCount();
		globalRet = EzGlobal.getGlobal(rfqListRetObj);
	}	
	
%>
<html>
<head>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<Script>
	var tabHeadWidth=90
	var tabHeight="70%"
</Script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script src="../../Library/JavaScript/Misc/ezHideButtons.js"></script>
<Script>
	

	function viewRFQDetailsFun(orderNo,closeDate,vendor,collectiveNo)
	{
		document.myForm.PurchaseOrder.value = orderNo
		document.myForm.EndDate.value 	    = closeDate
		document.myForm.rfqVendor.value     = vendor		
		document.myForm.collectiveRFQNo.value = collectiveNo		
		document.myForm.action 		    = "ezViewRFQDetails.jsp";
		document.myForm.submit()
	}
	
	function showRFQEdit()
	{
		var chkObj=document.myForm.chk1;
		var chkLen=0;
		var processFlg=false;
		var chkVal="";
		if(chkObj!=null)
		{
			chkLen=chkObj.length
			if(isNaN(chkLen)){
				if(chkObj.checked){
					processFlg=true;
					chkVal=(chkObj.value).split("¥¥");
				}
			}else{
				for(var i=0;i<chkLen;i++){
					if(chkObj[i].checked){
						processFlg=true;
						chkVal=(chkObj[i].value).split("¥¥");
						break;
					}	
				}
			}
			
			if(!processFlg){
				alert("Please select an RFQ to Edit");
				return;
			}else{
				document.myForm.PurchaseOrder.value   = chkVal[0];
				document.myForm.EndDate.value 	      = chkVal[1];
				document.myForm.rfqVendor.value       = chkVal[2];		
				document.myForm.collectiveRFQNo.value = chkVal[3];
				hideButton();
				document.myForm.action 	 = "ezEditRFQ.jsp";
				document.myForm.submit()
			}
			
			
			
		}
	}
</Script>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()">
<form name="myForm">
<%
	String display_header = "RFQs List";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<%
	if(retObjCount == 0)
	{
%>
		

		<br><br><br><br>
		<table width="50%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 align="center">
		<tr align="center">
			<th>No  RFQs exist to edit.</th>
		</tr>
		</table>
		

<%
	}else{
	
		
%>
		
		
		<br>
		<DIV id="theads">
		<table id="tabHead" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="90%">
			<tr align="center" valign="middle">
				
				<th width="5%">&nbsp;</th>
				<th width="12%">RFQ No</th>
				<th width="12%">Collective RFQ No.</th>
				<th width="12%">Vendor</th>
        <th width="25%">Vendor Name</th>
				<th width="19%">RFQ Date </th>
				<th width="15%">RFQ Closing Date</th>

			</tr>
		</table>
		</DIV>
		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:70%;height:80%;left:2%">
		<TABLE id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
<%
		for(int i=0;i<retObjCount;i++){
		
			String rfqNo=rfqListRetObj.getFieldValueString(i,"ERH_RFQ_NO");
			String collRFQNo=rfqListRetObj.getFieldValueString(i,"ERH_COLLETIVE_RFQ_NO");
			String vendor=rfqListRetObj.getFieldValueString(i,"ERH_SOLD_TO");
			String rfqDate=fD.getStringFromDate((java.util.Date)rfqListRetObj.getFieldValue(i,"ERH_RFQ_DATE"),".",fD.DDMMYYYY);
			String rfqValidUpto=fD.getStringFromDate((java.util.Date)rfqListRetObj.getFieldValue(i,"ERH_VALID_UPTO"),".",fD.DDMMYYYY);
			
			
			
%>
			<tr >
				
				<td width="5%"  align="center">
					<input type="radio" name="chk1" value="<%=rfqNo+"¥¥"+rfqValidUpto+"¥¥"+vendor+"¥¥"+collRFQNo%>">
				</td>
				<td width="12%" align="center">
				<a href ="JavaScript:viewRFQDetailsFun('<%=rfqNo%>','<%=rfqValidUpto%>','<%=vendor%>','<%=collRFQNo%>')"  onMouseover="window.status='Click to view the RFQ Lines '; return true" onMouseout="window.status=' '; return true" onClick="hideButton()"><%=rfqNo%></a> 
								
				</td>
				<td width="12%" align="center"><%=collRFQNo%></td>
				<td width="12%" align="center"><%=vendor%></td>
       				 <td width="25%" align="left"><%=venodorsHT.get(vendor)%></td>
				<!--<td width="13%" align="center"><%=rfqDate%></td>-->
				<td width="19%" align="center"><%=globalRet.getFieldValue(i,"ERH_RFQ_DATE")%></td>
				<td width="15%" align="center"><%=rfqValidUpto%>
				<!--<td width="15%" align="center"><%=globalRet.getFieldValue(i,"ERH_VALID_UPTO")%></td>-->
			
			</tr>
<%
		}
%>
		
		</Table>
		</Div>
		<input type="hidden" name="rfqVendor" value="">
		<input type="hidden" name="PurchaseOrder" value="">
		<input type="hidden" name="collectiveRFQNo" value="">
		<input type="hidden" name="EndDate" value="">
		<input type="hidden" name="type" value="EditRFQ">
		
		
<%
	}
%>


<!--<Div  id='ButtonsDiv' align="center" style="position:absolute;left:0%;width:100%;top:90%">
<Table>
<Tr>
<Td class=blankcell>

 <img style="cursor:hand" border=none src="../../Images/Buttons/<%=ButtonDir%>/back.gif" onClick="javascript:history.go(-1)">
 <img style="cursor:hand" border=none src="../../Images/Buttons/<%=ButtonDir%>/edit.gif" onClick="javascript:showRFQEdit()">
 </Td>
</Tr>

</Table>
</Div>-->

<Div  id='ButtonsDiv' align="center" style="position:absolute;left:0%;width:100%;top:90%">
 <span id="EzButtonsSpan" >
<%
          butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
          butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Edit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
    
          butActions.add("history.go(-1)");
          butActions.add("showRFQEdit()");
          out.println(getButtons(butNames,butActions));

%>
	</span>
	<span id="EzButtonsMsgSpan" style="display:none">
		<Table align=center>
			<Tr>
				<Td class="labelcell">Your request is being processed... Please wait</Td>
			</Tr>
		</Table>
	</span>
</Div>
</Form>
<Div id="MenuSol"></Div>

</Body>
</Html>