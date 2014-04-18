<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Rfq/iByPassList.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iGetUserName.jsp"%>

<Html>
<Head>
	<Title>ByPassing Approver List</Title>
	<Script>
		var tabHeadWidth=96 
    var tabHeight="65%"
	</Script>
	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<Script src="../../Library/JavaScript/chkEditAndDelete.js"></Script>
	<Script src="../../Library/JavaScript/ezSubmitForm.js"></Script>
	<Script>
		function closeWin(chkd)
		{
			window.opener = window.dialogArguments
			opener.document.myForm.bypass.checked = false;
			close();
		}
		function funCollect()	
		{
			var chkLength = document.myForm.chk1.length
			var chkdValue = "";
			var chkdArgs ;
			var chk = 0;
			var checkAlter = 0;
			var finApp = "";
			if(!isNaN(chkLength))
			{
				for(i=0;i<chkLength;i++)
				{
					allchkdValue = window.document.myForm.chk1[i].value ;
					allchkdArgs = allchkdValue.split(",")
					if(allchkdArgs[2] == "N")
						finApp = allchkdArgs[1]
					if(document.myForm.chk1[i].checked)
					{
						chkdValue = window.document.myForm.chk1[i].value ;
						chk = 1;
					}	
				}	
			}
			else
			{
					allchkdValue = window.document.myForm.chk1.value ;
					allchkdArgs = allchkdValue.split(",")
					if(allchkdArgs[2] == "Y")
						finApp = allchkdArgs[1]
					if(document.myForm.chk1.checked)
					{
						chkdValue = window.document.myForm.chk1.value ;
						chk = 1;
					}	
			}
			var retValue = "";
			if(chk == 1)
			{
				chkdArgs = chkdValue.split(",")
				retValue = chkdArgs[1]
				if(chkdArgs[1] == finApp)
				{
					var chkx = confirm("You are trying to bypass the final approver which will result in the approval of this QCF. Would you like to continue")
					if(chkx)
						retValue = retValue +"¥APPROVE"
				}
				else
				{
					retValue = retValue +"¥SUBMIT"
				}	
				window.returnValue=retValue;
			}
			else
				chk = 0;
			closeWin(chk)
		}
		function fillDefaults()
		{
			window.opener = window.dialogArguments
			var selValue = opener.document.myForm.hideBypassCount.value
			var chkObj = document.myForm.chk1
			if(selValue != null && selValue != "" && chkObj!=null)
			{
				chkLength = chkObj.length
				if(!isNaN(chkLength))
				{
					for(i=0;i<chkLength;i++)
					{
						var chkArr = (chkObj[i].value).split(",");
						if(chkArr[1] == selValue)
						{
							chkObj[i].checked = true
							break;
						}
					}
				}
				else
				{
						var chkArr = (chkObj.value).split(",");
						if(chkArr[1] == selValue)
						{
							chkObj.checked = true
						}
				}
			}	
		}
	</Script>
</Head>
<Body onLoad="scrollInit(10);fillDefaults()" onResize="scrollInit(10)" scroll="no" >
<Br>
<Form name=myForm>
<%
	if(listRet.getRowCount()==0)
	{
%>
		<br><br><br>
		<Table  align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 width="70%">
		<Tr>
			<Th width="100%" align=center>Bypassing was not configured for this value</Th>
		</Tr>
		</Table>
		<Div align=center id="ButtonDiv" style="position:absolute;top:90%;width:100%">
<%		
		butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
		butActions.add("closeWin(0)");
		out.println(getButtons(butNames,butActions));
%>
		</Div>
		
		
<%
	}
	else
	{
%>
		<Table  align=center class=tableClass border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 width="60%">
		<Tr class=trClass>
			<Th align=center class=displayheader>By Pass List </Th>
		</Tr>
		</Table>
		<Div id="theads">
		<Table id="tabHead" align=center class=tableClass border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 width="60%">
		<Tr class=trClass>
			<Th class=thClass align=center width="5%">&nbsp;</Th>
			<Th class=thClass align=center width="95%">Name</Th>
		</Tr>
<%	
		String opType = "";
		String disableCheck = "";
		int listCount = listRet.getRowCount();
		for(int i=0;i<listCount;i++)
		{
		
			if(lastStep.equals(listRet.getFieldValue(i,"STEP")))
				disableCheck = "disabled";
			else
				disableCheck = "";
				
				opType = (String)hashCheck.get(listRet.getFieldValue(i,"OPTYPE")); 
%>				
				<Tr class=trClass>
				<label for="cb_<%=i%>">
					<Td class=tdClass align=center width="5%">
						<input type=radio name=chk1 id="cb_<%=i%>" value="<%=listRet.getFieldValue(i,"TCODE")%>,<%=listRet.getFieldValue(i,"STEP")%>,<%=listRet.getFieldValue(i,"CANAPPROVE")%>" <%=disableCheck%>>
					</Td>
					<Td class=tdClass align=left width="95%"><%=getUserName(Session,(String)removeNull(listRet.getFieldValue(i,"OWNERPARTICIPANT")),listRet.getFieldValueString(i,"OPTYPE"),(String)session.getValue("SYSKEY"))%>&nbsp;</Td>
				</Tr>
<%				
		}
%>
		</Table>
		</Div>

		<Div align=center id="ButtonDiv" style="position:absolute;top:90%;width:100%">
<%
	 butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
	 butActions.add("funCollect()");
	 butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
	 butActions.add("closeWin(0)");
    	 out.println(getButtons(butNames,butActions));
%>
		</Div>
<%
	}
%>
</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>
