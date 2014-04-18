
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>

<%
	String[] files = null;
	try
	{
		java.io.File dir=new java.io.File("F:\\ora9ias\\EzRemoteSales\\SampleFiles\\Product");
		if(dir.exists())
		{
			files = dir.list();
		}
	}
	catch(Exception e)
	{
		out.println("L'exception arrivée dans obtenir de synch classe! ");
	}

%>

<html>
<head>
<script>
	var myFiles=new Array()
<%
	for(int i=0;i<files.length;i++)
	{
%>
		myFiles[<%=i%>] = "<%=files[i]%>"
<%
	}
%>

function fillFiles()
{
	var obj1=document.myForm.productFile
	var obj2=document.myForm.priceFile
	var obj3=document.myForm.hierarchyFile
	
	for(var i=1;i<=myFiles.length;i++)
	{
		if(myFiles[i-1].indexOf("G") >= 0)
			obj1.options[obj1.length]=new Option(myFiles[i-1],myFiles[i-1]);
		if(myFiles[i-1].indexOf("T") >= 0)	
			obj2.options[obj2.length]=new Option(myFiles[i-1],myFiles[i-1]);
		if(myFiles[i-1].indexOf("H") >= 0)		
			obj3.options[obj3.length]=new Option(myFiles[i-1],myFiles[i-1]);
	}
}

function funSubmit()
{
	var flag=false;
	if(document.myForm.productFile.selectedIndex==0)
	{
		alert("Please select Products")
		flag=true;
	}
	else if(document.myForm.priceFile.selectedIndex==0)
	{
		alert("Please select Prices")
		flag=true;
	}
	else if(document.myForm.hierarchyFile.selectedIndex==0)
	{
		alert("Please select Hierarchies")
		flag=true;
	}
	
	if(! flag)
	{
		document.myForm.action="ezSynchMain.jsp"
		document.myForm.submit();
	}
	
}




</script>

<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script>
<link href="../../Library/Styles/ezCalenderGreen.css" rel="stylesheet">

<body onLoad="fillFiles()">
<form name=myForm method="post" >
<br>

	<table id="header" width="40%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<tr align="center">
	    	<td class="displayheader">Product Synchronization</td>
	</tr>
	</table>

	<table id="tab1" width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<tr>
		<th align="center">Catalog</th>
		<td><input type="text" name="catalog" value="10020" ></td>
	</tr>
	<tr>
		<th align="center">Sector</th>
	<td><input type="text" name="sysno" value="999999" ></td>
	
	</tr>
	</table>


	<Table id="tab2" width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
		<th align="center" colspan="2" >Select Files to Synchronize</th>
	</Tr>
	<Tr align="center">
		<!--<td><input type="checkbox" name="chk1" value="1"></td>-->
		<td align="left">PRODUCTS</td>
		<Td>
			<Select name=productFile>
			<Option value="">--Privilégié--</Option>
			</Select>
		</Td>
	</Tr>	
	<Tr align="center">
		<!--<td><input type="checkbox" name="chk1" value="2" ></td>-->
		<td align="left">PRICES</td>
		<Td>
			<Select name=priceFile>
			<Option value="">--Privilégié--</Option>
			</Select>
		</Td>
	</tr>	
	<Tr align="center">
		<!--<td><input type="checkbox" name="chk1" value="3"  ></td>-->
		<td align="left">HIERARCHIES</td>
		<Td>		
			<Select name=hierarchyFile>
			<Option value="">--Privilégié--</Option>
			</Select>
		</Td>
	</Tr>	
	</Table>

<Div id="checkDiv" align="center"   style="width:100%;position:absolute;top:85%">
<a href="javascript:funSubmit()"><img src="../../Images/Buttons/<%=ButtonDir%>/synchronize.gif" border=none style="cursor:hand"></a>
</Div>


</form>
</body>
</html>
