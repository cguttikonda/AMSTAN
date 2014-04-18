
<%@ page import = "ezc.ezparam.*,java.util.*" %>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session" />
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%
String salesRepsList = request.getParameter("SalesRep");
String Syskey = request.getParameter("SysKey");
String index = request.getParameter("Index");
ReturnObjFromRetrieve retUsers  = null;


StringTokenizer str = new StringTokenizer(salesRepsList,"¥");
Hashtable hashtable = new Hashtable();
while(str.hasMoreTokens())
{
	String temp =str.nextToken();
	
	String[] str1 = temp.split("¤");
	
	String key=str1[0];
	String value="I";
	if(str1.length>1)
	value=str1[1];

	hashtable.put(key,value);	
}

EzcUserParams uparams= new EzcUserParams();
Session.prepareParams(uparams);	
EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
ezcUserNKParams.setLanguage("EN");
ezcUserNKParams.setSys_Key(Syskey);
uparams.createContainer();
boolean result_flag = uparams.setObject(ezcUserNKParams);
ezc.ezcommon.EzLog4j.log("DE1:Start Get BizUsers","I");
retUsers =	(ReturnObjFromRetrieve)UserManager.getUsersForSalesArea(uparams);

int deleteCount = 0;
	
if(retUsers!=null)	
{
	deleteCount = retUsers.getRowCount();
	for(int i=deleteCount-1;i>=0;i--)
	{
		if(!("2".equals(retUsers.getFieldValueString(i,"EU_TYPE"))))
		{
			retUsers.deleteRow(i);
		}
	}
}


%>


<html>
<head>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<Script src="../../Library/JavaScript/ezTrim.js"></script>
<Script>
	

function funSave()
{
	var obj=document.myForm.chk1;
	var len=obj.length;
	var finalStr="";
	var roleType="";
	var roleTypeObj;
	var index="<%=index%>";
	var chkBoxValue;
	var count=0;
	
	
	if(!isNaN(len))
	{
		for(i=0;i<len;i++)
		{
			chkBoxValue=obj[i].value;
			roleType="";
		
			if(obj[i].checked)
			{
				count++;
				roleTypeObj=eval("document.myForm.RoleType_"+chkBoxValue);
				 if(roleTypeObj[0].checked)
					roleType="I"
				 if(roleTypeObj[1].checked)
					roleType="O"	
				 if((funTrim(roleType))=="") 	
				 {
					alert("Please select role type of the user ("+chkBoxValue+")")
					return ;
				 }
				 

				if(finalStr=="") 
					finalStr=chkBoxValue+"¤"+roleType
				else	
					finalStr=finalStr+"¥"+chkBoxValue+"¤"+roleType
			}	
		}
	}
	else
	{
		if(obj.checked)
		{
			roleType=""
			chkBoxValue=obj.value;
			roleTypeObj=eval("document.myForm.RoleType_"+chkBoxValue);
			if(roleTypeObj[0].checked)
				roleType="I"
			if(roleTypeObj[1].checked)
				roleType="O"	
			if((funTrim(roleType))=="") 	
			{
				alert("Please select role type of the user ("+chkBoxValue+")")
				return ;
	 		}
			
		 	finalStr=obj.value+"¤"+roleType
		}
        }
        if(count>5)
        {
        	alert("Max. 5 sales representatives can be assigned")
        	return;
        }
	
	if(finalStr=="")
	{
		alert("Please select atleast one sales representative")
		return;
	}

opener.document.myForm.DefaultsValue[index].value=finalStr;
window.close();
	
	
}
</Script>
<Title>Business User Defaults</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body onLoad="scrollInit();" onResize = "scrollInit()">
<br>
<form name=myForm method=post>

<%
		
if(retUsers!=null && retUsers.getRowCount()>0)
{
%>
	<div id="theads">
	<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th width="10%" align="left" >Select</Th>
			<Th width="60%" align="left" > User </Th>
			<Th width="30%" align="left" > Role Type </Th>
		</Tr>
	</Table>
	</div>

	<DIV id="InnerBox1Div">
	<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
	
<%
	if(hashtable!=null)
	{
		Enumeration hashKeys = hashtable.keys();

		for(int cnt=0;cnt<hashtable.size();cnt++)
		{
			String hashUser = (String)hashKeys.nextElement();
			String Inchecked="",Outchecked="";
			int ind=retUsers.getRowId("EU_ID",hashUser);
			if(ind>=0)
			{
				if(hashtable.get(hashUser).equals("O"))
					Outchecked="checked";
				if(hashtable.get(hashUser).equals("I"))
					Inchecked="checked";
%>		
				<Tr>
					<Td width="10%" ><input type="checkbox" name="chk1" value="<%=retUsers.getFieldValueString(ind,"EU_ID").trim()%>" checked> </Td>
					<Td width="60%" align="left" > <%=retUsers.getFieldValueString(ind,"EU_ID")%> (<%=retUsers.getFieldValueString(ind,"EU_FIRST_NAME")%>)</Td>
					<Td width="30%" align="left" > <input type="radio" name="RoleType_<%=retUsers.getFieldValueString(ind,"EU_ID").trim()%>" value="I" <%=Inchecked%>>  Inside<br>
					<input type="radio" name="RoleType_<%=retUsers.getFieldValueString(ind,"EU_ID").trim()%>" value="O" <%=Outchecked%>>	Outside		
					</Td>
				</Tr>
<%		
			}
		}
	}	
	for(int i=0;i<retUsers.getRowCount();i++)	
	{
		String internalUser = retUsers.getFieldValueString(i,"EU_ID").trim();
		if(!hashtable.containsKey(internalUser))
		{
%>
		<Tr>
			<Td width="10%" ><input type="checkbox" name="chk1" value="<%=internalUser%>"> </Td>
			<Td width="60%" align="left" > <%=retUsers.getFieldValueString(i,"EU_ID")%> (<%=retUsers.getFieldValueString(i,"EU_FIRST_NAME")%>)</Td>
			<Td width="30%" align="left" > <input type="radio" name="RoleType_<%=internalUser%>" value="I">  Inside<br>
			<input type="radio" name="RoleType_<%=internalUser%>" value="O">	Outside		
			</Td>
		</Tr>
<%
		}
	}
%>
	</Table>
	</div>
	<div id="ButtonDiv"  align="center" style="position:absolute;;visibility:visible;top:80%;width:100%">
		
		<a href="JavaScript:funSave()"><img src="../../Images/Buttons/<%= ButtonDir%>/ok.gif" border=none></a>
		<a href="JavaScript:window.close()"><img src="../../Images/Buttons/<%= ButtonDir%>/close.gif" border=none></a>
	</div>

<%
}else{
%>
	<br><br><br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr align="center">
		<Td class="displayheader">There are no users to list</Td>
	</Tr>
	</Table><br>
	
	<div id="ButtonDiv"  align="center" style="position:absolute;;visibility:visible;top:70%;width:100%">
			
			<a href="JavaScript:window.close()"><img src="../../Images/Buttons/<%= ButtonDir%>/close.gif" border=none></a>
	</div>
<%
}
%>

</form>
</body>
</html>