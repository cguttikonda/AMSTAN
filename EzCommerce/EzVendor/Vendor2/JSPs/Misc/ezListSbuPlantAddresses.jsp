<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Labels/iListSbuPlantAddresses_Lables.jsp"%>
<% String fileName = "ezListSbuPlantAddresses.jsp"; %>
<%@ include file="../../../Includes/JSPs/Misc/iSbuPlantAddress.jsp"%>
<%@ include file="../../../Includes/Lib/ezCountries.jsp" %>
<head>

	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%> 



	<script>
	var ruSureDelPlnt_L = '<%=ruSureDelPlnt_L%>';
	function ShowAddress()
	{
		var usertype='<%=session.getValue("UserType")%>'
		var len=document.myForm.addcode.length;
		for(var i=1;i<len;i++)
		{
			var indexObj = document.getElementById("index"+i)
			if(indexObj != null)
				indexObj.style.visibility="hidden";
			if(usertype!=3)
			{
				document.getElementById("ButtonDiv1"+i).style.visibility="hidden";
			}
		}
		var ind=document.myForm.addcode.selectedIndex;

		if(ind!=0)
		{

			var indexObj = document.getElementById("index"+ind)
			if(indexObj != null)
				indexObj.style.visibility="visible";
			if(usertype!=3)
			{
				document.getElementById("ButtonDiv1"+ind).style.visibility="visible";
				document.getElementById("ButtonDiv").style.visibility="hidden";
			}
		}
		else
		{
			        if(document.getElementById("ButtonDiv")!=null)
				document.getElementById("ButtonDiv").style.visibility="visible";
		}

	}
	function funEdit(index)
	{
		document.myForm.index.value=index;
		document.myForm.action="ezEditSbuPlantAddress.jsp"
		document.myForm.submit();
	}
	function funAdd(index)
	{
		document.myForm.index.value=index;
		document.myForm.action="ezAddSbuPlantAddress.jsp"
		document.myForm.submit();
	}
	function funDelete(index)
	{
		if(confirm(ruSureDelPlnt_L))
		{
			document.myForm.index.value=index;
			document.myForm.action="ezDeleteSbuPlantAddress.jsp"
			document.myForm.submit();
		}	
	}

	function funOnload()
	{
		var index='<%=redirectindex%>'
		var code='<%=redirectcode%>'
		var count='<%=count%>'
		if(count!='0')
		{
			if(index!='null')
			{

				document.getElementById("index"+index).style.visibility="visible";
				document.getElementById("ButtonDiv1"+index).style.visibility="visible";
				document.getElementById("ButtonDiv").style.visibility="hidden";
			}
			else
			{

				var usertype='<%=session.getValue("UserType")%>'
				if(usertype!=3)
					document.getElementById("ButtonDiv").style.visibility="visible";
			}
		}
	}
	function showMsgDiv()
	{
		var msgDivObj = document.getElementById("showMsg");
		try{
		
			
		if(document.myForm.addcode.selectedIndex>0)
			msgDivObj.style.visibility = "hidden";
		else
			msgDivObj.style.visibility = "visible";
		}catch(e){
			
		}	
	}
	
	</script>
	
</head>
<body scroll="no"  onLoad="funOnload();showMsgDiv()">
<form method="post" name="myForm">
<%
	
	String display_header = plntAdd_L;
	
%>
<%@ include file="ezDisplayHeader.jsp"%>

<%
 	if(count==0)
	{
		String noDataStatement = clkAddPlntAdd_L;
%>
		<%@ include file="../Misc/ezDisplayNoData.jsp" %>
		<br>
		<Div id="ButtonDiv" align=center style="position:absolute;top:90%;visibility:visible;width:100%">
		<center>
		<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			
			buttonName.add("Back");
			buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");
			
			
			buttonName.add("Add");
			buttonMethod.add("funAdd()");
							
			out.println(getButtonStr(buttonName,buttonMethod));	
		%>
		</center>
		</Div>
<%
	}
	else
	{
%>
<br> 
<TABLE align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 height=70% width=90%>
<TR>
<TD  style="background-color:#ffffff" > 
<TABLE align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 height=70% width=100%>
<TR>
	<TD style="background-color:#ffffff" width="40%" align=center valign=middle>
		<br><br><br>
		<img src="../../Images/Others/corpplant.gif" border=0>
	</TD>
	<TD style="background-color:#ffffff" width="60%" align=left valign=middle>
	<br>
		<Div id='inputDiv' style='position:relative;align:center;top:1%;width:100%;height:15%'>
		<Table width="90%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
		<Tr>
			<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
		</Tr>
		<Tr >
			<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
			<Td style="background-color:'F3F3F3'" valign=middle>	
				<TABLE width="60%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
				<tr>
					<Td width="30%" style="background-color:'F3F3F3'"><B><%=selPlant_L%></B></Td>
					<td width="70%" style="background-color:'F3F3F3'">
					<div id="ListBoxDiv1">
					<select align="center"  style="width:80%" onChange="ShowAddress();showMsgDiv()" name="addcode" class="control">
					<option value="">--Select--</option>
<%

	   for(int i=0;i<count;i++)
	   {
	   		if(redirectcode!=null)
	   		{
	   			if(redirectcode.equals(ret.getFieldValueString(i,"CODE")))
	   			{
	   				out.println(redirectcode);
%>
					<option selected><%=ret.getFieldValueString(i,"CODE")%></option>
<%				}
				else
				{
%>
					<option><%=ret.getFieldValueString(i,"CODE")%></option>
<%
				}
			}
			else
			{
%>
					<option><%=ret.getFieldValueString(i,"CODE")%></option>
<%
			}
      }
%>
	</select>
	</div>
	</td>
	</tr>
	</table>
	</Td>
		<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
	</Tr>
	<Tr>
		<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
		<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
		<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
	</Tr>
	</Table>
</Div>	
		<Div id="showMsg" align=center style="position:absolute;top:30%;width:100%">
		<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr>
				<Td style="background-color:#ffffff;font-size: 12px;font-weight: bold;color:#3e8eb3" ><%=plzSelplAbv_L%></Td>
			</Tr>
		</Table>
		</Div>	  
<%
	for(int i=0;i<count;i++)
	{
%>
 
		<div id="index<%=(i+1)%>" style="position:absolute;visibility:hidden;">
		<br>
		<TABLE width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<tr>
			<th width="20%" align="left"><%=name_L%></th>
			<td width="80%" colspan=3><%=ret.getFieldValueString(i,"NAME")%>&nbsp;</td>
		</Tr>
		<Tr>

			<th width="20%" align="left"><%=add1_L%></th>
			<td width="30%"><%=ret.getFieldValueString(i,"ADDRESS1")%>&nbsp;</td>

			<th width="20%" align="left"><%=add2_L%></th>
			<td width="30%"><%=ret.getFieldValueString(i,"ADDRESS2")%>&nbsp;</td>
		</tr>
		<tr>


			<th width="20%" align="left"><%=city_L%></th>
			<td width="30%"><%=ret.getFieldValueString(i,"CITY")%>&nbsp;</td>

			<th width="20%" align="left"><%=state_L%></th>
			<td width="30%"><%=ret.getFieldValueString(i,"STATE")%>&nbsp;</td>
		</tr>
		<tr>

			<th width="20%" align="left"><%=country_L%></th>
			<td width="30%">
					<%=ret.getFieldValueString(i,"COUNTRY")%>
					&nbsp;
			</td>
			<th width="20%" align="left"><%=cst_L%></th>
			<td width="30%"><%=ret.getFieldValueString(i,"CST")%>&nbsp;</td> 

		</tr>
		<tr>


			

			<th width="20%" align="left"><%=phone_L%></th>
			<td width="80%" colspan=3><%=ret.getFieldValueString(i,"PHONE")%>&nbsp;</td>
		</tr>
		</table>
		</div>
<%	if(session.getValue("UserType").equals("2"))
	{
%>

<Div id="ButtonDiv" align=center style="position:absolute;top:90%;visibility:hidden;width:100%">
<Table align="center">
<tr align="center">
<td class=blankcell align="center">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	
	buttonName.add("Back");
	buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");
	buttonName.add("Add");
	buttonMethod.add("funAdd(\"null\")");
	
	out.println(getButtonStr(buttonName,buttonMethod));	
%>
</Td>
</Tr>
</Table>
</div>

<Div id="ButtonDiv1<%=i+1%>" align=center style="position:absolute;top:85%;visibility:hidden;width:100%">
<Table align="center">
<tr align="center">
<td class=blankcell align="center">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	
	buttonName.add("Add");
	buttonMethod.add("funAdd(\""+(i+1)+"\")");

	buttonName.add("Edit");
	buttonMethod.add("funEdit(\""+(i+1)+"\")");

	buttonName.add("Delete");
	buttonMethod.add("funDelete(\""+(i+1)+"\")");

	
	 out.println(getButtonStr(buttonName,buttonMethod));	
%>
</Td>
</Tr>
</Table>
</div>

	
<%
	}
	else
	{
%>
		<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;left:20%;visibility:visible">
		<Center>
		<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
		
			buttonName.add("Back");
			buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");
			
			out.println(getButtonStr(buttonName,buttonMethod));
		%>
		</Center>
		</Div>
<%
	}
%>
		<input type="hidden" name="name<%=i+1%>" value="<%=ret.getFieldValueString(i,"NAME")%>" >
		<input type="hidden" name="address1<%=i+1%>" value="<%=ret.getFieldValueString(i,"ADDRESS1")%>">
		<input type="hidden" name="address2<%=i+1%>" value="<%=ret.getFieldValueString(i,"ADDRESS2")%>" >
		<input type="hidden" name="city<%=i+1%>" value="<%=ret.getFieldValueString(i,"CITY")%>" >
		<input type="hidden" name="state<%=i+1%>" value="<%=ret.getFieldValueString(i,"STATE")%>" >
		<input type="hidden" name="country<%=i+1%>" value="<%=ret.getFieldValueString(i,"COUNTRY")%>" >
		<input type="hidden" name="cst<%=i+1%>" value="<%=ret.getFieldValueString(i,"CST")%>" >
		<input type="hidden" name="phone<%=i+1%>" value="<%=ret.getFieldValueString(i,"PHONE")%>" >
		<input type="hidden" name="sbu<%=i+1%>" value="<%=ret.getFieldValueString(i,"SBU")%>" >
		<input type="hidden" name="code<%=i+1%>" value="<%=ret.getFieldValueString(i,"CODE")%>" >


<%
	}

%>
	</td>
	</tr>
</table>
	
	</td>
	</tr>
</table>

<%
	}
%>
<input type="hidden" name="index" value="">
<Div id="MenuSol">
</Div>	
</form>
</body>
</html>
