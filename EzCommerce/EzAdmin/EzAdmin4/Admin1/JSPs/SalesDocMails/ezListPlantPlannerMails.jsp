<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/SalesDocMails/iListPlantPlannerMails.jsp" %>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%
	int mailCount = 0;
	int rowCount = ListObj.getRowCount();
	String code = "";
	for(int i=0;i<rowCount;i++)
	{
		code = ListObj.getFieldValueString(i,"ESM_PRODUCT_CODE");
		if((!code.equals("mktservices")) && (!code.equals("centralplanner")))
			mailCount++;
	}
%>
<html>
<head>
<script src="../../Library/JavaScript/ezTabScroll.js"></script>
<script language="JavaScript">
function checkAll()
{
    	var length=document.myForm.chk1.length
    	if(isNaN(length))
    	{
    		document.myForm.chk1.checked=true
    	}
    	else
    	{
    		for( i=0;i<length;i++)
    		{
	    		document.myForm.chk1[i].checked=true
	    	}
    	}
}
function selectAll()
{
  	len=document.myForm.chk1.length
    	if(isNaN(len))
  	{
  		if(document.myForm.chk1Main.checked)
  		{
  			document.myForm.chk1.checked=true
  		}else{
  			document.myForm.chk1.checked=false
  		}
  	}
  	else
  	{
	  	for(i=0;i<len;i++)
  		{
			if(document.myForm.chk1Main.checked)
  				document.myForm.chk1[i].checked=true
	  		else
  				document.myForm.chk1[i].checked=false
  		}
  	}
}
function clearAll()
{
    	var length=document.myForm.chk1.length
    	if(isNaN(length))
    	{
    		document.myForm.chk1.checked=false
    	}
    	else
    	{
    		for( i=0;i<length;i++)
    		{
	    		document.myForm.chk1[i].checked=false
    		}
    	}
}
function checkUpdate()
{
	if(document.myForm.chk1.checked)
        {
		return true
	}
        var j=document.myForm.chk1.length
        count=0;
        for(i=0;i<j;i++)
        {
        	if(document.myForm.chk1[i].checked)
                {
			count++;
                }
       	}
	if(count>1)
	{
              	alert("Please Select Only One Record To Update")
              	return false
	}
        if(count==0)
        {
		alert("please select a record to update")
              	return false
	}
        return true;
}
function checkDelete()
{
	if(document.myForm.chk1.checked)
        {
        	return true
	}
        var j=document.myForm.chk1.length
        count=0;
        for(i=0;i<j;i++)
        {
        	if(document.myForm.chk1[i].checked)
                {
                      	count++
                }
	}
	if(count!=0)
        {
		return true
	}
        alert("please select atleast one record to delete")
        return false
}
function checkMail()
{
	if(document.myForm.chk1.checked)
        {
        	return true
	}
        var j=document.myForm.chk1.length
        count=0;
        for(i=0;i<j;i++)
        {
        	if(document.myForm.chk1[i].checked)
                {
			count++
		}
	}
        if(count!=0)
        {
        	return true
	}
        alert("please select atleast one record to getMailIds")
        return false
}
function update()
{
	if(checkUpdate())
	{
		document.myForm.action="ezUpdateSalesDocMails.jsp"
		document.myForm.submit();
	}
}
function del()
{
	flag=false;
	if(checkDelete())
	{
		flag=confirm("Do you want to delete the record(s)");
		if(flag)
		{
			document.myForm.action="ezDeleteSalesDocMails.jsp"
			document.myForm.submit();
		}
	}
}
function mailIds()
{
	if(checkMail())
	{
		document.myForm.action="ezGetMailIds.jsp";
		document.myForm.submit();
	}
}
function funAdd()
{
	document.myForm.action="ezAddSalesDocMails.jsp?From=PP"
	document.myForm.submit();
}
</script>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()" scroll="no">
<form name="myForm" method="post">
<%
	String check="";
	int rows=ListObj.getRowCount();
%>
<%
        if(mailCount==0 )
        {
%>
	<br><br><br><br>
	<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="60%">
		<Tr>
		 	<Td class = "labelcell" align='center'>
				No Plant Planner Mails To List, Please Click on Add to Add Mails
			</Td>
		</Tr>
	</Table>
	<br>
	<center>
		<img src="../../Images/Buttons/<%= ButtonDir%>/add.gif" style="cursor:hand" border=no onClick="funAdd()">
		<img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" style="cursor:hand" border=no onClick="javascript:history.go(-1)">
	</center>
<%
		return;
	}
	else
	{
%>
<br>
<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
	<Tr>
		<Td class = "displayheader" align = "center">
			List of Plant Planner Mails
		</Td>
	</Tr>
</Table>
<div id="theads">
  <Table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>


	<Tr>
		<th width=4% align="center" title="Select/Deselect All"><input type='checkbox' name='chk1Main' onClick="selectAll()"></th>
		<Td class='labelcell' width="12%" align=center>Code</Td>
		<Td class='labelcell' width="12%" align=center>Plant/Area</Td>
		<Td class='labelcell' width="26%" align=center>To</Td>
		<Td class='labelcell' width="24%" align=center>CC</Td>
		<Td class='labelcell' width="22%" align=center>BCC / ERP ID</Td>
	</Tr>

</Table>
</div>
<DIV id="InnerBox1Div">
<Table  id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
	for(int i=0;i<ListObj.getRowCount();i++)
	{
   		String pcod=ListObj.getFieldValueString(i,"ESM_PRODUCT_CODE");
   		if((!pcod.equals("mktservices")) && (!pcod.equals("centralplanner")))
   		{
   			String toadd=ListObj.getFieldValueString(i,"ESM_TO");
			if((toadd==null) || ("null".equals(toadd)))
     			{
        			toadd="";
     			}
			if(toadd.endsWith(","))
   			{
       				toadd=toadd.substring(0,toadd.length()-1);
   			}
			String plant = ListObj.getFieldValueString(i,"ESM_PLANT");
			if((plant==null) || ("null".equals(plant)))
     			{
        			plant="";
     			}
			String tocc=ListObj.getFieldValueString(i,"ESM_CC");
			if((tocc==null) || ("null".equals(tocc)))
     			{
        			tocc="";
     			}
			if(tocc.endsWith(","))
   			{
       				tocc=tocc.substring(0,tocc.length()-1);
   			}
   			String tobcc=ListObj.getFieldValueString(i,"ESM_EDD");
    			if((tobcc==null) || ("null".equals(tobcc)))
     			{
        			tobcc="";
     			}
   			if(tobcc.endsWith(","))
   			{
       				tobcc=tobcc.substring(0,tobcc.length()-1);
   			}
%>

		<Tr>
		<label for="cb_<%=i%>">
		<Td  width="4%" align = "center"><input type='checkbox' name='chk1' id="cb_<%=i%>" value='<%=pcod.trim()%>¥<%=plant%>'></Td>
		<Td  width="12%" ><%=pcod%></Td>
		<Td  width="12%" ><%=plant%>&nbsp;</Td>
		<Td  width="26%"  title='<%=toadd%>'><input type=text name=text1 size=20 readonly value="<%=toadd%>" class=textInBox></Td>
		<Td  width="24%"  title='<%=tocc%>'><input type=text name=text1 size=20 readonly value="<%=tocc%>" class=textInBox></Td>
		<Td  width="22%"  title='<%=tobcc%>'><input type=text name=text1 size=20 readonly value="<%=tobcc%>" class=textInBox></Td>
		</label>
		</Tr>
<%
	}
}
%>
</Table>
</div>
<div align = "center" id="ButtonDiv" style="position:absolute;top:90%;width:100%">
	<a href="javascript:funAdd()"><img src="../../Images/Buttons/<%= ButtonDir%>/add.gif" style="cursor:hand" border=none></a>
	<a href="javascript:update()"><img src="../../Images/Buttons/<%= ButtonDir%>/edit.gif" style="cursor:hand" border=none></a>
	<a href="javascript:del()"><img src="../../Images/Buttons/<%= ButtonDir%>/delete.gif" style="cursor:hand" border=none></a>
	<!-- <img src="../Images/getmailids.gif" style="cursor:hand" border=no onClick="mailIds()"> -->
</div>
<%
} // if close
%>

</form>
</body>
</html>
