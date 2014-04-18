<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iAddUserDataNext.jsp"%>
<%
	session.putValue("myUserType",bussuser);
	String mySearchCriteria = FirstName.substring(0,1)+"*";
	session.putValue("mySearchCriteria",mySearchCriteria);
	
%>
<html>
<head>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script>

function myCheck()
{
	var pCount=0;
	var selCount=0;
	pCount=document.myForm.CheckBox.length;
	if(isNaN(pCount))
	{
		if(document.myForm.CheckBox.checked)
			selCount=1
	}
	else
	{
		for(i=0;i<pCount;i++)
		{
			if(document.myForm.CheckBox[i].checked)
				selCount=selCount+1;
		}
	}

	if(selCount<1)
	{
		alert("Select ERP Customer(s) to Continue...");
		return false;
	}
	return true;
}
</Script>

<script language="JavaScript" src="../../../Includes/Lib/JavaScript/Users.js"></script>

<Title>Add User Data NEXT</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body onLoad='scrollInit()' onResize='scrollInit()' scroll="no">
<form name=myForm method=post action="ezAddUser.jsp" onSubmit = "myCheck()">
<br>
<Table  width="89%" border="1" align="center" bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
  	<Tr align="center">
    		<Td class="displayheader">Add User Continued...</Td>
  	</Tr>
</Table>
<Table  width="89%" border="1" align="center" bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
	<Tr>
		<Th colspan="2"> Please select the Customers</Th>
	</Tr>
	<Tr>
	<Td width="52%" valign="top" class="blankcell">
		<Table valign=top  border="1" bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2 width="100%">
		<Tr>
			<Td class="labelcell" width="45%">User:</Td>
			<Td width="55%">
			<%=UserId%>
			<input type=hidden name="UserID" value="<%=UserId%>">
			<input type="hidden" name="InitialPassword" size=10 maxlength=10 value="<%=Password%>">
			</Td>
		</Tr>
		<Tr>
			<Td class="labelcell" width="55%">First Name:</Td>
			<Td width="45%">
			<%=FirstName%>
			<input type=hidden name="FirstName" value="<%=FirstName%>">
			</Td>
		</Tr>
		<Tr>
			<Td class="labelcell" width="55%">Middle Initial:</Td>
			<Td width="45%">
			<input type=hidden name="MidInit"	 value="<%=MiddleInit%>">
			<%=MiddleInit%>
			</Td>
		</Tr>
		<Tr>
			<Td class="labelcell" width="55%">Last Name:</Td>
			<Td width="45%">
			<%=LastName%>
			<input type=hidden name="LastName" value="<%=LastName%>">
			</Td>
		</Tr>
		<Tr>
			<Td class="labelcell" width="55%">Email:</Td>
			<Td width="45%">
			<%=Email%>
			<input type=hidden name="Email" value="<%=Email%>">
			</Td>
		</Tr>
		</Table>
	</Td>
	<Td width="48%" valign="top" class="blankcell">
		<Table valign=top  width="100%" border="1" bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
		<Tr>
			<Td class="labelcell" width="55%">User Type:<font face="Tw Cen MT"></font></Td>
			<Td width="45%">BusinessUser
			<input type=hidden name="UserType" value="<%=bussuser%>">
			</Td>
		</Tr>
		<Tr>
			<Td class="labelcell" width="55%">Admin User:</Td>
			<Td width="45%">
			<input type="checkbox" name="Admin" disabled>
			</Td>
		</Tr>
		<input type="hidden" name="UserGroup" value="0">
		<Tr>
			<Td class="labelcell" width="55%">Business Partner:</Td>
			<Td width="45%">
			<input type="hidden" name="BusPartner" value="<%=BusPartner%>">
			<%=BPDesc%>
			<input type=hidden name="BPDesc" value="<%=BPDesc%>">
		</Td>
		</Tr>
		<Tr>
			<Td width="55%" class="labelcell">Catalog:<font face="Tw Cen MT"></font></Td>
			<Td width="45%">
<%
              		String catdesc=catalog_description;
              		if(catdesc==null || "null".equals(catdesc))
              		{
              			catdesc="";
              			catalog_description="No Catalog Selected";
              		}
%>
              		<%=catalog_description%>
              		<input type=hidden name="CatDescription" value="<%=catdesc%>">
			<input type="hidden" name="CatalogNumber" value="<%=catalog_number%>">
			</Td>
		</Tr>
	        </table>
        </td>
        </tr>
        </table>
        <div id="theads">
	<Table id="tabHead" align=center  border="1" borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
     	<Tr align="center">
		<Td  colspan="2" class="labelcell"> ERP Customers </Td>
        </Tr>
        </table>
        </div>
  	<DIV id="InnerBox1Div">
	<Table id="InnerBox1Tab" align=center width="100%" border="1" borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
	<Tr>
		<Td colspan="2">
<%
		int custRows = retsoldto.getRowCount();
		if ( custRows > 0 )
		{
			retsoldto.sort(new String[]{ERP_CUST_NAME},true);
			for ( int i = 0 ; i < custRows; i++ )
			{
%>
				<Tr>
					<Td nowrap colspan="2">
        				<input type="checkbox" name="CheckBox" value="<%=retsoldto.getFieldValueString(i,"EC_ERP_CUST_NO")%>#<%=(retsoldto.getFieldValue(i,"EC_SYS_KEY"))%>">
<%
					String custNum = (String)retsoldto.getFieldValue(i,"EC_ERP_CUST_NO");
					String custName = (String)retsoldto.getFieldValue(i,ERP_CUST_NAME);
					String custSysKey = retsoldto.getFieldValueString(i,"EC_SYS_KEY");
					custName = custName.trim()+" - ("+custSysKey.trim()+")";
					if(custName != null)
					{
						out.println(custNum + " " + custName);
					}
					else
					{
						out.println("No Customer Name");
					}
%>

				        </Td>
				</Tr>
<%
			}
%>
			<input type="hidden" name="TotalCount" value=<%=custRows%> >
<%
		}
		else
		{
%>
			<Tr>
			<Td colspan="2">
				There are no ERP Customers synchronized for this Business Partner
			</Td>
			</Tr>
<%
		}
%>
		</Td>
        </Tr>
        </Table>
    	</div>
<%
	if ( custRows > 0 )
	{
%>

  <div id="ButtonDiv" align="center" style="position:absolute;top:91%;width:100%;">
  		    	<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/continue....gif" name="Submit" value="Continue...">
    			<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
    			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	    	</div>
<%
	}
	else
	{
%>
		<div id="buttons" style="position:absolute;top:80%;left:40%;">
	   	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
    		</div>
<%
	}
%>
</form>
</body>
</html>
