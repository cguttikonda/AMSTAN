<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<Html>
<Head>
<%
      java.util.Date today = new java.util.Date();
%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
	<title>Difficult to Source Items</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
       <script src="../../Library/JavaScript/ezCheckFormFields.js"></script>
       <script src="../../Library/JavaScript/ezShipValidations.js"></script>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<script src="../../Library/JavaScript/ezConvertDates.js"></Script>
<script>
		var FieldName=new Array();
		var CheckType=new Array();
		var Messages=new Array();

		FieldName[0] = "mat_desc";
		CheckType[0] = "Mnull";
		Messages[0] = "Please Enter Material Description";

		FieldName[1] = "mat_uom";
		CheckType[1] = "Mnull";
		Messages[1] = "Please Enter UOM";

		FieldName[2] = "mat_qty";
		CheckType[2] = "Mnull";
		Messages[2] = "Please Enter Quantity";


		function chk()
		{
			var s= funCheckFormFields(document.myForm,FieldName,CheckType,Messages);
			return s;
		}

		function chkReqDate()
		{
		        var reqDateVal = document.myForm.reqDate.value
			if(reqDateVal=="")
			{
				alert("Please Enter Required Date")
				return false;
			}

			reqDateVal = ConvertDate(reqDateVal,'<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>')

			var today = new Date('<%=today.getYear()+1900%>',parseInt('<%=today.getMonth()%>',10),'<%=today.getDate()%>')
			var requiredDate = new Date(reqDateVal.substring(6,10),parseInt(reqDateVal.substring(3,5),10)-1,reqDateVal.substring(0,2),23,59,59)

			if(requiredDate < today)
			{
			    	alert("Required Date cannot be less than todays  date")
				return false;
			}
			return true;
		}


	</script>

<script>
function funSave()
      {
	if(chk())
	{
	     if(verifyField(document.myForm.mat_qty))
	     {
		if('<%=request.getParameter("Type")%>'=='N')	
		{
			if(chkReqDate())	
			{
				document.getElementById("ButtonDiv").innerHTML="<Table border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 ><Tr><Th>Please wait .Your Request is being Processed ...</Th></Tr></Table>"
	    			document.forms[0].action="ezAddSaveMaterialRequest.jsp";
     				document.forms[0].submit();
			}
		}
		else
		{
			document.getElementById("ButtonDiv").innerHTML="<Table border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 ><Tr><Th>Please wait .Your Request is being Processed ...</Th></Tr></Table>"
    			document.forms[0].action="ezAddSaveMaterialRequest.jsp";
     			document.forms[0].submit();
		}
             }
	}
     }

	function funReset()
	{
		document.forms[0].reset();
	}

	function funBack()
	{
    		document.forms[0].action="ezListMaterialsInternal.jsp";
     		document.forms[0].submit();
	}
	</script>

</Head>

<Body>
<Form name="myForm" method="post">
	<TABLE width=40% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    <Tr align="center">
    <%

         String type = request.getParameter("Type");
         if(type.equals("N"))
         {
    %>
    	  <Td class="displayheader">Add New Material Request</Td>

    <%   }else{  %>

    	  <Td class="displayheader">Add Material For Disposal</Td>
    <%   }   %>
    </Tr>
    </Table>
<br>


	<Table width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >

	<Tr>
	  <th align="left" width="25%">Material Description</th>
	  <Td width="75%" colspan=3><input type="text" name="mat_desc" class="InputBox" size=58 maxlength="70"></Td>
        </tr>

        <tr>
        <th align="left" >UOM</th>
	<Td width="25%"><input type="text" name="mat_uom" class="InputBox" size=12 maxlength=3></Td>
        <th align="left">Qty</th>
	 <Td width="25%"><input type="text" name="mat_qty" class="InputBox" size=15 maxlength="14"></Td>
	</Tr>
	<Tr>
<%
	   if(request.getParameter("Type").equals("N"))
           {
%>

	  <th align="left">Required Date</th>
	  <Td width="25%"><input type="text" name="reqDate" class="InputBox" size=12 maxlength="12" readonly><img src="../../Images/Common/calender.gif" height="20" style="cursor:hand" onClick=showCal("document.myForm.reqDate",75,250,"<%= cDate%>","<%= cMonth%>","<%= cYear%>")></Td>

<%        }  %>
	  <th align="left">Delivery Terms</th>
	  <Td width="25%" colspan=3>Delivery at Factory</Td>
	</Tr>

	<tr>
        <th align="left">Visibility Level</th>
	<Td width="25%" colspan=3><input type="radio" name="chk1" value="A" checked>All &nbsp;&nbsp;&nbsp;<input type="radio" name="chk1" value="S">By Purchase Area</Td>
        <Tr>

	</Table><br>
        <table width=80% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
        <Tr>
        <th align="left">Additional Details</th>
        </Tr>

	<Tr>
        <td align="left" width="100%"><textarea name="comments" rows=3 style="width:100%;overflow:auto" class=inputbox></textarea></td>
	</Tr>

	</Table>
	<br>

 <div align=center id="ButtonDiv" style="position:absolute;top:89%;width:100%">
	<a href="JavaScript:funBack()"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border="none"></a>
	<a href = "JavaScript:funSave()"><img src="../../Images/Buttons/<%=ButtonDir%>/submit.gif" style="cursor:hand" border="none"></a>

        <a href="JavaScript:document.myForm.reset()"><img src="../../Images/Buttons/<%=ButtonDir%>/clear.gif" style="cursor:hand" border="none" ></a>


</div>
<input type="hidden" name="SysKey" value="<%=request.getParameter("SysKey")%>">
<input type="hidden" name="Type" value="<%=type%>">

</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>
