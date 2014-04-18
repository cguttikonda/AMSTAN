<%@ include file="../../Library/Globals/errorPagePath.jsp"%>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="AuditManager" class="ezc.ezaudit.client.EzAuditManager" scope="session" />
<%@ page import="ezc.ezparam.*,ezc.ezaudit.params.*,java.util.*" %>


<%

	EzcParams mainParams = new EzcParams(false);
	EziAuditTableListParams inParams = new EziAuditTableListParams();
	mainParams.setObject(inParams);
	Session.prepareParams(mainParams);
	ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve)AuditManager.getAuditDocumentsList(mainParams);

%>

<html>
<head>
<script>
function funSubmit()
{
    document.myForm.action="ezEditDocumentDetails.jsp"	
    document.myForm.submit()	
}

function funAdd()
{
    document.myForm.action="ezAddAuditDocuments.jsp"	
    document.myForm.submit()	
}

function funDelete()
{
  var conf = window.confirm("The record will be deleted permanently.\n Are you sure?")
    if(conf)
    {	
	    document.myForm.action="ezDeleteAuditDocuments.jsp"	
	    document.myForm.submit()	
    }	
}

function funChangeStatus(stat)
{
  var chkValue
  var len = document.myForm.chk1.length

  if(!isNaN(len))
  {
      for(var j=0;j<len;j++)
      {
     	 if(document.myForm.chk1[j].checked)
      	 {
      	 	chkValue = document.myForm.status[j].value
      	 }
      }
  }
  else
  {
      chkValue = document.myForm.status.value
  }

  if(stat=='A')
  {
     if(chkValue==stat)
     {
	alert("Auditing on this document is already active")
     }
     else
     {
        ans = window.confirm("Auditing on this document will be started")
        if(ans)
        {
	     document.myForm.stat.value=stat
             document.myForm.action="ezChangeDocumentStatus.jsp"
	     document.myForm.submit();
        }
     }

  }
  else if(stat=='S')
  {

     if(chkValue==stat)
     {
	alert("Auditing on this document is already inactive")
     }
     else
     {
        ans = window.confirm("Auditing on this document will be stopped")
        if(ans)
        {
	    
	     document.myForm.stat.value=stat	
           document.myForm.action="ezChangeDocumentStatus.jsp"
	     document.myForm.submit();
        }
     }

  }
}

</script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body onLoad='scrollInit()' onResize='scrollInit()'>
<form name="myForm" method="post" >
<br>
<% 
   int Count = ret.getRowCount();
   if(Count>0)
   {
%>
    <table width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    <tr>
    <th class="displayheader">List Audit Documents</th>
    </tr>
    </table>	 	
<br>
    <div id="theads">
    <table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    <tr>
    <th width="5%">&nbsp;</th>
    <th width="30%">Document Name</th>
    <th width="25%">Component</th>
    <th width="20%">Created By</th>
    <th width="20%">Status</th>
    </tr>
    </Table>
    </div>

    <DIV id="InnerBox1Div">
    <Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    <%
	
	String checked="";
	String status = "";
	String src="";
	for(int i=0;i<Count;i++)
	{
           checked="";
	   if(i==0)
		checked="checked";

	   status=ret.getFieldValueString(i,"STATUS");	
	   src="";
	   if(status.equals("A"))
		src="active";
	   else
		src="deactive";	
    %>	

    <tr>
    <td width="5%" align="center"><input type="radio" name="chk1"  value="<%=ret.getFieldValueString(i,"AUDITID")%>$$<%=ret.getFieldValueString(i,"TABLENAME")%>$$<%=ret.getFieldValueString(i,"EXT1")%>" <%=checked%>> </td>
    <td width="30%"><%=ret.getFieldValueString(i,"SHORTDESC")%></td>
    <td width="25%" align="center"><%=ret.getFieldValueString(i,"COMPONENT")%></td>
    <td width="20%" align="center"><%=ret.getFieldValueString(i,"CREATEDBY")%></td>
    <td width="20%" align="center"><img src="../../Images/Buttons/<%=ButtonDir%>/<%=src%>.gif"><input type="hidden" name="status" value="<%=status%>"></td>
    </tr>

    <%  }  %>

    </Table>
    </div>
     <input type="hidden" name="stat">
     <div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
     <img src="../../Images/Buttons/<%=ButtonDir%>/add.gif" style="cursor:hand" border=no onClick="funAdd()">
     <img src="../../Images/Buttons/<%=ButtonDir%>/edit.gif" style="cursor:hand" border=no onClick="funSubmit()">
     <img src="../../Images/Buttons/<%=ButtonDir%>/delete.gif" style="cursor:hand" border=no onClick="funDelete()">
     <img src="../../Images/Buttons/<%=ButtonDir%>/activate.gif" style="cursor:hand" border=no onClick="funChangeStatus('A')">
     <img src="../../Images/Buttons/<%=ButtonDir%>/suspend.gif" style="cursor:hand" border=no onClick="funChangeStatus('S')">
     </div>	

<% }else{  %>

<br><br><br>
    <table width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    <tr>
    <th>There are no documents to list</th>
    </th>
    </table>
<br>
<center>
<img src="../../Images/Buttons/<%=ButtonDir%>/add.gif" style="cursor:hand" border=no onClick="funAdd()">
</center>
<% } %> 
</form>
</body>
</html>
