<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/Lib/AdminUtilsBean.jsp"%>
<jsp:useBean id="AdminUtilsManager" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>
<%
	
	/******STARTS********/
	int syskeyCount 	= 0;
	int paytoCount 		= 0;
	boolean isPaytoSynch 	= false; 
	String sysKey 		= "";
	String partnerFunction 	= "VN";
	String subPartnerValue 	= "";
	String userId 		="";
	String userName 	="";
	String email 		="";
	String readOnly		="";
	String bizPartner	=null;
	String partnerValue = request.getParameter("payTo");
	java.util.Vector synchSysKeys = new java.util.Vector(); 
	
	ReturnObjFromRetrieve partnersRet = null;
	ReturnObjFromRetrieve usersRet = null;
		
	if(ret!=null)
		syskeyCount = ret.getRowCount();
	
	if(syskeyCount>0){
		sysKey = ret.getFieldValueString(0,SYSTEM_KEY);
		for (int i=1;i<syskeyCount;i++){
			sysKey += ","+ret.getFieldValueString(i,SYSTEM_KEY);
		}
	}	
	if(sysKey!=null && partnerFunction!=null && partnerValue!=null && (!"null".equals(partnerValue)))
	{
		partnerValue = partnerValue.trim();
		partnerValue = partnerValue.toUpperCase();
		try{
			partnerValue = Long.parseLong(partnerValue)+"";
			subPartnerValue="0000000000"+partnerValue;
			subPartnerValue=subPartnerValue.substring((subPartnerValue.length()-10),subPartnerValue.length());
		}
		catch(Exception e)
		{
			subPartnerValue = partnerValue;
		}
				
		EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
		adminUtilsParams.setSyskeys(sysKey);
		adminUtilsParams.setPartnerFunction(partnerFunction);
		adminUtilsParams.setPartnerValue(subPartnerValue);
		
		EzcParams mainParams = new EzcParams(false);
		mainParams.setObject(adminUtilsParams);
		Session.prepareParams(mainParams);
		
		partnersRet = (ReturnObjFromRetrieve)AUM.getPartnerPartners(mainParams);
		
		EziAdminUtilsParams adminUtilsParams1 = new EziAdminUtilsParams();
		adminUtilsParams1.setSyskeys(sysKey);
		adminUtilsParams1.setPartnerValueBy(subPartnerValue);
				
		EzcParams mainParams1 = new EzcParams(false);
		mainParams1.setObject(adminUtilsParams1);
		Session.prepareParams(mainParams1);
				
		usersRet = (ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParams1);
	}
		
	if(partnersRet!=null)
		paytoCount = partnersRet.getRowCount();
		
	if(paytoCount>0){
		
		isPaytoSynch 	= true;
		readOnly      	= "readonly";
		bizPartner 	= partnersRet.getFieldValueString(0,"EC_BUSINESS_PARTNER");
		for (int j=0;j<paytoCount;j++)
		{
		
			synchSysKeys.add(partnersRet.getFieldValueString(j,"EC_SYS_KEY"));
			
		}
		if(usersRet!=null)
		{
			userId   = usersRet.getFieldValueString(0,"EU_ID");
			userName = usersRet.getFieldValueString(0,"EU_FIRST_NAME");
			email	 = usersRet.getFieldValueString(0,"EU_EMAIL");
		}
	}else{
		userId = partnerValue;
	}
	
%>
<html>
<head>
	<Title>Quick Add Vendor</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<script src="../../Library/JavaScript/ezTabScroll.js"></script>
	<script src="../../Library/JavaScript/CheckFormFields.js"></script>
	<script src="../../Library/JavaScript/User/ezPreQuickAddVednor.js"></script>
	<Script>
	function funSubmit(){
		
		if(chkAll()){
		if(<%=isPaytoSynch%>)
		{
			document.myForm.action = "ezQuickExtendUser.jsp";
			document.myForm.submit();
		}else{
			document.myForm.action = "ezQuickAddVendor.jsp";
			document.myForm.submit();
		}
		}
	}
	</Script>
	
	
</head>
<body onLoad='scrollInit();funFocus()' onresize='scrollInit()' scroll = "no">
<form name=myForm method=post >
<%
int retCount = ret.getRowCount();
if(retCount>0)
{
%>
<br>
	<div id="theads">
       	<Table id="tabHead" width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Td class = "displayheader" align = "center" colspan = 6>Quick Add Vendor</Td>
	</Tr>
	<Tr>
		<Th>Pay To*</Th>
		<Td><input type = "text" class = "InputBox" name = "payTo" value="<%=partnerValue%>" <%=readOnly%> size = 15 maxlength = "10" onChange = "funUserId()"></Td>
		<Th>User ID*</Th>
		<Td><input type = "text" class = "InputBox" name = "userId" value="<%=userId%>" <%=readOnly%>  size = 15 maxlength = "10"></Td>
	</TR>
	<TR>
		<Th>Partner / User Name*</Th>
		<Td><input type = "text" class = "InputBox" name = "userName" value="<%=userName%>"  <%=readOnly%> size = 25 maxlength = "60"></Td>
		<input type="hidden" name="bizPartner" value="<%=bizPartner%>" >
		<Th>Email*</Th>
		<Td><input type = "text" class = "InputBox" name = "email" value="<%=email%>"  <%=readOnly%> size = 30 maxlength = "60"></Td>
	</Tr>
	</Table>
       	<Table width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th align="left" width = "10%" colspan = 1>
			<input type = "CheckBox" name = "chk1Main" value = "chk1Main" onClick="selectAll()">
			<font size=1>Select All</font> 
		</Th>	
		<Th align="center" width = "30%" colspan = 3>Business Area</Th>
	</Tr>
	</Table>
	</Div>
	<div id="InnerBox1Div">
        <Table  id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
	
<%
	for(int i=0;i<retCount;i++)
	{
%>
		<label for="cb_<%=i%>">
<%
		if(i%3==0)
		{
%>
	</Tr>
	<Tr>
		
<%
	}
%>
	<Td width = "33%" title = "(<%=ret.getFieldValueString(i,"ESKD_SYS_KEY")%>) <%=ret.getFieldValueString(i,"ESKD_SYS_KEY_DESC")%>">
<%
		if(!synchSysKeys.contains(ret.getFieldValueString(i,"ESKD_SYS_KEY"))){
%>		
		<input type = "CheckBox" name = "syskey" id="cb_<%=i%>" value = "<%=ret.getFieldValueString(i,"ESKD_SYS_KEY")%>" >
<%
		}else{
		
%>
		<input type = "CheckBox" name = "synchSyskey" id="cb_<%=i%>" checked disabled value = "<%=ret.getFieldValueString(i,"ESKD_SYS_KEY")%>" >			
<%
		}
%>
		
		<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=ret.getFieldValueString(i,"ESKD_SYS_KEY")%>">
			<input type = "text" value = "(<%=ret.getFieldValueString(i,"ESKD_SYS_KEY")%>) <%=ret.getFieldValueString(i,"ESKD_SYS_KEY_DESC")%>" size = "30" class = "DisplayBox" readonly Style = "Cursor:hand;text-decoration:underline">
		</a>
	</Td>
	
<%
	}
	
%>
	</label>
	</Tr>
	</Table>
	</Div>
	<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
	 	<a href="JavaScript:funSubmit()"><img src = "../../Images/Buttons/<%= ButtonDir%>/continue.gif" border=none></a>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
	</div>
<%
}
else
{
%>
	<br><br><br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  	<Tr align="center">
    	<Th>There are no Purchase Areas to List</Th>
  	</Tr>
	</Table>
	<br>
	<center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
	</center>
<%
}
%>
</form>
</html>