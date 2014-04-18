<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import = "ezc.ezparam.*" %>

<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"></jsp:useBean>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>

<%
String values[] = request.getParameter("BusinessUser").split("�");

String user_id=values[0];

%>		
<%@ include file="../../../Includes/JSPs/Misc/iSubUserDetails.jsp"%>

<%

	String userId=	ret.getFieldValueString(0,"EU_ID");
	String firstName=ret.getFieldValueString(0,"EU_FIRST_NAME");
	String email=ret.getFieldValueString(0,"EU_EMAIL");
	String password=ret.getFieldValueString(0,"EU_PASSWORD");
	
	if(email==null || "null".equals(email))
		email="";
	if(firstName==null || "null".equals(firstName))
		firstName="";	
	
	/***************** Sub User Authorizations Start ******************/
	
	Hashtable subUserAuthHT = new Hashtable();
	
	subUserAuthHT.put("VONLY","View");
	subUserAuthHT.put("VSAVE","Save");
	subUserAuthHT.put("VEDIT","Submit");
	
	/***************** Sub User Authorizations End ******************/
%>

<html>
<head>
	<Title>Change User Data</Title>


<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>

function echeck(str) 
{

	var at="@"
	var dot="."
	var lat=str.indexOf(at)
	var lstr=str.length
	var ldot=str.indexOf(dot)
	if (str.indexOf(at)==-1){
	   alert("Invalid E-mail ID")
	   return false
	}

	if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
	   alert("Invalid E-mail ID")
	   return false
	}

	if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
	    alert("Invalid E-mail ID")
	    return false
	}

	 if (str.indexOf(at,(lat+1))!=-1){
	    alert("Invalid E-mail ID")
	    return false
	 }

	 if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
	    alert("Invalid E-mail ID")
	    return false
	 }

	 if (str.indexOf(dot,(lat+2))==-1){
	    alert("Invalid E-mail ID")
	    return false
	 }

	 if (str.indexOf(" ")!=-1){
	    alert("Invalid E-mail ID")
	    return false
	 }

	 return true					
}
	
function updateSubVndr()
{
	
	var count=0;
	var len=document.myForm.CheckBox.length;
	var obj=document.myForm.CheckBox;
	var emailID=document.myForm.email
	
	if(document.myForm.userName.value=="")
	{
		alert("Please enter  username")
		document.myForm.userName.focus();
		return false;
	}
	if(document.myForm.email.value=="")
	{
		alert("Please enter  email")
		document.myForm.email.focus();
		return false;
	}
	if (echeck(emailID.value)==false){
		emailID.value=""
		emailID.focus()
		return
	}
	if(isNaN(len))
	{
		if(obj.checked)
		count++;
	}

	else
	{
		for(var i=0;i<len;i++)
		{
			if(obj[i].checked)
			count++;
		}	
	}
	if(count==0)
	{
		alert("Please select atleast one ERP customer");
		return;
	}
	else
	{

	document.myForm.action="ezSaveChangeSubUserDetails.jsp";
	document.myForm.submit();
	}
}
function selectAll()
{
	var chkHeader=document.myForm.CheckBox1;
	var len=document.myForm.CheckBox.length;
	var obj=document.myForm.CheckBox;

	if(isNaN(len))
	{
		obj.checked=chkHeader.checked;
	}

	else
	{
		for(var i=0;i<len;i++)
		obj[i].checked=chkHeader.checked;
	}
}
</Script>
</head>
<Script>
	var tabHeadWidth=89
	var tabHeight="45%"
</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
</head>
<body  onLoad='scrollInit()' onResize='scrollInit()' scroll=no>
<Script src="../../Library/JavaScript/wz_tooltip.js"></Script> 
<form name=myForm method=post action="">


<form name=myForm method=post action="ezChangeUser.jsp">

<br>

<Table  border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr align="center">
	    	<Td class="displayheader">Change User Information</Td>
	</Tr>
</Table>


<Table id="tabHead" border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr>
		<Th colspan="2" height="23"> Please go through the following information to change</Th>
	</Tr>
</Table>

<Table id="InnerBox1Tab" border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
      <Tr>
      		<input type = "hidden" name = "soldTo" value="">
      		<Td width = "25%" align="right">User ID *</Td>
      		<Td width = "25%"><%=userId %></Td>
		  <input type="hidden" name="UserID" value="<%=userId%>" >
      		<Td width = "25%" align="right"> User Name *</Td >
      		<Td width = "25%">
      			<input type=text class = "InputBox" name="userName"  size=20 maxlength=60 value="<%=firstName%>">
              		<input type="hidden" name="Password"  value="<%=password%>">
              	</Td>	
      	</Tr>
      	<Tr>
      		<Td width = "25%" align = "right">E Mail *</Td>
      		<Td width = "25%" > <input type=text class = "InputBox" name="email"  size=20 maxlength=40 value="<%=email%>"></Td>
      		<Td width = "25%" align = "right">Authorization *</Td>
		<Td width = "25%">
<%
		Enumeration enum2SA =  subUserAuthHT.keys();
		
		String enum2Key = null;
		String enum2Desc = null;

		while(enum2SA.hasMoreElements())
		{
			enum2Key = (String)enum2SA.nextElement();
			enum2Desc = (String)subUserAuthHT.get(enum2Key);
			
			String checked = "",shText="";
			
			if(suAuth.equals(enum2Key)) checked = "checked";
			if("VONLY".equals(enum2Key))shText="Can only view the documents";
			if("VSAVE".equals(enum2Key))shText="Can view and save the sales order but can not submit sales order/approve quotation";
			if("VEDIT".equals(enum2Key))shText="Can view/save/submit sales order and approve quotation";
%>
			<input type="radio" name="subUserAuth" value="<%=enum2Key%>" <%=checked%> onmouseover="Tip('<%=shText%>')" onmouseout="UnTip()"><%=enum2Desc%>
<%
		}
%>
		</Td>	
      		<input type="hidden" name = "catnum" value="<%=catalogNumber%>">
      	</Tr>
</table>
<Div id="theads">
	<Table  width="89%"  id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
     	<Tr align="center">
		<Th width="3%" align="center"><input type="checkbox" name="CheckBox1" value="" onclick="selectAll()"></Th>
		<Th>Sales Areas</Th>
        </Tr>
        </table>
        </div>
  	<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:89%;height:45%;left:2%">
	<Table  align=center id="InnerBox1Tab"  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
<%
	int syskeyCount = 0;
	int custRows 	= retsoldto.getRowCount(); 
	
	if(retSyskey!=null)
		syskeyCount = retSyskey.getRowCount(); 
		
	String soldToSyskey = null;
	if ( syskeyCount > 0 )
	{
		for ( int i = 0 ; i < syskeyCount; i++ )
		{
			String Checked = "";
			//String pFunction = retsoldto.getFieldValueString(i,"EC_PARTNER_FUNCTION");
			//pFunction  = pFunction.trim();
			//if ( pFunction.equals("AG") || pFunction.equals("VN") )
			//{
				soldToSyskey = retSyskey.getFieldValueString(i,"eud_sys_key");
				for(int j=0;j<custRows;j++)
				{
					if(soldToSyskey.equals(retsoldto.getFieldValueString(j,"EUD_SYS_KEY")))
						Checked = "checked";
%>
						<Tr>
						<Td colspan = "2" align="left">
							<input type="checkbox" name="CheckBox" value="<%=retsoldto.getFieldValueString(j,"EC_ERP_CUST_NO")%>#<%=(retsoldto.getFieldValue(j,"EC_SYS_KEY"))%>" <%=Checked%>>
							<%=retsoldto.getFieldValue(j,"ECA_NAME")%>&nbsp;
							(<%=retsoldto.getFieldValue(j,"EC_ERP_CUST_NO")%>)&nbsp;
							 <%=retSyskey.getFieldValueString(i,"ESKD_SYS_KEY_DESC")%>&nbsp;
							(<%=soldToSyskey%>)
						</Td> 
						</Tr>
						
					<input type=hidden name="SelSoldTo" value="<%=retsoldto.getFieldValueString(j,"EUD_VALUE")%>">
					<input type=hidden name="SelSysKey" value="<%=retsoldto.getFieldValueString(j,"EUD_SYS_KEY")%>">
			
<%			
				} 
			//}
%>
			

<%			
 			}
  		
	}
	

	else
	{
%>
	<Tr>
		<Td>No ERP Customers To List</Td>
	</Tr>
<%
}
%>

</Table>
</div>

<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%" align="center">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	
	if ( custRows > 0)
	{
		buttonName.add("Save");
		buttonMethod.add("updateSubVndr()");

		buttonName.add("Reset");
		buttonMethod.add("document.myForm.reset()");
	}	
	
	buttonName.add("Back");
	buttonMethod.add("history.go(-1)");
	
	out.println(getButtonStr(buttonName,buttonMethod));


%>
</Div>

</form>
<script language = "javascript">
	document.myForm.userName.focus();
</script>

<%
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('User Information updated successfully');
		</script>
<%
	}
%>
<Div id="MenuSol"></Div>
</body>
</html>

