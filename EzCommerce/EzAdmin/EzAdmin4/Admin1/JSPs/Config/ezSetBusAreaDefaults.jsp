
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iSetBusAreaDefaults.jsp"%>
<html>
<Title>Sales Area Defaults</Title>
<head>
<script src="../../Library/JavaScript/Config/ezSetBusAreaDefaults.js">
</script>

<script src="../../Library/JavaScript/Config/ezSetBusAreaDefaults.js">
</script>
<script src="../../Library/JavaScript/ezTabScroll.js">
</script>


<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body onLoad="placeFocus();scrollInit()" onResize="scrollInit()" scroll="no">
<form name=myForm method=post action="ezSaveBusAreaDefaults.jsp">

<br>
<%
	int defRows = 0;
	if(numCatarea > 0)
		{
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
    	<Tr>
      	<Th width="30%" class="labelcell"><%=areaLabel%>:</Th>
      	<Td width="70%">
<%
	int sysRows = retsyskey.getRowCount();
	if ( sysRows > 0 )
		{
%>
        	<select name="SystemKey" style="width:100%" id=FullListBox onChange="myalert('<%=areaLabel%>')">
        	<option value="sel">--Select <%=areaLabel%>--</option>
<%
		retsyskey.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
		for ( int i = 0 ; i < sysRows ; i++ )
			{
			String val = (String)(retsyskey.getFieldValue(i,SYSTEM_KEY));
			String checkFlag = (String)retsyskey.getFieldValue(i,"ESKD_SUPP_CUST_FLAG");
			String syskeyDesc = (String)(retsyskey.getFieldValue(i,SYSTEM_KEY_DESCRIPTION));

			val = val.toUpperCase();
			val = val.trim();
			if(sys_key!=null && !sys_key.equals("sel"))
				{
				if(sys_key.equals(val))
					{
%>
	        			<option selected value=<%=val%> >
<%

					if(checkFlag.equals(areaFlag))
						{
%>
			    	    		<%=syskeyDesc%> (<%=val%>)
<%
						}
					else
						{
%>
			        		<%=syskeyDesc%> (<%=val%>)
<%
						}
%>
					</option>
<%
					}
				else
					{
%>
	        			<option value=<%=val%> >
<%
					if(checkFlag.equals(areaFlag))
						{
%>
			    	    		<%=syskeyDesc%> (<%=val%>) 
<%
						}
					else
						{
%>
			    	    		<%=syskeyDesc%> (<%=val%>)
<%
						}
%>

	        			</option>
<%
					}
				}
			else
				{
%>
				<option value=<%=val%> >
<%
				if(checkFlag.equals(areaFlag))
					{
%>
					<%=syskeyDesc%> (<%=val%>)
<%
					}
				else
					{
%>
					<%=syskeyDesc%> (<%=val%>)
<%
					}
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
      	<!--<Td width="10%" align="center">
 	<a href="javascript:myalert('<%=areaLabel%>')"><img src="../../Images/Buttons/<%= ButtonDir%>/show.gif" border=none></a>
 	</Td>-->
    	</Tr>
  	</Table>
<%
  	if(sys_key!=null && !sys_key.equals("sel"))
	  	{
		defRows = retdef.getRowCount();
		String defDescription = null;

		//For EzCommerce Systems - SytsteNo number is always default
		//Added by Venkat on 7/11/2001
		if ( defRows == 1 && retdef.find("EUDD_KEY","SYSNO") )
			{
			defRows = 0;
			}
		if ( defRows > 0 )
			{
%>
		<div id="theads">
		<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr align="center">
		<Td class="displayheader"><%=areaLabel%> Defaults </Td>
		</Tr>
		</Table>
		</div>
		<div id="InnerBox1Div">
		<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr align="left">
		<Th width="49%" >
		<div align="center">Default</div>
		</Th>
		<Th width="51%" >
		<div align="center">Value </div>
		</Th>
		</Tr>
<%
		
		for ( int i = 0 ; i < defRows; i++ )
		{
	      		String defkey =(String)retdef.getFieldValue(i,"ECAD_KEY");
	      		String defValue = (String)retdef.getFieldValue(i,"ECAD_VALUE");
			
			if (defkey.equals("SYSNO"))
			{
%>				
				<input type="hidden" name="DefaultsKey" value=<%=defkey%> >
				<input type="hidden" name="DefaultsValue" size="20" value=<%=defValue%> onChange="setChangeFlag('<%=i%>');return document.returnValue">		
<%		
			}
			else
			{
%>
	    			<Tr align="left">
    	  			<Td width="49%">&nbsp;
<%
				defDescription = retdef.getFieldValueString(i,"EUDD_DEFAULTS_DESC").trim();
				if (defDescription != null)
			
				{
%>			
					<%=defDescription%>
<%
				}
%>
				<input type="hidden" name="DefaultsKey" value=<%=defkey%> >
				<input type="hidden" name="DefaultsDesc" value=<%=defDescription%> >
    	  			</Td>
    	  			<Td width="51%">
<%
		
				if (defValue != null)
				{
					defValue=defValue.trim();
%>
					<input type=text class = "InputBox" name="DefaultsValue" size="20"  maxlength="128" value=<%=defValue%> >
<%
				}
				else
				{
					defValue="";
%>
      					<input type=text class = "InputBox" name="DefaultsValue" size="20" maxlength="128"  value=<%=defValue%> >
<%
				}
%>
				</Td>
    				</Tr>
<%
			}
%>
     		
<%
		}//End for

%>
		</Table>
		</div>
<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<p>
  		<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/submit.gif" >
    		<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

  		</p>
  		</div>
<%
		}
	else
		{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
		<Tr>
			<Td class = "labelcell">
				<div align="center"><b>There are no defaults for this <%=areaLabel%></b></div>
			</Td>
		</Tr>
		</Table>
		<br>
		<center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

		</center>
<%
		}//End If
	}
else
	{

%>
	<br><br><br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr>
		<Td class = "labelcell">
			<div align="center"><b>Please Select <%=areaLabel%>  to continue.</b></div>
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
	<br><br><br><br>
	
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	  <Tr align="center">
	    <Th>There are no <%=areaLabel%>s Currently.</Th>
	  </Tr>
	</Table>
	
	<br>
	<center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	</center>
	
<%
	}
%>
<input type="hidden" name="Area" value="<%=areaFlag%>" >
</form>
<%
	String savedY = request.getParameter("saved");
	if ( savedY != null && savedY.equals("Y") )
		{
%>
		<script language="javascript">
			alert('<%=areaLabel%> defaults updated successfully');
		</script>
<%
		}
%>
</body>
</html>