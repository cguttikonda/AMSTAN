<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>
<%@ page import="ezc.ezmail.params.*" %>
<%@ page import="ezc.ezmail.client.EzMailManager" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "java.io.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="Mail" class="ezc.ezmail.client.EzMailManager" scope="session"></jsp:useBean>
<%
       	String userId=Session.getUserId();
       	String uploadDir="C:\\MailApp\\"+userId;
       	File  dirName = new File(uploadDir);
       	if(dirName.exists())
       	{
          	String[] attachedFiles=dirName.list();
          	for(int m=0;m<attachedFiles.length;m++)
          	{
          	 	new File(uploadDir+"\\"+attachedFiles[m]).delete();
       	  	}
       	  	dirName.delete();
       	}
     	EzcParams eParams = new EzcParams(false);
	EziMailGroupStructure  struct = new EziMailGroupStructure();
	eParams.setObject(struct);
	Session.prepareParams(eParams);
	ReturnObjFromRetrieve mailGroupObj = (ReturnObjFromRetrieve)Mail.ezListMailGroups(eParams);
%>
<HTML>
<HEAD>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/CheckFormFields.js"></script>
<script>
	var fieldNames= new Array()
	var checkTypes= new Array()
	var messages= new Array()

	function upLoadFun()
	{
     		window.open("ezSendAttachmentFrame.jsp","MyWind","height=400,width=300,left=100,top=100,status=no,"+"toolbar=no,menubar=no,scrollbars=yes,resizeable=0,top=10,left=25")
    	}
	function callChk()
	{
		if (document.myForm.chk1.checked)
  			document.myForm.contentType.value="HTML"
		else
	  		document.myForm.contentType.value="TEXT"
	}
	function ezCheckFields()
	{
		if(document.myForm.groupId.selectedIndex!=0)
		{
			var FieldName=new Array();
			var CheckType=new Array();
			var Messages=new Array();
		
			var cnt=0;
			if(document.myForm.to.value!="")
			{
	    			var value1="";
				var ccc=document.myForm.to.value;	
				if(ccc.indexOf(",")!=-1)
				{
					value1=ccc.split(",");			
					for(var i=0;i<value1.length;i++)
					{		
					 	if(!funEmail(value1[i]))
					 	{
					 		alert("Please Enter Valid Email Address.")
					 		document.myForm.to.focus();
					 		return false;
					 	}
	        		        }
				}
				else
				{
					FieldName[cnt] = "to";	
					CheckType[cnt] = "MEMAIL";
					Messages[cnt] = "Please enter Valid Email Address.";
					cnt++;		
				}
			}
			else
			{
				alert("Please enter To address")
				document.myForm.to.focus()
				return false
				
			}
			if(document.myForm.cc.value!="")
			{
				var value1="";
				var ccc=document.myForm.cc.value;		
				if(ccc.indexOf(",")!=-1)
				{
					value1=ccc.split(",");			
				   	for(var i=0;i<value1.length;i++)
				   	{		
				 		if(!funEmail(value1[i]))
				 		{
				 			alert("Please Enter Valid Email Address.")
				 			document.myForm.cc.focus();
				 			return false;
				 		}
        		        	}
				}
				else
				{
					FieldName[cnt] = "cc";
					CheckType[cnt] = "MEMAIL";
					Messages[cnt] = "Please enter Valid Email Address.";
					cnt++;
				}
			}
			if(document.myForm.bcc.value!="")
			{
				var value1="";
				var ccc=document.myForm.bcc.value;		
				if(ccc.indexOf(",")!=-1)
				{
					value1=ccc.split(",");			
				   	for(var i=0;i<value1.length;i++)
				   	{		
				 		if(!funEmail(value1[i]))
				 		{
				 			alert("Please Enter Valid Email Address.")
				 			document.myForm.bcc.focus();
				 			return false;
				 		}
        		        	}
				}
				else
				{
					FieldName[cnt] = "bcc";
					CheckType[cnt] = "MEMAIL";
					Messages[cnt] = "Please enter Valid Email Address.";
					cnt++;
				}
			}			
			if(funCheckFormFields(document.myForm,FieldName,CheckType,Messages))
				return true;
			return false
		}
		else
		{
			alert("Please Select Mail Group.")
			//document.myForm.groupId.foucs();
			return false;
		}
		return false;
	}
	function addGroup()
	{
		document.location.href="ezAddMailGroup.jsp"
	}	
	function funFocus()
	{
		if(document.myForm.groupId!=null)
			document.myForm.groupId.focus()	
	}
</script>
</HEAD>
<BODY onLoad="funFocus()">
<form  name='myForm'  method=post onSubmit="return ezCheckFields()" action="ezSendMail.jsp">
<%
if(mailGroupObj.getRowCount()!=0)
{
%>  
	<br>
	<TABLE align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
	<TR><th class = "displayheader" align=center colspan=2>Send Mail</th></tr>
	<tr>
		<th width=15% align = "right">Mail Group*</th>
		<td width=70%>
		<select name="groupId" id = "FullListBox" style = "width:100%">
		<Option>--Select Mail Group--</Option>
<%
		for(int i=0;i<mailGroupObj.getRowCount();i++)
		{
%>
			<option value='<%=mailGroupObj.getFieldValueString(i,"GROUPID")%>'><%=mailGroupObj.getFieldValueString(i,"GROUPDESC")%></option>
<%
		}	
%>
		</select>
		</td>
		</tr>
		<tr>
		<Th width="15%" align = "right">To*</Td>
		<td><input type=text name='to' style = "width:100%" value="" class="inputbox" size="28"></td>
		</tr>
		<tr>
		<Th width="15%" align = "right">Bcc</Td>
		<td><input type=text name='bcc' style = "width:100%" value="" class="inputbox" size="28"></td>
		</tr>
		<tr>
		<Th width="15%" align = "right">Cc</Td>
		<td><input type=text name='cc' style = "width:100%" value="" class="inputbox" size="28"></td>
		</tr>
		<TR >
		<Th width="15%" align = "right">Subject</TD>
		<td><input type=text name='subject' style = "width:100%" value="" class="inputbox" size="28"></td>
		</tr>
		<TR>
		<Th width="15%" align = "right" valign = "top">Mail Text</Th>
		<td><textarea name=msgtxt rows=5 cols=65 class="inputbox" style="overflow:auto;border:0;width:100%"></textarea></td></tr>
<%		int i=0;
%>
		<TR><label for="cb_<%=i%>"><td colspan=2><input type=checkbox name='chk1' id="cb_<%=i%>" onClick="callChk()">
		Content Type HTML
		</td>
		</label>
		</tr>
		</TABLE>
		<input type=hidden value="TEXT" name=contentType>
		<br>
		<center>
		<input type=image src="../../Images/Buttons/<%=ButtonDir%>/send.gif" border=none>
		<img src="../../Images/Buttons/<%=ButtonDir%>/attach.gif" border=none style="cursor:hand" onClick="upLoadFun()">
		<img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick = "JavaScript:document.myForm.reset()" style = "cursor:hand"> 		
		</center>
<%
   	} //if(mailGroupObj.getRowCount()!=0) close
   	else
   	{
%>  
		<br><br><br><br>
		<TABLE align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="80%">
		<Tr>
			<Th align = "center">No Mail Groups to List.</Th>
   		</Tr>
   		</Table>
   		<br>
   		<center>
			<a href="javascript:addGroup()"><img src="../../Images/Buttons/<%= ButtonDir%>/add.gif" border=none ></a>
   			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
  		</center>
<%
  	}
%> 
</form>
</BODY>
</HTML>
