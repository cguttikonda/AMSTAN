<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iAddUserData.jsp"%>
<%
	session.putValue("myAreaFlag",areaFlag);
%>
<html>
<head>
<script language="JavaScript" src="../../../Includes/Lib/JavaScript/Users.js"></script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>

<script>
userArray = new Array();
<%
	int allUserCount = allUsersRet.getRowCount();
	for(int i=0;i<allUserCount;i++)
	{
%>
		userArray[<%=i%>] = '<%=(allUsersRet.getFieldValueString(i,"EU_ID")).trim()%>'
<%
	}
%>
function chkUserExists()
{
	userId = document.myForm.UserID.value;
	userId = userId.toUpperCase();
	for (var i=0;i<userArray.length;i++)
	{
		if (userId==userArray[i])
		{
			alert("User already Exists with "+userId+" name");
			document.forms[0].UserID.focus();
		}
	}
}
function funFocus()
{
	if(document.myForm.UserID!=null)
	{
		document.myForm.UserID.focus()
	}
}
</script>


<Title>Add User Data</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>

<%
if(ret.getRowCount()==0)
{
%>
	
	<br><br><br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
		<Tr>
			<Td class = "displayheader">
				<div align="center">No Partners To Add User.</div>
			</Td>
		</Tr>
		</Table>
	<br>
	<center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</center>
<%
	return;
}
%>
<body onLoad = "funFocus();scrollInit()" onResize="scrollInit()" scroll="no">
<form name=myForm method=post action="ezAddUserDataNext.jsp">
<form method="post" action="ezAddUserDataNext.jsp" name="AddUser">
<br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr align="center">
	    	<Td class="displayheader">Create User</Td>
	</Tr>
	</Table>

<div id="theads">
<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr>
		<Th colspan="2" height="23"> Please enter the following information</Th>
	</Tr>
</Table>
</div>

<div id="InnerBox1Div">
<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
    	<Tr>
      		<Td width="45%" class="blankcell">
        	<Table  width="100%" border="1" bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
          		<Tr>
            			<Td class="labelcell" width="54%">
              				<div align="right">User:<font size="1">*</font></div>
            			</Td>
            			<Td width="46%">
              				<!-- input type = "text" Style = "width:100%" class = "InputBox"    name="UserID" style="width:100%" maxlength=10 onBlur='chkDupUser("")' -->
              				<%//allUsersStr%>
              				<input type = "text" Style = "width:100%" class = "InputBox"    name="UserID" style="width:100%" maxlength=10 onBlur="chkUserExists()" >
            			</Td>
          		</Tr>
          		<Tr>
            			<Td class="labelcell" width="54%">
              				<div align="right">Password:<font size="1">*</font></div>
            			</Td>
            			<Td width="46%">
              				<input  type="password" class=InputBox  name="InitialPassword" style="width:100%" maxlength="16" >
            			</Td>
          		</Tr>
          		<Tr>
            			<Td class="labelcell" width="54%">
              				<div align="right">Confirm Password:<font size="1">*</font></div>
            			</Td>
            			<Td width="46%">
              				<input  type="password" class=InputBox name="ConfirmPassword" style="width:100%" maxlength="16">
            			</Td>
          		</Tr>
          		<Tr>
            			<Td class="labelcell" width="54%">
              				<div align="right">First Name<font color="#000000"><font size="2"></font></font>:<font size="1">*</font></div>
            			</Td>
            			<Td width="46%">
              				<input  type = "text" Class = "InputBox" Style = "width:100%"  name="FirstName" style="width:100%" maxlength=60>
            			</Td>
          		</Tr>
          		<Tr>
            			<Td class="labelcell" width="54%">
              				<div align="right">Middle Initial:</div>
            			</Td>
            			<Td width="46%">
              				<input type = "text" Style = "width:100%" class = "InputBox"    name="MidInit" size=1 maxlength=1>
            			</Td>
          		</Tr>
          		<Tr>
				<Td class="labelcell" width="54%">
			      		<div align="right">Last Name:<font size="1">*</font></div>
			    	</Td>
			    	<Td width="46%">
			      		<input  type = "text" Class = "InputBox" Style = "width:100%"  name="LastName" style="width:100%" maxlength=60>
			    	</Td>
			</Tr>
			<Tr>
				<Td class="labelcell" width="54%">
				<div align="right">Email:<font size="1">*</font></div>
			    	</Td>
			    	<Td width="46%">
			      		<input  type = "text" Class = "InputBox" Style = "width:100%"  name="Email" style="width:100%" maxlength="40">
			    	</Td>
			</Tr>
			<input type="hidden" name="select2" value="0">
		</Table>
      		</Td>
      		<Td width="55%" valign="top" class="blankcell">
        	<Table  width="100%" border="1" bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
          		<Tr>
            			<Td class="labelcell" width="42%">
			      		<div align="right">User Type:<font size="1">*</font></div>
			    	</Td>
			    	<Td width="58%">
					
			    	  	<select  name="UserType" onChange="checkAdmin('myForm')" size="1" id=ListBoxDiv>
					<option value="3"selected>BusinessUser</option>
					<option value="2" >IntranetUser</option>
			      		</select>

			    	</Td>
			  </Tr>
			  <Tr>
			  <label for="cb_<%=0%>">
			    	<Td class="labelcell" width="42%">
			      		<div align="right">Admin User:</div>
			    	</Td>
			    	<Td width="58%">
			      		<input type="checkbox" id="cb_<%=0%>" name="Admin">
			    	</Td>
			  </label>
			  </Tr>
			  <Tr>
			    	<Td width="52%" class="labelcell"><nobr>
			      		<div align="right">Business Partner:<font size="1">*</font></div>
			    	<nobr></Td>
			    	<Td width="48%">
<%
				
				String companyName = null;
				if ( bpRows > 0 )
				{
					ret.sort(new String[]{BP_COMPANY_NAME},true);
%>
        				<select  name="BusPartner" id=ListBoxDiv>
        				<option value="sel" >--Select Bussiness Partner--</option>
<%					ret.sort(new String[]{BP_COMPANY_NAME},true);
					for ( int i = 0 ; i < bpRows ; i++ )
					{
              					String busPartNumb = (String)ret.getFieldValue(i,BP_NUMBER);
              					String busIntFlag = (String)ret.getFieldValue(i,"EPBC_INTRANET_FLAG");
              					if ( busIntFlag != null )
              						busPartNumb = busPartNumb+busIntFlag;
%>
	        				<option value="<%=busPartNumb%>" >
<%
						companyName = (String)ret.getFieldValue(i,BP_COMPANY_NAME);
						if (companyName != null)
						{
%>					
							<%=companyName%>
<%
						}
						else
						{
%>
							&nbsp;
<%
						}
%>
	        				</option>
<%
					}
%>
        				</select>

<%
				}
%>
            		</Td>
          		</Tr>
        	</Table>
	</Table>
	</div>
<%
if ( bpRows > 0 )
{
%>
        <div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		  <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/continue.gif"  name="Submit" value="Continue..." onClick="checkAll('myForm','AddUser');return document.returnValue">
		  <a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
		  <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
         </div>
<%
}//if Bps > 0
%>
</Td>
<script Language="JavaScript">
<%
if ( !Uflag )
{
%>
	alert('UserID: <%=userid.toUpperCase()%> is already exists, Please enter different User Id.' );
	//document.forms[0].UserID.value='<%=userid%>';
	document.forms[0].UserID.focus();
<%
}
else if ( userid != null && Uflag )
{
%>
	document.myForm.UserID.value='<%=userid%>';
	document.myForm.InitialPassword.focus();
<%
}
else
{
%>
	document.forms[0].UserID.focus();
<%
}
%>
</script>
</form>
</body>
</html>
