<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/News/iListNews.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Html>
<Head>
<Script>
		  var tabHeadWidth=89
 	   	  var tabHeight="50%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<Script>
	function checkAll(obj)
	{
		var chkstatus = false;
		if(obj.checked)  chkstatus =true;
		
		var chkObj = document.myForm.chk1
		var chkObjLen =  document.myForm.chk1.length
		if(chkObj != null)
		{
			if(!isNaN(chkObjLen))
			{
				for(i=0;i<chkObjLen;i++)
				{
					chkObj[i].checked = chkstatus		
				}
			}
			else
			{
				chkObj.checked = chkstatus
			}
		}
	}

	function checkChkBoxSelection(clickedOnButton)
	{
		chkLength=document.myForm.chk1.length
		var count=0;

		if(!(isNaN(chkLength)))
		{
			for(i=0;i<chkLength;i++)
			{
				if(document.myForm.chk1[i].checked)
				count=count+1
			}
		}
		else
		{
			if(document.myForm.chk1.checked)
				count=count+1;
		}

		if(count ==0)
		{
			if(clickedOnButton == 'EDIT')
				alert("Please check checkbox which you want to Edit")
			else  if(clickedOnButton == 'DELETE')
				alert("Please check checkbox(s) which you want to Delete")

			return false;
		}
		else if(count >1 && clickedOnButton == 'EDIT')
		{
			alert("Please check only one checkbox to edit news.")
			return false;
		}

		return true;
	}

	function funAdd()
	{
		document.myForm.action = "ezAddNews.jsp";
		document.myForm.submit();
	}

	function funEdit()
	{
		if(checkChkBoxSelection('EDIT'))
		{
			document.myForm.action = "ezEditNews.jsp";
			document.myForm.submit();
		}
	}

	function funDelete()
	{
		if(checkChkBoxSelection('DELETE'))
		{
			document.myForm.action = "ezDeleteNews.jsp";
			document.myForm.submit();
		}	
	}

	function funNewsList()
	{
		document.myForm.action = "ezListNews.jsp";
		document.myForm.submit();
	}
</Script>
</Head>
<Body  onLoad="scrollInit();" onResize="scrollInit()" scroll="no" >
<Form name=myForm method="POST">
<br>
<%
	if(retObjPAsCnt>0)
	{
%>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=60%>
			<Tr>
				<Th width=20% align=left  >Business Area:*</Td>
				<Td width=80%>
				<Select name="syskey" style="width:100%" id=FullListBox onChange="funNewsList()">
					<Option value="sel">--Select Business Area--</Option>
<%
					retObjPAs.sort(new String[]{"ESKD_SYS_KEY_DESC"},true);
					for(int i=0;i<retObjPAs.getRowCount();i++)
					{
							if(syskey!=null)
							{
								if(syskey.equals(retObjPAs.getFieldValue(i,"ESKD_SYS_KEY")))
								{
%>
									<Option value="<%=retObjPAs.getFieldValue(i,"ESKD_SYS_KEY")%>" selected><%=retObjPAs.getFieldValue(i,"ESKD_SYS_KEY_DESC")%> (<%=retObjPAs.getFieldValue(i,"ESKD_SYS_KEY")%>)</Option>
<%
								}
								else
								{
%>
									<Option value="<%=retObjPAs.getFieldValue(i,"ESKD_SYS_KEY")%>"><%=retObjPAs.getFieldValue(i,"ESKD_SYS_KEY_DESC")%> (<%=retObjPAs.getFieldValue(i,"ESKD_SYS_KEY")%>)</Option>
<%
								}
							}
							else
							{
%>
								<Option value="<%=retObjPAs.getFieldValue(i,"ESKD_SYS_KEY")%>"><%=retObjPAs.getFieldValue(i,"ESKD_SYS_KEY_DESC")%> (<%=retObjPAs.getFieldValue(i,"ESKD_SYS_KEY")%>)</Option>
<%
							}
					}
%>
				</Select>
				</Td>
			</Tr>
		</Table>
<%
		if(myNewsRetCnt>0) 
		{
%>
			<Div id="theads">
			<Table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
			<Tr>
				<Th class="displayheader" width="5%"  ><input type=checkbox name=tochkall onclick='checkAll(this)'></Th>
				<Th class="displayheader" width="45%" >News</Th>
				<Th class="displayheader" width="20%" >Start Date</Th>
				<Th class="displayheader" width="20%" >End Date</Th>
				<Th class="displayheader" width="10%" >News Type</Th>
			</Tr>
			
			</Table >
			</Div>

			<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:89%;height:50%;left:2%">
			<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
<%
				int rowCount=myNewsRet.getRowCount();
				String nType ="",startdate="",enddate="",newsText="";
				for(int i=0;i<rowCount;i++)
				{
					nType 		= myNewsRet.getFieldValueString(i,"EZN_TYPE");
					startdate	= myNewsRet.getFieldValueString(i,"START_DATE_CHAR");
					enddate		= myNewsRet.getFieldValueString(i,"END_DATE_CHAR");
					newsText 	= myNewsRet.getFieldValueString(i,"EZN_TEXT");
					if(newsText!=null && (newsText.length()>50)) newsText = newsText.substring(0,50);
%>
					<Tr title="<%=myNewsRet.getFieldValueString(i,"EZN_TEXT")%>">
						<Td width="5%" align=center><input type=checkbox name=chk1 value="<%=myNewsRet.getFieldValueString(i,"EZN_ID")+"$$"+myNewsRet.getFieldValueString(i,"EZN_SYSKEY")%>"></Td>
						<Td  width="45%"  ><%=newsText%></Td>
						<Td width="20%" align=center><%=startdate.substring(0,10)%></Td>
						<Td width="20%" align=center><%=enddate.substring(0,10)%></Td>
						<Td  width="10%"><%=(String)typrHash.get(nType)%></Td>
					</Tr>
<%
				}
%>
			</Table>
			</Div>
			<Div align=center id="ButtonDiv" style="position:absolute;top:90%;width:100%">
			<%
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
				buttonName.add("Add");
				buttonMethod.add("funAdd()");
				buttonName.add("Edit");
				buttonMethod.add("funEdit()");
				buttonName.add("Delete");
				buttonMethod.add("funDelete()");
				out.println(getButtonStr(buttonName,buttonMethod));
			%>
				<!--<img src="../../Images/Buttons/<%= ButtonDir%>/add.gif" border=none style="cursor:hand" title="Click Here To Add News" onClick="funAdd()">
				<img src="../../Images/Buttons/<%= ButtonDir%>/edit.gif" border=none style="cursor:hand" title="Click Here To Edit News" onClick="funEdit()">
				<img src="../../Images/Buttons/<%= ButtonDir%>/delete.gif" border=none style="cursor:hand" title="Click Here To Delete News" onClick="funDelete()">-->
			</Div>	
<%
		} // End Of myNewsRetCnt If
		else
		{
%>
			<Div align=center  style="position:absolute;top:50%;width:100%">
			<Table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="50%">
				<Tr>
<%
					if(syskey==null || "sel".equals(syskey))
					{
%>
						<Th class="displayheader" width="10%">Please select Business Area.</Th>
<%
					}
					else
					{
%>
						<Th class="displayheader" width="10%">News not found under selected Business Area.</Th>
<%
					}
%>
				</Tr>
			</Table >
			</Div>	
			
<%
			if(syskey!=null && !"sel".equals(syskey))
			{
%>			
				<Div align=center id="ButtonDiv" style="position:absolute;top:90%;width:100%">
				<%
								buttonName = new java.util.ArrayList();
								buttonMethod = new java.util.ArrayList();
								buttonName.clear();
								buttonMethod.clear();
								buttonName.add("Add");
								buttonMethod.add("funAdd()");
								out.println(getButtonStr(buttonName,buttonMethod));
				%>
					<!--<img src="../../Images/Buttons/<%= ButtonDir%>/add.gif" border=none style="cursor:hand" onClick="funAdd()">-->
				</Div>	
<%
			}
		} // End Of myNewsRetCnt Else
	} // End Of PAs If
	else
	{
%>
			<Div align=center  style="position:absolute;top:50%;width:100%">
				<Table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="50%">
					<Tr>
						<Th class="displayheader" width="10%">No Business Areas to list.</Th>
					</Tr>
				</Table >
			</Div>
			<Div align=center  style="position:absolute;top:90%;width:100%">
			<%
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
				buttonName.clear();
				buttonMethod.clear();
				buttonName.add("Back");
				buttonMethod.add("history.go(-1)");
				out.println(getButtonStr(buttonName,buttonMethod));
			%>
				<!--<img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none style="cursor:hand" onClick="javascript:history.go(-1)">-->

			</Div>
<%
	} // End Of PAs Else
%>

</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>
