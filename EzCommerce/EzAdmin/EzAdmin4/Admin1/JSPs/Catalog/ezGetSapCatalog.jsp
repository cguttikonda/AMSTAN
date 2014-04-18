<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iGetSapCatalog.jsp"%>

<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<script src="../../Library/JavaScript/Catalog/ezGetSapCatalog.js" ></script>
	<Script src="../../Library/JavaScript/ezTabScroll.js"></script>

	<Title>ezGetSapCatalog</Title>
</head>
<body  onLoad="scrollInit()" onResize = "scrollInit()">
<form name=myForm method=post action="../Catalog/Synchronize.jsp">
<br>

	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="89%">
	<Tr align="center">
		<Td class="displayheader">Products Synchronization</Td>
	</Tr>
	</Table>

<%
	ReturnObjFromRetrieve retobj = (ReturnObjFromRetrieve)ret.getObject("OffsetTable");
	retobj.check();

	//Total levels in the catalog
	int iTotalCells = retobj.getRowCount();
	int totalchk =0;

	String testoffset1 = retobj.getFieldValueString(0, "OFFSET");
	String testoffset2 = retobj.getFieldValueString(1, "OFFSET");
	String testoffset3 = retobj.getFieldValueString(2, "OFFSET");
	retobj.toEzcString();
	if (ret!= null && ret.getRowCount() > 0)
	{
%>
		<div id="theads">
		<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="80%">
		<Tr>
			<Th width="80%" colspan="<%=iTotalCells%>"> Product Groups</Th>
			<Th width="10%"> Show All</Th>
			<Th width="10%"> Image</Th>
		</Tr>
		</Table>
		</div>

		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
<%
		int Rows = ret.getRowCount();
		int level=0,offset,chklen;
		String stroffset=null,chkname=null,chkFullName=null,groupSelected=null;
		String deleteFlag=null;
		int x=0;
		for ( int i = 0 ; i <  Rows; i++ )
		{
			deleteFlag = ret.getFieldValueString(i,"EPG_DELETION_FLAG");
			if (deleteFlag.equals("N"))
			{
				level = ((java.math.BigDecimal)ret.getFieldValue(i,PROD_GROUP_LEVEL)).intValue();
				if(level==0) level=1;
%>
				<Tr>
<%
				for ( int j = 0 ; j < (level -1); j++ )
				{
					if (level != 1)
					{
%>
						<Td>&nbsp;</Td>
<%
					}
				}
				// Get the offset for a particular level
				stroffset = retobj.getFieldValueString((level-1), "OFFSET");
				try 
				{
					offset = (new Integer(stroffset)).intValue();
				}
				catch(Exception e) 
				{
					offset = 0;
				}
				chkname = ret.getFieldValueString(i,PROD_GROUP_NUMBER);
				chkFullName = chkname;
				if ( chkname != null ) chkname = chkname.trim();
				chklen = chkname.length();
				for ( int m = 0; m < (18-chklen); m++ )
					chkname = chkname + " ";
				chkname = chkname.substring(0, offset);
				//chkname = "'"+chkname+"'";
				chkname = "'"+chkname+"'##"+ret.getFieldValue(i,PROD_GROUP_LEVEL);
%>
				<label for="cb_<%=x%>">
				<Td align="left">
<%
				groupSelected =ret.getFieldValueString(i,CATALOG_GROUP_CHECKED);
				totalchk=totalchk+1;
				if (groupSelected.equals("Y"))
				{
%>
        				<input type="checkbox"  name="CheckBox" id=cb_<%=x%>" value="<%=chkname%>" checked  onClick = "SelectChk( <%=i%>, this, (this.value).substring(1,<%=(offset+1)%>) , <%=offset%>, <%=String.valueOf(level)%>)" > <!-- onClick="enableCheck('C','<% //=i%>')">-->
<%
				}
				else
				{
%>
					<input type="checkbox" name="CheckBox" id="cb_<%=x%>" value="<%=chkname%>" unchecked onClick = "SelectChk( <%=i%>, this, (this.value).substring(1,<%=(offset+1)%>) , <%=offset%>, <%=String.valueOf(level)%>)" >
<%
				}
%>
				<%=(ret.getFieldValue(i,PROD_GROUP_WEB_DESC))%>
				</Td>
				</label>
<%
				x++;
				for ( int k = 0 ; k < (iTotalCells - level)  ; k++ )
				{
%>
					<Td>&nbsp;</Td>
<%
				}
%>
				<label for="cb_<%=x%>">
				<Td valign="top" align="center" width="10%">
<%
				if ( level == 1 && groupSelected.equals("Y") )
				{
%>
					<input type="checkbox" name="ShowAll" id="cb_<%=x%>" value="Selected" checked  onClick="enableCheck('S','<%=i%>')">
<%
				}
				else
				{
%>
					<input type="checkbox" name="ShowAll" id="cb_<%=x%>" value="Selected" unchecked>
<%
				}
				x++;
%>
				</Td>
				</label>
				<label for="cb_<%=x%>">
				<Td valign="top" align="center" width="9%">
<%
				if ( level == 1  && groupSelected.equals("Y") )
				{
%>
					<input type="checkbox"  name="ImageFlag" id="cb_<%=x%>" value="Selected" checked  onClick="enableCheck('I','<%=i%>')">
<%
				}
				else
				{
%>
					<input type="checkbox" name="ImageFlag" id="cb_<%=x%>" value="Selected" unchecked>
<%
				}
%>
				<input type="hidden" name="ProductGroup" value=<%=ret.getFieldValue(i,PROD_GROUP_NUMBER)%> >
				<input type="hidden" name="GroupLevel" value=<%=ret.getFieldValue(i,PROD_GROUP_LEVEL)%> >
				</Td>
<%			
				x++;
%>
				</label>
      				</Tr>
<%
			}//End if
		}//End for
%>
		<input type="hidden" name="TotalCount" value=<%=Rows%> >
		<input type="hidden" name="TotalChk" value=<%= totalchk%> >
		<input type="hidden" name="SysKey" value=<%=Sys_Key%>  >
		<input type="hidden" name="DUMMYGROUP" value="N">
		</Table></div>
		<div id="ButtonDiv"  align="center" style="position:absolute;visibility:visible;top:90%;width:100%">
		<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/synchronize.gif" name="Submit" value="Synchronize" onClick="AddCheckSelect();return document.returnValue">
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</div>
<%
	}
	else
	{
	/** Following Html/ Jsp code adde by Venkat on 9/21/2001 for Flextronics **/
%>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr>
			<Td align=right>
			Default Product Group
			</Td>
			<Td><input type=text class = "InputBox" name="ProductGroup" value=""></Td>
		</Tr>
		</Table>
		<br>
		<center>
			<input type="image" name="Submit" src = "../../Images/Buttons/<%= ButtonDir%>/synchronize.gif" value="Synchronize" onClick="SyncWH();return document.returnValue">
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>

		<!-- ** Added by Venkat on 9/21/2001 for Flextronics **
		 ** Do not remove any of the following lines     **
		** -->

		<Table >
		<Tr>
		<Td align="center" >
		<input type="hidden" name="TotalCount" value="1">
		<input type="hidden" name="SysKey" value="<%=Sys_Key%>" >
		<input type="hidden" name="CheckBox_0" value="DUMMY">
		<input type="hidden" name="GroupLevel_0" value="1">
		<input type="hidden" name="ShowAll_0" value="selected">
		<input type="hidden" name="ImageFlag_0" value="selected">
		<input type="hidden" name="DUMMYGROUP" value="Y" >
		</Td>
		</Tr>
		</Table>
<%
	}
%>
</form>
</body>
</html>


