<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Reports/iAddReport.jsp"%>
<%
	int sysRows = retsys.getRowCount();

%>
<html>
<head>
  <title>ezAddReport.htm</title>

  <meta http-equiv="content-type"
 content="text/html; charset=ISO-8859-1">
     <script src="../../Library/JavaScript/ezTrim.js"></script>
     <script src="../../Library/JavaScript/ezSelSelect.js"></script>
  <script>

        var MValues = new Array(); // this is text field mandactory check variable
        var MSelect = new Array();  // this is Select Box mandactory check variable

MValues[0] =new EzMList("reportName","Report Name");
MValues[1] =new EzMList("reportDesc","Report Description");

MSelect[0] = "system,Please select System";
/*MSelect[1] ="reportType,Please select Report Type";
MSelect[2] ="exeType,Please select Execution Type";
MSelect[3] ="visibility,Please select Visibility";
MSelect[4] ="status,Please select Status";*/


function EzMList(fldname,flddesc)
{
	this.fldname=fldname;
	this.flddesc=flddesc;
}
function ezMandactoryCheck()
{
       // this is for text field mandactory Check
       for(z=0;z<MValues.length;z++)
	{
		obj=eval("document.addForm."+MValues[z].fldname)
		if( funTrim(obj.value) == "")
		{
			obj.focus()
			alert("Please enter Values for "+MValues[z].flddesc);
			return false;
		}

	}

        // this is for Select box mandactory  check
	for(a=0;a<MSelect.length;a++)
	{
		if(selselect(MSelect[a])){}else{
			return false;
		}
	}
return true
}



function ezFormSubmit()
{
	ezForm=document.addForm
      if(ezMandactoryCheck())
      {
          ezForm.action="ezAddReportNext.jsp"
          ezForm.submit()
      }
}

function ezBack()
{
	//ezForm=document.addForm
	//ezForm.action="../Config/ezListSystems.jsp"
	//ezForm.submit()
	history.go(-1);
}

function setDesc(obj)
{
	pp1=obj.options[obj.selectedIndex].text
	document.addForm.sysDesc.value=pp1
}
function funFocus()
{
	if(document.addForm.system!=null)
		document.addForm.system.focus()
}
</script>
</head>
<body onLoad="funFocus()">

<form name="addForm">
<br>
  <Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
    		<Td class="displayheader">Add Report</Td>
  	</Tr>
</Table>
  <%
  if(sysRows >0)
  {
  %>
  <table width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
      <tbody>
                <tr>
            <th align="right" width="15%" align="left">System</th>
            <td align="left" width="35%"><input type="hidden" name="sysDesc">
        <select name="system" onChange="setDesc(this)" style="width:100%" id=FullListBox>
        <option value="">--Select System--</option>
       <%
         String aSysNo,system_desc="";
	 retsys.sort(new String[]{SYSTEM_NO_DESCRIPTION},true);
         for ( int i = 0 ; i < sysRows ; i++ )
	 {
		aSysNo = retsys.getFieldValueString(i,SYSTEM_NO);
		system_desc = (String)(retsys.getFieldValue(i,SYSTEM_NO_DESCRIPTION));
%>
	       	<option value=<%=aSysNo%> >
			<%=system_desc%> -> <%=aSysNo%>
	       	</option>
<%
	}
%>
        </select>
            </td>
	    <th align="right" width="15%">Domain</th>
          <td align="left" width="35%">
	  	<select name="reportDomain" style="width:100%" id=FullListBox>
			<option value="1">Sales</option>
			<option value="2">Vendor</option>
			<option value="3">Service</option>
			<option value="4">ReverseAuction</option>
		</Select>
	 </td>
          </tr>
        <tr>
	    <th align="right" width="15%">Name</th>
          <td align="left" width="35%"><input type="text" name="reportName" style="width:100%" class="InputBox"></td>
          <th align="right">Description</th>
          <td align="left"><input type="text" name="reportDesc" style="width:100%" class="InputBox"></td>

        </tr>
        <tr>
            <th align="right">Type</th>
            <td align="left">

        <select name="reportType" style="width:100%" id=FullListBox>
       <!--  <option value="">Select Type</option> -->
         <option value="2">Back End</option>
	 <option value="1">Local</option>
        </select>
            </td>
            <th align="right"><nobr>Execution Type</nobr></th>
            <td align="left">

        <select name="exeType" style="width:100%" id=FullListBox>
        <!--<option value="">Select Type</option> -->
	<option value="O">On-Line</option>
	<option value="B">Back Ground</option>
	<option value="A">Both</option>
        </select>
            </td>
          </tr>
        <tr>
            <th align="right">Visibility</th>
            <td align="left">

        <select name="visibility" style="width:100%"  id = "FullListBox">
        <!--<option value="">Select</option> -->
	<option value="A">All</option>
        <option value="I">Internal Users</option>
        <option value="B">Business users</option>

        </select>
             </td>
            <th align="right">Status</th>
            <td align="left">

        <select name="status" style="width:100%" id = "FullListBox">
        <!-- <option value="">Select</option> -->
        <option value="A">Active</option>
        <option value="I">In Active</option>
        </select>
            </td>
          </tr>

    </tbody>
  </table>
  <br>
    <table align="center" width="100%">
  <tbody>
       <tr>
  <td align="center" class="blankcell"><a href="JavaScript:ezFormSubmit()"><img src="../../Images/Buttons/<%= ButtonDir%>/continue.gif" alt="Continue" title="Continue" border="none"></a>&nbsp;<a href="JavaScript:ezBack()"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" alt="Back" title="Back" border="none"></a> </td>
  </tr>

    </tbody>
  </table>

  <%}else{%>
  <br><br><br><br>
	<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  		<Tr align="center">
    		<Th class="displayheader">There are No Systems.</Th>
  		</Tr>
	</Table>
	<br>
	<center>
	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</center>
  <%}%>
    </form>

</body>
</html>
