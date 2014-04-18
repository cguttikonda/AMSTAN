<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%
	String index = request.getParameter("myIndex");
	String selPlant = request.getParameter("selPlant");
	String SAP = request.getParameter("SAP");

%>
<html>
<head>
<Title>Material Search</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>

<Script src="../../Library/JavaScript/ezTrim.js"></Script>

<script>
	function search1()
	{
		
		if(!document.myForm.sapSearchType[0].checked && !document.myForm.sapSearchType[1].checked)
		{
			alert('Please select SAP search type')
			return
		}

		if(document.myForm.sapSearchType[0].checked && document.myForm.sapMatNo.value=='')
		{
			alert('Please enter material')
			document.myForm.sapMatNo.focus()
			return
		}
		if(document.myForm.sapSearchType[1].checked && document.myForm.sapMatDesc.value=='')
		{
			alert('Please enter material description')
			document.myForm.sapMatDesc.focus()
			return
		}

		if(document.myForm.sapSearchType[0].checked)
		{
			var url = "ezReturnableContainerMtrlSearch.jsp?matCode="+document.myForm.sapMatNo.value+"&myIndex=<%=index%>&searchType=CODE&matDesc=NA&selPlant="+"<%=selPlant%>";
			document.myForm.action=url
			document.myForm.submit()
			
		}
		else if(document.myForm.sapSearchType[1].checked)
		{
			var url = "ezReturnableContainerMtrlSearch.jsp?matCode="+document.myForm.sapMatNo.value+"&myIndex=<%=index%>&searchType=DESC&matDesc="+document.myForm.sapMatDesc.value+"&selPlant="+"<%=selPlant%>";
			document.myForm.action=url
			document.myForm.submit()
			
		}
	}

	function selectDef1(type,val)
	{
		if(type=='SAP')
		{
			if(val=='MAT')
			{
				document.myForm.sapSearchType[0].checked = true
			}
			else if(val=='DES')
			{
				document.myForm.sapSearchType[1].checked = true
			}
		
		}
	}
	function KeySubmit()
	{
		if (event.keyCode==13 && '<%=SAP%>'=='Y')
		{
			search1()
		}
	}	
</script>
</head>

<body scroll="yes">
<form name="myForm" method="post">
<input type="hidden" name="index" value="<%=index%>">
<input type="hidden" name="SAP" value="<%=SAP%>">

<Br><Br><Br><Br>
<Table align=center id="ezRCItemTab1"  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=1 cellSpacing=1 width='70%'>
	<Tr>
		<Th width="100%" align="left" colspan=3>SAP search</Th>
	</Tr>
	<Tr>
		<Th width="10%" align="right"><input type="radio" name="sapSearchType" value="MAT" ></Th>
		<Th width="40%" align="right">Material</Th>
		<Td width="50%"><input type="text" name="sapMatNo" class="InputBox" size="14" maxlength="18" value="" onFocus="selectDef1('SAP','MAT')" onKeyPress="KeySubmit()"></Td>
	</Tr>
	<Tr>
		<Th width="10%" align="right"><input type="radio" name="sapSearchType" value="DES" ></Th>
		<Th width="40%" align="right">Description</Th>
		<Td width="50%"><input type="text" name="sapMatDesc" class="InputBox" size="14" maxlength="18" value="" onFocus="selectDef1('SAP','DES')" onKeyPress="KeySubmit()"></Td>
	</Tr>
</Table>
<br>
<Div id="buttonDiv" align=center style="position:absolute;visibility:visible;width:100%">
	<span id="EzButtonsSpan" >
        
<%
	buttonName.add("&nbsp;&nbsp;&nbsp;Search&nbsp;&nbsp;&nbsp;");
	buttonMethod.add("search1()");
	buttonName.add("&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;");
	buttonMethod.add("window.close()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>			

          
	</span>
	<span id="EzButtonsMsgSpan" style="display:none">
	<Table align=center>
		<Tr>
			<Td class="labelcell">Your request is being processed... Please wait</Td>
		</Tr>
	</Table>
	</span>
	</Div>	

</form>
<Div id="MenuSol"></Div>
</body>
</html>