<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ include file="../../../Includes/JSPs/Materials/iViewMaterialRequest.jsp" %>
<%@ page import="ezc.ezutil.*" %>

<%  ezc.drl.util.Replace rep = new ezc.drl.util.Replace(); %>

<Html>
<%
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
%>

<Head>
	<title>Material Requirements Posting</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
	<script src="../../Library/JavaScript/ezCheckFormFields.js">
	</script>

<script>
		var FieldName=new Array();
		var CheckType=new Array();
		var Messages=new Array();

		FieldName[0] = "price";
		CheckType[0] = "Mnull";
		Messages[0] = "Please Enter Price";

		FieldName[1] = "details";
		CheckType[1] = "Mnull";
		Messages[1] = "Please Enter Remarks";
	function chk()
	{
		var s= funCheckFormFields(document.myForm,FieldName,CheckType,Messages);
		return s;
	}
	function chkQty(theField){
		if(isNaN(theField.value))
		{
			alert("Please enter valid Price");
			theField.focus();
			return false
		}
		else if (parseInt(theField.value,10)< 0)
		{
			alert("Price can not be less than 0. Please enter valid price.");
			theField.focus();
			return false
		}
		return true;
	}

	var newWindow4;

	function openFileWindow(file)
	{
		newWindow4 = window.open(file+"?requestId=<%=requestId%>&sysKey=<%=sysKey%>&soldTo=<%=soldTo%>&refNum=<%=refNum%>","MyNewtest","center=yes,height=300,left=200,top=100,width=450,titlebar=no,status=no,resizable=no,scrollbars")

	}

	var uploadWindow;
	function openUploadWindow()
	{
    		uploadWindow = window.open("ezAttachResponseFiles.jsp","UserWindow","width=400,height=300,left=100,top=100,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no");
	}
	function formEvents(evnt)
	{
		if(chk())
		{
			document.getElementById("ButtonDiv").innerHTML="<Table border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 ><Tr><Th>Please wait .Your Request is being Processed ...</Th></Tr></Table>"
   			document.myForm.action=evnt
   			document.myForm.submit();
   		}
	}

	function showDiv()
	{
		document.getElementById("MaterialDetails").style.visibility="hidden";
		document.getElementById("Respond").style.visibility="visible";
		document.getElementById("ButtonDiv").style.visibility="visible";
		if(document.myForm.price!=null)
		{
	  		document.myForm.price.focus()
	 	}
	}
	function hideDiv()
	{
		document.getElementById("Respond").style.visibility="hidden";
		document.getElementById("ButtonDiv").style.visibility="hidden";
		document.getElementById("MaterialDetails").style.visibility="visible";
	}
	function funUnLoad()
	{
		if(uploadWindow!=null && uploadWindow.open)
		{
	   		uploadWindow.close();
		}

		if(newWindow4!=null && newWindow4.open)
		{
	   		newWindow4.close();
		}
	}
	function funBack(usertype)
	{
		if(usertype==2)
		{
			document.myForm.action="ezListMaterialsInternal.jsp";
			document.myForm.submit();
		}
		else if(usertype==3)
		{
			document.myForm.action="ezListMaterialRequest.jsp";
			document.myForm.submit();
		}
	}
</script>

</Head>

<Body onUnLoad="funUnLoad()">
<Form name="myForm" method="post" onSubmit="return false">

<div id="MaterialDetails" align=center style="position:absolute;width:100%">
    <table width="50%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0  align="center">
    <Tr align="center">
    <Td class="displayheader">View Material Requirement Details</Td>
    </Tr>
    </Table>

<br>


   <Table width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >

   	<Tr>
	<th align="left" width="25%">Material Description</th>
	<Td width="25%" colspan=3><%=reqHeader.getFieldValueString(0,"MATERIALDESC")%></Td>
        </tr>

        <tr>
        <th align="left" >UOM</th>
	<Td width="25%"><%=reqHeader.getFieldValueString(0,"UOM")%></Td>

	<th align="left">Qty </th>
	<Td width="25%"><%=reqHeader.getFieldValueString(0,"REQUIREDQTY")%></Td>
	</Tr>
	<Tr>
 	<th align="left">Delivery Terms</th>
	<Td width="25%" >Delivery at Factory</Td>
	<th align="left">Created By </th>
	<Td width="25%"><%=reqHeader.getFieldValueString(0,"CREATEDBY")%></Td>
	</Tr>

	<%
	   	String reqDate=null;
		int mm=0;
		int dd=0;
		int yy=0;
		GregorianCalendar DocDate=null;	   
		
		if(type.equals("N"))
		{
	   	 reqDate=reqHeader.getFieldValueString(0,"EXT1");
		 mm=Integer.parseInt(reqDate.substring(3,5));
		 dd=Integer.parseInt(reqDate.substring(0,2));
		 yy=Integer.parseInt(reqDate.substring(6,10));
		 DocDate=new GregorianCalendar(yy,mm-1,dd);	   
		
	%>
		<tr>
		<th align="left">Required Date</th>
		<Td width="25%" colspan=3><%=FormatDate.getStringFromDate(DocDate.getTime(),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></Td>
		</Tr>
	<%      } %>

	</Table><br>

        <Table width=80% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
       	<Tr>
        <th align="left">Additional Details</th>
        </Tr>
	<Tr>
        <td align="left" width="100%">
		<% String reqdesc = reqHeader.getFieldValueString(0,"REQUESTDESC");
                   reqdesc = reqdesc.trim().equals("null")?"":reqdesc;
                 %>
	 <%=rep.setNewLine(reqdesc)%>&nbsp;
         <!--<textarea rows=5 style="width:100%;overflow:auto" readonly class=inputbox><%//reqdesc%></textarea></td>-->
	</Tr>
	</Table>
	<br>


<center>
<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border="none" onClick="javascript:funBack('<%=userType%>')">
<%
   if(userType.equals("3"))
   {
	if(resCount==0)
	{
%>
	<img src="../../Images/Buttons/<%=ButtonDir%>/respond.gif" style="cursor:hand" border="none" onClick="showDiv()">
<%	}else{  %>
	<img src="../../Images/Buttons/<%=ButtonDir%>/viewresponse.gif" style="cursor:hand" border="none" onClick="showDiv()">
<%	}
   }
%>

</center>

</div>



<div id="Respond" align=center style="position:absolute;visibility:hidden;width:100%">

    <table width="35%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0  align="center">
    <Tr align="center">
    <Td class="displayheader">Post Response</Td>
    </Tr>
    </Table>

<br>


   <Table width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >

   	<Tr>
	<th align="left" width="25%">Material Description</th>
	<Td width="25%" colspan=3><%=reqHeader.getFieldValueString(0,"MATERIALDESC")%></Td>
        </tr>

        <tr>
        <th align="left" >UOM</th>
	<Td width="28%"><%=reqHeader.getFieldValueString(0,"UOM")%></Td>

	<th align="left">Qty </th>
	<Td width="25%"><%=reqHeader.getFieldValueString(0,"REQUIREDQTY")%></Td>
	</Tr>

	<tr>
	<th align="left">Delivery Terms</th>
	<Td width="25%" >Delivery at Factory</Td>
	<th align="left">Created By </th>
	<Td width="25%"><%=reqHeader.getFieldValueString(0,"CREATEDBY")%></Td>
	</Tr>

	

	<%
		if(type.equals("N"))
		{
	   	 reqDate=reqHeader.getFieldValueString(0,"EXT1");
		 mm=Integer.parseInt(reqDate.substring(3,5));
		 dd=Integer.parseInt(reqDate.substring(0,2));
		 yy=Integer.parseInt(reqDate.substring(6,10));
		 DocDate=new GregorianCalendar(yy,mm-1,dd);	   		
	%>
			<tr>
			<th align="left">Required Date</th>
			<Td width="25%"><%=FormatDate.getStringFromDate(DocDate.getTime(),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></Td>
			<%
				if(resCount==0)
			      {
			%>
					<th align="left">Price</th>
				<Td width="25%"><input type="text" class="InputBox" name="price" size=10 maxlength = 10 onBlur="chkQty(this)"></Td>
			<%
			}else{%>
				<th align="left">Price</th>
				<Td width="25%"><%=myFormat.getCurrencyString(resHeader.getFieldValueString(0,"EXT1"))%></Td>
			<%
			}
			%>
		  </tr>

	<%    }else{ %>

			<tr>
			<%
				if(resCount==0)
			      {
			%>
					<th align="left">Price</th>
					<Td width="25%" colspan=3><input type="text" class="InputBox" name="price" size=10 maxlength = 10 onBlur="chkQty(this)"></Td>
			<%
			}else{%>
				<th align="left">Price </th>
				<Td width="25%" colspan=3><%=myFormat.getCurrencyString(resHeader.getFieldValueString(0,"EXT1"))%></Td>
			<%
			}
			%>
		  </tr>
	<%    } %>

	
	
	</Table><br>

        <Table width=80% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
       	<Tr>
        <th align="left">Additional Details</th>
        </Tr>
	<Tr>
        <td align="left" width="100%">
        <%
           	 if(resCount==0)
            	{
        %>

	  	      <textarea rows=4 style="width:100%;overflow:auto" name="details" class=inputbox></textarea>
			<input type=hidden name="flag" value="Add">
	        <%  }else{ %>

		<% String desc = resHeader.getFieldValueString(0,"RESPONSEDESC");
                   desc = desc.trim().equals("null")?"":desc;
                 %>

		 <%=rep.setNewLine(desc)%>&nbsp;
		<!--<textarea rows=5 style="width:100%;overflow:auto" name="details" class=inputbox><%//desc%></textarea>-->
		<input type=hidden name="flag" value="Edit">
        <%  	}
        %>
	</td>
	</Tr>
	</Table>
	<br>
		
<input type=hidden name="requestId" value="<%=requestId%>">
	<input type=hidden name="Type" value="<%=type%>">
	<input type="hidden" name="fileName" value="<%=fileName%>">
	<input type="hidden" name="serverCoa" value="<%=serverCoa%>">
	<input type="hidden" name="serverStp" value="<%=serverStp%>">
	<input type="hidden" name="refDocNo" value="<%=refNum%>">
	<input type="hidden" name="materialDesc" value="<%=reqHeader.getFieldValueString(0,"MATERIALDESC")%>">

</div>

<div align=center id="ButtonDiv" style="position:absolute;visibility:hidden;top:88%;width:100%">
	<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border="none" onClick="hideDiv()">
	<%
        if(resCount==0)
        {
		 if(type.equals("N"))
		 {
	  %>
		<img src="../../Images/Buttons/<%=ButtonDir%>/adddocuments.gif"  border="none" valign=bottom style="cursor:hand" onClick="openUploadWindow()"></a>

	<%	}   %>

	      <img src="../../Images/Buttons/<%=ButtonDir%>/submit.gif" style="cursor:hand" border="none" onClick="formEvents('../Materials/ezAddSaveMaterialResponse.jsp')">
	      <img src="../../Images/Buttons/<%=ButtonDir%>/clear.gif" style="cursor:hand" border="none" onClick="document.myForm.reset()">

	<%
	 }else{
		 if(type.equals("N"))
		 {
	%>
		<img src="../../Images/Buttons/<%=ButtonDir%>/viewdocuments.gif" style="cursor:hand" border=none onClick="openFileWindow('ezViewResponseFiles.jsp')">

	<%	}
	} %>
</div>

</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>
