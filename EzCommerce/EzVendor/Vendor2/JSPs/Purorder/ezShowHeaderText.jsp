<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Html>
<Head>
<Title>Header / Shipping instructions-- Powered By Answerthink.</Title>

<Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script>
<Script>
	function winClose()
	{
     		window.close();	
		
	}
	function setVal()
	{
		document.myForm.hText.value=opener.window.document.myForm.hText.value;
	}
</Script>



</Head>


<Body scroll="no" onLoad="setVal()">
<%
	String headerText=request.getParameter("hText");
%>

<Form name="myForm">

<Table  border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=5 cellSpacing=1  width="90%">
	<Tr>
		<Th>Header / Shipping instructions </Th>
	</Tr>
	<Tr>
		<Td><textarea name="hText" style='width:100%' rows=10 readonly></textarea></Td>
	</Tr>
</Table>



<DIV id="ButtonsDiv" align="center" style="position:absolute;width:100%;top:85%">
<%	
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Cancel");				
	buttonMethod.add("window.close()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>

</Div>
</Body>
</Html>