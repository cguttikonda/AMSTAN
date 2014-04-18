<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/News/iListNews.jsp"%>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Html>
<Head>
<Script>
	 var tabHeadWidth=89
 	 var tabHeight="50%"
</Script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
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
<%
		String purGrpTemp  = "";	
		String purGrpDesc  = "";
		String display_header	= "  News  ";
	
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp" %>
		
		<Div id='inputDiv' style='position:relative;align:center;top:1%;width:100%;height:15%'>
			<Table width="40%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
				<Tr>
					<Td height="5" style="background-color:'#F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
					<Td height="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
					<Td height="5" style="background-color:'#F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
				</Tr>
				<Tr >
					<Td width="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
					<Td style="background-color:'#F3F3F3'" valign=middle>
						<Table border="0" align="center" valign=middle width="100%" cellpadding=1 cellspacing=1 class=welcomecell>
						<Tr>
							<Td style='background:##F3F3F3;font-size=11px;color:#00355D;font-weight:bold' width='35%' align=left>
								&nbsp;&nbsp; Purchase Group*
							</Td>
							<Td style='background:##F3F3F3;font-size=11px;color:#00355D;font-weight:bold' width='55%' align=right>
							<Select name="syskey" style="width:100%" id=listBoxDiv >
								
		<%
									while(purGrpEnum.hasMoreElements()){
										purGrpTemp = (String)purGrpEnum.nextElement();
										purGrpDesc = (String)purGroupsHash.get(purGrpTemp);
												
										if(syskey!=null){
											if(syskey.equals(purGrpTemp)){
		%>
												<Option value="<%=purGrpTemp%>" selected><%=purGrpDesc%></Option>
		<%
											}
											else{
		%>
												<Option value="<%=purGrpTemp%>" ><%=purGrpDesc%> </Option>
		<%
											}
										}
										else{
		%>
												<Option value="<%=purGrpTemp%>" ><%=purGrpDesc%> </Option>
		<%
										}
									}
		%>
							</Select>
							</Td>
							<Td style='background:##F3F3F3' align=center>
								<Img src="../../../../EzCommon/Images/Body/left_arrow.gif" style="cursor:hand" border="none" onClick="funNewsList()" onMouseover="window.status=' Click on go to View News '; return true" onMouseout="window.status=' '; return true">
							</Td>
						</TR>
						</Table>
					</Td>
					<Td width="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
				</Tr>
				<Tr>
					<Td width="5" style="background-color:'#F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
					<Td height="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
					<Td width="5" style="background-color:'#F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
				</Tr>
				</Table>
		</Div>		
<%
		if(myNewsRetCnt>0){
%>
			<Div id="theads">
			<Table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
			<Tr>
				<Th class="displayheader" width="5%"  ><input type=checkbox name=tochkall onclick='checkAll(this)'></Th>
				<Th class="displayheader" width="49%" >News</Th>
				<Th class="displayheader" width="18%" >Start Date</Th>
				<Th class="displayheader" width="18%" >End Date</Th>
				<Th class="displayheader" width="10%" >News Type</Th>
			</Tr>
			
			</Table >
			</Div>

			<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:89%;height:50%;left:2%">
			<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
<%
				int rowCount=myNewsRet.getRowCount();
				String nType ="",newsText="";
				for(int i=0;i<rowCount;i++)
				{
					nType 		= myNewsRet.getFieldValueString(i,"EZN_TYPE");
					newsText 	= myNewsRet.getFieldValueString(i,"EZN_TEXT");
					if(newsText!=null && (newsText.length()>50)) newsText = newsText.substring(0,50);
%>
					<Tr title="<%=myNewsRet.getFieldValueString(i,"EZN_TEXT")%>">
						<Td width="5%" align=center><input type=checkbox name=chk1 value="<%=myNewsRet.getFieldValueString(i,"EZN_ID")+"$$"+myNewsRet.getFieldValueString(i,"EZN_SYSKEY")%>"></Td>
						<Td  width="49%"  ><%=newsText%></Td>
						<Td width="18%" align=center><%=FormatDate.getStringFromDate((Date)myNewsRet.getFieldValue(i,"START_DATE_CHAR"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></Td>
						<Td width="18%" align=center><%=FormatDate.getStringFromDate((Date)myNewsRet.getFieldValue(i,"END_DATE_CHAR"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></Td>
						<Td  width="10%"><%=(String)typrHash.get(nType)%></Td>
					</Tr>
<%
				}
%>
			</Table>
			</Div>
			
<%
		} // End Of myNewsRetCnt If
		else{
			 String noDataStatement =  "News not found under selected Purchase Group.";
			
			 
%>
				<%@ include file="../Misc/ezDisplayNoData.jsp" %>				
			
<%
		}
		
%>
<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	
	
		buttonName.add("Back");
		buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");

		buttonName.add("Add");
		buttonMethod.add("funAdd()");
	
		if(myNewsRetCnt>0){
			buttonName.add("Edit");
			buttonMethod.add("funEdit()");

			buttonName.add("Delete");
			buttonMethod.add("funDelete()");
		}
		out.println(getButtonStr(buttonName,buttonMethod));
		

	
%>
</center>
</div>
<%@ include file="../Misc/AddMessage.jsp" %>
</Form>
</Body>
<Div id="MenuSol"></Div>

</Html>
