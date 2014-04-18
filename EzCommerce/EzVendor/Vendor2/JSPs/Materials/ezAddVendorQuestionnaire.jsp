<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@include file="../../../Includes/JSPs/Materials/iAddVendorQuestionnaire.jsp"%>

<html>

<head>
<title>Add Vendor Questionnaire</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script src="../../Library/JavaScript/ezTrim.js"></script>
<script src="../../Library/JavaScript/ezCheckFormFields.js"></script>
<script src="../../Library/JavaScript/ezCountriesAndStates.js"></script>
<script>
var newWindow4;
var attach;

function chkTab1()
{

   if(funTrim(document.myForm.materialDesc.value)=="")
   {
   	alert("Please enter Name of the Material")
   	document.myForm.materialDesc.focus()
   	return false;

   }
   return true;

}


function chkTab2()
{

   if(funTrim(document.myForm.mktEmail.value)!="")
   {
       if(!funEmail(document.myForm.mktEmail.value))
       {
            alert(msgString);
            document.myForm.mktEmail.focus()
            return false;
       }
   }

   if(funTrim(document.myForm.qaEmail.value)!="")
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

   if(document.myForm.chk23[0].checked && funTrim(document.myForm.n1.value)=="")
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
}


function fun3()
{
    newWindow4 = window.open("ezViewUndertaking.jsp","MyWin","center=yes,height=450,left=50,top=50,width=650,titlebar=no,status=no,resizable=no,scrollbars")
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
	 var obj = eval("document.myForm.button"+i)
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
   for(var e=1;e<2;e++)
   {
   		document.getElementById("div"+e).style.visibility="hidden"
   }
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

<%

   if(profileCount>0)
   {
%>

<body scroll=no onUnLoad="funUnLoad()">
<form name="myForm" method="post">

	<table align="center" width="40%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<tr>
	<td class="displayheader" align="center">Add Vendor Questionnaire</td>
	</tr>
	</table>


 <div id="totDiv" style="overflow:auto;position:absolute;top:9%;left:5%;width:92%;height:75%">
	<table align=center width=100% border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<tr>
	<th align="left" >Name of the Material</th>
	<td colspan=3><input size=50 type="text" class="InputBox" name="materialDesc" maxlength=70></td>
	</tr>

	<tr>
	<th align="left" colspan=4>Contact Person(s)</th>
	</tr>

	<tr>
	<th align="left" colspan=4>1 . Marketing Department</th>
	</tr>

	<tr>
	<th align="left">Name</th>
	<td><input type="text" class="InputBox" name="mktName" maxlength=64></td>
	<th align="left">Designation</th>
	<td><input type="text" class="InputBox" name="mktDesig" maxlength=64></td>
	</tr>

	<tr>
	<th align="left">Phone1</th>
	<td><input type="text" class="InputBox" name="mktPhone1" maxlength=20></td>
	<th align="left">Phone2</th>
	<td><input type="text" class="InputBox" name="mktPhone2" maxlength=20></td>
	</tr>

	<tr>
	<th align="left">Fax</th>
	<td><input type="text" class="InputBox" name="mktFax" maxlength=20></td>
	<th align="left">E-mail</th>
	<td><input type="text" class="InputBox" name="mktEmail" maxlength=64></td>
	</tr>

	<tr>
	<th align="left" colspan=4>2 . Quality Assurance</th>
	</tr>

	<tr>
	<th align="left">Name</th>
	<td><input type="text" class="InputBox" name="qaName" maxlength=64></td>
	<th align="left">Designation</th>
	<td ><input type="text" class="InputBox" name="qaDesig" maxlength=64></td>
	</tr>

	<tr>
	<th align="left">Phone1</th>
	<td><input type="text" class="InputBox" name="qaPhone1" maxlength=20></td>
	<th align="left">Phone2</th>
	<td><input type="text" class="InputBox" name="qaPhone2" maxlength=20></td>
	</tr>

	<tr>
	<th align="left">Fax</th>
	<td><input type="text" class="InputBox" name="qaFax" maxlength=20></td>
	<th align="left">E-mail</th>
	<td><input type="text" class="InputBox" name="qaEmail" maxlength=64></td>
	</tr>

	<tr>
	<th align="left" colspan=2>Manufacturing Capacity</th>
	<td colspan=2><input type="text" class="InputBox" name="mfgCapacity" maxlength=64></td>
	</tr>

	<tr>
	<th align="left" colspan=2>Total Capacity per Month</th>
	<td colspan=2><input type="text" class="InputBox" name="totCapacity" maxlength=64></td>
	</tr>

	<tr>
	<th align="left" colspan=2>% of supply to NCP</th>
	<td colspan=2><input type="text" class="InputBox" name="perSupply" maxlength=10></td>
	</tr>

	<tr>
	<th align="left" colspan=2>Is the company a prime manufacturer ?</th>
	<td colspan=2><input type="radio" name=chk1 value="Y"> Yes <input type="radio" name=chk1 value="N" checked> No</td>
	</tr>

	<tr>
	<th align="left" colspan=2>Name of other products manufactured</th>
	<td colspan=2><textarea rows=2 cols=35 style="overflow:auto" name="prodsManufactured"></textarea></td>
	</tr>


	<tr>
	<th align="left" colspan=2>Name of other major customers</th>
	<td colspan=2><textarea rows=2 cols=35 style="overflow:auto" name="majorCustomers"></textarea></td>
	</tr>

	<tr>
	<th align="left" colspan=2>Is the facility certified?<br>If Yes, please provide a copy of Certification </th>
	<td colspan=2>
	    GMP<input type="radio" name=chk23 onClick="showButton(1)" value="Y"> Yes <input type="radio" name=chk23 onClick="hideButton(1)" value="N" checked>No<div id=div1 style="visibility:hidden"><input type=text size="20" value="" name="n1" readonly><img src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" id="button1" style="cursor:hand" border=none onClick="commonFun(1)"></div>
	    Other(specify)<input type="text" name="Other" maxlength=64></td>
	</tr>
	</table>

	<table align=center width=100% border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<tr>
	<th align="left" colspan=4>Personnel</th>
	</tr>

	<tr>
	<td align="left">Is training program conducted for personnel ?</td>
	<td><input type="radio" name=chk31 value="Y"> Yes <input type="radio" name=chk31 value="N" checked>No</td>
	</tr>

	<tr>
	<th align="left" colspan=4>Premises</th>
	</tr>

	<tr>
	<td align="left">Does the company have written procedures for house keeping ?</td>
	<td><input type="radio" name=chk32 value="Y"> Yes <input type="radio" name=chk32 value="N" checked>No</td>
	</tr>

	<tr>
	<th align="left" colspan=4>Equipment</th>
	</tr>

	<tr>
	<td align="left" colspan=4>Is the manufacturing equipment </td>
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
	<td align="left" colspan=4>Are written procedures available for </td>
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
	
	<tr>
	<th align="left" colspan=4>Manufacture</th>
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
	      <th align="left" colspan=4>Quality Control</th>
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
        <th align="left" colspan=4>SHE Questionnaire</th>
	</tr>

	<tr>
	    <td align="left" width="80%">Has the company adopted ISO 14000/Responsible Care/Any
	      other voluntary environmental code ?</td>
	    <td width="20%">
	<input type="radio" name=chk51 value="Y"> Yes <input type="radio" name=chk51 value="N" checked>No</td>
	</tr>

	<tr>
	    <td align="left" colspan=4>Does the company have Environmental consents as per</td>
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
	    <th align="left" colspan=4>Miscellaneous</th>
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
	<img src="../../Images/Buttons/<%=ButtonDir%>/submit.gif" style="cursor:hand" border=none onClick="formEvents('ezAddSaveVendorQuestionnaire.jsp')">
	<img src="../../Images/Buttons/<%=ButtonDir%>/annexure.gif" style="cursor:hand" border=none onClick="fun3()">
	</div>

<input type="hidden" name="fileName" value="">
<input type="hidden" name="serverLou" value="">
</form>
</body>
<%  }else{  %>
<body>
<form name="myForm">
	<br><br><br><br>
	<table align=center width=60% border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>

	<tr>
	    <th>Please Add Your Company's Information by selecting 'Vendor Profile' Option from the SelfService Menu or Click 'Add' button bellow.</th>
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
</html>
