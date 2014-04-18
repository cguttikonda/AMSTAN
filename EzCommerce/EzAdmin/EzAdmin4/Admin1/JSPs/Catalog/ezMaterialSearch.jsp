<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iMaterialSearch.jsp"%>
<Head>
<Title>Search Materials</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
</Head>
<Body onLoad='scrollInit()' onresize='scrollInit()' scroll="no">
<form name=myForm method=post onSubmit="">
<%
	String areaFlag="C"; 
	int retCount = searchRet.getRowCount();
	if(retCount==0)
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  		<Tr>
    			<Th>There are no <%=msg%> to List as per your search criteria.</Th>
  		</Tr>
		</Table>
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
                </center>
<%
		return;
	}
%>
<br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
<Tr>
	<Th>Search Materials</Th>
</Tr>
</Table>
<div id="theads">
<Table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<Tr>
<%
	if("matDesc".equals(searchBy))
	{
%>
		<Th width = "40%">Material Code</Th>
		<Th width = "60%">Description</Th>
<%
	}
	if("matCode".equals(searchBy)&&("G".equals(searchPattern)))
	{

%>		<Th width = "40%">Material Group</Th>
		<Th width = "60%">Description</Th>
<%
	}
	if("matCode".equals(searchBy)&&("GS".equals(searchPattern)))
	{
%>		
		<Th width = "15%">Material Group</Th>
		<Th width = "30%">Description</Th>
		<Th width = "55%">Sales Area</Th>
<%
	}
	if("matCode".equals(searchBy)&&("GSC".equals(searchPattern)))
	{
%>		
		<Th width = "30%">Material Group</Th>
		<Th width = "50%">Sales Area</Th>
		<Th width = "20%">Catalog</Th>
<%
	}
	if("matGrp".equals(searchBy)&&("S".equals(searchPattern)))
	{
%>		
		<Th width = "30%">System Key</Th>
		<Th width = "70%">Sales Area</Th>
<%
	}
	if("matGrp".equals(searchBy)&&("C".equals(searchPattern)))
	{
%>		
		<Th width = "30%">Catalog Number</Th>
		<Th width = "70%">Description</Th>
<%
	}	
%>
</Tr>
</Table>
</div>
<DIV id="InnerBox1Div">
<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
	if("matDesc".equals(searchBy))
	{
		for(int i=0;i<retCount;i++)
		{
			String myMatNo = searchRet.getFieldValueString(i,"MATNO");		
			try
			{
				myMatNo = ""+Long.parseLong(myMatNo);
			}
			catch(Exception e)
			{
				
			}
%>
			<Tr>
				<Td width = "40%"><%=myMatNo%></Td>
				<Td width = "60%"><%=searchRet.getFieldValueString(i,"WEBDESC")%></Td>
			</Tr>
<%	
		}
	}
	if(("matCode".equals(searchBy)&&("G".equals(searchPattern))))
	{
		for(int i=0;i<retCount;i++)
		{
%>
			<Tr>
				<Td width = "40%"><%=searchRet.getFieldValueString(i,"MATGRP")%></Td>
				<Td width = "60%"><%=searchRet.getFieldValueString(i,"MATWEBDESC")%></Td>
			</Tr>
<%
		}
	}
	if("matCode".equals(searchBy)&&("M".equals(searchPattern)))
	{
		for(int i=0;i<retCount;i++)
		{
%>
			<Tr>
				<Td width = "40%"><%=searchRet.getFieldValueString(i,"MATNO")%></Td>
				<Td width = "60%"><%=searchRet.getFieldValueString(i,"WEBDESC")%></Td>
			</Tr>
<%
		}
	
	}
	if("matCode".equals(searchBy)&&("GS".equals(searchPattern)))
	{
		for(int i=0;i<retCount;i++)
		{
%>
	
			<Tr>
				<Td width = "15%">
				<a href = "javascript:openWin('<%=searchRet.getFieldValueString(i,"MATGRP")%>','<%=searchRet.getFieldValueString(i,"SYSKEY")%>')">
					<%=searchRet.getFieldValueString(i,"MATGRP")%>
				</a>
				</Td>
				<Td width = "30%"><%=searchRet.getFieldValueString(i,"MATGRPDESC")%></Td>
				<Td width = "55%"><a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=searchRet.getFieldValueString(i,"SYSKEY")%>"><%=searchRet.getFieldValueString(i,"SYSKEYDESC") %> (<%=searchRet.getFieldValueString(i,"SYSKEY")%>)&nbsp;</a></Td>
			</Tr>
<%
		}
	}
	if("matCode".equals(searchBy)&&("GSC".equals(searchPattern)))
	{
		for(int i=0;i<retCount;i++)
		{
%>
			<Tr>
				<Td width = "30%">
				<a href = "javascript:openWin('<%=searchRet.getFieldValueString(i,"MATGRP")%>','<%=searchRet.getFieldValueString(i,"SYSKEY")%>')">
					<%=searchRet.getFieldValueString(i,"MATGRPDESC")%> (<%=searchRet.getFieldValueString(i,"MATGRP")%>)
				</a>
				</Td>
				<Td width = "50%"><a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=searchRet.getFieldValueString(i,"SYSKEY")%>"><%=searchRet.getFieldValueString(i,"SYSKEYDESC") %> (<%=searchRet.getFieldValueString(i,"SYSKEY")%>)&nbsp;</a></Td>


				<Td width = "50%">
			
<%
					String desc=(String)searchRet.getFieldValueString(i,"CATDESC");
					String catNum=(String)searchRet.getFieldValueString(i,"CATNUM");
					String systemKey=searchRet.getFieldValueString(i,"SYSKEY");
					if(!desc.equals("No Catalogs Selected"))
					{
%>
          	  				<a href = "../Catalog/ezShowCatalog.jsp?CatNumber=<%=catNum%>&catDesc=<%=desc%>&SystemKey=<%=systemKey%>"><%=desc%> (<%=catNum%>)</a>
<%
					}
					else
					{
%>
						<%= desc %>
<%
					}


%>
				</Td>
			</Tr>
<%
		}
	}
	if("matGrp".equals(searchBy)&&("S".equals(searchPattern)))
	{
		for(int i=0;i<retCount;i++)
		{
%>

			<Tr>
				<Td width = "30%"><%=searchRet.getFieldValueString(i,"SYSKEY")%>
				</Td>
				<Td width = "70%"><a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=searchRet.getFieldValueString(i,"SYSKEY")%>"><%=searchRet.getFieldValueString(i,"SYSKEYDESC") %></a>
				</Td>
				
			</Tr>
<%
		}
	}
	if("matGrp".equals(searchBy)&&("C".equals(searchPattern)))
	{
		for(int i=0;i<retCount;i++)
		{
%>
			<Tr>
				<Td width = "30%"><%=searchRet.getFieldValueString(i,"CATNUM")%></Td>
				<Td width = "70%">
				
				
				<%
					String desc=(String)searchRet.getFieldValueString(i,"CATDESC");
					String catNum=(String)searchRet.getFieldValueString(i,"CATNUM");				
					if(!desc.equals("No Catalogs Selected"))
					{
%>
          	  				<a href = "../Catalog/ezShowCatalog.jsp?CatNumber=<%=catNum%>&catDesc=<%=desc%>"><%=desc%></a>
<%
					}
					else
					{
%>
						<%= desc %>
<%
					}


%>				</Td>
			</Tr>
<%
		}
	}
%>
</Table>
</div>
<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">		
 	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</div>
<script>
function openWin(groupNum,sysKey)
{
	var url = "ezChangeProdDesc.jsp?ProductGroup=" + groupNum + "&SystemKey=" + sysKey + "&Language=" +"EN"+  "&target=products"
	window.open(url,"UserWindow","width=790,height=500, left = 0 top = 0 resizable=no, menubar = no locationbar = no scrollbars=yes");
}
</Script>
</body>
</html>