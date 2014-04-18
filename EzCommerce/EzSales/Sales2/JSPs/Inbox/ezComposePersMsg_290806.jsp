<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/Lib/ezInboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezInbox.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iLang_Lables.jsp" %>

<HTML>
<HEAD>
	<script src="../../Library/JavaScript/Inbox/ezComposePersMsgs.js"></script>
  	<Title>Inbox: Compose Message</Title>
  	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<script>
		
			
		function ezHref(event)
		{
			document.location.href = event;
		}
	
function chkSubmit()
{
	var myFlag=true
	var myFlag1=true
	var FieldNames=new Array();
	var CheckType=new Array();
	var Messages=new Array();

    	var msg=document.myForm.msgText.value;
/*
	if(document.myForm.attachs.length>0)
	{
		document.myForm.attachflag.value="true";
		var astring=""
		for(var i=0;i<document.myForm.attachs.length;i++)
		{
			astring=astring+document.myForm.attachs.options[i].value+",";
		}
		astring=astring.substring(0,astring.length-1);
		document.myForm.attachString.value=astring;
	}
*/	

	var ctr=0
	if(document.myForm.toUser.value=="")
	{
		alert("Please Select/Enter To Address");
		document.myForm.toUser.focus();
		return;
	}
	else if(((document.myForm.toUser.value).indexOf("@")>=0) || (((document.myForm.toUser.value).indexOf(".")>=0)))
	{
		var val=document.myForm.toUser.value
		var obj=val.split(",");
		for(var i=0;i<obj.length;i++)
		{
			if((obj[i].indexOf("@")>=0) || ((obj[i].indexOf(".")>=0)))
			{
				myFlag1 = funEmail(obj[i])
				if(! myFlag)
				{
					alert("Please enter valid mail ids for CC")

					document.myForm.toUser.focus()
					return;
				}
			}
		}

	}
	if(document.myForm.ccUser.value != "" && myFlag1)
	{
		if((document.myForm.ccUser.value).indexOf(",")>0)
		{
			var val=document.myForm.ccUser.value
			var obj=val.split(",")
			for(var i=0;i<obj.length;i++)
			{
				if((obj[i].indexOf("@")>=0) || ((obj[i].indexOf(".")>=0)))
				{
					myFlag = funEmail(obj[i])
					if(! myFlag)
					{
						document.myForm.ccUser.focus()
						return;
					}
				}
			}
		}
		else
		{
			if(((document.myForm.ccUser.value).indexOf("@")>=0) || (((document.myForm.ccUser.value).indexOf(".")>=0)))
			{
				myFlag1 = funEmail(document.myForm.ccUser.value)
				if(!myFlag1)
				{
					document.myForm.ccUser.focus()
					return;
				}
			}

		}
	}
	
	if(document.myForm.bccUser.value != "" && myFlag1)
	{
		if((document.myForm.bccUser.value).indexOf(",")>0)
		{
			var val=document.myForm.bccUser.value
			var obj=val.split(",")
			for(var i=0;i<obj.length;i++)
			{
				if((obj[i].indexOf("@")>=0) || ((obj[i].indexOf(".")>=0)))
				{
					myFlag = funEmail(obj[i])
					if(! myFlag)
					{
						document.myForm.bccUser.focus()
						return;
					}
				}
			}
		}
		else
		{
			if(((document.myForm.bccUser.value).indexOf("@")>=0) || (((document.myForm.bccUser.value).indexOf(".")>=0)))
			{
				myFlag1 = funEmail(document.myForm.bccUser.value)
				if(!myFlag1)
				{
					document.myForm.bccUser.focus()
					return;
				}
			}

		}
	}

		if(myFlag && myFlag1)
		{
			document.myForm.action=action="ezSendPersMsg.jsp"
			document.myForm.submit();

		}
	}
	function ezHref(event)
	{
		document.location.href = event;
	}
	</script>
</HEAD>
<BODY scroll=no>
<FORM name=myForm method=post>
<% String display_header="Compose New Message"; %>
<%@ include file="../Misc/ezDisplayHeader.jsp" %>

<Table width="95%" align=center border="1" borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
	<Tr>
		<Th  width="15%" height="23" align="left">&nbsp;&nbsp;<b><a href="Javascript:getAddressWindow()" ><font color="#ffffff"><u><%= getLabel("TO") %></u></font></a></b></Th>
		<Td  width="53%" height="23"><input type='text'  class=InputBox style="width:100%" tabindex=2  name=toUser></Td>
	</Tr>
	<Tr>
		<Th  width="15%" height="18" align="left">&nbsp;&nbsp;<B><%= getLabel("CC") %> </B></Th>
		<Td  width="53%" height="18"><input type='text' class=InputBox  style="width:100%" style="width:100%" tabindex=3  name=ccUser></Td>
		
	</Tr>
	<Tr>
		<Th  width="15%" height="14" align="left">&nbsp;&nbsp;<B><%= getLabel("BCC") %></B></Th>
		<Td  width="53%" height="14"><input type='text' class=InputBox style="width:100%"  tabindex=3    name=bccUser></Td>
	</Tr>
	<Tr>
		<Th  width="15%" height="21" ALIGN="left">&nbsp;&nbsp;<B><%= getLabel("SUBJ") %> </B></Th>
		<Td  width="53%"  height="21"><input type='text' class=InputBox style="width:100%" maxLength=80 tabindex=4  name=msgSubject></Td>
		
	</Tr>
	<Tr>
		<Td  colspan="3" height="65"><Textarea title="Type Message Text" style="overflow:auto;width:100%" tabIndex=5 name="msgText" rows=10></Textarea> </Td>
	</Tr>
</Table>

<Table width="100%" align=center >
	<Tr>
		<Td class=blankcell align="center">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Clear");
	buttonMethod.add("funReset()");
	buttonName.add("Send");
	buttonMethod.add("chkSubmit()");
	buttonName.add("Back");
	buttonMethod.add("history.go(-1)");
	out.println(getButtonStr(buttonName,buttonMethod));	
%>
		</Td>
	</Tr>	
</Table>

<input type=hidden name="attachflag" value="">
<input type="hidden" name="attachString" value="">

</FORM>
<Div id="MenuSol"></Div>
</BODY>

</HTML>
