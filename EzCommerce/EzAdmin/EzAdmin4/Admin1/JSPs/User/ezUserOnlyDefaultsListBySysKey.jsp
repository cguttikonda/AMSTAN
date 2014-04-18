<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iUserOnlyDefaultsListBySysKey.jsp"%>
<html>
<head>
<script src="../../Library/JavaScript/User/ezUserOnlyDefaultsListBySysKey.js"></script>
<Script src="../../Library/JavaScript/User/ezUserRoles.js"></script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<Script src="../../Library/JavaScript/ezTrim.js"></script>
<Script>
function funSalesRep(value)
{
	var len=document.myForm.DefaultsKey.length;
	var index;
	for (  j = 0  ; j < len; j++ )
	{
		var key=document.myForm.DefaultsKey[j].value;
		
		if((funTrim(key))=="SALESREPRES")
		index=j;
				
	}
	value=document.myForm.DefaultsValue[index-2].value;
	var retValue = window.open("ezDisplaySalesRepsList.jsp?SysKey=<%=websyskey%>&SalesRep="+value+"&Index="+(index-2),"","location=0,width=550,height=400,left=250,top=150,resizable=false,scrollbars=yes,toolbar=no,menubar=no");
}
</Script>
<Title>Business User Defaults</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body onLoad="scrollInit();document.myForm.currency.focus()" onResize = "scrollInit()">
<br>
<form name=myForm method=post action="ezSaveUserOnlyDefaultsListBySysKey.jsp" onSubmit="return funSelect()">
<%
	if(ret.getRowCount()==0)
	{
%>
		<br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr>
			<Td class="displayheader">
			<div align="center">No <%=areaLabel%> To List Defaults</div>
			</Td>
		</Tr>
		</Table><br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
		<input type="hidden" name="Area" value="<%=areaFlag%>">
		<input type ="hidden" name="flag" value="1">
<%
		return;
	}
%> 
	<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
	<Th width="20%" class="labelcell">
		<div align="right"><%=areaLabel.substring(0,areaLabel.length()-1)%>&nbsp;:
		</div>
	</Th>
	<Td width="20%">
<%
		String wsk=null;
		for(int i=0;i<ret.getRowCount();i++)
		{
			if(websyskey.equals(ret.getFieldValue(i,SYSTEM_KEY)))
			{
				wsk=ret.getFieldValueString(i,SYSTEM_KEY_DESCRIPTION);
			}
		}
%>
		<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=websyskey%>"><%= wsk %> (<%=websyskey%>)&nbsp;</a>
	</Td>
	<Th width="10%" class="blankcell">
		<div align="right">User:</div>
	</Th>
	<Td width="20%">
<%
		if("2".equals((String)session.getValue("myUserType")))
		{
%>
			<a href="../User/ezViewIntranetUserData.jsp?UserID=<%=bus_user%>"><%=bus_user%></a>
<%
		}
		else
		{
%>
			<a href="../User/ezUserDetails.jsp?UserID=<%=bus_user%>"><%=bus_user%></a>
<%
		}
%>
	</Td>
	</Tr>
	</Table>
<%
	if(retuser!=null && websyskey!=null)
	{
		if(!"sel".equals(websyskey))
		{
			if(retuser.getRowCount()==0 && !"sel".equals(websyskey))
			{
%>
				<input type="hidden" name="Area" value="<%=areaFlag%>">

				<br><br>
				<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
				<Tr>
					<Td class = "labelcell">
						<div align="center"><b>No User Present Under This <%=areaLabel.substring(0,areaLabel.length()-1)%></b></div>
					</Td>
				</Tr>
				</Table>
<%
				return;
			}
		}
	}
%>
<%
    	if(websyskey!=null && !"sel".equals(websyskey) )
	{
	    	if( !"sel".equals(bus_user))
		{
%>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
			<Tr align="center">
				<Td height="2" class="displayheader">User Specific Defaults</Td>
			</Tr>
			</Table>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="89%">
			<Tr>
				<Th colspan="3" >The following defaults are specific to the user.<font color="#0066CC"><font color="#FFFFFF">
				</font></font>For a list of user defaults for a business area
				</Th>
			</Tr>
			</Table>
			<div id="theads">
			<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 >
			<Tr>
				<Th width="50%" align="left" >Default</Th>
				<Th width="50%" align="left" > Value </Th>
			</Tr>
			</Table>
			</div>

			<DIV id="InnerBox1Div">
			<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<%
			//out.println("reterpdef:::"+reterpdef.toEzcString());
			for(int d=reterpdef.getRowCount()-1;d>0;d--)
			{
				String dfedesc = reterpdef.getFieldValueString(d,"EUDD_DEFAULTS_DESC");
				dfedesc = dfedesc.trim();

				if("Sales Representative Responsible".equals(dfedesc) || "Currency".equals(dfedesc) || 
				   "Email Notification".equals(dfedesc) || "SubUser Ship To".equals(dfedesc) || 
				   "Sub User Authorization".equals(dfedesc) || "View All Customers".equals(dfedesc) || 
				   "Purchase Organization".equals(dfedesc) || "DEFAULT SHIPTO".equals(dfedesc) ||
				   "DEFAULT SOLDTO".equals(dfedesc) || "DEFAULT SYSKEY".equals(dfedesc))
				{
					reterpdef.deleteRow(d);
				}
			}
			int defRows = reterpdef.getRowCount();
			String defDescription = null;
			if ( defRows > 0 ) 
			{
				for ( int i = 0 ; i < defRows; i++ )
				{
					if("STYLE".equals(reterpdef.getFieldValueString(i,"EUD_KEY")))
						continue;
%>
				<Tr align="center">
				<Td align="left" width="50%">
<%
				defDescription = reterpdef.getFieldValueString(i,"EUDD_DEFAULTS_DESC");
				if (defDescription != null)
				{
%>
					<%=defDescription%>
<%
				}
				//out.println(defDescription);
%>
				<input type="hidden" name="DefaultsKey" value=<%=(reterpdef.getFieldValueString(i,USER_DEFAULT_KEY))%> >
				</Td>

				<Td align="left" width="50%">
<%
				String defValue = (String)reterpdef.getFieldValue(i,USER_DEFAULT_VALUE);
				String defKey = (String)(reterpdef.getFieldValue(i,USER_DEFAULT_KEY));
				defKey = defKey.trim();
				
				//out.println("defKey:::"+defKey);
				
				if (defKey.equals("LANGUAGE"))
				{
					int langRows = retdef.getRowCount();
					if(langRows == 0)
					{
						retdef.setFieldValue(LANG_ISO,"EN");
						retdef.setFieldValue("ELK_LANG","EN");
						retdef.setFieldValue(LANG_DESC,"ENGLISH");
						retdef.addRow();
					}
			
					langRows = retdef.getRowCount();
					if ( langRows > 0 ) 
					{
%>
						<select name="lang" id = "ListBoxDiv" style="width:30%">
<%
						for ( int j = 0 ; j < langRows ; j++ )
						{
					  		String langKey = ((String)retdef.getFieldValue(j,LANG_ISO)).toUpperCase();

							if(langKey.equals(defValue.trim()))
							{
%>
								<option selected value="<%=retdef.getFieldValueString(j,LANG_DESC)%>" >
								<%=retdef.getFieldValueString(j,LANG_DESC)%>
								</option>
<%
							}
							else
							{
%>
								<option value="<%=retdef.getFieldValueString(j,LANG_DESC)%>" >
								<%=retdef.getFieldValueString(j,LANG_DESC)%>
								</option>
<%
							}
						}
%>
						</select>
<%
					}
				}
				else
				{
					if (defKey.equals("CURRENCY"))
					{
						int curRows = retcur.getRowCount();
						if ( curRows > 0 ) 
						{
%>
							<select name="currency"  id = "ListBoxDiv">
<%
							for ( int k = 0 ; k < curRows ; k++ )
							{
								String curKey = ((String)retcur.getFieldValue(k,CURRENCY_KEY )).toUpperCase();
								if((curKey.trim()).equals(defValue.trim()))
								{
%>
									<option selected value="<%=retcur.getFieldValueString(k,CURRENCY_KEY)%>" >
									<%=retcur.getFieldValueString(k,CURRENCY_LONG_DESC)%>
									</option>
<%
								}
								else
								{
%>
									<option value="<%=retcur.getFieldValueString(k,CURRENCY_KEY)%>" >
									<%=retcur.getFieldValueString(k, CURRENCY_LONG_DESC)%>
									</option>
<%
								}
							}
%>
							</select>
<%
						}
					}
					else
					{
						if (defKey.equals("USERROLE"))
						{
							if (defValue != null)
								defValue=defValue.trim();
							else
								defValue="";
%>
							<select name=DefaultsValue  id = "ListBoxDiv" style="width:30%">
							<option>--Select Role--</option>
							<script>
							for(var i=0;i<userroles.length;i++)
							{
								var userrole='<%=defValue%>';

								if(userroles[i].RoleCode==userrole)
								{
									document.write("<option value="+userroles[i].RoleCode+" selected>"+userroles[i].RoleDesc+"</option>");
								}
								else
								{
									document.write("<option value="+userroles[i].RoleCode+">"+userroles[i].RoleDesc+"</option>");
								}
							}
							</script>
							</select>
<%			
						}
						else
						{
							if (defKey.equals("SALESREPRES"))
							{
%>
								<a href="javascript:funSalesRep('<%=defValue%>')">click</a>
								<input type=hidden name="DefaultsValue" size="20" value=<%=defValue%> >
<%
							}
							else
							{
								if (defKey.equals("EXCLUSIVE_MAT"))
								{
									if (defValue != null)
										defValue=defValue.trim();
									else
										defValue="";
%>
									<select name=DefaultsValue  id = "ListBoxDiv" style="width:30%">
<%
									String selectedY="";
									String selectedN="selected";

									if("Y".equals(defValue))
									{
										selectedY="selected";
										selectedN="";
									}
%>
									<option value="Y" <%=selectedY%>>Y</option>
									<option value="N" <%=selectedN%>>N</option>
									</select>
<%			
								}
								else
								{
									if (defValue != null)
											defValue=defValue.trim();
										else
											defValue="";
									String rOnly = "";
									if (defKey.equals("ISSUBUSER") || defKey.equals("STATUS") || defKey.equals("SUAUTH") || defKey.equals("MAILNOTE") || defKey.equals("REPAGECODE"))
										rOnly = "readonly";
									else
										rOnly = "";
%>
									<input type=text class = "InputBox" <%=rOnly%> name="DefaultsValue" size="20" value=<%=defValue%> >
<%
								}
							}
						}
					}
				}
%>
				</Td>
				</Tr>
<%
				}
			}
%>
			</Table>
			</div>
			<div id="ButtonDiv"  align="center" style="position:absolute;;visibility:visible;top:90%;width:100%">
				<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/save.gif" name="Submit" value="Save">
				<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</div>
<%
		}
		else
		{
%>
			<br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
			<Tr>
				<Td class = "labelcell">
					<div align="center"><b>Please Select User to continue.</b></div>
				</Td>
			</Tr>
			</Table>
			<br>
			<center>
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</center>
<%
		}
	}
	else
	{
%>
			<br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
			<Tr>
				<Td class = "labelcell">
					<div align="center"><b>Please Select <%=areaLabel.substring(0,areaLabel.length()-1)%> and User to continue.</b></div>
				</Td>
			</Tr>
			</Table>
			<br>
			<center>
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</center>
<%
	}
%>
<input type="hidden" name="Area" value="<%=areaFlag%>">
<input type="hidden" name="WebSysKey" value="<%=websyskey%>">
<input type="hidden" name="BusUser" value="<%=bus_user%>">
</form>
<%
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('User Default(s) updated successfully');
			history.go(-2);
		</script>
<%
	}
%>
</body>
</html>