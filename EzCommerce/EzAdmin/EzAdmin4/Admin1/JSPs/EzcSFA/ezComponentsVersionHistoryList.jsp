<%--***************************************************************
       /* Copyright Notice =====================================*
	* This file contains proprietary information of EzCommerce Inc.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2003-2004 =====================================*/

       /* Author : Arun Chowdary Nekkanti
	* Team   : Admin
	* Date   : 10-2-2003
	* Copyright (c) 2003-2004 =====================================*/
*****************************************************************--%>

<%@ include file="../../Library/Globals/errorPagePath.jsp"%>

<%@ include file="../../../Includes/JSPs/EzcSFA/iComponentsVersionHistoryList.jsp"%>
<Html>
<Head>
	<Title>EzComponents Version History List----Powered by Ezcommerce Global Solutions</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<script src="../../Library/JavaScript/ezTabScroll.js"></script>
	<script src="../../Library/JavaScript/chkEditAndDelete.js"></script>
	<script src="../../Library/JavaScript/Components/ezComponentsVersionHistoryList.js"></script>

</Head>
<body onLoad="scrollInit()" scroll=no onResize="scrollInit()">
<Form name=myForm method="post" onSubmit="return go()" >
<%
		if(ComponentVersionHistoryListCount==0)
		{

%>
				<Div id="tabHead" align=center style="position:absolute;top:40%;width:100%">
				<Table align="center">
				<Tr>
					<Th class=nolabelcell> No Components Versions History To List</Th>
				</Tr>
				<Tr>
					<Th class=nolabelcell>Please Click 'Add' To Add A Component Versions History</Th>
				</Tr>
				<Tr>
					<Th class=nolabelcell><input type=image src="../../Images/Buttons/<%=ButtonDir%>/add.gif"  alt="Add" border=no onClick="fun(1)"></Th>
				</Tr>
				</Table>
				</Div>
<%
			}
			else
			{
%>

		<Br>
		<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
		<Tr>
			<Th class="displayheader" align=center>List Of Component Versions History</Th>
		</Tr>
		</Table>
		<Div id="theads">
		<Table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
		<Tr>
			<Th width="25%">History No</Th>
			<Th width="25%">Version</Th>
			<Th width="25%">Released On</Th>
			<Th width="25%">Patch</Th>

		</Tr>
		</Table>
		</Div>
			<Div id="InnerBox1Div">
			<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
<%
				String relOn;
				for(int i=0;i<ComponentVersionHistoryListCount;i++)
				{
					relOn=retComponentVersionHistoryList.getFieldValueString(i,"RELEASED_ON").substring(0,10);


		if(relOn!=null)
		{
		java.util.StringTokenizer st=new java.util.StringTokenizer(relOn,"-");
		String Year=st.nextToken();
		String Month=st.nextToken();
		String Day=st.nextToken();
		relOn=Day+"-"+Month+"-"+Year;
		}


%>
					<Tr>
						<Td width="25%" ><Input type="Text" class="textInBox" value='<%=retComponentVersionHistoryList.getFieldValue(i,"HISTORY_NO")%>'size="22%" readonly></Td>
						<Td width="25%"><Input type="Text" class="textInBox" value='<%=retComponentVersionHistoryList.getFieldValue(i,"VERSION")%>'size="22%" readonly></Td>
						<Td width="25%" align="center"><Input type="Text" name="d" class="textInBox" value='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=relOn%>' size="22%" readonly></Td>
						<Td width="25%"><Input type="Text" name="d" class="textInBox" value='<%=retComponentVersionHistoryList.getFieldValue(i,"PATCH")%>' size="22%" readonly></Td>

					</Tr>
<%
				}
%>

			</Table>
			</Div>
			<Div id="ButtonDiv" align=center style="position:absolute;top:90%;width:100%">
			<Table border=0 align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width=35%>
			<Tr>
				<Td class="blankcell" align=center>
					<a href="javascript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif"  alt="Back" border=no style="cursor:hand"></a>
				</Td>
			</Tr>
			</Table>
			</Div>

<%
		}
%>

	</Form>
</Body>
</Html>
