 <%@ page import = "ezc.ezparam.*" %>
 <%@ page import = "ezc.ezcommon.*" %>
 <%@ page import="ezc.ezupload.params.*,java.util.ResourceBundle" %>
 <jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
 <jsp:useBean id="EzUploadManager" class="ezc.ezupload.client.EzUploadManager" scope="session" />
 <jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
 
 <%
 
	String currSysKey   = (String) session.getValue("SalesAreaCode");
	String objId        = (String) session.getValue("AgentCode");
	String userRole     = (String) session.getValue("UserRole");
	String soldToSel    = request.getParameter("SoldTo");
	String msgOut ="";
	
	
	ReturnObjFromRetrieve retsoldto = null;
	int soldToCount = 0;
	
	if(!"CU".equals(userRole)){
	
		if(soldToSel!=null && !"null".equals(soldToSel) && !"".equals(soldToSel.trim())){
			objId = soldToSel;
		}else{
			objId = "";
			msgOut = "Please select the customer from list";
			
		}
	
	        java.util.ArrayList desiredSteps=new java.util.ArrayList();
		if("CM".equals(userRole))
			desiredSteps.add("1");
		else if("DM".equals(userRole))
			desiredSteps.add("2");	
		else if("LF".equals(userRole))
			desiredSteps.add("3");
		else if("SM".equals(userRole))
			desiredSteps.add("4");	
		else if("SBU".equals(userRole))
			desiredSteps.add("5");
		else if("INDREG".equals(userRole))
			desiredSteps.add("6");
	
		ezc.ezparam.EzcParams mainParamsu = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFParams paramsu= new ezc.ezworkflow.params.EziWFParams();
		paramsu.setTemplate((String)session.getValue("Template"));
		paramsu.setSyskey(currSysKey); 
		paramsu.setPartnerFunction("AG");
		paramsu.setParticipant((String)session.getValue("UserGroup"));
		paramsu.setDesiredSteps(desiredSteps);
		mainParamsu.setObject(paramsu);
		Session.prepareParams(mainParamsu);
		retsoldto=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParamsu);
		if(retsoldto!=null){
			soldToCount= retsoldto.getRowCount();
			if(soldToCount>0)
			retsoldto.sort(new String[]{"ECA_NAME"},true);
		}	
		
	}
	
	
	String searchKey = "'"+currSysKey+"VENDPRICE"+objId+"'";
	String delFlg    = request.getParameter("delFlg"); 
	String document  = request.getParameter("docNo"); 
	ezc.ezparam.ReturnObjFromRetrieve listRetObj=null;
	ezc.ezparam.ReturnObjFromRetrieve fileRetObj=null;
	int retObjCount = 0;
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	String severPath = "";
	try{
		  ResourceBundle rb = ResourceBundle.getBundle("Site");
		  severPath         = rb.getString("UPLOADDIR");
		  
		 
	}catch(Exception err){ }
	
	if("X".equals(delFlg)){
		EziUploadDocFilesParams fileParam = new EziUploadDocFilesParams();
		java.util.StringTokenizer st = new java.util.StringTokenizer(document,"$$");
		fileParam.setUploadNo(st.nextToken());
		fileParam.setServerFileName("'"+st.nextToken()+"'");
		mainParams.setObject(fileParam);
		Session.prepareParams(mainParams);
		EzUploadManager.deleteUploadedFiles(mainParams);
	
	}
	
	if(!"".equals(objId)){
		ezc.ezupload.params.EziUploadDocsParams params= new ezc.ezupload.params.EziUploadDocsParams();
		params.setObjectNo(searchKey);
		mainParams.setObject(params);
		Session.prepareParams(mainParams);
		listRetObj=(ezc.ezparam.ReturnObjFromRetrieve)EzUploadManager.getUploadedDocs(mainParams);
		if(listRetObj!=null)
		{
			retObjCount =  listRetObj.getRowCount(); 
			if(retObjCount>0){
			 listRetObj.sort(new String[]{"CREATEDON"},false);
			}else{
				if("CU".equals(userRole)){
					msgOut = "No Price Files exist, Please Click on 'Attach' for uploading.";
				}else{
					msgOut = "No Price Files exist for the selected customer.";
				}
				
			}
		}
 	}
 	
%>
 
 
 
 
 
 <Html>
 <Head>
 <Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script>
 <Title>Vendor Price Upload</Title>
 <%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<Script>
	  var tabHeadWidth=95
	  var tabHeight="40%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
 <Script>
 
 function uploadDocs()
 {
 	 
 	 var qryString = "ezVendorPriceAttach.jsp";   
 	 retVal= window.open(qryString,"PriceUpload","resizable=no,left=100,top=220,height=350,width=400,status=no,toolbar=no,menubar=no,location=no")
 }
 
 function deleteDocs()
 {
 	
 	var docObj = document.myForm.docNo;
 	var len = docObj.length;
 	var flg = 'N';
 	if(isNaN(len)&&docObj.checked){
 	   flg = 'Y';
 	}else{
 		for(i=0;i<len;i++){
 			if(docObj[i].checked){
 			 flg = 'Y';
 			 break;
 			}
 			
 		}
 	}
 	
 	
 	if('N'== flg){
 		alert('Please select the price file from list');
 	}else{
		document.myForm.delFlg.value = 'X';
		document.myForm.action = "ezVendorPriceUpload.jsp";
		document.myForm.submit();
 	}
 }
 
 function showFile(indx){
 
 	var serFileObj = document.myForm.serverFile;
 	var len = serFileObj.length;
 	var serFile = "";
 	if(isNaN(len)){
 	serFile = serFileObj.value; 	 		
 	}else{
 	serFile = serFileObj[indx].value; 	 	
 	}
 	 	
 	var qryString = "../Misc/ezViewFile.jsp?filename="+serFile;  
 	
 	document.myForm.action = qryString;
 	document.myForm.submit();
 	
 
 }
 
 function funProcess(){
        
        var soldTo =document.myForm.SoldTo.value;
        
        if(soldTo!=''){
          document.myForm.action="ezVendorPriceUpload.jsp";
          document.myForm.submit();
        }
 	
 }
 
 </Script>
 
 </Head>
 <Body onLoad="scrollInit();" onresize="scrollInit();"  scroll=no>
 <Form name="myForm" method="post" > 
 <input type= 'hidden' name='delFlg' value="">
 <%
 	String display_header = "Vendor Price Files";
 	 	
 %>
 
 
 <%@ include file="../Misc/ezDisplayHeader.jsp"%>
 
<% if(soldToCount>0){%>
	
	<Table width="60%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
	<Tr>
		<Td height="5" style="background-color:'#69c'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
		<Td height="5" style="background-color:'#69c'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
		<Td height="5" style="background-color:'#69c'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
	</Tr>
	<Tr height=25px>
		<Td width="5" style="background-color:'#69c'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
		<Td style="background-color:'#69c';font-size:12px" valign=middle align=center>

		<table width="80%" align=center border=0  borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
		<Tr>
			<Th width="30%" style="background-color:'#69c'" align=right>Customer &nbsp;&nbsp;----&nbsp;&nbsp;</Th>
			<Td width="70%" align='left' style="background-color:'#69c'">
			<Select name='SoldTo' onChange="funProcess()">
				<option value="">--Select--</Option>
<%				
                        String selected ="";
			for(int i = 0;i < soldToCount;i++)
			{
				selected ="";
				if((retsoldto.getFieldValueString(i,"EC_ERP_CUST_NO")).equals(objId))
				selected ="Selected";
				
%>						
				<option <%=selected%> value="<%=retsoldto.getFieldValueString(i,"EC_ERP_CUST_NO")%>"><%=retsoldto.getFieldValueString(i,"ECA_NAME")%>[<%=retsoldto.getFieldValueString(i,"EC_ERP_CUST_NO")%>]</option>
<%
			}
%>				
			</select>
			</Td>
		</Tr>
		</Table>
	</Tr>
	<Tr>
		<Td width="5" style="background-color:'#69c'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
		<Td height="5" style="background-color:'#69c'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
		<Td width="5" style="background-color:'#69c'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
	</Tr>
	</Table>
	
<%}%>
 
<br><br>
<%if(retObjCount == 0){%>
<Table align=center border=0 >
<TR>
	<Td class=displayalert  colspan="4" align="center"> <%=msgOut%> </TD>
</TR>
</Table>
<%}else{%>

<Div id="theads">
<Table width="95%"  id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<Tr>
	<% if("CU".equals(userRole)){%>
	
		<th width="5%" valign="top" nowrap>&nbsp;</th>
		<th width="50%" valign="top" nowrap>Price File</th>
	<%}else{%>
		<th width="55%" valign="top" nowrap>Price File</th>
	
	<%}%>
	
	<th width="20%" valign="top" nowrap>Updated By</th>
	<th width="25%" valign="top" nowrap>Updated On</th>
        
</Tr>
</Table>
</Div>

<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:40%;left:2%">
<Table align=center  id="InnerBox1Tab"  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">

<%
	String serFile ="";
	String clntFile ="";
	for(int i=0;i<retObjCount;i++){
		fileRetObj = (ezc.ezparam.ReturnObjFromRetrieve)listRetObj.getFieldValue(i,"FILES");
		if(fileRetObj!=null&&fileRetObj.getRowCount()>0){
			serFile = fileRetObj.getFieldValueString(0,"SERVERFILENAME");
			serFile = serFile.replace('*','\\');
			clntFile = fileRetObj.getFieldValueString(0,"CLIENTFILENAME");
			
			
		}
		
%>
		<Tr>
			
			<%if("CU".equals(userRole)){%>
				
				<Td width="5%"> <input type='radio' name='docNo' value="<%=listRetObj.getFieldValueString(i,"UPLOADNO")+"$$"+serFile%>"></Td>
				<Td width="50%"> <input type ='hidden' name='serverFile'  value="<%=severPath+serFile%>">
				<a href="JavaScript:showFile(<%=i%>)" title ='Click here to View'><%=clntFile%> </a></Td>
			<%}else{%>
				<Td width="55%"> <input type ='hidden' name='serverFile'  value="<%=severPath+serFile%>">
				<a href="JavaScript:showFile(<%=i%>)" title ='Click here to View'><%=clntFile%> </a></Td>
				
			<%}%>			
			
			<Td width="20%"> <%=listRetObj.getFieldValueString(i,"CREATEDBY")%></Td>
			<Td width="25%"> <%=listRetObj.getFieldValueString(i,"CREATEDON")%></Td>
		</Tr>
<%
	}
%>

</Table>
</Div>


<%}%>
<br><br>
 <Div id="buttonDiv"  style="position:absolute;top:65%;left:40%" align="center">
 	
 <%	
 	        if("CU".equals(userRole)){
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();

			if(retObjCount>0){

				buttonName.add("Delete");
				buttonMethod.add("deleteDocs()");	

			}

			buttonName.add("Attach");
			buttonMethod.add("uploadDocs()");	
			out.println(getButtonStr(buttonName,buttonMethod));
 		}
 		
 %>		
 
</Div>
</Form>

<Div id="MenuSol"></Div>
</Body>
</Html>
