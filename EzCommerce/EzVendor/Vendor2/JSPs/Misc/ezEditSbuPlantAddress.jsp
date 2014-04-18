
<%
	String index	= request.getParameter("index");
	String name	= request.getParameter("name"+index);
	String address1	= request.getParameter("address1"+index);
	String address2	= request.getParameter("address2"+index);
	String city	= request.getParameter("city"+index);
	String state	= request.getParameter("state"+index);
	String country	= request.getParameter("country"+index);
	String phone	= request.getParameter("phone"+index);
	String centralexice=request.getParameter("centralexice"+index);
	String cst	= request.getParameter("cst"+index);
	String code 	= request.getParameter("code"+index);
	String sbu	=request.getParameter("sbu"+index);
%>
<%@ include file="../../../Includes/Lib/ezCountries.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iListSbuPlantAddresses_Lables.jsp"%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
	<SCRIPT SRC="../../../Service1/Library/JavaScript/checkFormFields.js"></script>
	<script>
		function savePrice()
		{

			document.myForm.action="ezEditSaveSbuPlantAddress.jsp"
			document.myForm.submit();
		}
		function back()
		{

			document.myForm.action="ezListSbuPlantAddresses.jsp"
			document.myForm.submit();
		}
		
	</script>
</head>
<body onLoad="document.myForm.name.focus()">
<form name=myForm method=post>

<%
	String display_header = editPlntAdd_L;
%>	

	<%@ include file="ezDisplayHeader.jsp"%>

	<br>
	<Table align=center border=1 width=80% borderColorLight=#006666 bordercolordark=#ffffff cellpadding=2 cellspacing=0>
	<Tr width="20%">
		<Th width="20%" align="left" ><%=name_L%></Th>
		<Td width="80%" colspan=3>
			<input type="text" name=name value="<%=name%>" style="width:100%" class="InputBox">
			<input type="hidden" name=sbu value="<%=sbu%>" class="InputBox">
		</Td>
	</Tr>
	<Tr>
		<Th width="20%" align="left" ><%=add1_L%></Th>
		<Td width="30%"><input type=text name=address1 size=50 value="<%=address1%>" class="InputBox"></Td>


		<Th width="20%" align="left" ><%=add2_L%></Th>
		<Td width="30%"><input type=text name=address2 size=50 value="<%=address2%>" class="InputBox"></Td>
	</Tr>
	<Tr >
	
		<Th width="20%" align="left" ><%=city_L%></Th>
		<Td width="30%"><input type=text name=city  size=50 value="<%=city%>" class="InputBox"></Td>

		<Th width="20%" align="left" ><%=state_L%></th>
		<Td width="30%"><input type=text name=state  size=50 value="<%=state%>" class="InputBox"></Td>
	</Tr>
	<Tr>


		<Th  width="20%" align="left"><%=country_L%></Th>

		<Td width="30%"><input type=text name=country size=50 value="<%=country%>" class="InputBox">
<%--
			<select name="country">
			   <% for(int i=0;i<countryList.length;i++){
				if(countryList[i][1].equals(country)){
			  %>
				 <option selected value="<%=countryList[i][0]%>"><%=countryList[i][0]%></option>

			  <%}else{%>
				<option  value="<%=countryList[i][0]%>"><%=countryList[i][0]%></option>

			<%}}%>
	      </select>
--%>
		</Td>


	
		<th width="20%" align="left" ><%=cst_L%></Th>
		<Td width="30%"><input type=text name=cst size=50 value="<%=cst%>" class="InputBox"></Td>
	</Tr>


	<Tr>

		<!-- <Th width="20%" align="left" ><%=CentrExCode_L%></Th>
		<Td width="30%"><input type=text name=centralexice size=50 value="<%=centralexice%>" class="InputBox"></Td> -->
		

		<Th width="20%" align="left" ><%=phone_L%></Th>
		<Td width="30%"><input type=text name=phone size=50 value="<%=phone%>" class="InputBox"></Td>
	</Tr>


	</Table>
	<Div id="ButtonDiv" align=center style="position:absolute;top:85%;visibility:visible;width:100%">
		<Table align="center">
		<tr align="center">
		<td class=blankcell align="center">
		<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			
			buttonName.add("Back");
			buttonMethod.add("back()");
			buttonName.add("Save");
			buttonMethod.add("savePrice()");
			out.println(getButtonStr(buttonName,buttonMethod));	
		%>
		</Td>
		</Tr>
		</Table>
	</div>

<input type="hidden" name="code" value="<%=code%>" >
<input type="hidden" name="index" value="<%=index%>">
<Div id="MenuSol">
</Div>
</form>
</body>
</html>

