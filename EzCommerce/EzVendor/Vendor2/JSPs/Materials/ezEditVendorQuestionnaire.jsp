<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ include file="../../../Includes/JSPs/Materials/iViewVendorQuestionnaire.jsp" %>
<html>
<head>
<title>Edit Vendor Questionnaire</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%@ include file="../../../Includes/JSPs/Materials/iTopTabQuesScript.jsp" %>
<script src="../../Library/JavaScript/ezCheckFormFields.js"></script>
<script src="../../Library/JavaScript/ezCountriesAndStates.js"></script>


<script>
var newWindow4;
var attach;
function setDefaults()
{

	if('<%=ret.getFieldValueString(0,"ISPRIMEMFR")%>'=="Y")
	  document.myForm.chk1[0].checked=true;
	else
	  document.myForm.chk1[1].checked=true;

	if('<%=ret.getFieldValueString(0,"GMP")%>'=="Y")
	{
	  document.myForm.chk23[0].checked=true;
	  showDiv1()
	}  
	else
	{
	  document.myForm.chk23[1].checked=true;
	} 

	if('<%=ret.getFieldValueString(0,"EMPTRAINING")%>'=="Y")
	   document.myForm.chk31[0].checked=true;
	else
	   document.myForm.chk31[1].checked=true;

	if('<%=ret.getFieldValueString(0,"HOUSEKEEPING")%>'=="Y")
	   document.myForm.chk32[0].checked=true;
	else
	   document.myForm.chk32[1].checked=true;

	if('<%=ret.getFieldValueString(0,"EQDEDICATED")%>'=="Y")
	   document.myForm.chk33[0].checked=true;
	else
	   document.myForm.chk33[1].checked=true;

	if('<%=ret.getFieldValueString(0,"EQMULTIPUR")%>'=="Y")
	   document.myForm.chk34[0].checked=true;
	else
	   document.myForm.chk34[1].checked=true;

	if('<%=ret.getFieldValueString(0,"EQWPMAINT")%>'=="Y")
	   document.myForm.chk35[0].checked=true;
	else
	   document.myForm.chk35[1].checked=true;

	if('<%=ret.getFieldValueString(0,"EQWPCLEAN")%>'=="Y")
	   document.myForm.chk36[0].checked=true;
	else
	   document.myForm.chk36[1].checked=true;

	if('<%=ret.getFieldValueString(0,"EQWPCALLIB")%>'=="Y")
	   document.myForm.chk37[0].checked=true;
	else
	   document.myForm.chk37[1].checked=true;

	if('<%=ret.getFieldValueString(0,"EQABVDOC")%>'=="Y")
	   document.myForm.chk38[0].checked=true;
	else
	   document.myForm.chk38[1].checked=true;

	if('<%=ret.getFieldValueString(0,"MFRTSECERT")%>'=="Y")
	   document.myForm.chk41[0].checked=true;
	else
	   document.myForm.chk41[1].checked=true;

	if('<%=ret.getFieldValueString(0,"MFRISPENCILLINS")%>'=="Y")
	   document.myForm.chk42[0].checked=true;
	else
	   document.myForm.chk42[1].checked=true;

	if('<%=ret.getFieldValueString(0,"MFRISSTOPPROC")%>'=="Y")
	   document.myForm.chk43[0].checked=true;
	else
	   document.myForm.chk43[1].checked=true;

	if('<%=ret.getFieldValueString(0,"MFRISABNORMAL")%>'=="Y")
	   document.myForm.chk44[0].checked=true;
	else
	   document.myForm.chk44[1].checked=true;

	if('<%=ret.getFieldValueString(0,"QCTESTPROC")%>'=="Y")
	   document.myForm.chk45[0].checked=true;
	else
	   document.myForm.chk45[1].checked=true;

	if('<%=ret.getFieldValueString(0,"QCSPECS")%>'=="Y")
	   document.myForm.chk46[0].checked=true;
	else
	   document.myForm.chk46[1].checked=true;

	if('<%=ret.getFieldValueString(0,"QCSTATMETHODS")%>'=="Y")
	   document.myForm.chk47[0].checked=true;
	else
	   document.myForm.chk47[1].checked=true;

	if('<%=ret.getFieldValueString(0,"SHEISOADAPTED")%>'=="Y")
	   document.myForm.chk51[0].checked=true;
	else
	   document.myForm.chk51[1].checked=true;

	if('<%=ret.getFieldValueString(0,"SHEWATERACT")%>'=="Y")
	   document.myForm.chk52[0].checked=true;
	else
	   document.myForm.chk52[1].checked=true;

	if('<%=ret.getFieldValueString(0,"SHEAIRACT")%>'=="Y")
	   document.myForm.chk53[0].checked=true;
	else
	   document.myForm.chk53[1].checked=true;

	if('<%=ret.getFieldValueString(0,"SHEWASTEMGMT")%>'=="Y")
	   document.myForm.chk54[0].checked=true;
	else
	   document.myForm.chk54[1].checked=true;

	if('<%=ret.getFieldValueString(0,"MISCTEST")%>'=="Y")
	   document.myForm.chk55[0].checked=true;
	else
	   document.myForm.chk55[1].checked=true;

	if('<%=ret.getFieldValueString(0,"MISCCERT")%>'=="Y")
	   document.myForm.chk56[0].checked=true;
	else
	   document.myForm.chk56[1].checked=true;

	if('<%=ret.getFieldValueString(0,"MISCSOP")%>'=="Y")
	   document.myForm.chk57[0].checked=true;
	else
	   document.myForm.chk57[1].checked=true;




}
</script>



<script>
function setServerFileName(code)
{
	if(code=='GMP')
	  document.myForm.serverFile.value="¥";

}


function chkTab1()
{

   if(document.myForm.materialDesc.value=="")
   {
   	alert("Please enter Material Description")
   	document.myForm.materialDesc.focus()
   	return false;

   }
   return true;
}


function chkTab2()
{
   if(document.myForm.mktEmail.value!="")
   {
       if(!funEmail(document.myForm.mktEmail.value))
       {
            alert(msgString);
            document.myForm.mktEmail.focus()
            return false;
       }
   }

   if(document.myForm.qaEmail.value!="")
   {
       if(!funEmail(document.myForm.qaEmail.value))
       {
            alert(msgString);
            document.myForm.qaEmail.focus()
            return false;
       }
   }

   return true;
}


function chkTab3()
{

   if(document.myForm.chk23[0].checked && document.myForm.n1.value=="")
   {
	    alert("Please select a file to Upload.");
            return false;
   }

   return true;

}


function formEvents(evnt)
{
   if(chkTab1())
   {
     	if(chkTab2())
   		{
   			if(chkTab3())
   			{
   				 document.myForm.action=evnt
   			 	 document.myForm.submit()
   			}
        }
   }
}

function funAttach(i)
{
	attach=window.open("../Materials/ezAttachFile.jsp?index="+i,"UserWindow1","width=350,height=250,left=150,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
	changeButton()
}

function changeButton()
{
   	 var obj = eval("document.myForm.button1")
	 if(document.myForm.n1.value=="")
	 {
	   obj.src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif";
	 }
	 else
	 {
	   obj.src="../../Images/Buttons/<%=ButtonDir%>/remove.gif";
	 }

}

function removeFile(i)
{
   document.myForm.n1.value="";
   changeButton()
}

function commonFun(i)
{
	 var obj = eval("document.myForm.button1")
	 var path = obj.src
	 if(path.indexOf('attachfile.gif')>0)
	 {
	    funAttach(i)
	 }
	 else
	 {
	   removeFile(i)
	 }
}

function fun3()
{
    newWindow4 = window.open("ezViewUndertaking.jsp","MyWin","center=yes,height=500,left=10,top=10,width=770,titlebar=no,status=no,resizable=no,scrollbars")
}

function hideAll()
{
     document.getElementById("div1").style.visibility="hidden"
}

function showDiv1()
{
   	obj = eval("document.myForm.chk23[0]")
   	if(obj.checked)
   	{
   	   document.getElementById("div1").style.visibility="visible"
   	}
   	else
   	{
   	   document.getElementById("div1").style.visibility="hidden"
   	}

  changeButton()
}

function showButton(n)
{
   document.getElementById("div"+n).style.visibility="visible"
   changeButton()
}

function hideButton(m)
{
  document.getElementById("div"+m).style.visibility="hidden"
}

function setFname(j)
{
   var path = eval('document.myForm.f'+j).value
   var x = path.lastIndexOf('\\')
   var fileName=path.substring(x+1,path.length);
   eval('document.myForm.n'+j).value=fileName
}


function funReset()
{
   document.myForm.reset()
   setDefaults()
   showDiv()
}

var uploadWindow
function funUnLoad()
{
	if(newWindow4!=null && newWindow4.open)
	{
	   newWindow4.close();
	}

	if(attach!=null && attach.open)
	{
	   attach.close();
	}

	if(uploadWindow!=null && uploadWindow.open)
	{
	   uploadWindow.close();
	}


}


function funAttachFile()
{
    uploadWindow = window.open("ezAttachQuestionnaireFiles.jsp","UserWindow","width=400,height=300,left=100,top=100,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no");
}

</script>
</head>

<body onLoad="setDefaults()" scroll=no onUnLoad="funUnLoad()">
<form name="myForm" method="post">
	<table align="center" width="40%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<tr>
	<td class="displayheader" align="center">Edit Vendor Questionnaire</td>
	</tr>
	</table>

 <div id="totDiv" style="overflow:auto;position:absolute;top:9%;left:5%;width:92%;height:75%">

	<table align=center width=100% border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<tr>
	<th align="left">Name of the Material</th>
	<td colspan=3><input type="text" value="<%=MaterialDesc%>" class="InputBox" name="materialDesc" maxlength=70></td>
	</tr>

	<tr>
	<th align="left" colspan=4>Contact Person(s)</th>
	</tr>

	<tr>
	<th align="left" colspan=4>1 . Marketing Department</th>
	</tr>

	<tr>
	<th align="left">Name</th>
	<td><input type="text" value="<%=MktContactName%>" class="InputBox" name="mktName" maxlength=64></td>
	<th align="left">Designation</th>
	<td><input type="text" value="<%=MktContactDesignation%>" class="InputBox" name="mktDesig" maxlength=64></td>
	</tr>

	<tr>
	<th align="left">Phone1</th>
	<td><input type="text" value="<%=MktContactPhone1%>" class="InputBox" name="mktPhone1" maxlength=20></td>
	<th align="left">Phone2</th>
	<td><input type="text" value="<%=MktContactPhone2%>" class="InputBox" name="mktPhone2" maxlength=20></td>
	</tr>

	<tr>
	<th align="left">Fax</th>
	<td><input type="text" value="<%=MktContactFax%>" class="InputBox" name="mktFax" maxlength=20></td>
	<th align="left">E-mail</th>
	<td><input type="text" value="<%=MktContactEmail%>" class="InputBox" name="mktEmail" maxlength=64></td>
	</tr>

	<tr>
	<th align="left" colspan=4>2 . Quality Assurance</th>
	</tr>

	<tr>
	<th align="left">Name</th>
	<td><input type="text" value="<%=QaContactName%>" class="InputBox" name="qaName" maxlength=64></td>
	<th align="left">Designation</th>
	<td><input type="text" value="<%=QaContactDesig%>" class="InputBox" name="qaDesig" maxlength=64></td>
	</tr>

	<tr>
	<th align="left">Phone1</th>
	<td><input type="text" value="<%=QaContactPhone1%>" class="InputBox" name="qaPhone1" maxlength=20></td>
	<th align="left">Phone2</th>
	<td><input type="text" value="<%=QaContactPhone2%>" class="InputBox" name="qaPhone2" maxlength=20></td>
	</tr>

	<tr>
	<th align="left">Fax</th>
	<td><input type="text" value="<%=QaContactFax%>" class="InputBox" name="qaFax" maxlength=20></td>
	<th align="left">E-mail</th>
	<td><input type="text" value="<%=QaContactEmail%>" class="InputBox" name="qaEmail" maxlength=64></td>
	</tr>

	<tr>
	<th align="left" colspan=2>Manufacturing Capacity</th>
	<td colspan=2><input type="text" value="<%=MfgCapacity%>" class="InputBox" name="mfgCapacity" maxlength=64></td>
	</tr>

	<tr>
	<th align="left" colspan=2>Total Capacity per Month</th>
	<td colspan=2><input type="text" value="<%=TotalCapacity%>" class="InputBox" name="totCapacity" maxlength=64></td>
	</tr>

	<tr>
	<th align="left" colspan=2>% of supply to NCP</th>
	<td colspan=2><input type="text" value="<%=PctgSupply%>" class="InputBox" name="perSupply" maxlength=10></td>
	</tr>

	<tr>
	<th align="left" colspan=2>Is the company a prime manufacturer ?</th>
	<td colspan=2><input type="radio" name=chk1 value="Y">Yes<input type="radio" name=chk1 value="N" checked>No</td>
	</tr>

	<tr>
	<th align="left" colspan=2>Name of other products manufactured</th>
	<td colspan=2><textarea rows=2 cols=35 style="overflow:auto" name="prodsManufactured"><%=prodsOffered%></textarea></td>
	</tr>


	<tr>
	<th align="left" colspan=2>Name of other major customers</th>
	<td colspan=2><textarea rows=2 cols=35 style="overflow:auto" name="majorCustomers"><%=customers%></textarea></td>
	</tr>

	<tr>
	<th align="left" colspan=2>Is the facility certified by<br>If, Yes provide a copy of Certification </th>
	<td colspan=2>GMP<input type="radio" name=chk23 onClick="showButton(1)" value="Y"> Yes <input type="radio" name=chk23 onClick="hideButton(1)" value="N" checked>No<div id="div1" style="visibility:hidden"><input type=text size="20" value="<%=gmpFile%>" name="n1" onPropertyChange="setServerFileName('GMP')" readonly><img src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" id="button1" style="cursor:hand" border=none onClick="commonFun(0)"></div>
	    <input type="hidden" name="serverFile" value="<%=gmpServerFile%>">
	    Other(specify)<input type="text" value="<%=Other%>" name="Other" maxlength=64 ></td>
	</tr>
	</table>

	<table align=center width=100% border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<tr>
	<th align="left" colspan=2>Personnel</th>
	</tr>

	<tr>
	<td align="left">Is training program conducted for personnel ?</td>
	<td><input type="radio" name=chk31 value="Y"> Yes <input type="radio" name=chk31 value="N" checked>No</td>
	</tr>

	<tr>
	<th align="left" colspan=2>Premises</th>
	</tr>

	<tr>
	<td align="left">Does the company have written procedures for house keeping ?</td>
	<td><input type="radio" name=chk32 value="Y"> Yes <input type="radio" name=chk32 value="N" checked>No</td>
	</tr>

	<tr>
	<th align="left" colspan=2>Equipment</th>
	</tr>

	<tr>
	<td align="left" colspan=2>Is the manufacturing equipment </td>
	</tr>

	<tr>
	<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Dedicated</td>
	<td><input type="radio" name=chk33 value="Y"> Yes <input type="radio" name=chk33 value="N" checked> No</td>
	</tr>

	<tr>
	<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Multi purpose type</td>
	<td><input type="radio" name=chk34 value="Y"> Yes <input type="radio" name=chk34 value="N" checked> No</td>
	</tr>

	<tr>
	<td align="left" colspan=2>Are written procedures available for </td>
	</tr>

	<tr>
	<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Maintenance of equipment</td>
	<td><input type="radio" name=chk35 value="Y"> Yes <input type="radio" name=chk35 value="N" checked>No</td>
	</tr>

	<tr>
	<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cleaning of equipment</td>
	<td><input type="radio" name=chk36 value="Y"> Yes <input type="radio" name=chk36 value="N" checked> No</td>
	</tr>

	<tr>
	<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Calibration of equipment and instruments</td>
	<td><input type="radio" name=chk37 value="Y"> Yes <input type="radio" name=chk37 value="N" checked> No</td>
	</tr>

	<tr>
	<td align="left">Are all the above mentioned activities being documented</td>
	<td><input type="radio" name=chk38 value="Y"> Yes <input type="radio" name=chk38 value="N" checked> No</td>
	</tr>

	<table align=center width=100% border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>

	<tr>
	      <th align="left" colspan=2>Manufacture</th>
	</tr>

	<tr>
	      <td align="left" width="80%">Are the materials supplied by the company, of
	        animal origin ?<br>
	(Furnish the TSE / BSE declaration certificate)</td>
	      <td width="20%">
	        <input type="radio" name=chk41 value="Y"> Yes <input type="radio" name=chk41 value="N" checked>No</td>
	</tr>

	<tr>
	      <td align="left" width="80%">Are the materials being manufatured along with
	        Cephalosporins/Pencillins ?</td>
	      <td width="20%">
	        <input type="radio" name=chk42 value="Y"> Yes <input type="radio" name=chk42 value="N" checked>No</td>
	</tr>

	<tr>
	      <td align="left" width="80%">Are there Standard Operating procedures for carrying
	        out Various activities related to the Production ?</td>
	      <td width="20%">
	        <input type="radio" name=chk43 value="Y"> Yes <input type="radio" name=chk43 value="N" checked> No</td>
	</tr>

	<tr>
	      <td align="left" width="80%">Is follow up action taken in case any abnormalities
	        are observed during the course of manufacture of any batch ?</td>
	      <td width="20%">
	        <input type="radio" name=chk44 value="Y"> Yes <input type="radio" name=chk44 value="N" checked> No</td>
	</tr>

	<tr>
	      <th align="left" colspan=2>Quality Control</th>
	</tr>

	<tr>
	      <td align="left" width="80%">Are there test procedures for the analysis of
	        the products of the company ?</td>
	      <td width="20%">
	        <input type="radio" name=chk45 value="Y"> Yes <input type="radio" name=chk45 value="N" checked> No</td>
	</tr>

	<tr>
	      <td align="left" width="80%">Are all the specifications and test procedures
	        documented ?</td>
	      <td width="20%">
	        <input type="radio" name=chk46 value="Y"> Yes <input type="radio" name=chk46 value="N" checked> No</td>
	</tr>

	<tr>
	      <td align="left" width="80%">Are there any statistical methods being employed
	        in the Sampling of the materials for the purpose of analysis ?</td>
	      <td width="20%">
	        <input type="radio" name=chk47 value="Y"> Yes <input type="radio" name=chk47 value="N" checked> No</td>
	</tr>

	<tr>
	    <th align="left" colspan=2>SHE Questionnaire</th>
	</tr>

	<tr>
	    <td align="left" width="80%">Has the company adopted ISO 14000/Responsible Care/Any
	      other voluntary environmental code ?</td>
	    <td width="20%">
	<input type="radio" name=chk51 value="Y"> Yes <input type="radio" name=chk51 value="N" checked>No</td>
	</tr>

	<tr>
	    <td align="left" colspan=2>Does the company have Environmental consents as per</td>
	</tr>

	<tr>
	    <td align="left" width="80%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Water Act</td>
	    <td width="20%">
	<input type="radio" name=chk52 value="Y"> Yes <input type="radio" name=chk52 value="N" checked> No</td>
	</tr>

	<tr>
	    <td align="left" width="80%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Air Act</td>
	    <td width="20%">
	<input type="radio" name=chk53 value="Y"> Yes <input type="radio" name=chk53 value="N" checked> No</td>
	</tr>

	<tr>
	    <td align="left" width="80%">Authorization as per the hazardous waste management ?</td>
	    <td width="20%">
	<input type="radio" name=chk54 value="Y"> Yes <input type="radio" name=chk54 value="N" checked> No</td>
	</tr>

	<tr>
	    <th align="left" colspan=2>Miscellaneous</th>
	</tr>

	<tr>
	    <td align="left" width="80%">Is the company prepared to provide the Test Methods
	      for the products supplied ?</td>
	    <td width="20%">
	<input type="radio" name=chk55 value="Y"> Yes <input type="radio" name=chk55 value="N" checked> No</td>
	</tr>

	<tr>
	    <td align="left" width="80%">Is the company prepared to provide the Certificate
	      of Analysis for the dispatched batches ?</td>
	    <td width="20%">
	<input type="radio" name=chk56 value="Y"> Yes <input type="radio" name=chk56 value="N" checked> No</td>
	</tr>

	<tr>
	    <td align="left" width="80%">Does the company have a SOP on complaints and does
	      it address the Corrective and Preventive actions ?</td>
	    <td width="20%">
	<input type="radio" name=chk57 value="Y"> Yes <input type="radio" name=chk57 value="N" checked> No</td>
	</tr>

	</table>
	</div>

	<div style="position:absolute;top:87%;width:100%" align="center">
	<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border=none onClick="javascript:history.go(-1)">	
	<img src="../../Images/Buttons/<%=ButtonDir%>/adddocuments.gif" style="cursor:hand" border=none onClick="funAttachFile()">
	<img src="../../Images/Buttons/<%=ButtonDir%>/update.gif" style="cursor:hand" border=none onClick="formEvents('../Materials/ezEditSaveVendorQuestionnaire.jsp')">
	<img src="../../Images/Buttons/<%=ButtonDir%>/annexure.gif" style="cursor:hand" border=none onClick="fun3()">
	</div>

<input type=hidden name="companyAddressId" value="<%=CompanyAddressId%>">
<input type=hidden name="materialId" value="<%=materialId%>">
<input type=hidden name="fileName" value="<%=fileName%>">
<input type=hidden name="serverLou" value="<%=serverLou%>">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
