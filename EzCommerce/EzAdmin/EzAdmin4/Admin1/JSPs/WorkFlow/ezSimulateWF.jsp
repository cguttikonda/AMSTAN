<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iSimulateWF.jsp" %>

<html>
<head>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>

	<script>
		function setFields1(ind)
		{
			var attObj=eval("document.myForm.attribute"+ind)
			var attVal=attObj.value
			var attType=attVal.substring(attVal.indexOf(",")+1,attVal.length);
			var spanId=document.getElementById("span"+ind);
			var txt1=eval("document.myForm.attributeVal"+ind);	
			var txt2=eval("document.myForm.attributeVal"+ind+ind);
		
			if(attType=="Date")
			{
				spanId.style.visibility="visible"
				txt1.readOnly=true
				txt2.readOnly=true
			}	
			else
			{
				spanId.style.visibility="hidden"
				txt1.readOnly=false
				txt2.readOnly=false
			}	
			
		}
	</script>
</head>
<body>
<form name=myForm action="ezSimulateWFNext.jsp">
<br><br>
	<Table align=center width="70%" border=1 bordercolorlight=#000000 bordercolordark=#ffffff cellpadding=2 cellspacing=0>
	<Tr>
		<Td class=displayheader align=center colspan=2>WF Simulation</Td>
	</Tr>
	<Tr>
		<Td class=labelcell>Template</Td>
		<Td><div id="ListBoxDiv1">
			<select name=template>
<%
			int tCount=templatesRet.getRowCount();
			for(int i=0;i<tCount;i++)
			{
%>			
				<option value="<%=templatesRet.getFieldValue(i,"TCODE")%>"><%=templatesRet.getFieldValue(i,"DESCRIPTION")%></option>
<%				
			}
%>
			</select></div>
		</Td>
	</Tr>
<%
		int aCount=attributesRet.getRowCount();
		for(int i=0;i<aCount;i++)
		{
%>
			<Tr>
				<Td><div id="ListBoxDiv2">
					<select name="attribute<%=i%>" onChange="setFields1(<%=i%>)">
						<option value="SELECT">--Select--</option>
<%
					for(int j=0;j<aCount;j++)
					{
%>
						<option value="<%=attributesRet.getFieldValue(j,"ATTRIBUTE")%>,<%=attributesRet.getFieldValue(j,"TYPE")%>"><%=attributesRet.getFieldValue(j,"DESCRIPTION")%></option>
<%
					}
%>
					</select></div>
				</Td>
				<Td>
					<input type=text class = "InputBox" name="attributeVal<%=i%>" >
					<span id=span<%=i%> style="visibility:hidden">
						<img src="../../Images/calendar.gif" style="cursor:hand" onClick="showCal('document.myForm.attributeVal<%=i%>')">
						<input type=text class = "InputBox" name="attributeVal<%=i%><%=i%>" >
						<img src="../../Images/calendar.gif" style="cursor:hand"  onClick="showCal('document.myForm.attributeVal<%=i%><%=i%>')">
					</span>
				</Td>
			</Tr>
<%
		}
%>
	</Table><br>
				<input type=hidden name=attCount value="<%=aCount%>">
		<center>
				
				<input type=image  src="../../Images/Buttons/<%= ButtonDir%>/simulate.gif"  >
		</center>
</form>
</body>
</html>
