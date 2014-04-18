
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Labels/iReplyPersMsg_Labels.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<%
	String replyToUser = request.getParameter("fromUser");
	String replyToSubject = request.getParameter("msgSubject");
	String replyToMsgID = request.getParameter("MessageID");
       session.putValue("fname","");
%>

<html>
<head>
      <Title>Inbox: Reply Personal Message</Title>
      <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
      <script language="javascript">
          
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
<script>
	
	
	var attach;
	/* function funAttach()
	{
		attach=window.open("ezAttachFile.jsp","UserWindow1","width=350,height=250,left=150,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
	} */
	function formSubmit()
	{
		if(NewVerifyEmptyFields())
		{
			
			var to = document.myForm.toUser.value;
			if(document.myForm.ccUser.value!="")
				to = to+','+document.myForm.ccUser.value;
			if(document.myForm.bccUser.value!="")
				to = to+','+document.myForm.bccUser.value;
			document.myForm.apptoUser.value = to;
			SendQuery(to);
		}
		else
			return;
	}

	/* function funRemove()
	{
		var attachments=new Array();
		var j=0;
		var count=0;
		if(document.myForm.attachs.length>0)
		{
			for(var i=0;i<document.myForm.attachs.length;i++)
			{
				if(document.myForm.attachs.options[i].selected==true)
				{
					count++;
				}
			}
			if(count==0)
			{
				alert('<%=plzSelFileDel_L%>');

			}
		}
		else
		{
			alert('<%=noAttachRem_L%>');
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
		var req;
		function Initialize()
		{
			try
			{
				req = new ActiveXObject("Msxml2.XMLHTTP");
			}
			catch(e)
			{
				try
				{
					req = new ActiveXObject("Microsoft.XMLHTTP");
				}
				catch(oc)
				{
					req = null;
				}
			}
			if(! req&&typeof XMLHttpRequest != "undefined")
			{
				req = new XMLHttpRequest();
			}
		
		}
		function SendQuery(key)
		{
			try
			{
				req = new ActiveXObject("Msxml2.XMLHTTP");
			}
			catch(e)
			{
				try
				{
					req = new ActiveXObject("Microsoft.XMLHTTP");
				}
				catch(oc)
				{
					req = null;
				}
			}
			if(!req&&typeof XMLHttpRequest!="undefined")
			{
				req = new XMLHttpRequest();
			}
			var url="";
			url=location.protocol+"//<%=request.getServerName()%>/j2ee/EzCommerce/EzVendor/Vendor2/JSPs/Inbox/ezSelectUsersAjax.jsp?userId="+key+"&date="+new Date();
			//alert(">>"+url)
			if(req!=null)
			{
				req.onreadystatechange = Process;
				req.open("GET", url, true);
				req.send(null);
			}
		}
		function Process()
		{
			if (req.readyState == 4)
			{
				var resText = req.responseText;	 
				//alert(resText)
				var resultText	= resText.split("¥");
				var rcount  = 0;			
				var temp = resultText[0].split("£");
				try
				{				
					rcount   = parseInt(resultText[1]);
					globalid = rcount;
				}catch(Exception){}
				//alert("temp[1]  "+resultText[1]);
				if (req.status == 200)
				{
					if(rcount>0)
					{
						alert("Please check the following user id(s) ' "+temp[1]+" ' and try again")
						//myFlag1 = false;						
						return;
					}
					else
					{
						setMessageVisible();
						document.myForm.action="ezSendReplyPersMsg.jsp"
						document.myForm.submit();
					}
				}
				else
				{
					if(req.status == 500)	
					alert("There was a problem while retrieving data,please contact system administrator.");		
				}
			}
		}


</script>

</head>
<body onLoad="document.myForm.ccUser.focus()" scroll=no>
<form name=myForm method=post action="ezSendReplyPersMsg.jsp">
<input type="hidden" name=apptoUser value="">
<!--<Table  width=40%  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th align="center" >
			Reply To Message
		</Th>
	</Tr>
</Table> -->
<% String display_header=replyToMsg_L;%>
<%@ include file="../Misc/ezDisplayHeader.jsp" %>



<Table align="right" width="98%">
<Tr>
<Td align="right" class=blankcell>
<font color="#000000" size=-1 align="right"></font>
</Td>
</Tr>
</Table>
<br>
<Table width="100%" border="1" borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0  >
  <Tr>
    <Th  width="15%" height="23" align="left">&nbsp;&nbsp;<B><A href="Javascript:getAddressWindow('TO')" ><font color="#ffffff"><u><%=replyTo_L%></u> </font></A></B></Th>
    <Td  width="53%" height="23">
      <input type='text'  class=InputBox tabindex=2 style="width:100%" name=toUser value='<%=replyToUser%>'>
    </Td>
    <!--<Th  width="35%" height="23"><a href="javascript:getAttachWindow()"><font size=-2 color="#ffffff" <%=statusbar%> ><%=clkAtt_L%><font></a></Th> -->
    
  </Tr>
  <Tr>
    <Th  width="15%" height="18" align="left">&nbsp;&nbsp;<B><A href="Javascript:getAddressWindow('CC')" ><font color="#ffffff"><u>Cc</u> </font></A></B></Th>
    <Td  width="53%" height="18">
      <input type='text'  class=InputBox  tabindex=3 style="width:100%" name=ccUser>
    </Td>
   
  </Tr>
  <Tr>
    <Th  width="15%" height="14" align="left">&nbsp;&nbsp;<B><A href="Javascript:getAddressWindow('BCC')" ><font color="#ffffff"><u>Bcc</u> </font></A></B></Th>
    <Td  width="53%" height="14">
		<input type='text' class=InputBox  tabindex=3  style="width:100%"  name=bccUser>
    </Td>
  </Tr>
  <Tr>
    <Th  width="15%" height="21" ALIGN="left">&nbsp;&nbsp;<B><%=subject_L%> </B></Th>
    <Td  width="53%" height="21">
     <input type='text' class=InputBox maxLength=80 tabindex=4 style="width:100%" name=msgSubject value ="Re: <%=replyToSubject%>">
    </Td>


  </Tr>
  <Tr>
    <Td  colspan="3" height="47">
    <Textarea title="Type Message Text" class=txarea tabIndex=5 name="msgText" rows=4  style="width:100%"  ></Textarea>
    <input type="hidden" name="toMessage" value=<%=replyToMsgID%>
    </Td>
  </Tr>
</Table>
<br>

		<!--<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif"  style="text-decoration:none"  class=subclass   title="Click here to go to Previous Page" tabindex=7 border=none  <%=statusbar%>  ></a>
		<a href="JavaScript:funReset()"><img src = "../../Images/Buttons/<%= ButtonDir%>/clear.gif"  title="Click here to clear Text Area" tabindex=8 name="clearMsg" value="Clear"   <%=statusbar%>  border="none" ></a>
		<input type=image src="../../Images/Buttons/<%= ButtonDir%>/send.gif"  style="text-decoration:none"  class=subclass  tabindex=6  title="Click here to send mail" border=none>-->
		<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
		<center>
		<%
				
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
				
				buttonName.add("Back");
				buttonMethod.add("history.go(-1)");
				
				buttonName.add("Clear");
				buttonMethod.add("funReset()");
				
				buttonName.add("Send");
				buttonMethod.add("formSubmit()");
				
				out.println(getButtonStr(buttonName,buttonMethod));
		%>
		</center>
		</div>
		<%@ include file="../Misc/AddMessage.jsp" %>


<input type=hidden name="attachflag" value="">
<input type="hidden" name="attachString" value="">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
