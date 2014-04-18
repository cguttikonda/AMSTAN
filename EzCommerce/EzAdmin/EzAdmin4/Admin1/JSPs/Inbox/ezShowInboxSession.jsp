<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<%
/*	ezc.ezparam.EzcUserParams uparams= new ezc.ezparam.EzcUserParams();
	ezc.ezparam.EzcUserNKParams ezcUserNKParams = new ezc.ezparam.EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");
	ezcUserNKParams.setSys_Key("0");
	uparams.createContainer();
	uparams.setUserId(Session.getUserId());
	uparams.setObject(ezcUserNKParams);
	Session.prepareParams(uparams);
	ezc.ezparam.ReturnObjFromRetrieve retObj = (ezc.ezparam.ReturnObjFromRetrieve)(UManager.getAddUserDefaults(uparams));
	
	int retCount = retObj.getRowCount();
	String server="",protocol="",user="";
	for(int i=0;i<retCount;i++)
	{
		if("POP3HOST".equals(retObj.getFieldValueString(i,"EUD_KEY")))
			server = retObj.getFieldValueString(i,"EUD_VALUE");
		if("POP3PROTOCOL".equals(retObj.getFieldValueString(i,"EUD_KEY")))
			protocol = retObj.getFieldValueString(i,"EUD_VALUE");
		if("POP3USERID".equals(retObj.getFieldValueString(i,"EUD_KEY")))
			user = retObj.getFieldValueString(i,"EUD_VALUE");	
	}
*/
	String server = request.getParameter("server");
	String protocol = request.getParameter("protocol");
	String user = request.getParameter("user");

%>
	<html>
	<head>
	<Title>POP3 Account Info -- Powered by EzCommerce Global Solutions</Title>
	<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>
	<script>
		var track = null;
		function setInfo()
		{
			var FieldNames=new Array;
			var CheckType=new Array;
			var Messages=new Array;
			 
			FieldNames[0]="server";
			CheckType[0]="MNull";
			Messages[0]="Please enter Server";
			FieldNames[1]="protocol";
			CheckType[1]="MNull";
			Messages[1]="Please enter Protocol";
			FieldNames[2]="userId";
			CheckType[2]="MNull";
			Messages[2]="Please enter userId";
			FieldNames[3]="password";
			CheckType[3]="MNull";
			Messages[3]="Please enter password";
	
			if(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
			{
				track = "forward";	
			
				var server = document.myForm.server.value
				var protocol = document.myForm.protocol.value
				var userId = document.myForm.userId.value
				var password = document.myForm.password.value

				window.returnValue="ezSaveInboxSession.jsp?server="+server+"&protocol="+protocol+"&userId="+userId+"&password="+password
				window.close()
			}	
		}
		function setCancel()
		{
			if(track != "forward")
			{
				window.returnValue="Cancel"
				window.close()
			}	
		}
		
	</script>
</head>
<body bgcolor=#ffcc66 leftmargin="0" topmargin="0" onunload="setCancel()">

<form name=myForm method=post>
<Table  border="1" align=center cellspacing="0" cellpadding="2" bordercolorlight="#000000" bordercolordark="#ffffff" width=100% >
	<Tr>
    	<Td valign=top rowspan=5><img src="../../Images/Buttons/<%=ButtonDir%>/Buttons/ezbird.gif" ></Td>
    	<Td colspan=2><nobr>Please give us your POP3 account info</nobr></Td>
	</Tr>
	<Tr>
		<Td ><nobr>Server*</nobr></Td>
		<Td >
			<input type=text name="server" class="InputBox"   size="22" value="<%=server%>"></Td>
	</Tr>
	<Tr>
			<Td ><nobr>Protocol*</nobr></Td>
			<Td >
			<input type=text name="protocol" class="InputBox"   size="22" value="<%=protocol%>"></Td>
	</Tr>
	<Tr>
			<Td ><nobr>User Id*</nobr></Td>
			<Td >
			<input type=text name="userId" class="InputBox"   size="22" value="<%=user%>"></Td>
	</Tr>
	<Tr>
			<Td ><nobr>Password*</nobr></Td>
			<Td >
			     <input type=password name="password" class="InputBox"   size="22" ></Td>
	</Tr>
	
	
	
</Table >
	<br><center>
	<a href="JavaScript:void(0)"><img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" border=none onClick="setInfo()"></a>
	<a href="JavaScript:void(0)"><img src="../../Images/Buttons/<%=ButtonDir%>/cancel.gif" border=none onClick="setCancel()"></a>
</form>
</body>