<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="ezWorkbenchManager" class="ezc.ezworkbench.client.EzWorkbenchManager" scope="session" />
<jsp:useBean id="AuditManager" class="ezc.ezaudit.client.EzAuditManager" scope="session" />
<%@ page import="ezc.ezparam.ReturnObjFromRetrieve,ezc.ezparam.*,ezc.ezworkbench.params.*,java.util.*,ezc.ezaudit.params.*" %>

<%

	ReturnObjFromRetrieve attribList=null;

	Hashtable ht = new Hashtable();	
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	EziDocumentParams params= new EziDocumentParams();
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	ReturnObjFromRetrieve docList=(ReturnObjFromRetrieve)ezWorkbenchManager.getDocumentsList(mainParams);

	EzcParams mParams = new EzcParams(false);
	EziAuditTableListParams inParams = new EziAuditTableListParams();
	mParams.setObject(inParams);
	Session.prepareParams(mParams);
	ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve)AuditManager.getAuditDocumentsList(mParams);
	int retCount=ret.getRowCount();

	for(int i=docList.getRowCount()-1;i>=0;i--)
	{
		for(int j=0;j<retCount;j++)
		{
			if(docList.getFieldValueString(i,"DOCUMENTID").equals(ret.getFieldValueString(j,"EXT1")))
			{
				docList.deleteRow(i);
				break;
		 	}
		}
	}	

      int docListCount = docList.getRowCount();	
	int docattrCount = 0;

	String documentId=request.getParameter("documentId");
	String tableName="";


	if(docListCount>0)
	{
		if(documentId==null)
		{
			documentId=docList.getFieldValueString(0,"DOCUMENTID");
			tableName=docList.getFieldValueString(0,"TABLENAME");
		}
		else
		{
			StringTokenizer st = new StringTokenizer(documentId,"$$");
			documentId = st.nextToken();		
			tableName = st.nextToken();
		}

		ezc.ezparam.EzcParams subParams = new ezc.ezparam.EzcParams(false);
		EziDocumentAttributeParams attParams= new EziDocumentAttributeParams();
		attParams.setDocumentId(documentId);
		subParams.setObject(attParams);
		Session.prepareParams(subParams);
		attribList=(ReturnObjFromRetrieve)ezWorkbenchManager.getDocumentAttributes(subParams);	
		docattrCount = attribList.getRowCount();
	

	}

%>


<html>
<head>
<script>
var attributes = new Array()

function setData(attribId,attribText)
{
    this.attribId = attribId
    this.attribText = attribText
}		


function formSubmit()
{
	document.myForm.action="ezAddAuditDocuments.jsp"
	document.myForm.submit()
}

function addValues()
{
	var len = document.myForm.attributeId.length

	if(len>0)
	{
		var x=0;
		for(i=0;i<len;i++)
		{
			if(document.myForm.attributeId.options[i].selected)
			{
				x++;	
			}
		}
		if(x>0)
		{
			var remKeys = new Array()
			var n=0;
	
			var j = document.myForm.selectedAttributes.length	
			if(j > 0)
			{	  	
				for(i=0;i<j;i++)
				{
				     remKeys[n] = document.myForm.selectedAttributes.options[i].value 	
				     n++;
				}	
			}
	
			for(i=0;i<len;i++)
			{
				j = document.myForm.selectedAttributes.length	
				if(document.myForm.attributeId.options[i].selected)
				{
			     
			            if(j > 0)
		 	     	    {
					document.myForm.selectedAttributes.options[j] = new Option(document.myForm.attributeId.options[i].text,document.myForm.attributeId.options[i].value)	
				    }
				    else
				    {				
					document.myForm.selectedAttributes.options[0] = new Option(document.myForm.attributeId.options[i].text,document.myForm.attributeId.options[i].value)	
				    }
		 		    remKeys[n] = document.myForm.attributeId.options[i].value 	
			     	    n++;	
				}	
			}
	
			for(i=len;i>0;i--)
			{
			   document.myForm.attributeId.options[i-1] = null;		
			}
	
			var ln = attributes.length
			var notThere = true;
			var s = 0;
			for(i=0;i<ln;i++)
			{
				notThere = true;
				for(k=0;k<remKeys.length;k++)
				{
				    if(attributes[i].attribId == remKeys[k])	
				    {
					notThere = false;
					break;
				    }		
				}
	
				if(notThere)
				{
				   document.myForm.attributeId.options[s] = new Option(attributes[i].attribText,attributes[i].attribId)
				   s++;	 			
				}
			}		
		}else{
		   alert("Please select atleast one field to add")		
		}
	}else{
		alert("There are no fields to add")
	}
}


function removeValues()
{
	var len = document.myForm.selectedAttributes.length
	if(len>0)
	{
		var x=0;
		for(i=0;i<len;i++)
		{
			if(document.myForm.selectedAttributes.options[i].selected)
			{
				x++;	
			}
		}
		if(x>0)
		{
			var addKeys = new Array()
			var n=0;

			var j = document.myForm.attributeId.length	
			if(j > 0)
			{	  	
				for(i=0;i<j;i++)
				{
				     addKeys[n] = document.myForm.attributeId.options[i].value 	
				     n++;
				}	
			}
	
			for(i=0;i<len;i++)
			{
				j = document.myForm.attributeId.length	
				if(document.myForm.selectedAttributes.options[i].selected)
				{
    
			            if(j > 0)
		 	     	    {
					document.myForm.attributeId.options[j] = new Option(document.myForm.selectedAttributes.options[i].text,document.myForm.selectedAttributes.options[i].value)	
				    }
				    else
				    {				
					document.myForm.attributeId.options[0] = new Option(document.myForm.selectedAttributes.options[i].text,document.myForm.selectedAttributes.options[i].value)	
				    }
				    addKeys[n] = document.myForm.selectedAttributes.options[i].value 	
			     	    n++;
				}	

			}

			for(i=len;i>0;i--)
			{
			   document.myForm.selectedAttributes.options[i-1] = null;		
			}

			var ln = attributes.length
			var notThere = true;
			var s = 0;
			for(i=0;i<ln;i++)
			{
				notThere = true;
				for(k=0;k<addKeys.length;k++)
				{
				    if(attributes[i].attribId == addKeys[k])	
				    {
					notThere = false;
					break;
				    }		
				}
	
				if(notThere)
				{
				   document.myForm.selectedAttributes.options[s] = new Option(attributes[i].attribText,attributes[i].attribId)
				   s++;	 			
				}
			}		

			

		}else{
		   alert("Please select atleast one field to remove")		
		}
	}else{
		alert("There are no fields added to remove")
	}

}

function formEvents()
{

	var len = document.myForm.selectedAttributes.length
	if(len>0)
	{
		for(var i=0;i<len;i++)
		{
			document.myForm.selectedAttributes.options[i].selected=true;
		}
		
		document.myForm.action = "ezAddAuditFields.jsp"
		document.myForm.submit()
	}
	else
	{
		alert("Please select atleast one field")
	}

}
</script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<body>
<form name="myForm" method="post" >
<%
   if(docListCount > 0)
   {	
%>
     <table width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    <tr>
    <th class="displayheader">Add Audit Documents</th>
    </tr>
    </table>	<br><br>

<table width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<tr>
<th>Select Document</th>
<td>
<select name="documentId" onChange="formSubmit()">

<%

 int Count = docList.getRowCount();
 String docId="";	
 String tabName="";
 for(int i=0;i<Count;i++)
 {
	docId=docList.getFieldValueString(i,"DOCUMENTID");
	tabName=docList.getFieldValueString(i,"TABLENAME");
	if(docId.equals(documentId))
	{
%>
		<option value="<%=docId%>$$<%=tabName%>" selected><%=docList.getFieldValueString(i,"SHORTDESC")%></option>

<% 	}else{  %>

	<option value="<%=docId%>$$<%=tabName%>"><%=docList.getFieldValueString(i,"SHORTDESC")%></option>

<%  }
} %>
</select>
</td></tr>
</table>
<br><br><br>
<%
   if(docattrCount>0)
   {
%>


<table width="60%" align=center>
<tr>
<td width="40%" align="left" class="blankcell">
Document Attributes<br>
<select name="attributeId" size=5 style="width:80%" multiple>
<%
	 int Cnt = attribList.getRowCount();
	 String attbId = "";	
	 String shtDesc = "";	
	 String htPut = "";
       for(int i=0;i<Cnt;i++)
	 {
		attbId=attribList.getFieldValueString(i,"LONGDESC");
		shtDesc = attribList.getFieldValueString(i,"SHORTDESC");
		htPut = attribList.getFieldValueString(i,"SHORTDESC")+"$$"+attribList.getFieldValueString(i,"DATATYPE");
		ht.put(attbId,htPut);

 %>
	       <option value="<%=attbId%>"><%=shtDesc%></option>
		<script>
			attributes[<%=i%>] = new setData('<%=attbId%>','<%=shtDesc%>')
		</script>

<%     }
	session.setAttribute("ATTRIBUTES",ht);
	Hashtable h = (Hashtable)session.getAttribute("ATTRIBUTES");
%>

</select>
</td>
<td width="20%" align="center" class="blankcell">
<img src="../../Images/Buttons/<%=ButtonDir%>/rightarrow.gif" style="cursor:hand" border=none onClick="addValues()">
<br><br>
<img src="../../Images/Buttons/<%=ButtonDir%>/leftarrow.gif" style="cursor:hand" border=none onClick="removeValues()">
</td>
<td width="40%" align="right" class="blankcell">
Selected Attributes<br>
<select name="selectedAttributes" size=5 style="width:80%" multiple>
</select>
</td>
</tr>
</table>
<br><br>
<center><img src="../../Images/Buttons/<%=ButtonDir%>/next.gif" style="cursor:hand" border=none onClick="formEvents()"></center>
<%     }else{  %>	

    <br><br><br>
    <table width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    <tr>
    <th>There are no document attributes to list</th>
    </th>
    </table>



<%	}
 }else{ %>

<br><br><br>
    <table width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    <tr>
    <th>There are no documents to list</th>
    </th>
    </table>

<% } %>
</form>
</body>
</html>
