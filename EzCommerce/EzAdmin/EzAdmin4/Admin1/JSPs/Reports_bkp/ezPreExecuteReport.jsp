<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Reports/iPreExecuteReport.jsp"%>
<html>
<head>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script src="../../Library/JavaScript/Report/ezPreExecReport.js">
</script>
<Title>Pre-execute Reports</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body onLoad="scrollInit()" onresize="scrollInit()" scroll=no>
<br>
<%
boolean shToVal=false;

if (RepParam!=null && !RepParam.isError())
{
	if(repTable != null)
	{
		int paramRows = repTable.getRowCount();
		for ( int i = 0 ; i < paramRows; i++ )
		{
			repRow = repTable.getReportSelectRow(i);
			if ((repRow.getParameterType()).equalsIgnoreCase("S"))
			{
				shToVal = true;
				break;
			}
		}
	}
}
%>
<form name=myForm method=post action="ezSaveExecuteReport.jsp">
<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  	<Tr align="center"> 
    	<Td class="displayheader">Run Report</Td>
  	</Tr>
</Table>
<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    	<Tr> 
      	<Th colspan = 2>System Description:</Th>
      	<Td colspan = 2 > 
        <input type=hidden name="SysNum" value=<%=sys_num%> >
        <%=sys_name%>
      	</Td>
      	</tr>
      	<tr>
      	<Th>Report Name:</Th>
      	<Td> 
        <input type=hidden name="RepName" value=<%=rep_name%> >
        <%=rep_name%>
      	</Td>
      	<Th>Report Description:</Th>
      	<Td> 
        <input type=hidden name="RepDesc" value=<%=(repInfo.getReportDesc()).trim()%> >
        <%=(repInfo.getReportDesc()).trim()%>
      	</Td>
    	</Tr>
</Table>

<Div id="theads">
<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
    	<Tr align="left"> 
      	<Th width="30%" >Parameters</Th>
      	<Th width="35%" >Parameter From Value </Th>
<%
	if (shToVal) 
	{
%>		
	      	<Th width="35%" >Parameter To Value </Th>
<%
	}
%>
    	</Tr>
	</Table>
	</Div>
	<DIV id="InnerBox1Div">
	<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
<%

try
	{
		if (RepParam!=null && !RepParam.isError())
		{
			if(repTable != null)
			{
				int paramRows = repTable.getRowCount();
				String param = null;
				String paramname = null;
				String paramtype = null;
				String paramValueFrom = null;
				String paramValueTo = null;
				String hiddenValue = null; //--SP10/03/00
				if ( paramRows > 0 ) 
				{
					for ( int i = 0 ; i < paramRows; i++ )
					{		
						repRow = repTable.getReportSelectRow(i);
						param = repRow.getParameterDesc();
						paramname = repRow.getParameterName();
						hiddenValue = repRow.getIsHidden();
%>
    	<Tr align="left"> 
    	<Td width="30%">
<%
			//--SP 10/03/00 if (param != null)
						paramValueFrom = repRow.getParameterValueLow();
						if ( paramValueFrom == null )paramValueFrom="";
						paramValueTo = repRow.getParameterValueHigh();
						if ( paramValueTo == null )paramValueTo="";
						if (param != null && hiddenValue.equals("N"))
						{
							out.println(param);
						}
						out.println("<input type=\"hidden\"name=\"ParamKey_"+i+"\"value=\""+paramname+"\" >");
%>
	</Td>
      	<Td width="35%">
<%
						if (hiddenValue.equals("N"))
						{
	      						out.println("<input type=\"text\" name= \"ParamValueFrom_"+i+"\" size=\"15\"  maxlength=\"64\" value=\""+paramValueFrom+"\" >");
						}
						else
						{
		      				out.println("<input type=\"hidden\" name= \"ParamValueFrom_"+i+"\" size=\"15\" maxlength=\"64\" value=\""+paramValueFrom+"\" >");
						}		
%>
	</Td>
<%
						paramtype = repRow.getParameterType();
						if (paramtype.equals("S"))
						{
%>
	<Td width="35%">
<%
							if (hiddenValue.equals("N"))
							{
								out.println("<input type=\"text\" name= ParamValueTo_"+i+" size=\"15\" value=\""+paramValueTo+"\" >");
							}
							else
							{
								out.println("<input type=\"hidden\" name= ParamValueTo_"+i+" size=\"15\" value=\""+paramValueTo+"\" >");
							}
%>
	</Td>
<%
						}
						else
						{
%>
						<Td align="center" valign="top">
						&nbsp;
		        			</Td>	
<%
						}
					out.println("<input type=\"hidden\" name= ParamType_"+i+" value=\""+paramtype+"\" >");
%>
    	</Tr>
<%
				repRow = null;
				param = null;
		
		}//End for
%>
		<input type="hidden" name="TotalCount" value=<%=paramRows%>>
<%
		}//End If
	}//RetParam null check
	}else
	{
		if (RepParam.isError())
		{
			String errMess[] = RepParam.getErrorMessages();
			String Message1 = "";
			for (int i=0; i<errMess.length; i++)
			{
				Message1 = Message1 + errMess[i] ;
			}
			response.sendRedirect("ezReportErrorDisplay.jsp?Message="+Message1);		
		}
	}
}
catch (Exception e) 
{
	//e.printStackTrace(out);
}
%> 
</Table>
</Table>
</div>

<br>
<Div id="ButtonDiv" align = "center" style="position:absolute;top:90%;width:100%">
	<input type="image" src = "../../Images/Buttons/<%=ButtonDir%>/runreport.gif" alt = "Run Report" style = "cursor:hand" name="Submit" value="Run Report" onClick="checkEmpty(); return document.returnValue">
</div>
</form>
<script Language="JavaScript">
	//document.forms['ChgRep'].elements['ParamValueFrom_0'].focus();
</script>
</body>
</html>
