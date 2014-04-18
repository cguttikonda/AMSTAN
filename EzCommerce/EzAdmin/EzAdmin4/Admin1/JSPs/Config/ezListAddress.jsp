<%@ include file="../../../Includes/Lib/Countries.jsp" %>

<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>

<%@ include file="../../../Includes/JSPs/Config/iListAddress.jsp"%>
<html>
<head>
<script>
var tabHeadWidth=100

function selectAll()
{
	len=document.myForm.chk1.length	
	if(isNaN(len))
	{
		if(document.myForm.addr.checked)
		{
			document.myForm.chk1.checked=true
		}else{
			document.myForm.chk1.checked=false
		}
	}
	else
	{	
	for(i=0;i<len;i++)
	{	if(document.myForm.addr.checked)
		document.myForm.chk1[i].checked=true
		else
		document.myForm.chk1[i].checked=false
	}
	}
}
</script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Config/ezListAddress.js"></script>
<script src="../../Library/JavaScript/Status.js"></script>
<script src="../../Library/JavaScript/chkEditAndDelete.js"></script>
<script src="../../Library/JavaScript/ezTabScroll.js"></script>
</head>
<body bgcolor="#FFFFF7" onLoad='scrollInit()' onresize='scrollInit()' scroll=no>
<form name="myForm" method="post" onSubmit="return chkForSubmit()" >
<%
	if(ret.getRowCount()==0)
	{
%>
	<br><br><br><br><br>
	<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	  <Tr align="center">
	    <Th>There are No Address Created Currently.Click on Add to Add Address.</Th>

	  </Tr>
	</Table>
	<br>
	<center>
	    	<a href="ezAddAddress.jsp"><img src="../../Images/Buttons/<%= ButtonDir%>/add.gif"   border=none ></a>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</center>
<%	}
	else
	{
%>
	

<br>
	<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>	    
	<Td colspan=4 class="displayheader" >
        	<div align="center">List of Addresses</div>
        </Td>
        </Tr>
	</Table>
	<div id="theads">
	<Table  id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr><th width='5%' title="Select/Deselect All"><input type='checkbox' name='addr' onClick="selectAll()"></Th>
	<Th  width='10%'> Number</Th>
	<Th  width='16%'>Company Name</Th>
	<Th  width='13%'>URL</Th>
	<Th  width='15%'>Email</Th>
	<Th  width='18%'>Country</Th>
	</Tr>
	</Table>
	</div>
	<DIV id="InnerBox1Div">
	<Table  id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
		for(int i=0;i<ret.getRowCount();i++)
		{
%>
			<Tr>
			<label for="cb_<%=i%>">
			<Td width='5%' align=center>
				<input type=checkbox name="chk1" id="cb_<%=i%>" value="<%=ret.getFieldValue(i,"NUM")%>" ></td>
			<Td  width='10%' align=center>
			<a style="text-decoration:none" href="ezAddressDetails.jsp?chk1='<%=ret.getFieldValue(i,"NUM")%>'" ><%=ret.getFieldValue(i,"NUM")%></a>
			</Td>
	<%
			String name=(String)ret.getFieldValue(i,"COMPANYNAME");
			if(name == null || name.equals(""))
			{
				name="&nbsp;";
			}
	%>
			<Td width='16%' align='left' title='<%=name%>'>&nbsp;<input type="text" class="displaybox" name="name" size="12" readonly style="border:0;"  value="<%=name%>"></Td>
	<%
				String url= (String)ret.getFieldValue(i,"URL");
				if(url == null || "".equals(url))
				{
					url="&nbsp;";
				}
	%>
			<Td  width='13%' align='left' title='<%=url%>'>&nbsp;<input type="text" class="displaybox" name="url" size="12" readonly style="border:0;"  value="<%=url%>"></Td>
	<%
				String email=(String)ret.getFieldValue(i,"EMAIL");
				 if(email == null || email.equals(""))
				 {
				 	email="&nbsp;";
				 }
	%>
			<Td  width='15%' align='left' title='<%=email%>'>&nbsp;<input type="text" class="displaybox" name="email" size="12" readonly style="border:0;" value="<%=email%>"></Td>
	<%
				String country=(String)ret.getFieldValue(i,"COUNTRY");
				if(country.equals(""))
				{
					country="&nbsp;";
				}
				else
				{
					  for(int j=0;j<countryList.length;j++)
					  {
						if(ret.getFieldValueString(i,"COUNTRY").equals(countryList[j][1]))
						  country=countryList[j][0];
					  }
				}
	%>
			<Td  width='18%' align='left' title='<%=country%>'>&nbsp;<input type="text" class="displaybox" name="country" size="18" readonly style="border:0;"  value="<%=country%>"></Td>
			</label>
			</Tr>
<%
		}
%>
	</Table>
	</div>

		<div id="ButtonDiv" align=center style="position:absolute;top:90%;width:100%">
   	     <a href="ezAddAddress.jsp"><img src="../../Images/Buttons/<%= ButtonDir%>/add.gif" border=none></a>
 	     <input type="image" src="../../Images/Buttons/<%= ButtonDir%>/edit.gif" onClick="checkFun('Edit')">
 	     <input type="image" src="../../Images/Buttons/<%= ButtonDir%>/delete.gif" onClick="checkFun('Del')">
 	     <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
 
 	</div>

<%
	}
%>
</form>
</body>
</html>
