<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="AuditManager" class="ezc.ezaudit.client.EzAuditManager" scope="session" />
<jsp:useBean id="ezWorkbenchManager" class="ezc.ezworkbench.client.EzWorkbenchManager" scope="session" />
<%@ page import="ezc.ezparam.*,ezc.ezaudit.params.*,java.util.*,ezc.ezworkbench.params.*" %>

<%
	String checkId = request.getParameter("chk1");

	StringTokenizer st = new StringTokenizer(checkId,"$$");
	String auditId = st.nextToken();
	String tableName = st.nextToken();
	String docId = st.nextToken();

	String fieldPrefix = "";	
	StringTokenizer stk = new StringTokenizer(tableName,"_");
	String temp="";	
	while(stk.hasMoreElements())
    	{
		temp = stk.nextToken();
		fieldPrefix = fieldPrefix+temp.substring(0,1);
    	}		
	fieldPrefix = fieldPrefix+"_";

        EzcParams mainParams = new EzcParams(false);
	EziAuditTableDetailsParams inParams = new EziAuditTableDetailsParams();
	inParams.setAuditId(auditId);
	mainParams.setObject(inParams);
	Session.prepareParams(mainParams);
	ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve)AuditManager.getAuditDocumentDetails(mainParams);

        ezc.ezparam.EzcParams subParams = new ezc.ezparam.EzcParams(false);
	EziDocumentAttributeParams attParams= new EziDocumentAttributeParams();
	attParams.setDocumentId(docId);
	subParams.setObject(attParams);
	Session.prepareParams(subParams);
	ReturnObjFromRetrieve retFields=(ReturnObjFromRetrieve)ezWorkbenchManager.getDocumentAttributes(subParams);	

	Vector insertVector = new Vector();
	Vector updateVector = new Vector();
	Vector deleteVector = new Vector();

	int Count=ret.getRowCount();
	String opType = "";
	for(int i=0;i<Count;i++)
	{
		opType = ret.getFieldValueString(i,"OPERATIONTYPE");
	   	if(opType.equals("I"))
		{
		   insertVector.addElement(ret.getFieldValueString(i,"FIELDNAME"));	
		}
		else if(opType.equals("U"))
		{
		   updateVector.addElement(ret.getFieldValueString(i,"FIELDNAME"));				
		}
		else if(opType.equals("D"))
		{
		   deleteVector.addElement(ret.getFieldValueString(i,"FIELDNAME"));				
		}

	}
%>


<html>
<head>
<script>
function funSubmit()
{
	var len = document.myForm.selectedAttributes.length
	var count=0;
	if(len>0)
	{
		for(var i=0;i<len;i++)
		{
			var obj = eval("document.myForm.Insert"+i)
			var obj1 = eval("document.myForm.Update"+i)
			var obj2 = eval("document.myForm.Delete"+i)
			if(obj.checked)
			{
				count++;
				break;
			}

			if(obj1.checked)
			{
				count++;
				break;
			}

			if(obj2.checked)
			{
				count++;
				break;
			}
	
		}
	}
	else
	{
		if(document.myForm.Insert0.checked)
		{
			count++;
		}
		else if(document.myForm.Update0.checked)
		{
			count++;
		}
		else if(document.myForm.Delete0.checked)
		{
			count++;
		}
	}

	if(count>0)
	{

		document.myForm.action = "ezUpdateSaveAudit.jsp"
		document.myForm.submit();
	}
	else
	{
		alert("Select atleast one field to Update")
	}	
}
</script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body onLoad='scrollInit()' onResize='scrollInit()'>
<form name="myForm" method="post" >
<br>
<table width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
<tr>
<th align="center" class="displayheader">Edit Document Attributes</th>
</tr></table><br>

    <div id="theads">
    <table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
    <tr>
    <th width="40%">Attribute Name</th>
    <th width="20%">Insert</th>
    <th width="20%">Update</th>
    <th width="20%">Delete</th>
    </tr>
    </table>
   </div>

    <DIV id="InnerBox1Div">
    <Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
    int fieldCount = retFields.getRowCount();	
    String field="";
    String chk1="";    
    String chk2="";
    String chk3="";
	
    for(int i=0;i<fieldCount;i++)
    {	
	field = fieldPrefix+retFields.getFieldValueString(i,"LONGDESC");	
%>
    <tr>	
    <td width="40%"><%=retFields.getFieldValueString(i,"SHORTDESC")%><input type="hidden" name="selectedAttributes" value="<%=field%>"></td>
    <td width="20%" align="center">
    <% if(insertVector.contains(field))
	chk1="checked";
       else
	chk1="";
    %>	
    <input type="checkbox" name="Insert<%=i%>" <%=chk1%> ></td>
    <% if(updateVector.contains(field))
	chk2="checked";
       else
	chk2="";
    %>	
    <td width="20%" align="center"><input type="checkbox" name="Update<%=i%>" <%=chk2%> ></td>
    <% if(deleteVector.contains(field))
	chk3="checked";
       else
	chk3="";
    %>	
    <td width="20%" align="center"><input type="checkbox" name="Delete<%=i%>" <%=chk3%> ></td>
    </tr>

<%  }   %>
    </table>
    </div>	

<input type="hidden" value="<%=docId%>" name="docId">
<input type="hidden" value="<%=auditId%>" name="auditId">
<input type="hidden" value="<%=tableName%>" name="tableName">

<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
<img src="../../Images/Buttons/<%=ButtonDir%>/save.gif" style="cursor:hand" border=none onClick="funSubmit()">
<img src="../../Images/Buttons/<%=ButtonDir%>/clear.gif" style="cursor:hand" border=none onClick="document.myForm.reset()">
<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border=none onClick="javascript:history.go(-1)">
</div>
</form>
</body>
</html>
