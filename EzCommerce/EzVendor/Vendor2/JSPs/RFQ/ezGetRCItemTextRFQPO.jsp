<%
	String hdrIndx=request.getParameter("hdrIndx");
	String itemIndx=request.getParameter("itemIndx");
	
	String itemText=request.getParameter("itemText");
  String shipmentText=request.getParameter("shipmentText");
	if( itemText==null || "null".equals(itemText))
		itemText="";
  if( shipmentText==null || "null".equals(shipmentText))
		shipmentText="";

%>


<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<Html>
<Head>
<Title>Item Text Page -- Powered By Answerthink India Pvt Ltd.</Title>

<Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script>
<Script>
	function winClose()
	{
			var itemObj = eval("opener.window.document.myForm.rcText"+<%=hdrIndx%>);
      
			if(!isNaN(itemObj.length))
			{
				itemObj[<%=itemIndx%>].value=document.myForm.itemText.value;
        
       

			}	
			else
			{
				itemObj.value=document.myForm.itemText.value;
        
			}	
			window.close();	
			
	}	
</Script>



</Head>
<Body>
<Body scroll="no" onLoad="document.myForm.itemText.focus()">

<Form name="myForm">

<Table  border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=5 cellSpacing=1  width="80%">
	<Tr>
		<Th>Item Text</Th>
	</Tr>
	<Tr>
		<Td><textarea style='width:100%' rows=10 name="itemText" ><%=itemText%></textarea></Td>
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