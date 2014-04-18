<%@ include file="../../../Includes/JSPs/Audit/iAuditDocumentsList.jsp" %>
<%@ page import="java.util.*,java.text.*" %>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<html>
<head>
<script>
function funSubmit()
{
	len=document.myForm.Columns.length;
	for(var i=0;i<len;i++)
	{
		document.myForm.Columns[i].selected=false
	}
	//document.myForm.Columns.selectedIndex=0;
	document.myForm.action="ezAuditDocumentsList.jsp";
	document.myForm.submit();
}

function funShow()
{
	
	len=document.myForm.Columns.length;
	
	count=0;
	for(var i=0;i<len;i++)
	{
		if(document.myForm.Columns[i].selected==true)
		{
			count++
		}
	}
	
	if(document.myForm.auditId.selectedIndex==0)
	{
		alert("Please Select A Document");
		return false;
	}
	else
	{
		if(count>0)
		{
		
			document.myForm.action="ezAuditDocumentsList.jsp";
			document.myForm.submit();

		}
		else
		{
			alert("Please Select Atleast One Attribute");
			return false;
		}
	}
}

</script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<body onLoad='scrollInit()' onResize="scrollInit()">
<form name="myForm" method="post"  >


<%
	int count=retTable.getRowCount();
	if(count>0)
	{
%>
	    <Table width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	    <Tr>
                <Th align="center">Document Audit History</Th>
             </Tr>
                </Table>

	<br>

	    <table width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	    <Tr>
	    	<Th width="15%">Documents</Th>
	    	<Td width="35%">
	    		<select name="auditId" onChange="funSubmit()" style="width:100%">
	    		<option value="">--Select Document--</option>
<%
			for(int i=0;i<count;i++)
			{
				if(auditId!=null && !"".equals(auditId) && !"null".equals(auditId))
				{
					if(auditId.trim().equals(retTable.getFieldValueString(i,"AUDITID")))
					{
%>
						<option value="<%=retTable.getFieldValueString(i,"AUDITID")+"~"+retTable.getFieldValueString(i,"SITENO")+"~"+retTable.getFieldValueString(i,"TABLENAME")%>" selected><%=retTable.getFieldValueString(i,"SHORTDESC")%></option>

<%					}
					else
					{
%>
						<option value="<%=retTable.getFieldValueString(i,"AUDITID")+"~"+retTable.getFieldValueString(i,"SITENO")+"~"+retTable.getFieldValueString(i,"TABLENAME")%>" ><%=retTable.getFieldValueString(i,"SHORTDESC")%></option>
<%					}
				}
				else
				{
%>
					<option value="<%=retTable.getFieldValueString(i,"AUDITID")+"~"+retTable.getFieldValueString(i,"SITENO")+"~"+retTable.getFieldValueString(i,"TABLENAME")%>"><%=retTable.getFieldValueString(i,"SHORTDESC")%></option>
<%
				}
			}
%>

	    		</select>
	    	</Td>
	    	<Th width="15%">Attributes</Th>
	    	<Td width="35%">
<%
	int colCount=0;
%>
	       	<select name="Columns"  size=3 style="width:100%" multiple>
		
<%
		String value="";
		if(columns.size()>0)
		{
			Enumeration enum=columns.keys();

			while(enum.hasMoreElements())
			{
				String key=(String)enum.nextElement();
				if(columnValue!=null)
				{
					
					for(int i=0;i<columnValue.length;i++)
					{
						if(columnValue[i].equals(key))
						{
							value=columnValue[i];
							break;
						}
					}
					
					if(value.equals(key))
					{
%>
						<option value='<%=key%>' selected><%=key%></option>

<%
					}
					else
					{
%>
						<option value='<%=key%>'><%=key%></option>
<%											
					}
						
				}
				else
				{
%>
					<option value='<%=key%>'><%=key%></option>
<%				}
			}
		}

%>
		</select>
	    	</Td>
		<Td>
		<!--<input type="button" name="show" value="Show" onClick="funShow()"> -->
		<img src="../../Images/Buttons/<%=ButtonDir%>/show.gif" onClick="funShow()">

	    </Tr>
	    </Table>

<%
	if(retLog!=null)
	{
		int logCount=retLog.getRowCount();

	if(logCount>0)
	{
	
%>
		<br><br>

		<div id="theads">
	     	<table id="tabHead" width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
		<Th width="22%">Field Name</Th>
	     	<Th width="15%">Changed Date</Th>
		<Th width="15%">Operation Type</Th>
		<Th width="15%">Old Value</Th>
		<Th width="15%">Changed Value</Th>
		<Th width="11%">Changed By</Th>
		</Tr>
		</Table>
		</div>
		<div id="InnerBox1Div">
		<table id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		
<%
		SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy hh:mm a");
		for(int i=0;i<logCount;i++)
		{
			Date postdate=(java.util.Date)retLog.getFieldValue(i,"POSTEDDATE");
			String fdate=sdf.format(postdate);
			String optype=retLog.getFieldValueString(i,"OPERATIONTYPE");
			if(optype.equals("I"))
			{
				optype="Inserted";
			}
			else if(optype.equals("D"))
			{
				optype="Deleted";
			}
			else
			{
				optype="Update";
			}
			String oldValue=retLog.getFieldValueString(i,"OLDVALUE");
			if(oldValue.equals("NA"))
			{
				oldValue="-";
			}
			String newValue=retLog.getFieldValueString(i,"CHANGEDVALUE");
			if(newValue.equals("NA"))
			{
				newValue="-";
			}

%>
			<Tr>
			<Td width="22%"><%=retLog.getFieldValueString(i,"FIELDNAME")%></Td>
			<Td width="15%"><%=fdate%></Td>
			<Td width="15%"><%=optype%></Td>
			<Td width="15%"><%=oldValue%></Td>
			<Td width="15%"><%=newValue%></Td>
			<Td width="11%"><%=retLog.getFieldValueString(i,"CHANGEDBY")%></Td>
			</Tr>
<%		}
%>
		</Table>
		</div>
<%
		}
		else
		{
%>

		<br><br><br><br>
	     	<table width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
	     	<Th width="20%">No  Log To List</Th>
		</Table>

<%
		}
	}
	else
	{
		if(auditId!=null && !"null".equals(auditId) && !"".equals(auditId))
		{
%>
			<br><br><br><br><br><br><br><br><br>
	     		<table width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr>
	     		<Th width="20%">Select Attribute(s) and Click on Show</Th>
			</Table>

<%		}
		else
		{
%>
			<br><br><br><br><br><br><br><br><br>
	     		<table width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr>
	     		<Th width="20%">Please Select A Document </Th>
			</Table>

<%		}
	}
}
else
{

%>
		<br><br><br><br><br><br><br><br><br>
		<table width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
		<Th width="20%">No Documents To View Log</Th>
		</Table>

<%
		
}
%>
</form>
</body>
</html>
