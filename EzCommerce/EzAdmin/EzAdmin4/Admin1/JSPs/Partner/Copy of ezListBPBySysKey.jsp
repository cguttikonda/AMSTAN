<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iListBPBySysKey.jsp"%>
<%@ page import="java.util.*" %>
<html>
<head>
<Title>List Business Partners </Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<script src="../../Library/JavaScript/chkEditAndDelete.js"></script>
	<script src="../../Library/JavaScript/Partner/ezListBPBySysKey.js"></script>
	<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
</head>
<%
		//String searchPartner=request.getParameter("searchcriteria");
		session.putValue("myAreaFlag",areaFlag);
		session.putValue("myWebSysKey",websyskey);
		session.putValue("mySearchCriteria",searchPartner);
		if(ret.getRowCount()!=0)
		{
%>
			<body onLoad='scrollInit();document.myForm.WebSysKey.focus()' bgcolor="#FFFFF7" onResize='scrollInit()' scroll="no">
<%
		}
		else
		{
%>
			<body onLoad='scrollInit()' bgcolor="#FFFFF7"  scroll=no>
<%
		}
%>



<br>


<form name=myForm method=post action="ezListBPBySysKey.jsp" onSubmit="return chkSubmit()">

<%



		if(ret.getRowCount()>0)
		{
%>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
			<Tr align="center">
				  <Th width="35%" class="labelcell"><%=areaLabel.substring(0,areaLabel.length()-1)%>
				  </Th>
	      			  <Td width="65%" class="blankcell">
					<select name="WebSysKey" style="width:100%" id=FullListBox onChange="funsubmit()">
					<option value="sel">--Select <%=areaLabel.substring(0,areaLabel.length()-1)%>--</option>
<%
			if(websys!=null)
			{
				ret.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
				for(int i=0;i<ret.getRowCount();i++)
				{
					if(websyskey!=null)
					{
						if(websyskey.equals(ret.getFieldValue(i,SYSTEM_KEY)))
						{
%>
							<option value='<%=ret.getFieldValue(i,SYSTEM_KEY)%>' selected><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%
						}
						else
						{
%>
							<option value='<%=ret.getFieldValue(i,SYSTEM_KEY)%>'><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%
						}
					}
					else
					{
%>
						<option value='<%=ret.getFieldValue(i,SYSTEM_KEY)%>'><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%
					}
				}
			}
%>

					</select>
					</Td>
		</Tr>
	</Table>
	<%@ include file="../../../Includes/Lib/AlphabetBean.jsp" %>
<%
		String from = request.getParameter("from");
%>
		<input type="hidden" name="BPDesc" value=""  >
		<input type="hidden" name="Area" value="<%=areaFlag%>">
		<input type="hidden" name="syskey" value="" >
		<input type="hidden" name="searchcriteria" value="$">
		<input type="hidden" name="BusinessPartner" value="">
		<input type="hidden" name="from" value="<%=from%>">
		<input type="hidden" name="webSys" value="<%=websyskey%>">
<%
		if(ret1!=null && alphaTree.size()>0)
		{

			ezc.ezbasicutil.EzSearchReturn mySearch = new ezc.ezbasicutil.EzSearchReturn();
			if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=0)
			{
			  mySearch.search(ret1,"ECA_COMPANY_NAME",searchPartner.toUpperCase());
			}

			if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=0 && ret1.getRowCount()==0 && from!=null)
			{
				if(searchPartner.indexOf("*")==-1)
					searchPartner = "Equals to "+searchPartner;
				else if(searchPartner.indexOf("*")==0)
					searchPartner = "Ends with "+searchPartner.substring(searchPartner.indexOf("*")+1,searchPartner.length());
				else
					searchPartner = "Starts with "+searchPartner.substring(0,searchPartner.indexOf("*"));
%>
			<br><br><br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
			    	<Td class="displayheader" align = "center"><nobr>
					There are no Partners to list with Partner Name <%=searchPartner%>.
				</nobr>
		    		</Td>
		  	</Tr>
		  	</Table>
			<br>
			<center>
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</center>
<%
			return;
			}
			if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=0 && ret1.getRowCount()==0)
			{
%>
			<br><br><br><br>
				<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
				<Tr>
				<Td class="displayheader">
					<div align="center">There are no Partners to list with alphabet starts with "<%=searchPartner.substring(0,searchPartner.indexOf("*"))%>".</div>
				</Td>
				</Tr>
				</Table>
				<br>
				<center>
					<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
				</center>
<%
			return;
			}
		    }//ret1!=null
%>



<%
		if(ret1!=null && !"sel".equals(websyskey))
		{


			if(ret1.getRowCount()>0)
			{
%>
				<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
				<Tr align="center">
				<Td class="displayheader">List of Partners</Td>
				</Tr>
				</Table>
				<div id="theads">
				<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 >
				<Tr>
					<Th width="5%">M</Th>
					<Th width="20%">Partner</Th>
					<Th WIDTH="75%">Description</Th>
				</Tr>
				</Table>
				</div>
				<div id="InnerBox1Div">
				<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
					ret1.sort(new String[]{"ECA_COMPANY_NAME"},true);
					for(int j=0;j<ret1.getRowCount();j++)
					{
%>
						<Tr>
						<label for="cb_<%=j%>">
							<Td width="5%" align = "center"><input type="radio" name="chk1" id="cb_<%=j%>" value= '<%=ret1.getFieldValueString(j,"EBPC_BUSS_PARTNER")%>' >
							<input type="hidden" name="BPDesch" value= '<%=ret1.getFieldValueString(j,"ECA_COMPANY_NAME")%>' ></Td>
							<Td width="20%"><a href = "ezShowBPInfo.jsp?BusPartner=<%=ret1.getFieldValueString(j,"EBPC_BUSS_PARTNER")%>" class=bb><%=ret1.getFieldValueString(j,"EBPC_BUSS_PARTNER")%></a></Td>
							<Td width="75%"><%=ret1.getFieldValueString(j,"ECA_COMPANY_NAME")%></Td>
						</label>
						</Tr>

<%
					}
%>

				</Table>
				</div>
				<div style="position:absolute;top:90%;left:5%;visibility:visible">
				<Table>
				<Tr>
					<Td class="search"><a href="JavaScript:ezSearch()">Search The Business Partner By Name</a></Td>
				</Tr>
				</Table>

				</div>
				<div id="ButtonDiv" align="center" style="position:absolute;top:85%;width:100%">
					<img src="../../Images/Buttons/<%= ButtonDir%>/summary.gif" style="cursor:hand" onClick="funSummary('<%=areaLabel.substring(0,areaLabel.length()-1)%>')">
					 <img src="../../Images/Buttons/<%= ButtonDir%>/modify.gif" style="cursor:hand" onClick="funCheckBoxSingleModify('<%=areaLabel.substring(0,areaLabel.length()-1)%>')">
					<img src="../../Images/Buttons/<%= ButtonDir%>/modifypartnersystems.gif" style="cursor:hand" onClick="funCheckBoxSingleMPS('<%=areaLabel.substring(0,areaLabel.length()-1)%>')">
					<img src="../../Images/Buttons/<%= ButtonDir%>/delete.gif" style="cursor:hand" onClick="funDeleteBP()">
	
					<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


				 </div>
<%				}

			else
			{
				if(ret1!=null)
				{
					if( !"sel".equals(websys))
					{
%>	




			<br><br><br><br>
				<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
					<Tr>
			    		<Td class="displayheader">
    		      			<div align="center">No Partners To List In This <%=areaLabel.substring(0,areaLabel.length()-1)%></div>
		    			</Td>
		  			</Tr>
		  		</Table>
	<br>
				<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
				</center>


<%					}
				}
			}
		}//ret1!=null&&sel.equls(websyskey)
			else
			{
%>
				<br><br>
				<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
				<Tr>
					<Td class = "labelcell">
						<div align="center"><b>Please Select <%=areaLabel.substring(0,areaLabel.length()-1)%> to continue.</b></div>
					</Td>
				</Tr>
				</Table>
		<br>
				<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
				</center>


<%
				}
			}//ret.getRowount()
			else
			{
%>
				<br>
				<br>
				<br>
				<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
				<Tr>
				    <Td class="displayheader">
				      <div align="center">No <%=areaLabel%> To List Partners</div>
				    </Td>
				  </Tr>
				  </Table>
	  				<input type="hidden" name="Area" value="<%=areaFlag%>">
				<br>
					<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
					</center>


<%
			}
%>
</form>
</body>
</html>
