<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/Lib/ezInboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezInbox.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iLang_Lables.jsp" %>


<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>

<%
	ReturnObjFromRetrieve retUser = null;
	String language = "EN";
	String client = "200";
	EzcUserParams uparams= new EzcUserParams();
	Session.prepareParams(uparams);
	EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");
	uparams.createContainer();
	boolean result_flag = uparams.setObject(ezcUserNKParams);
	//retUser = (ReturnObjFromRetrieve)UserManager.getAllBussUsers(uparams);
	//retUser.check();
	session.putValue("fname","");
%>
<HTML>
<HEAD>
	<script>
		var plzSelEntAdd_L = '<%=plzSelEntAdd_L%>';
		var plzSelToAdd_L = '<%=plzSelToAdd_L%>';
		var plzSelToAddNoSp_L = '<%=plzSelToAddNoSp_L%>';
    		var plzEnMsg_L = '<%=plzEnMsg_L%>';
    		var mailIdInv_L = '<%=mailIdInv_L%>';
		var mailAtInv_L = '<%=mailAtInv_L%>';
		var mailIdFormat_L = '<%=mailIdFormat_L%>';
		var mailNoAt_L = '<%=mailNoAt_L%>';
		var mailNoCom_L = '<%=mailNoCom_L%>';
    		var plzSelFile_L = '<%=plzSelFile_L%>';
    		var curNoAttach_L = '<%=curNoAttach_L%>';
		var plzSelOptRem_L= '<%=plzSelOptRem_L%>';
   		var plzNotSelMore_L = '<%=plzNotSelMore_L%>';
    		

	</script>
	<script src="../../Library/JavaScript/Inbox/ezComposePersMsgs.js"></script>
  	<Title>Inbox: Compose Message</Title>
  	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
	var attach;
	/* function funAttach()
	{
		attach=window.open("ezAttachFile.jsp","UserWindow1","width=350,height=250,left=150,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
	} */

	/* function funRemove()
	{
		
		var plzSelFileDel_L = '<%=plzSelFileDel_L%>';
		var noAttachRem_L = '<%=noAttachRem_L%>';
		var attachments=new Array();
		var j=0;
		var count=0;
		if((document.myForm.attachs.length)>0)
		{
			for(var i=0;i<(document.myForm.attachs.length);i++)
			{
				if(document.myForm.attachs.options[i].selected==true)
				{
					count++;
				}
			}
			if(count==0)
			{
				alert(plzSelFileDel_L);
				//return false;
			}
		}
		else
		{
			alert(noAttachRem_L);
			//return false;
		}
		for(var i=0;i<document.myForm.attachs.length;i++)
		{
			if(document.myForm.attachs.options[i].selected==false)
			{
				attachments[j]=document.myForm.attachs.options[i].value;
				j++;
			}
		}

		for(var i=document.myForm.attachs.length;i>=0;i--)
		{
			document.myForm.attachs.options[i]=null;
		}
		for(var i=0;i<attachments.length;i++)
		{
			document.myForm.attachflag.value="true"
			document.myForm.attachs.options[i]=new Option(attachments[i],attachments[i]);
		}
	} */
	function funSubmit()
	{
		if(chkSubmit())
		{
		
			setMessageVisible();
			document.myForm.submit();
		}
		else 
			return;
	}
	function ezHref(param)
	{
		setMessageVisible();
		document.myForm.action = param;
		document.myForm.submit();
		
	}

</script>
</HEAD>
<BODY scroll=no>
<FORM name=myForm method=post action="ezSendPersMsg.jsp" >
<% 
	String display_header=composeNewMessage_L; 
	
%>
<%@ include file="../Misc/ezDisplayHeader.jsp" %>

<Table width="95%" align=right >
<Tr>
<Td class=blankcell align="right">
	<font color="#000000" size=-2 ></font>
</Td>
</table>
<br>
<Table width="95%" align=center border="1" borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<Tr>
	<Th  width="15%" height="23" align="left">&nbsp;&nbsp;<b><a href="Javascript:getAddressWindow()" ><font color="#ffffff"><u><%=to_L%></u></font></a></b></Th>
	<Td  width="53%" height="23"><input type='text'  class=InputBox style="width:100%" tabindex=2  name=toUser></Td>
	
</Tr>
<Tr>
	<Th  width="15%" height="18" align="left">&nbsp;&nbsp;<B>Cc </B></Th>
	<Td  width="53%" height="18"><input type='text' class=InputBox  style="width:100%" style="width:100%" tabindex=3  name=ccUser></Td>
    	
</Tr>
<Tr>
	<Th  width="15%" height="14" align="left">&nbsp;&nbsp;<B>Bcc</B></Th>
	<Td  width="53%" height="14"><input type='text' class=InputBox style="width:100%"  tabindex=3    name=bccUser></Td>
</Tr>
<Tr>
    	<Th  width="15%" height="21" ALIGN="left">&nbsp;&nbsp;<B><%=subject_L%> </B></Th>
    	<Td  width="53%"  height="21" ><input type='text' class=InputBox style="width:100%" maxLength=80 tabindex=4  name=msgSubject></Td>
 
</Tr>
<Tr>
	<Td  colspan="3" height="47"><Textarea title="Type Message Text" style="overflow:auto;width:100%" tabIndex=5 name="msgText" rows=4></Textarea> </Td>
</Tr>
</Table>


<Div id="ButtonDiv" style="position:absolute;top:90%;visibility:visible;width:100%">
<center>
<%

		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();

		buttonName.add("Clear");
		buttonMethod.add("funReset()");

		buttonName.add("Send");
		buttonMethod.add("funSubmit()");

		buttonName.add("Inbox");
		buttonMethod.add("ezHref(\"ezListPersMsgs.jsp\")");
		out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>
<%@ include file="../Misc/AddMessage.jsp" %>


<input type=hidden name="attachflag" value="">
<input type="hidden" name="attachString" value="">
</FORM>
<Div id="MenuSol"></Div>
</BODY>

</HTML>
