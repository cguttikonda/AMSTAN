<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ include file="../../../Includes/JSPs/Materials/iAddSample.jsp" %>
<Html>
<Head>
<title>Add Sample</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>

<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<script src="../../Library/JavaScript/ezCheckFormFields.js"></script>
<script src="../../Library/JavaScript/ezCountriesAndStates.js"></script>
<script src="../../Library/JavaScript/ezShipValidations.js"></script>
<script src="../../Library/JavaScript/ezTrim.js"></script>

<script>
var addresses=new Array();

function funCheckNull(sValue)
{
	if(sValue=='null')
	   sValue='';

   return sValue;
}

function changeAddress()
{
         if(document.myForm.chk1[1].checked)
	 {

	      document.getElementById("manufacture").style.visibility="hidden";
	      document.getElementById("manufacture").style.display="none";
	      document.getElementById("supplier").style.visibility="visible";
	      document.getElementById("supplier").style.display="block";
	      document.myForm.type.value="S"
	 }
	 else
	 {
	      document.getElementById("supplier").style.visibility="hidden";
	      document.getElementById("supplier").style.display="none";
	      document.getElementById("manufacture").style.visibility="visible";
	      document.getElementById("manufacture").style.display="block";
	      document.myForm.type.value="M"
	 }
}


function setData(addressId,address1,address2,city,state,country,zip,phone1,phone2,fax,email)
{
	    this.addressId= addressId
	    this.address1= funCheckNull(address1)
	    this.address2= funCheckNull(address2)
	    this.city=funCheckNull(city)
	    this.state=funCheckNull(state)
	    this.country=funCheckNull(country)
	    this.zip=funCheckNull(zip)
	    this.phone1=funCheckNull(phone1)
	    this.phone2=funCheckNull(phone2)
	    this.fax=funCheckNull(fax)
	    this.email=funCheckNull(email)
}

if('<%=profileCount%>'>0)
{

	<%
		for(int i=0;i<addressCount;i++)
		{

 	%>

 		var country="";
		   for(var i=0;i<CountryArr.length;i++)
		   {
		   		if(CountryArr[i].key=='<%=retAddress.getFieldValueString(i,"COUNTRY")%>')
		   		{
		   			 country=CountryArr[i].value;
		   		}
		   }

		    addresses[<%=i%>]=new setData("<%=retAddress.getFieldValueString(i,"NUM")%>","<%=retAddress.getFieldValueString(i,"ADDRESS1")%>","<%=retAddress.getFieldValueString(i,"ADDRESS2")%>","<%=retAddress.getFieldValueString(i,"CITY")%>","<%=retAddress.getFieldValueString(i,"STATE")%>",country,"<%=retAddress.getFieldValueString(i,"ZIPCODE")%>","<%=retAddress.getFieldValueString(i,"PHONE1")%>","<%=retAddress.getFieldValueString(i,"PHONE2")%>","<%=retAddress.getFieldValueString(i,"FAX")%>","<%=retAddress.getFieldValueString(i,"EMAIL")%>");
	 <%
		}

	%>

	}
</script>

<script>

function showAddress()
{
  if(document.myForm.sites !=null)
  {
    var i=document.myForm.sites.selectedIndex
    document.myForm.address1.value=addresses[i].address1
    document.myForm.address2.value=addresses[i].address2
    document.myForm.city.value=addresses[i].city
    document.myForm.state.value=addresses[i].state
    document.myForm.country.value=addresses[i].country
    document.myForm.zip.value=addresses[i].zip
    document.myForm.phone1.value=addresses[i].phone1
    document.myForm.phone2.value=addresses[i].phone2
    document.myForm.fax.value=addresses[i].fax
    //document.myForm.email.value=addresses[i].email
  }
}

</script>


<script>
var uploadWindow;
var qaAddWindow;

var FieldNames=new Array;
var CheckType=new Array;
var Messages=new Array;

FieldNames[0]="DeliveryChallan";
CheckType[0]="MNull";
Messages[0]="Please enter Ref.Doc No";

FieldNames[1]="DCDate";
CheckType[1]="MNull";
Messages[1]="Please enter Ref.Doc Date";

FieldNames[2]="LR";
CheckType[2]="MNull";
Messages[2]="Please enter LR/RR/AIR BILL No";

FieldNames[3]="ShipDate";
CheckType[3]="MNull";
Messages[3]="Please enter Shipment Date";

FieldNames[4]="CarrierName";
CheckType[4]="MNull";
Messages[4]="Please enter Carrier Name";

FieldNames[5]="ExpectedArivalTime";
CheckType[5]="MNull";
Messages[5]="Please enter Expected Arrival Time";


function checkFormValues()
{

   if(document.myForm.MaterialDesc.selectedIndex==0)
   {
	alert("Please Select Material");
	document.myForm.MaterialDesc.focus();
	return false;
   }

   if(document.myForm.type.value=="S")
   {
   	if(document.myForm.suppcompanyName.value=="")
	{
		alert("Please Enter Company Name")
		document.myForm.suppcompanyName.focus()
		return false;
	}
   }

   if(!funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
   {
	return false;
   }
   return true;

}

function openUploadWindow()
{
    uploadWindow = window.open("ezAttachSampleFiles.jsp","UserWindow","width=500,height=400,left=50,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no");
}

function qaWindow(file,n)
{
    dcVal = document.myForm.DeliveryChallan.value
    if(dcVal=="")
    {
      dcVal="-"
    }

    matDesc = document.myForm.MaterialDesc.options[document.myForm.MaterialDesc.selectedIndex].text;
    if(matDesc=="--Select--")
    {
       matDesc="-"
    }

    dcDate = document.myForm.DCDate.value;
    if(funTrim(dcDate)=="")
    {
      dcDate="-"
    }

    batNo = document.myForm.Line[n].value;
    if(funTrim(batNo)=="")
    {
      batNo="-"
    }

    batQty = document.myForm.QTY[n].value;
    if(funTrim(batQty)=="")
    {
      batQty="-"
    }

    coastr=dcVal+"¤"+matDesc+"¤"+dcDate+"¤"+batNo+"¤"+batQty;
    qaAddWindow = window.open(file+"&coastr="+escape(coastr),"QaWindow","width=550,height=450,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no");
}



function checkVals()
{
    for(var i=0;i<3;i++)
    {
	if(funTrim(document.myForm.Line[i].value)!="")
	{

		if(funTrim(document.myForm.UOM[i].value)=="")
		{
		    alert("Please Enter UOM")
		    document.myForm.UOM[i].focus();
		    return false;
		}

		if(funTrim(document.myForm.QTY[i].value)=="")
		{
		    alert("Please Enter Quantity")
		    document.myForm.QTY[i].focus();
		    return false;
		}

		if(!verifyField(document.myForm.QTY[i]))
		{
		   return false;
		}
    	}

    }
    return true;
}

function checkFiles()
{
    var no = document.myForm.files.value
    if(no<17)
    {
       var ans1 = window.confirm("You have not Attached all the necessary documents.\n If you want to continue without attaching remaining files press 'Ok' \n To attach remaining file press 'Cancel' and use 'Upload' button")
       return ans1;
    }
    else
    {
       return true;
    }
}

function checkCOA()
{
    cnt=0
    for(var i=0;i<3;i++)
    {
	if(funTrim(document.myForm.Line[i].value)!="")
	{
		if(funTrim(document.myForm.coaData[i].value)=="")
		{
		    cnt++;
		}
	}

    }

    if(cnt=='0')
    {
    	return true;
    }
    else
    {
    	var ans2 = window.confirm("You have not entered COA for all the line items.\n If you want to continue press 'Ok' \n To fill the remaining data press 'Cancel' and use 'QA' link")
        	return ans2;
    }
}

function showAlerts()
{

   if(checkFormValues())
   {

         if(checkVals())
         {

  		if(checkFiles())
        	{
        	     if(checkCOA())
	       	     {

	       	          document.myForm.action="ezAddSaveSamples.jsp"
	       	          var url = "../Purorder/ezSelectSampleUsers.jsp";
	   		  var hWnd = window.open(url,"UserWindow","width=300,height=300,resizable=yes,scrollbars=yes");
		          if ((document.window != null) && (!hWnd.opener))
			   hWnd.opener = document.window;
        	     }
        	}

         }
   }

}

function showMessage()
{
    var ans2 = window.confirm("If you want to restart the whole process press 'Ok'")
    if(ans2)
    {
        document.location.href="ezAddSample.jsp"
    }

}

function funUnLoad()
{
	if(uploadWindow!=null && uploadWindow.open)
	{
		uploadWindow.close();
	}

	if(qaAddWindow!=null && qaAddWindow.open)
	{
		qaAddWindow.close();
	}
}

</script>
</Head>
<%

  if(profileCount>0)
  {
%>


	<%
		int count=retVendor.getRowCount();
		if(count==0)
		{
	%>
		<br><br><br><br><br>
		<TABLE align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<tr>
		<Th>No New Material Profiles added.To add a Sample, first you need to enter <a href="ezAddVendorQuestionnaire.jsp"><font color="#FFFFFF">Material Profile.</font></a></th>
		</tr>
		</table>
	<%
		return;
		}
	%>
<Body onLoad="showAddress();changeAddress()" onUnLoad="funUnLoad()">
<Form name="myForm" action="ezAddSaveSamples.jsp" method="post">
	<TABLE width=40% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<Tr align="center">
	        <Td class="displayheader">Add Sample</Td>
	</Tr>
	</Table>

	<div id="Sample" style="overflow:auto;position:absolute;height:75%;width:100%" >
	<TABLE width=100% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>

	<tr>
    	<th colspan=4  align="center">Material Details</th>
    </tr>

    <tr>
	<th align="left" width="25%"> Material Description</th>
	<td width="25%">
	<div id="listBoxDiv1">
	<select name="MaterialDesc">
	<option value="">--Select--</option>
<%
		for(int i=0;i<count;i++)
		{
%>
			<option value='<%=retVendor.getFieldValueString(i,"MATERIALID")%>'><%=retVendor.getFieldValueString(i,"MATERIALDESC")%></option>
<%
		}
%>
	</select>
	</div>
	</td>

	<td colspan=2>
	Are you &nbsp;&nbsp;<input type="radio" name="chk1" onClick="changeAddress()" checked> Manufacturer&nbsp;&nbsp;<input type="radio" name="chk1" onClick="changeAddress()">Agent for this material.
	</td>

	</tr>

    	<tr>
	<th align="left" width="25%">Specifications</th>
	<td colspan=3 width="75%"><textarea cols="70" class="inputbox" rows=2 style="overflow:auto" name="materialSpec"></textarea></td>
	</tr>
        </table>

        <span id="manufacture" style="postion:absolute;visibility:hidden;display:none">
        <TABLE width=100% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<tr>
	<th colspan=4 align=center width="100%">
	Select Manufacturing Site
		   <select name=sites onChange='showAddress()'>
		   <script>
		      for(var j=0;j<addresses.length;j++)
		      {
		      	  var x = j+1;
		   	  if(j==0)
		   	  {
		   	     document.write("<option value="+addresses[j].addressId+" selected>Manufacturing Site"+x+"</option>")
		   	  }
		   	  else
		   	  {
		   	     document.write("<option value="+addresses[j].addressId+" >Manufacturing Site"+x+"</option>")
		   	  }

		      }
		    </script>
		    </select>

 	</th>
	</tr>

	<tr>
	<th align="left" width="25%">Address1</th><td width="25%"><input type="text" name="address1" maxlength=40 class=tx readonly></td>
	<th align="left" width="25%">Address2</th><td width="25%"><input type="text" name="address2" maxlength=40 class=tx readonly></td>
	</tr>

	<tr>
	<th align="left" width="25%">City</th><td width="25%"><input type="text" name="city" maxlength=40 class=tx readonly></td>
	<th align="left" width="25%">State</th><td width="25%">
	<input type="text" name="state" maxlength=40 class=tx readonly>
        </td>
	</tr>

	<tr>
   	<th align="left" width="25%">Country</th><td width="25%">
	<input type="text" name="country" maxlength=40 class=tx readonly>
   	</td>
   	<th align="left" width="25%">Zip</th><td width="25%"><input type="text" name="zip" maxlength=10 class=tx readonly></td>
   	</tr>

	<tr>
	<th align="left" width="25%"> Phone1</th><td width="25%"><input type="text" name="phone1" class=tx maxlength=20 readonly></td>
   	<th align="left" width="25%">Phone2</th><td width="25%"><input type="text" name="phone2" class=tx maxlength=20 readonly></td>
   	</tr>

	<tr>
    	<th align="left" width="25%"> Fax</th><td width="25%"><input type="text" name="fax" class=tx maxlength=20 readonly></td>
	<td align="left" width="25%" colspan=2>&nbsp;</td>
	</tr>
	</table>
	</span>

	
      <span id="supplier" style="postion:absolute;visibility:hidden;display:none">
      <TABLE width=100% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<tr>
	<th colspan=2 align=center width="50%">Manufacturer's Office Address</th>
	<th colspan=2 align=center width="50%">Manufacturing Site Address</th>
	</tr>

	<tr>
	<th align="left" width="25%">Company Name</th><td width="25%"><input type="text" class="InputBox" name="suppcompanyName" maxlength=40></td>
	<td align="left" width="25%" colspan=2>&nbsp;</th></td>
	</tr>

	<tr>
	<th align="left" width="25%">Address1</th><td width="25%"><input type="text" class="InputBox" name="suppaddress1" maxlength=40></td>
	<th align="left" width="25%">Address1</th><td width="25%"><input type="text" class="InputBox" name="mfgaddress1" maxlength=40></td>
	</tr>

	<tr>
	<th align="left" width="25%">Address2</th><td width="25%"><input type="text" class="InputBox" name="suppaddress2" maxlength=40></td>
	<th align="left" width="25%">Address2</th><td width="25%"><input type="text" class="InputBox" name="mfgaddress2" maxlength=40></td>
	</tr>

	<tr>
	<th align="left" width="25%">City</th><td width="25%"><input type="text" class="InputBox" name="suppcity" maxlength=40></td>
	<th align="left" width="25%">City</th><td width="25%"><input type="text" class="InputBox" name="mfgcity" maxlength=40></td>
	</tr>

	<tr>
	<th align="left" width="25%">State</th><td width="25%">
	<SELECT NAME="suppstate">
	<OPTION VALUE="" >--- Select---</option>
        <script>
		getPreStates('','document.myForm.suppstate','')
	 </script>
	 </SELECT>
	</td>
	<th align="left" width="25%">State</th><td width="25%">
		<SELECT NAME="mfgstate">
	<OPTION VALUE="" >--- Select---</option>
        <script>
		getPreStates('','document.myForm.mfgstate','')
	 </script>
	 </SELECT>
	</td>
	</tr>

	<tr>
   	<th align="left" width="25%">Country</th><td width="25%">
	<SELECT NAME="suppcountry" onChange="getStates(this,'document.myForm.suppstate')">
	  <OPTION VALUE="" >- Select -</option>
	<script>
	for(var i=0;i<CountryArr.length;i++)
	{
		document.write("<option value="+CountryArr[i].key+">"+CountryArr[i].value+"</option>");
	}
	</script>
	</SELECT>
	</td>
	<th align="left" width="25%">Country</th><td width="25%">
	<SELECT NAME="mfgcountry" onChange="getStates(this,'document.myForm.mfgstate')">
	  <OPTION VALUE="" >- Select -</option>
	<script>
	for(var i=0;i<CountryArr.length;i++)
	{
		document.write("<option value="+CountryArr[i].key+">"+CountryArr[i].value+"</option>");
	}
	</script>
	</SELECT></td>
   	</tr>

	<tr>
	<th align="left" width="25%">Zip</th><td width="25%"><input type="text" class="InputBox" name="suppzip" maxlength=10></td>
	<th align="left" width="25%">Zip</th><td width="25%"><input type="text" class="InputBox" name="mfgzip" maxlength=10></td>
   	</tr>

	<tr>
	<th align="left" width="25%"> Phone1</th><td width="25%"><input type="text" class="InputBox" name="suppphone1" maxlength=20></td>
   	<th align="left" width="25%">Phone1</th><td width="25%"><input type="text" class="InputBox" name="mfgphone1" maxlength=20></td>
   	</tr>

	<tr>
	<th align="left" width="25%"> Phone2</th><td width="25%"><input type="text" class="InputBox" name="suppphone2" maxlength=20></td>
   	<th align="left" width="25%">Phone2</th><td width="25%"><input type="text" class="InputBox"  name="mfgphone2" maxlength=20></td>
   	</tr>


	<tr>
    	<th align="left" width="25%"> Fax</th><td width="25%"><input type="text" name="suppfax" class="InputBox" maxlength=20></td>
	<th align="left" width="25%"> Fax</th><td width="25%"><input type="text" name="mfgfax" class="InputBox" maxlength=20></td>
	</tr>
	</table>
	</span>



	<TABLE width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<tr>
	<th colspan=4 align="center">Shipment Details</th>
	</tr>

	<tr align="center" valign="middle">
		<th align="left" width="25%">DN No </th>
		<td align="left" width="25%"><input type="text" class=InputBox  name="DeliveryChallan" tabindex="1" maxlength="30">
		</td>
	     	<th align="left" width="25%">DN Date </th>
		<td  align="left" valign=center width="25%"><input type="text" class=InputBox  readonly name="DCDate" size=12 onfocus=this.blur()><a href="JavaScript:showCal('document.myForm.DCDate',75,450,'<%=cDate%>','<%=cMonth%>','<%=cYear%>')" ><img src="../../Images/Common/calender.gif" height="20" style="cursor:hand" border=no></a></td>
	 </tr>
	 <tr>
		<th align="left" width="25%">Invoice No </th>
		<td align="left" width="25%"><input type="text" class=InputBox  name="InvoiceNo" tabindex="2" maxlength="20"></td>
		<th align="left" width="25%">Invoice Date </th>
		<td align="left" valign=center width="25%"><input type="text" class=InputBox  name="InvoiceDate"  size=12 readonly onfocus=this.blur()><a href="JavaScript:showCal('document.myForm.InvoiceDate',75,450,'<%= cDate%>','<%= cMonth%>','<%= cYear%>')" ><img src="../../Images/Common/calender.gif" height="20" style="cursor:hand" border=no></a></td>
	</tr>
	<tr >
	<th align="left" width="25%">LR/RR/AIR BILL No </th>
		<td align="left" width="25%"><input type="text" class=InputBox  name="LR" tabindex="3" maxlength="30"></td>
	 <th align="left" width="25%">Shipment Date </th>
		<td align="left" valign=center width="25%"><input type="text" class=InputBox  name="ShipDate"  size=12 readonly onfocus=this.blur()><a href="JavaScript:showCal('document.myForm.ShipDate',75,450,'<%=cDate%>','<%=cMonth%>', '<%=cYear%>')" ><img src="../../Images/Common/calender.gif" style="cursor:hand" height="20" border=no></a></td>


	</tr>
	<tr>
	<th align="left" width="25%">Carrier Name </th>
		<td width="25%"><input type="text" class=InputBox  name="CarrierName" tabindex="4" maxlength="50"></td>
	 <th align="left" width="25%">Exp. Arrival Date </th>
	<Td valign=center width="25%"><input type="text" class=InputBox  name="ExpectedArivalTime"  size=12 readonly onfocus=this.blur()><a href="JavaScript:showCal('document.myForm.ExpectedArivalTime',75,450,'<%=cDate%>','<%=cMonth%>','<%=cYear%>')" ><img src="../../Images/Common/calender.gif" height="20" style="cursor:hand" border=no></a></Td>

	</tr>
	<Tr>
	<th align="left" width="25%">General Text </th>
	<Td colspan="3" align="left" width="25%"><Textarea name="generalInfo" cols="70" class="inputbox" style="overflow:auto"  rows="2"></Textarea></Td>
	</Tr>
  </table>

  <Table align="center" id="Table1" width="100%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
  <tr>
    <th align="center" width="25%">Batch No</th>
    <th align="center" width="25%">UOM</th>
    <th align="center" width="25%">Qty</th>
    <th align="center" width="25%">COA</th>
  </tr>
  </table>


  <Table align=center width=100% border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
	for(int i=0;i<3;i++)
	{
%>
  		<tr>
  		   <td width="25%" align="center"><input type="text" class="inputbox" name="Line" size=10 maxlength=16></td>
  		   <td width="25%" align="center"><input type="text" class="inputbox" name="UOM"  size=10 maxlength=5></td>
  		   <td width="25%" align="center"><input type="text" class="inputbox" name="QTY"  size=10 maxlength=15 style="text-align:right"></td>
  		   <td width="25%" align="center"><a href="javascript:qaWindow('ezCertificate.jsp?index=<%=i%>','<%=i%>')">QA</a></td>
  		   <input type="hidden" name="coaData" value="">
  		   <input type="hidden" name="coaLong" value="">
  		</tr>
<%
	}
%>

  </table>
  </div>
<br>
<div id="Buttons" align=center style="position:absolute;top:90%;width:100%" >
<table align="center" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<tr>
<td align="center" class=blankcell>
<a href="JavaScript:openUploadWindow()"><img src="../../Images/Buttons/<%=ButtonDir%>/adddocuments.gif"  border="none" valign=bottom style="cursor:hand" ></a>
<a href="JavaScript:showAlerts()"><img src="../../Images/Buttons/<%=ButtonDir%>/submit.gif" border="none" valign=bottom  style="cursor:hand"></a>
<a href="JavaScript:showMessage()"><img src="../../Images/Buttons/<%=ButtonDir%>/cancel.gif" border="none" valign=top style="cursor:hand" ></a>
</td>
</tr>
</Table>
</div>
<input type="hidden" name="files" value="0">
<input type="hidden" name="fileName" value="">

<input type="hidden" name="coastr" value="">
<input type="hidden" name="toUser" value="">
<input type="hidden" name="type" value="">

</Form>
</Body>
<%  }else{  %>
<body>
<form name="myForm">
	<br><br><br><br>
	<table align=center width=60% border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>

	<tr>
	    <th>Please Add Vendor Profile before adding Samples</th>
	</tr>
	</table>
	<br><br><br><br>
	<center>
	<a href="../Materials/ezAddVendorProfile.jsp" target="display"><img src="../../Images/Buttons/<%=ButtonDir%>/addbutton.gif" style="cursor:hand" border=none></a>
	</center>
</form>
<Div id="MenuSol"></Div>
</body>
<% } %>

</Html>
