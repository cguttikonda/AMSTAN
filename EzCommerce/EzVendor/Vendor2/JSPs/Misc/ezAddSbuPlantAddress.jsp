<%@ include file="../../Library/Globals/errorPagePath.jsp" %>
<%@ include file="../../../Includes/Lib/ezCountries.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iListSbuPlantAddresses_Lables.jsp"%>
<html>
<head>
<%
	String index1 = request.getParameter("index");
	String  code1 = request.getParameter("code"+index1);
	String fileName = "ezAddSbuPlantAddress.jsp";
%>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<%@ include file="../../../Includes/JSPs/Misc/iSbuPlantAddress.jsp"%>
	
	<SCRIPT SRC="../../../Vendor2/Library/JavaScript/ezCheckFormFields.js"></script>
	<script>
		
		var cdAlrdyPres_L = '<%=cdAlrdyPres_L%>';
		
		function savePrice()
		{

			var FieldNames=new Array();
			var CheckType=new Array();
			var Messages=new Array();
			FieldNames[0] = "plantCode";
			CheckType[0] = "MNull";
			Messages[0] = "Please Enter code";

			if(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
			{
				
				if(isNaN(document.myForm.actcode.length))
				{
					if(document.myForm.actcode.value==document.myForm.plantCode.value)
					{
						alert(cdAlrdyPres_L);
						return false;
					}
					else
					{
						document.myForm.action="ezAddSaveSbuPlantAddress.jsp"
						document.myForm.submit();
					}
				}
				else
				{
					var bool="true"
					for(var i=0;i<document.myForm.actcode.length;i++)
					{
						if(document.myForm.actcode[i].value==document.myForm.plantCode.value)
						{
							bool="false"
							break;
						}
					}
					if(bool=="false")
					{
						alert(cdAlrdyPres_L);
						return false;

					}
					else
					{	
						
						document.myForm.action="ezAddSaveSbuPlantAddress.jsp"
						document.myForm.submit();
					}
				}
			}
		}
		function back()
		{

			document.myForm.action="ezListSbuPlantAddresses.jsp"
			document.myForm.submit();
		}
	</script>
</head>
<body  onLoad="document.myForm.plantCode.focus()">
<form name=myForm method=post >

<%
	String display_header = addPlntAdd_L;
%>	

	<%@ include file="ezDisplayHeader.jsp"%>
	<br>
	<Table align=center border=1 width=80% borderColorLight=#006666 bordercolordark=#ffffff cellpadding=2 cellspacing=0>
	<Tr>
		<Th align="left" width="20%"><%=codeStr_L%></Th>
		<Td width="30%"><input type=text style="width:100%" name=plantCode value="" class="InputBox">
			<input type="hidden" name=sbu value="  " >
		</Td>
		<Th align="left" width="20%"><%=name_L%></Th>
		<Td width="30%"><input type="text" style="width:100%" name=name value="" class="InputBox"> </Td>

	</Tr>

	<Tr>
		<Th align="left" width="20%"><%=add1_L%></Th>
		<Td width="30%"><input type=text name=address1 style="width:100%" value="" class="InputBox"></Td>
		<Th align="left" width="20%"><%=add2_L%></Th>
		<Td width="30%"><input type=text name=address2 style="width:100%" value="" class="InputBox"></Td>

	</Tr>
	<Tr>
		<Th align="left" width="20%"><%=city_L%></Th>
		<Td width="30%"><input type=text name=city style="width:100%" value="" class="InputBox"></Td>
		<Th align="left" width="20%"><%=state_L%></th>
		<Td width="30%"><input type=text name=state style="width:100%" value="" class="InputBox"></Td>

	</Tr>

	<Tr>
		<Th align="left" width="20%"><%=country_L%></Th>
		<Td width="30%"><input type=text name=country style="width:100%" value="" class="InputBox">
		<%--
			<select name="country">
		        <%for(int i=0;i<countryList.length;i++){%>
				<option  value="<%=countryList[i][0]%>"><%=countryList[i][0]%></option>
			<%}%>
	      </select>
		--%>
		</Td>
		<Th align="left" width="20%"><%=phone_L%></Th>
		<Td width="30%"><input type=text name=phone style="width:100%" value="" class="InputBox"></Td>

	</Tr>


	<Tr >
		<Th align="left" width="20%"><%=cst_L%></Th>
		<Td colspan=3 width="30%"><input type=text  size="44" name=cst value=""  class="InputBox"></Td>

		

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


<%
	
	for(int i=0;i<count;i++)
	{
%>
		<input type="hidden" name="actcode" value="<%=ret.getFieldValueString(i,"CODE")%>" >
<%
	}
	if(count==0)
	{
%>
		<input type="hidden" name="actcode" value="" >
<%
	}
%>
	<input type="hidden" name="code" value="<%=code1%>" >
	<input type="hidden" name="index" value="<%=index1%>">
	<Div id="MenuSol">
	</Div>

</form>
</body>
</html>