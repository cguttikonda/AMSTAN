<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>

<html>
<head>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<Script>
function funFocus()
{
	if(document.myForm.SysNum!=null)	
	{
		document.myForm.SysNum.focus()
	}
}
</Script>
<script src="../../Library/JavaScript/CParam/ezDeleteConnectParam.js">
</script>

<%!
// Start Declarations

final String SYSTEM_NO = "ESD_SYS_NO";
final String SYSTEM_NO_DESC_LANGUAGE = "ESD_LANG";
final String SYSTEM_NO_DESCRIPTION = "ESD_SYS_DESC";

//End Declarations
%>

<%
// Key Variables
ReturnObjFromRetrieve retsys = null;
ReturnObjFromRetrieve retgrp = null;

// System Configuration Class
String grp_id = null;
String sys_num = null;
int numGrps = 0;

// Get List Of Systems
			EzcSysConfigParams sparams = new EzcSysConfigParams();
			EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
			snkparams.setLanguage("EN");
			sparams.setObject(snkparams);
			Session.prepareParams(sparams);
			retsys = (ReturnObjFromRetrieve)sysManager.getSystemDesc(sparams);
			retsys.check();

//Get List of Systems
int numSystem = retsys.getRowCount();

if(numSystem > 0){
	sys_num = request.getParameter("SystemNumber");

   if(sys_num!=null && !sys_num.equals("sel"))
   {

		// Get List Of Groups for a System
			EzcSysConfigParams sparams1 = new EzcSysConfigParams();
			EzcSysConfigNKParams snkparams1 = new EzcSysConfigNKParams();
			snkparams1.setLanguage("EN");
			snkparams1.setSystemNumber(sys_num);
			sparams1.setObject(snkparams1);
			Session.prepareParams(sparams1);
			retgrp = (ReturnObjFromRetrieve)sysManager.getUserGroups(sparams1);
			retgrp.check();


			//Number of groups
			numGrps = retgrp.getRowCount();

			if(numGrps > 0){
				grp_id = request.getParameter("GrpID");
				if(grp_id == null){
					grp_id = (retgrp.getFieldValue(0,"EUG_ID")).toString();
			}
		}//end if
	}
	}//end if
%>

<Title>SAP Connection Parameters</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>

<body onLoad="funFocus()">
<form name=myForm method=post action="ezDeleteSaveConnectParam.jsp">

<%
if(numSystem > 0){
%>

<br>


  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="50%">
    <Tr>
      <Td width="25%" nowrap class="labelcell">
        <div align="right">ERP System:</div>
      </Td>
      <Td width="75%">
<%
		int sysRows = retsys.getRowCount();
		String sysName = null;

			if ( sysRows > 0 )
			{
%>
		    <select name="SysNum" style="width:100%" id=FullListBox onChange="myalert()">
			<option value='sel'>--Select System--</option>
<%
				for ( int i = 0 ; i < sysRows ; i++ ){

				String val = (retsys.getFieldValue(i,SYSTEM_NO)).toString();
				sysName = (String)retsys.getFieldValue(i,SYSTEM_NO_DESCRIPTION);
				if(sys_num!=null)
				{
					if(sys_num.equals(val.trim())){
%>
			    	    <option selected value=<%=val%> >
						<%=val%> ( <%=sysName %> )
			    	    </option>
<%
					}else{
%>
			    	    <option value=<%=val%> >
						<%=val%> ( <%=sysName%> )
			    	    </option>
<%
					}//End If

				}
				else
				{
%>
			    	    <option value=<%=val%> >
						<%=val%> ( <%=sysName%> )
			    	    </option>
<%
				}
			}
%>
		        </select>
<%
			}
%>
      </Td>
            <!--<Td width="10%" align="center">
	  	  	 <a href="javascript:myalert()"><img src="../../Images/Buttons/<%= ButtonDir%>/show.gif" border=none></a>
	  	  	</Td>-->

    </Tr>
    </Table>
    <%
   	 if(sys_num!=null && !sys_num.equals("sel"))
   	{
    %>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Td class="displayheader">ERP Connection Parameters</Td>
  </Tr>
</Table>

    <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0  width="80%">
    <Tr>
      <Td width="50%" nowrap class="labelcell">
        <div align="right">Group Name:</div>
      </Td>
      <Td width="50%">
        <%


			if ( numGrps > 0 ) {


				for ( int i = 0 ; i < numGrps ; i++ ){
		%>

			       <input type="hidden" name="GroupId" value=<%=(retgrp.getFieldValue(i,"EUG_ID"))%> >
			        <%=retgrp.getFieldValue(i,"EUG_NAME")%>
		<%

				}
				}else{
		%>
			        No Group exists for this System.
		<%
				}
  }
  else
  {
%>
<br><br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
		<Td class = "labelcell">
			<div align="center"><b>Please Select ERP System  to continue.</b></div>
		</Td>
	</Tr>
</Table>
<%
	}
%>
      </Td>
    </Tr>
  </Table>
<%
if ( numGrps > 0 ) {
%>
  <div align="center"><br>
    	<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/delete.gif" >
    	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

  </div>
<%
}//end if
else
	{
%>
  <div align="center"><br>
    	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

  </div>

<%
	}
%>
</form>
  <%
}else{
%>
<br><br><br><br>
 <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Th>There are No Systems Created Currently</Th>
  </Tr>
</Table>
<br>
<center>
	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</center>
    <%
}//end if
%>
</body>
</html>
