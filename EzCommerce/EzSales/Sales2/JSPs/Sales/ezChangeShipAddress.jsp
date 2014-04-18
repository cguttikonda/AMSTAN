<%

String editOrViewAddr = request.getParameter("status");
if(editOrViewAddr!=null && !"null".equals(editOrViewAddr) && "V".equals(editOrViewAddr))
	editOrViewAddr = "readonly";
else
	editOrViewAddr = "";

%>
<html>
<head>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/ezCheckFormFields.js"></Script>
<script>
	var passedString = ""
	function changeAddr()
	{
		if(document.myForm.txtShipaddr1.value=="")
		{
			alert("Please enter Address");
			document.myForm.txtShipaddr1.focus();
			return;
		}
		/*if(document.myForm.txtShipaddr2.value=="")
		{
			alert("Please enter Address 2");
			document.myForm.txtShipaddr2.focus();
			return;
		}*/
		if(document.myForm.txtCity.value=="")
		{
			alert("Please enter City");
			document.myForm.txtCity.focus();
			return;
		}
		/*
		if(document.myForm.txtState.value=="")
		{
			alert("Please enter State");
			document.myForm.txtState.focus();
			return;
		}
		*/
		if(document.myForm.txtZipCode.value=="")
		{
			alert("Please enter Postal Code");
			document.myForm.txtZipCode.focus();
			return;
		}
		/*
		if(!funZip(funTrim(document.myForm.txtZipCode.value)))
		{
			
			alert("Please enter valid 6 digit numeric Ship Address PostalCode")
			document.myForm.txtZipCode.focus()
			return;
		}
		*/
		
		
		
		var num_of_elements = document.myForm.length;
		for (var i=0; i<num_of_elements; i++)
		{
			var theElement = document.myForm.elements[i];
			var element_type = theElement.type;
			var element_name = theElement.name;
			var element_value = theElement.value;
			if (element_type == "text") 
			{
				if (element_value != '') 
				{
					
					
					tempvar_js = element_value.replace(/'/g,"`")
					theElement.value = tempvar_js.replace(/&/g," ")

				}
			}

		}					
		
		
		window.returnValue = document.myForm.txtShipaddr1.value+"¥"+document.myForm.txtCity.value+"¥"+document.myForm.txtState.value+"¥"+document.myForm.txtZipCode.value;
		self.close();	
	}
	function funcLoad()
	{ 
		passedString 		= window.dialogArguments;
		var shipAddrValues 	= passedString.split('¥');
		
		if(shipAddrValues[0]==null)
			shipAddrValues[0]="";
		
		document.myForm.txtShipaddr1.value 	= shipAddrValues[0]		
		document.myForm.txtCity.value 		= shipAddrValues[1]
		document.myForm.txtState.value		= shipAddrValues[2]
		document.myForm.txtZipCode.value	= shipAddrValues[3]

		window.returnValue =''
	}
</script>
</head>
<body onLoad="funcLoad()" scroll=no>
<form name="myForm">


<Div id='inputDiv' style='position:relative;align:center;top:5%;width:100%;'>
<Table width="70%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
<Tr>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
	<Td style="background-color:'F3F3F3'" valign=middle align=center>
	
		<Table width="100%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
		<TR>
			<TD align="right"  style="width:25%;background-color:'F3F3F3'" height="22"><STRONG>&nbsp;Address:&nbsp;</STRONG></TD>
			<TD align="left" style="width:75%;background-color:'F3F3F3'" height="22"><input type=text class="InputBox" name="txtShipaddr1" size=50 maxlength=40 <%=editOrViewAddr%> >&nbsp;</TD>
		</TR>
		<TR>
			<TD align="right"  style="width:25%;background-color:'F3F3F3'" height="22"><STRONG>&nbsp;City:&nbsp;</STRONG></TD>
			<TD align="left" style="width:75%;background-color:'F3F3F3'" height="22">
			<input type=text class="InputBox" name="txtCity" size=40 maxlength=40 >&nbsp;
			</TD>
		</TR>
		<TR>
			<TD align="right"  style="width:25%;background-color:'F3F3F3'" height="22"><STRONG>&nbsp;State:&nbsp;</STRONG></TD>
			<TD align="left" style="width:75%;background-color:'F3F3F3'" height="22">
			<input type=text class="InputBox" name="txtState" size=40 maxlength=40 >
			</TD>
		</TR>
		<TR>
			<TD align="right"  style="width:25%;background-color:'F3F3F3'" height="22"><STRONG>&nbsp;Postal Code:&nbsp;</STRONG></TD>
			<TD align="left" style="width:75%;background-color:'F3F3F3'" height="22"><input type=text class="InputBox" name="txtZipCode" size=8 maxlength=6 >&nbsp;</TD>
		</TR>

		</Table>
	</Td>
	<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif" ></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
</Tr>
</Table>
</Div>
<Div id="buttonDiv" align="center" style='position:Absolute;Top:75%;width:100%'>
<center>
<font color=red>* All fields are mandatory</font>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Continue");
	buttonMethod.add("changeAddr()");
	buttonName.add("Cancel");
	buttonMethod.add("self.close()");	
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</Div>
</form>
</body>
</html>