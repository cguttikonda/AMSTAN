<%
	String rowIndex=request.getParameter("rowIndex");
	String headerText=request.getParameter("headText");
  String flag= request.getParameter("flag");
	if( headerText==null || "null".equals(headerText))headerText="";
  String disStr="";
  
  if("H".equals(flag)) disStr="Header Text";
  else disStr="Shipping Instructions";

%>


<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<Html>
<Head>
<Title><%=disStr%> Page -- Powered By Answerthink.</Title>

<Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script>
<Script>
	function winClose()
	{
      var len=opener.window.document.myForm.headerText.length;
			if(!isNaN(len))
			{
				if('H'==document.myForm.flag.value)
          eval("opener.window.document.myForm.headerText[<%=rowIndex%>]").value=document.myForm.headerText.value;
       else
          eval("opener.window.document.myForm.shipmentText[<%=rowIndex%>]").value=document.myForm.headerText.value;

			}	
			else
			{
        if('H'==document.myForm.flag.value)
          eval("opener.window.document.myForm.headerText").value=document.myForm.headerText.value;
        else
          eval("opener.window.document.myForm.shipmentText").value=document.myForm.headerText.value;
			}	
			window.close();	
			
	}	
</Script>



</Head>
<Body>
<Body scroll="no" onLoad="document.myForm.headerText.focus()">

<Form name="myForm">
<input type="hidden" name="flag" value="<%=flag%>">
<Table  border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=5 cellSpacing=1  width="90%">
	<Tr>
		<Th><%=disStr%></Th>
	</Tr>
	<Tr>
		<Td><textarea style='width:100%' rows=10 name=headerText ><%=headerText%></textarea></Td>
	</Tr>
</Table>


<Div align='center' style='position:absolute;top:85%;width:100%'>
<%
	butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
	butActions.add("winClose()");
	butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cancel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
	butActions.add("window.close()");
	out.println(getButtons(butNames,butActions));
%>
</Div>
</Body>
</Html>