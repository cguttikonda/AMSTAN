
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/Inbox.jsp"%>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>

<html>
<head>
<%
// Key Variables
ReturnObjFromRetrieve retUser = null;

String language = "EN";
String client = "200";

EzcUserParams uparams= new EzcUserParams();
Session.prepareParams(uparams);

EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
ezcUserNKParams.setLanguage("EN");


uparams.createContainer();
boolean result_flag = uparams.setObject(ezcUserNKParams);



// Get List of Business Users
//retUser = IBObject.getListOfUsers(AdminObject, servlet, client, language);
retUser = (ReturnObjFromRetrieve)UserManager.getAllBussUsers(uparams);
//retUser = (ReturnObjFromRetrieve)UserManager.getAllUsers(uparams);

retUser.check();

%>

<script language="javascript">

function CheckSelect() {
	var selCount=0;

	for (var i = 0; i < document.myForm.elements.length; i++)
	{
		var e = document.myForm.elements[i];
		if (e.name == 'to' && e.checked)
		{
			selCount = selCount + 1;
		}
	}

	if(selCount<1){
		alert("Select User(s) Before Submitting");
		document.returnValue = false;
	}else{

		document.returnValue = true;
	}

}

</script>

<Title>List of Users</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>

<body >

<form name=myForm method=post action="javascript:Update()">

  
     <%
int userRows = retUser.getRowCount();
String userName = null;
if ( userRows > 0 ) 
{
%>
      <Table   width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666  cellPadding=2 cellSpacing=0 >
          <Tr align="center" valign="middle">
            <Th width="19%">Select</Th>
            <Th width="81%">User </Th>
    </Tr>
<%
    for (int i = 0 ; i < userRows; i++) 
    {
	userName = (String)retUser.getFieldValue(i,USER_ID);
%>
     <Tr align="center">
        <Td width="19%" class = "labelcell">
	   <input type="checkbox" name= "to" value=<%=userName%> >
	</Td>
        <Td width="81%">
<%
	    out.println(userName);
%>
        </Td>
     </Tr>
<%

    }//End for
%>
      </Table >
  <input type="hidden" name="userStr" value="">
  <br>
  <div align="center">
    <!--<input type="submit" name="select" value="Select" onClick="CheckSelect();return document.returnValue">-->
    <input type="image" src = "../../Images/Buttons/<%=ButtonDir%>/select.gif" name="select" value="Select" onClick="CheckSelect();return document.returnValue">
    <img src = "../../Images/Buttons/<%=ButtonDir%>/close.gif"  onClick="window.close()" style="cursor:hand">
  </div>  
<%
 }//End if
 else
 {
 %>
     <Table   width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666  cellPadding=2 cellSpacing=0 >    
       <Tr align="center">
          <Td>No Users To List</Td>
       </Tr>
     </Table >
       <br><br><br><br><center><img src = "../../Images/Buttons/<%=ButtonDir%>/close.gif"  onClick="window.close()" style="cursor:hand"></center>
 <%
 }
%> 
 
  
<script language="JavaScript">
<!--
function Update()
{
	var e2 = document.myForm.userStr.value;
	for (var i = 0; i < document.myForm.elements.length; i++)
	{
		var e = document.myForm.elements[i];
		if (e.name == 'to' && e.checked)
		{
			if (e2)
				e2 += ",";
			e2 += e.value;
		}
	}
	e2 += ",";
	window.opener.document.myForm.toUser.value = e2.substring(0,e2.length-1);
	window.close();

}
//-->
</script>
</form>
</body>
</html>