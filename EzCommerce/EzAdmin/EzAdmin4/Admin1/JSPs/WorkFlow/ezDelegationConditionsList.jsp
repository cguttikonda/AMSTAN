<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>

<%@ include file="../../../Includes/JSPs/WorkFlow/iDelegationConditionsList.jsp"%>

<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<script>
function checkOption(filename)
{
	document.myForm.action=filename;
	document.myForm.submit();
	//return true
}
function funSubmit()
{
	document.myForm.action="ezDelegationConditionsList.jsp"
	document.myForm.submit();
}
</script>
<script>
function setChecked(chkVal)
{
	var len=document.myForm.chk1.length;
	if(isNaN(len))
	{
		document.myForm.chk1.checked=chkVal;
	}
	else
	{
		for ( i=0; i<len; i++)
		{
			document.myForm.chk1[i].checked = chkVal;
		}
	}
}
</script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/chkEditAndDelete.js"></Script>
<Script src="../../Library/JavaScript/ezSubmitForm.js"></Script>
<Script src="../../Library/JavaScript/ezSortTableData.js"></Script>
</Head>
<Body onLoad="scrollInit()" onResize="scrollInit()" scroll="no" >
<Br>
<Form name=myForm method="post" onSubmit="return checkOption('ezAddSaveDelegationConditions.jsp')">
<%
	 if(listRet2.getRowCount()>0)
	 {
%>

		<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="50%">
		<Tr class=trClass>
			<Th class=thClass align=center >Delegations</Th>

		<Td>
		<select name="delegationid" id=ListBoxDiv onChange="funSubmit()">
		<option value="sel"> Select Delegation</option>
<%
	 	for(int i=0;i<listRet2.getRowCount();i++)
	 	{

	 		if(delegationid!=null)
	 		{
	 			if(delegationid.equals(listRet2.getFieldValueString(i,"DELEGATIONID")))
	 			{
%>
					<option value="<%=listRet2.getFieldValueString(i,"DELEGATIONID")%>" selected><%=listRet2.getFieldValueString(i,"DELEGATIONID")%></option>


<%				}
				else
				{
%>

					<option value="<%=listRet2.getFieldValueString(i,"DELEGATIONID")%>"><%=listRet2.getFieldValueString(i,"DELEGATIONID")%></option>
<%				}
			}
			else
			{
%>
					<option value="<%=listRet2.getFieldValueString(i,"DELEGATIONID")%>"><%=listRet2.getFieldValueString(i,"DELEGATIONID")%></option>

<%			}
		}
%>
		</select>
		</Td>
			<!--<Td>
			<img border=no style="cursor:hand" src="../../Images/Buttons/<%= ButtonDir%>/show.gif" alt = "Go" align="middle" onClick="funSubmit()">
			</Td>-->

		</Tr>
		</Table>

<%
	 
	 if(listRet1!=null)
	 {
	 	if(listRet.getRowCount() > 0)
	 	{
%>
			<br>
			<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
				<Tr class=trClass>
					<Td align=center class=displayheader>Conditions List </Td>
				</Tr>
				</Table>
				<Div id="theads">
				<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
				<Tr class=trClass>
					<Th class=thClass align=center width="5%">M&nbsp;</Th>
					<Th class=thClass align=center width="47%" >Conditions</Th>

				</Tr>
				</Table>
				</Div>

			<DIV id="InnerBox1Div">
				<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%




				for(int i=0;i<listRet.getRowCount();i++)
				{
					String checFlag="";


					if(listRet1.getRowCount()>0)
					{
						if ( listRet1.find("CONDITIONID",listRet.getFieldValue(i,"RULEID")) )
						{
							checFlag = "checked";
						}
						else
						{

							checFlag = "unchecked";
			  			}
			  		}

%>
				<Tr class=trClass>
					<Td class=tdClass align=center width="5%">
						<input type=checkbox name="chk1" value='<%=listRet.getFieldValue(i,"RULEID")%>' <%=checFlag%>>
					</Td>
				<Td class=tdClass  width="47%">
					<%=listRet.getFieldValue(i,"DESCRIPTION")%>
					</Td>

		<script>
		//========= Folowing code is for sorting=========================//
			 rowArray=new Array()
			 rowArray[0]=""
			 rowArray[1]= "<%=listRet.getFieldValue(i,"DESCRIPTION")%>"

			dataArray[<%=i%>]=rowArray
		</script>
				</Tr>
<%
				}
%>
				</Table>
			</Div>
			
			
			<Div align=center id="ButtonDiv" style="position:absolute;top:90%;width:100%">
			<img  src=../../Images/Buttons/<%= ButtonDir%>/selectall.gif  alt="Click Here To CheckAll" border=no onClick="setChecked(true)" style="cursor:hand">
				<input type=image  src=../../Images/Buttons/<%= ButtonDir%>/save.gif  alt="Click Here To Add" border=no >
				<img src=../../Images/Buttons/<%= ButtonDir%>/clearall.gif  alt="Click Here To Add" border=no onClick="setChecked(false)" style="cursor:hand">
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


			</Div>
<%
		}
		else
		{
%>
			<br><br><br>
			<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
			<Tr>
				<Th width="100%" align=center>
				No Conditions To List 
				</Th>
			</Tr>
			</Table>
<%
		}
	    }
	    else
	    {
%>
		<br><br><br>
		<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
				Please select delegation and click show
			</Th>
		</Tr>
		</Table>

<%
	    }
	}	
	else
	{
%>
		<br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
			No Delegations To List Conditions
			</Th>
		</Tr>
		</Table><br><center>
		<img src="../../Images/Buttons/<%= ButtonDir%>/add.gif" style="cursor:hand" alt="Click Here To Add" border=no onClick="checkOption('ezAddDelegationInfo.jsp')">
		</center>


<%		
	}
%>
	</Form>

</Body>
</Html>
