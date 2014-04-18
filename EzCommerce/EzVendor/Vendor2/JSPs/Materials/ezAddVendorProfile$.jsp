<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ include file="../../../Includes/JSPs/Materials/iGetVendorProfile.jsp"%>

<html>
<head>
<style>
.menu{
	font-family: "Verdana";
	font-size: 11px;
	font-style: normal;
	color: #000000;
	}

	.labelcell{}
	td.labelcell{
		font-family: "Arial";
		font-size: 9pt;
		font-style: normal;
		color: WHITE;
		background-color:"#336699"
}
</style>

<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%
	ButtonDir = "ENGLISH/MAROON";
%>
<%@ include file="../../../Includes/JSPs/Materials/iTopTabScript.jsp"%>

<script src="../../Library/JavaScript/ezTrim.js"></script>
<script src="../../Library/JavaScript/ezCheckFormFields.js"></script>
<script src="../../Library/JavaScript/ezCountriesAndStates.js"></script>

<script>

	var uploadWindow
	function openUploadWindow()
	{
	    uploadWindow = window.open("ezAttachProfileFiles.jsp","UserWindow","width=400,height=500,left=100,top=100,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no");
	}

	function funUnLoad()
	{
		if(uploadWindow!=null && uploadWindow.open)
		{
		   uploadWindow.close();
		}
	}


   function funUrl(xvalue)
   {
   	if(xvalue.lastIndexOf('.')<1)
	{
	    msgString = "Url should be of the form xyz.com"
	    return false;
	}

	var ct = xvalue.substring(xvalue.lastIndexOf('.')+1,xvalue.length).length
   	if(ct<2)
        {
	    msgString = "Url should be of the form xyz.com"
	    return false;
        }
 	return true;

   }

   function setDefaults()
   {
   	<%
   	   if(count>0)
   	   {
   	%>

   		for(i=0;i<document.myForm.man1state.options.length;i++)
		{
		   if(document.myForm.man1state.options[i].value=='<%=man1state%>')
		   {
		    	document.myForm.man1state.selectedIndex=i;
		   }
   		}
   		for(i=0;i<document.myForm.man1country.options.length;i++)
		{
		   if(document.myForm.man1country.options[i].value=='<%=man1country%>')
		   {
		    	document.myForm.man1country.selectedIndex=i;
		   }
   		}
   		for(i=0;i<document.myForm.man2state.options.length;i++)
		{
		   if(document.myForm.man2state.options[i].value=='<%=man2state%>')
		   {
		    	document.myForm.man2state.selectedIndex=i;
		   }
		}
		for(i=0;i<document.myForm.man2country.options.length;i++)
		{
		   if(document.myForm.man2country.options[i].value=='<%=man2country%>')
		   {
		    	document.myForm.man2country.selectedIndex=i;
		   }
   		}
   		for(i=0;i<document.myForm.man3state.options.length;i++)
		{
		   if(document.myForm.man3state.options[i].value=='<%=man3state%>')
		   {
		    	document.myForm.man3state.selectedIndex=i;
		   }
		}
		for(i=0;i<document.myForm.man3country.options.length;i++)
		{
		   if(document.myForm.man3country.options[i].value=='<%=man3country%>')
		   {
		    	document.myForm.man3country.selectedIndex=i;
		   }
   		}

   	<%
   	   }
   	 %>


   }

   function funCheck(n)
   {

   	document.myForm.action="ezAddSaveVendorProfile.jsp"
	document.myForm.submit()
	}

   function showDiv(n)
   {
          for(var i=1;i<=4;i++)
	  {
	  	if(i==n)
		{
                   document.getElementById("tab"+i).style.visibility="visible"
				   document.getElementById("tab"+i+"color").style.color="#000000"
		}
		else
		{
			document.getElementById("tab"+i).style.visibility="hidden"
			document.getElementById("tab"+i+"color").style.color="#ffffff"
		}
	}
	tabfun(n)
   }
   function ezHref(param)
   {
   	document.myForm.action=param;
   	document.myForm.submit();
   }
   function showDiv_new(currentTab,totalTabs)
   {
     	  for(var i=1;i<=totalTabs;i++)
     	  {
     		if(i==currentTab)
     		{
     			document.getElementById("tab"+i).style.visibility="visible"
     			document.getElementById("tab"+i).style.width="100%"
     			document.getElementById("tab"+i+"color").style.color="MAROON"
   		   
     			document.getElementById("tab"+i+"_3").src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/new_tabs/ImgLftUp.gif"
     			document.getElementById("tab"+i+"_2").src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/new_tabs/ImgRgtUp.gif"
     			document.getElementById("tab"+i+"_1").style.background="url('../../Images/Buttons/<%=ButtonDir%>/Inbox_files/new_tabs/ImgCtrUp.gif')"
   		   			
     		}
     		else
     		{
     			document.getElementById("tab"+i).style.visibility="hidden"
     			document.getElementById("tab"+i+"color").style.color="#B7B7B7"
   		   
     			document.getElementById("tab"+i+"_3").src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/new_tabs/ImgLftDn.gif"
     			document.getElementById("tab"+i+"_2").src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/new_tabs/ImgRgtDn.gif"
     			document.getElementById("tab"+i+"_1").style.background="url('../../Images/Buttons/<%=ButtonDir%>/Inbox_files/new_tabs/ImgCtrDn.gif')"
     			document.getElementById("tab"+i).style.width="0%"
     		}
     	  }
   		   
   }
</script>
</head>

<body topmargin=0 rightmargin=0 leftmargin=0 onLoad="showDiv('1');setDefaults()" scroll="no">
<form name="myForm" method="post">
<% String display_header ="Vendor Profile";%>
<!-- <table align="center" width="40%" border=1 borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>

	<tr>
	<td class="displayheader" align="center">Vendor Profile</td>
	</tr>
	</table>  -->
	<%@ include file="../Misc/ezDisplayHeader.jsp" %>

 <div id="totDiv" style="position:absolute;top:6%;width:100%;height:100%">

 <Table align=center border=0 cellPadding=0 cellSpacing=0  width="94%" >
 <TBODY>
 <Tr>
 <Td>
  	<Table cellSpacing=0 cellPadding=0 width=100% border=0>
	<TBODY>
	<Tr>
	<Td vAlign=bottom height=45 width=100%  class=blankcell>
	<Table cellSpacing=0 cellPadding=0 border=0 >
	<TBODY>
	<Tr>
												
		<Td class=blankcell width=10 ><IMG name=startBack height=27 src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_front_left.gif" width=15 border=0></Td>

		<Td class=blankcell id="tab1_1" style="cursor:hand" background="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_fill_front.gif" onClick="showDiv('1')"><font id='tab1color' color=#000000>Company Details</font></Td>
		<Td class=blankcell width=10><IMG name="tab1_2" height=27 src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_front_right.gif" width=15  border=0></Td>
		<Td class=blankcell width=10><IMG name="tab1_3" height=27 src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back1_left.gif" width=15 border=0></Td>

		<Td class=blankcell id="tab2_1" style="cursor:hand" background="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_fill_back.gif" onClick="showDiv('2')"><font id='tab2color' color=#ffffff>Trade Details</font></Td>
		<Td class=blankcell width=10><IMG name="tab2_2" height=27 src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back_right.gif" width=15 border=0></Td>
		<Td class=blankcell width=10 ><IMG name="tab2_3" height=27  src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back2_left.gif" width=15 border=0></Td>

		<Td class=blankcell id="tab3_1" style="cursor:hand" background="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_fill_back.gif" onClick="showDiv('3')"><font  id='tab3color' color=#ffffff>Manufacturing Sites</font></Td>
		<Td class=blankcell width=10><IMG name="tab3_2" height=27 src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back_right.gif" width=15 border=0></Td>
		<Td class=blankcell width=10 ><IMG name="tab3_3" height=27  src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back2_left.gif" width=15 border=0></Td>

		<Td class=blankcell id="tab4_1" style="cursor:hand" background="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_fill_back.gif" onClick="showDiv('4')"><font id='tab4color' color=#ffffff>Other Details</font></td>
		<Td class=blankcell width=10><IMG name="tab4_2" height=27 src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back_right.gif" width=15 border=0></Td>
		<Td class=blankcell width=12><IMG name="tab4_3" height=27 src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back_end.gif" width=12 border=0></Td>
		</Tr>
		<Tr>
		<!--<%
			java.util.Hashtable tabHash = new java.util.Hashtable();
			tabHash.put("TAB1","Corporate Details");
			tabHash.put("TAB2","Trade Details");
			tabHash.put("TAB3","Manufacturing Sites");
			tabHash.put("TAB4","Company Details");
			for(int i=1;i<=4;i++)
			{
			%>
				<Td width=5 class='blankcell'><IMG id="tab<%=i%>_3" height=27 src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/new_tabs/ImgLftUp.gif" width=5 border=0></Td>
				<Td id="tab<%=i%>_1" style="cursor:hand" style="background-image:url('../../Images/Buttons/<%=ButtonDir%>/Inbox_files/new_tabs/ImgCtrUp.gif')" onClick="showDiv_new('<%=i%>',4)"><font id='tab<%=i%>color'><b>&nbsp;&nbsp;&nbsp;&nbsp;<%=(String)tabHash.get("TAB"+i)%>&nbsp;&nbsp;&nbsp;</b></font></Td>
				<Td width=10 class='blankcell'><IMG id="tab<%=i%>_2" height=27 src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/new_tabs/ImgRgtUp.gif" width=10  border=0></Td>
		      <%}%>
		</Tr> -->
	</TBODY>
	</Table>
	</Td>
	<Td class=blankcell vAlign=center align=right height=45>&nbsp; </Td>
	</Tr>
	</TBODY>
	</Table>
  </Td>
  </Tr>
</Table>




<div id="tab1" style="position:absolute;height:86%;width:100%;visibility:hidden">

<div align=center style="overflow:auto;position:absolute;height:82%;width:96%;left:3%;top:0%">
<table align=left width=99% border=0 borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<tr><td class="blankcell">
	  <table align=center border=1 borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="100%">

	<Tr>
		<th width="20%" align="left">Company Name </th>
        	<td width="80%" colspan = 3>
        	<input type="hidden" name="companyname" value="<%=companyName%>">	<%=companyName%>
		<!--<input type="text"  class="InputBox" name="companyname" value="<%//companyName%>" maxlength="64" read>-->
		</td></Tr>

	<tr>
	<th width="20%" align="left">Address1 </th>
        <td width="31%"><%=address1%>&nbsp;</td>
	<th width="14%" align="left">Contact Person </th>
	<td width="35%">
	<input type="text"  class="InputBox" name="contperson" value="<%=contactPerson%>" maxlength="64"></td>
	</tr>

	<Tr>
	<th width="14%" align="left">Address2 </th>
        <td width="35%"><%=address2%>&nbsp;</td>
	<th width="20%" align="left">Designation </th>
        <td width="31%">
	<input type="text"  class="InputBox" name="desig" value="<%=designation%>" maxlength="64"></td>
	</Tr>
	<Tr>
	<th width="20%" align="left">City</th>
	<td width="31%"><%=city%>&nbsp;</td>
	<th width="20%" align="left"> Phone1 </th>
        <td width="31%">
	<input type="text"  class="InputBox" size=20 name="phone1" value="<%=phone1%>" maxlength="20">  </td>
	</Tr>
	<Tr>
	<th width="14%" align="left">Zip </th>
        <td width="35%"><%=zipcode%>&nbsp;</td>
	<th width="14%" align="left">Phone2 </th>
        <td width="35%">
	<input type="text"  class="InputBox" size=20 name="phone2" value="<%=phone2%>" maxlength="20"></td>
	</tr>
	<tr>
	<th width="20%" align="left">State</th>
	<td width="31%"><%=state%>&nbsp;</td>
	<th width="20%" align="left"> Fax </th>
        <td width="31%">
	<input type="text"  class="InputBox" size=20 name="fax" maxlength="20" value="<%=fax%>"></td>
	</Tr>
	<Tr>
	<th width="14%" align="left">Country </th>
	<td width="35%"><%=country%>&nbsp;</td>
	<th width="14%" align="left">E-Mail </th>
        <td width="35%">
	<input type="text"  class="InputBox" name="email" value="<%=email%>" maxlength="64"></td>
	</tr>
   </table>
      </td>
    </tr>
    <Tr>
    <Td class="blankcell">* If you want to change the Company Address, Click on <a href="../Misc/ezGetInfo.jsp">Change Address</a> .</Td>
    </Tr>
</table>

	</div>

<div align=center style="position:absolute;top:82%;width:100%">
<!--<a href="../Misc/ezSBUWelcome.jsp" target="display"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border="none"></a>
<img src="../../Images/Buttons/<%=ButtonDir%>/adddocuments.gif" style="cursor:hand" border="none" valign=bottom onClick="openUploadWindow()">-->
<%
		
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Back");
		buttonMethod.add("ezHref(\"../Misc/ezSBUWelcome.jsp\")");
		
		buttonName.add("Add Documents");
		buttonMethod.add("openUploadWindow()");
		
%>
<% if(editPage.equals("N"))
   {
%>
	<!-- <img src="../../Images/Buttons/<%=ButtonDir%>/submit.gif"  border="none" valign=bottom onClick="funCheck(1)" style="cursor:hand"> -->
	<% buttonName.add("Submit");
	   buttonMethod.add("funCheck(1)"); %>
<% }else{ %>
	<!-- <img src="../../Images/Buttons/<%=ButtonDir%>/update.gif"  border="none" valign=bottom onClick="funCheck(1)" style="cursor:hand"> -->
	<% buttonName.add("Update");
	   buttonMethod.add("funCheck(1)"); %>
<% }out.println(getButtonStr(buttonName,buttonMethod)); %>

</div>
</div>

<div id="tab2" style="position:absolute;height:86%;width:100%;visibility:hidden">

<div align=center style="overflow:auto;position:absolute;height:82%;width:96%;left:3%">
<table align=left width=99% border=0 borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<tr><td class="blankcell">

	    <table align=center border=1 borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="100%">

            <tr>

            <th width="35%" align="left">Sales Tax Regn. No </th>

            <td width="65%">
              <input type="text"  class="InputBox" name="SalestaxNo"  size="64" maxlength="64" value="<%=salestax%>">
				</td>
		    </tr>
 	    <tr>

            <th width="35%" align="left">Central Excise Regn. No </th>

            <td width="65%">
              <input type="text"  class="InputBox" name="CentralExciseNo"  id="fuser"  size="64" maxlength="64" value="<%=cexcise%>">
					 					 		</td>
				     </tr>

				     <tr>

            <th width="35%" align="left">Drug License No </th>

            <td  width="65%">
              <input type="text"  class="InputBox" name="LicenseNo"  size="64" maxlength="64" value="<%=druglic%>">
					 					 		</td>
				     </tr>
				     <tr>

            <th width="35%" align="left">DMF No </th>

            <td width="65%">
              <input type="text"  class="InputBox" name="DMFNo"  size="64" maxlength="64" value="<%=dmfno%>">
					 					 		</td>
				     </tr>
				     <tr>

            <th width="35%" align="left">Total Production Capacity </th>

            <td width="65%">
              <input type="text"  class="InputBox" name="prodCapacity"  size="64" maxlength="64" value="<%=prodCapacity%>">
	    </td>
	   </tr>
	   <tr>

            <th width="35%" align="left">TurnOver - Domestic/Exports</th>

            <td  width="65%" class="">
              <input type="text"  class="InputBox" name="TurnOver"  id="fuser"  size="64" maxlength="64" value="<%=turnOver%>">
					 					 		</td>
				     </tr>
</table>
</td></tr>
</table>
</div>

<div align=center style="position:absolute;top:82%;width:100%">
<!-- <a href="../Misc/ezSBUWelcome.jsp" target="display"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border="none"></a>
<img src="../../Images/Buttons/<%=ButtonDir%>/adddocuments.gif" style="cursor:hand" border="none" valign=bottom onClick="openUploadWindow()"> -->
<%
		
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Back");
		buttonMethod.add("ezHref(\"../Misc/ezSBUWelcome.jsp\")");
		
		buttonName.add("Add Documents");
		buttonMethod.add("openUploadWindow()");
		
%>
<% if(editPage.equals("N"))
   {
%>
	<!-- <img src="../../Images/Buttons/<%=ButtonDir%>/submit.gif"  border="none" valign=bottom onClick="funCheck(2)" style="cursor:hand"> -->
	<% buttonName.add("Submit");
	   buttonMethod.add("funCheck(2)"); %>
<% }else{ %>
	<!-- <img src="../../Images/Buttons/<%=ButtonDir%>/update.gif"  border="none" valign=bottom onClick="funCheck(2)" style="cursor:hand">-->
	<% buttonName.add("Update");
	   buttonMethod.add("funCheck(2)"); %>
<% }out.println(getButtonStr(buttonName,buttonMethod)); %>

</div>

</div>



<div id="tab3" style="overflow:auto;position:absolute;height:86%;width:100%;visibility:hidden">
<div align=center style="overflow:auto;position:absolute;height:82%;width:96%;left:3%">
<table align=left width=99% border=0 borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<tr><td class="blankcell">

	   <table align=center border=1 borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="100%">
	   <tr>
	   <Th>&nbsp;</Th>
	   <Th>Manufacturing Site - I </Th>
	   <Th>Manufacturing Site - 2</Th>
	   <Th>Manufacturing Site - 3</Th>
	   </tr>
	   <Tr>
	   <th align="left">Address1 </th>
	   <td><input type="text"  class="InputBox" name="man1add1" value="<%=man1address1%>" maxlength="64" tabindex=1></td>
	   <td><input type="text"  class="InputBox" name="man2add1" value="<%=man2address1%>" maxlength="64" tabindex=10></td>
	   <td><input type="text"  class="InputBox" name="man3add1" value="<%=man3address1%>" maxlength="64" tabindex=19> </td>
	   </Tr>
	   <Tr>
	   <th align="left">Address2 </th>
	   <td><input type="text"  class="InputBox" name="man1add2" value="<%=man1address2%>" maxlength="64" tabindex=2></td>
	   <td><input type="text"  class="InputBox" name="man2add2" value="<%=man2address2%>" maxlength="64" tabindex=11></td>
	   <td><input type="text"  class="InputBox" name="man3add2" value="<%=man3address2%>" maxlength="64" tabindex=20></td>
	   </tr>
	   <tr>
	   <th align="left">City </th>
	   <td><input type="text"  class="InputBox" name="man1city" value="<%=man1city%>" maxlength="30" tabindex=3></td>
	   <td><input type="text"  class="InputBox" name="man2city" value="<%=man2city%>" maxlength="64" tabindex=12></td>
	   <td><input type="text"  class="InputBox" value="<%=man3city%>" name="man3city" maxlength="30" tabindex=21></td>
	   </Tr>
	   <Tr>
	   <th align="left">Zip </th>
	   <td><input type="text"  class="InputBox" name="man1zip" value="<%=man1zipcode%>" maxlength="6" tabindex=4></td>
	   <td><input type="text"  class="InputBox" name="man2zip" value="<%=man2zipcode%>" maxlength="6" tabindex=13></td>
	   <td><input type="text"  class="InputBox" name="man3zip" value="<%=man3zipcode%>" maxlength="6" tabindex=22></td>
	   </Tr>
	   <Tr>
	   <Th align="left">Country </th>
	   <td><SELECT NAME="man1country" onChange="getStates(this,'document.myForm.man1state')" tabindex=5>
	   <option value="">---Select---</option>
	   <script>
	   for(var i=0;i<CountryArr.length;i++)
	   {
	   	document.write("<option value="+CountryArr[i].key+">"+CountryArr[i].value+"</option>");
	   }
	   </script>
          </SELECT></td>
	  <td>
	   	   <SELECT NAME="man2country" onChange="getStates(this,'document.myForm.man2state')" tabindex=14>
	   	   <option value="">---Select---</option>
		   <script>

		   for(var i=0;i<CountryArr.length;i++)
		   {
		   		document.write("<option value="+CountryArr[i].key+">"+CountryArr[i].value+"</option>");
		   }
		   </script>
	  </SELECT></td>
	  <td><SELECT NAME="man3country" onChange="getStates(this,'document.myForm.man3state')" tabindex=23>
	  <OPTION VALUE="" >- Select -</option>
	<script>
	for(var i=0;i<CountryArr.length;i++)
	{
		document.write("<option value="+CountryArr[i].key+">"+CountryArr[i].value+"</option>");
	}
	</script>
	</SELECT></td>
	</Tr>
	<Tr>
     	<th align="left">State </th>
	<td><SELECT NAME="man1state" tabindex=6>
	<OPTION VALUE="" >--- Select---</option>
        <script>
		getPreStates('<%=man1country%>','document.myForm.man1state','<%=man1state%>')
	 </script>
	 </SELECT></td>
	<td><SELECT NAME="man2state" tabindex=15>
	<OPTION VALUE="" >- Select -</option>
	<script>
		getPreStates('<%=man2country%>','document.myForm.man2state','<%=man2state%>')
	</script>
	</SELECT></td>
	<td><SELECT name="man3state" tabindex=24>
	<OPTION VALUE="" >- Select -</option>
	<script>
		getPreStates('<%=man3country%>','document.myForm.man3state','<%=man3state%>')
	</script>
	</SELECT></td>
	</tr>
	 <tr>
	 <th align="left"> Phone1 </th>
	 <td>	<input type="text"  class="InputBox" size=20 name="man1phone1" value="<%=man1phone1%>" maxlength="20" tabindex=7></td>
	 <td><input type="text"  class="InputBox" size=20 name="man2phone1" value="<%=man2phone1%>" maxlength="20" tabindex=16></td>
	 <td><input type="text"  class="InputBox" size=20 name="man3phone1" value="<%=man3phone1%>" maxlength="20" tabindex=25></td>
	</Tr>
	<Tr>
	<th align="left">Phone2 </th>
	<td>	<input type="text"  class="InputBox" size=20 name="man1phone2" value="<%=man1phone2%>" maxlength="20" tabindex=8></td>
	<td><input type="text"  class="InputBox" size=20 name="man2phone2" value="<%=man2phone2%>" maxlength="20" tabindex=17></td>
	<td><input type="text"  class="InputBox" size=20 name="man3phone2" value="<%=man3phone2%>" maxlength="20" tabindex=26></td>
	</Tr>
 	<Tr>
	<th align="left">Fax </th>
	<td><input type="text"  class="InputBox" size=20 name="man1fax" value="<%=man1fax%>" maxlength="20" tabindex=9></td>
	<td><input type="text"  class="InputBox" size=20 name="man2fax" value="<%=man2fax%>" maxlength="20" tabindex=18></td>
	<td><input type="text"  class="InputBox" size=20 name="man3fax" value="<%=man3fax%>" maxlength="20" tabindex=27></td>
	</Tr>
</Table>
</td></tr>
</table>
</div>

<div align=center style="position:absolute;top:82%;width:100%">
<!-- <a href="../Misc/ezSBUWelcome.jsp" target="display"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border="none" style="cursor:hand"></a>
<img src="../../Images/Buttons/<%=ButtonDir%>/adddocuments.gif" style="cursor:hand" border="none" valign=bottom onClick="openUploadWindow()"> -->
<%
		
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Back");
		buttonMethod.add("ezHref(\"../Misc/ezSBUWelcome.jsp\")");
		
		buttonName.add("Add Documents");
		buttonMethod.add("openUploadWindow()");
		
%>
<% if(editPage.equals("N"))
   {
%>
	<!-- <img src="../../Images/Buttons/<%=ButtonDir%>/submit.gif"  border="none" valign=bottom onClick="funCheck(3)" style="cursor:hand"> -->
	<% buttonName.add("Submit");
	   buttonMethod.add("funCheck(3)"); %>
<% }else{ %>
	<!-- <img src="../../Images/Buttons/<%=ButtonDir%>/update.gif"  border="none" valign=bottom onClick="funCheck(3)" style="cursor:hand"> -->
	<% buttonName.add("Update");
	   buttonMethod.add("funCheck(3)"); %>
<% }out.println(getButtonStr(buttonName,buttonMethod)); %>
 </div>
</div>

<div id="tab4" style="overflow:auto;position:absolute;height:86%;width:100%;visibility:hidden">
<div align=center style="overflow:auto;position:absolute;height:82%;width:96%;left:3%">
<table align=left width=99% border=0 borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<tr><td class="blankcell">

 <table align=center border=1 borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="100%">
		<tr>
	    <th width="35%"align="left">Organogram </th>
	     <td width="65%" align=left>
              <textarea  name="organogram" class=inputbox rows="2" style="width:100%;overflow:auto"><%=organogram%></textarea>
	</td></tr>
	</tr>
	<tr>
           <th width="35%" align="left">
              Details of the Company </th>

            <td width="65%" align="left">
            <textarea  name="companyDetails" class=inputbox rows="2" style="width:100%;overflow:auto"><%=companyDetails%></textarea>
	 </td>
	</tr>
	<tr>

            <th width="35%" align="left">Banker Details </th>

            <td height="35" width="65%">
              <textarea  name="BankerDetails" class=inputbox style="width:100%;overflow:auto" rows="2"><%=bankerDetails%></textarea>

							 				              </td>
						     </tr>
            <tr>

            <th width="35%" align=left>Products Offered </th>
            <td height="35" width="65%"> <textarea   class=inputbox style="width:100%;overflow:auto" name="Products" rows="2"><%=prodsOffered%></textarea></td>
		</tr>
		<tr>

           <th width="35%" align=left>New Developments </th>

            <td height="35" width="65%">
              <textarea  name="Developments" class=inputbox style="width:100%;overflow:auto" rows="2"><%=newDevelopments%></textarea>
							 		</td>
     </tr>
     </table>
</td></tr>
</table>
</div>

<div align=center style="position:absolute;top:82%;width:100%">
<!-- <a href="../Misc/ezSBUWelcome.jsp" target="display"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border="none"></a>
<img src="../../Images/Buttons/<%=ButtonDir%>/adddocuments.gif" style="cursor:hand" border="none" valign=bottom onClick="openUploadWindow()"> -->
<%
		
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Back");
		buttonMethod.add("ezHref(\"../Misc/ezSBUWelcome.jsp\")");
		
		buttonName.add("Add Documents");
		buttonMethod.add("openUploadWindow()");
		
%>
<% if(editPage.equals("N"))
   {
%>
	<!-- <img src="../../Images/Buttons/<%=ButtonDir%>/submit.gif"  border="none" valign=bottom onClick="funCheck(4)" style="cursor:hand"> -->
	<% buttonName.add("Submit");
	   buttonMethod.add("funCheck(4)"); %>
<% }else{ %>
	<!-- <img src="../../Images/Buttons/<%=ButtonDir%>/update.gif"  border="none" valign=bottom onClick="funCheck(4)" style="cursor:hand"> -->
	<% buttonName.add("Update");
	   buttonMethod.add("funCheck(4)"); %>
<% }out.println(getButtonStr(buttonName,buttonMethod)); %>
 </div>
</div>
</div>



<input type="hidden" name="SysKey" value="<%=sysKey%>">
<input type="hidden" name="SoldTo" value="<%=soldTo%>">

<input type="hidden" name="fileName" value="<%=fileName%>">
<input type="hidden" name="serverFda" value="<%=serverFda%>">
<input type="hidden" name="serverMfgLic" value="<%=serverMfgLic%>">
<input type="hidden" name="serverIso" value="<%=serverIso%>">
<input type="hidden" name="serverWho" value="<%=serverWho%>">

<input type="hidden" name="ManAddress1Id" value="<%=manAddress1Id%>">
<input type="hidden" name="ManAddress2Id" value="<%=manAddress2Id%>">
<input type="hidden" name="ManAddress3Id" value="<%=manAddress3Id%>">

<input type="hidden" name="editPage" value="<%=editPage%>">

</form>
<Div id="MenuSol"></Div>
</body>
</html>
