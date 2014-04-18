<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<Html>
<Head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<%@ include file="../../../Includes/JSPs/WebStats/iCalendar.jsp"%>
<%@ include file="../../../../../EzSales/Sales2/JSPs/DrillDownCatalog/ezCountryStateList.jsp"%>
<%@ include file="ezZoneList.jsp"%>
<Script>
	var tabHeadWidth=95
	var tabHeight="30%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<Script src="../../Library/JavaScript/ezTrim.js"></Script>


<script>
	
	function formSubmit()
	{
		if(document.myForm.fromZip.value=='')
		{
			alert('Please enter from Zip')
			document.myForm.fromZip.focus()
			return
		}
		if(document.myForm.toZip.value=='')
		{
			alert('Please enter to Zip')
			document.myForm.toZip.focus()
			return
		}
		if(parseFloat(document.myForm.toZip.value)<parseFloat(document.myForm.fromZip.value))
		{
			alert('To Zip should be greater than From Zip')
			return
		}
		
		document.myForm.action="ezAddSaveZoneMap.jsp"
		document.myForm.submit()
		
	
	}
	function onlyNumbers(evt)
	{
		var e = event || evt; // for trans-browser compatibility
		var charCode = e.which || e.keyCode;

		if (charCode > 31 && (charCode < 48 || charCode > 57))
			return false;

		return true;

	}


	
</script>

</Head>
<Body  onLoad="scrollInit()" onResize="scrollInit()" scroll="no" >
<Form name=myForm method=post >
<br><br>

	<Div align=center>
	    <Table  width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th colspan='2' width="100%">Add Zone Mapping</Th>
		</Tr>
	    </Table>
	</Div>
	<Div align=center>
	    <Table  width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >

		<Tr>
			<Th width = "40%" align="right">Country*</Th>
			<Td width = "60%">
			<select name="countryCode" style="width:40%">
<%

			Enumeration enum2S =  ezCountry.keys();
			String enum2Key=null;
			String enum2Desc=null;
			String selK = "";

			while(enum2S.hasMoreElements())
			{
				enum2Key = (String)enum2S.nextElement();
				enum2Desc = (String)ezCountry.get(enum2Key);
				if("US".equals(enum2Key))
					selK = "selected";
				else
					selK = "";
%>
				<option value="<%=enum2Key%>" <%=selK%>><%=enum2Desc%></Option>

<%
			}
%>
			 </select>
			</Td>
		</Tr>
		<Tr>
			<Th width = "40%" align="right">From Zip*</Th>
			<Td width = "60%" ><input type = "text" class = "InputBox" name = "fromZip" size = "10" maxlength = "10"  onkeypress="return onlyNumbers();"></Td>
		</Tr>	
		<Tr>
			<Th width = "40%" align="right">To Zip*</Th>
			<Td width = "60%" ><input type = "text" class = "InputBox" name = "toZip" size = "10" maxlength = "10"  onkeypress="return onlyNumbers();"></Td>
		</Tr>	
		<Tr>
			<Th width = "40%" align="right">Zone*</Th>
			<Td width = "60%" >
			<select name="zone" style="width:40%">
<%
			for(int i=0;i<ezZones.size();i++)
			{
%>
				<option value="<%=ezZones.get(i)%>"><%=ezZones.get(i)%></Option>
<%
			}
%>
			
			
			</select>
			</Td>
		</Tr>	

	    </Table>
	</Div>
	<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<a href="JavaScript:formSubmit()"><img src="../../Images/Buttons/<%=ButtonDir%>/add.gif" border=none></a>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
	</Div>
</Form>
</Body>
</Html>