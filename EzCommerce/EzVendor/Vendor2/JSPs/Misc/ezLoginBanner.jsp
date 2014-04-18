
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />
<%@ include file="../../Library/Globals/ezBannerErrPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iLoginBanner.jsp" %>
<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,java.io.FileOutputStream,javax.xml.transform.stream.StreamResult" %>
<%
	String XMLsupportid="";
	try
		{
			DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

			String fileName = "ezLoginBanner.jsp";
			String filePath=request.getRealPath(fileName);
			filePath=filePath.substring(0,filePath.indexOf(fileName));
			String filePath1 = filePath+"\\..\\..\\..\\..\\EzCommon\\XMLs\\ezData.xml";
			java.io.File fileObj = new java.io.File(filePath1);
			if(!fileObj.exists())
			{
				filePath1 = filePath+"\\EzCommerce\\EzCommon\\XMLs\\ezData.xml";
			}

			Element element=null;
			Node node=null;
			Document doc = docBuilder.parse("file:"+filePath1);
			Element root = doc.getDocumentElement();

			NodeList list = root.getElementsByTagName("EzVendor");
			node=list.item(0);
			XMLsupportid = ((Element)node).getElementsByTagName("support").item(0).getFirstChild().getNodeValue();
			if(XMLsupportid == null || "null".equals(XMLsupportid))
				XMLsupportid = "";
			 
			
			
		}
	catch(Exception e){}




%>

<Html>
<Head>
	<Script src="../../Library/JavaScript/ezStatus.js"></Script>
	<Script src="../../Library/JavaScript/ezTrim.js"></Script>
	<Script src="../../Library/JavaScript/Misc/ezLoginBanner.js"></Script>
	<link rel="stylesheet" href="../../Library/Styles/Banner/ezBannerPink.css">
	<script>
	function callFun(clickedOn)
	{
		if(clickedOn=='H')
		{
			top.display.location.href = "../Misc/ezSBUWelcomeWait.jsp";
		}	
		else if(clickedOn=='L')
		{
			top.location.href='../Misc/ezLogout.jsp'
		} 
	}
	function changePurArea1()
	{
		if(confirm("Do you want to continue with the selected Purchase Area?"))
		{
			var selcatarea=document.myForm.CatalogArea.value;
			document.myForm.callPreWelcomePage.value="Y";
			document.myForm.target="banner"
			document.myForm.changePurArea.value="Y";
			document.myForm.action = "ezLoginBanner.jsp?CatalogArea="+selcatarea;
			document.myForm.submit();
		}
		else
		{
			document.myForm.CatalogArea.options[document.myForm.selPAIndex.value].selected=true;
		}

	}
	function changeVendor(mFlag)
	{
		document.myForm.callPreWelcomePage.value="S";
		if(mFlag == 'Y')
		{

			document.myForm.target="banner"
			document.myForm.action="ezLoginBanner.jsp";
			document.myForm.submit();
		}
		else
		{
			if(confirm("Do you want to continue with the selected vendor?"))
			{
				var vendorDetails 	= document.myForm.Vndr.options[document.myForm.Vndr.options.selectedIndex].value
				var vendorData		= vendorDetails.split("#")	
				document.myForm.VENDOR_CODE.value = vendorData[0]
				document.myForm.VENDOR_NAME.value = vendorData[1]
				document.myForm.target="banner"
				document.myForm.action="ezLoginBanner.jsp";
				document.myForm.submit();
			}
			else
			{
				document.myForm.Vndr.options[document.myForm.selVNIndex.value].selected=true;
			}
		}
	}	
	
	</script>
<Style>	
.tx {
	border:0;
	background-color:#0C517B;
	text-align:left;
}
</Style>
</Head>
<Body leftMargin=0 topMargin=0 MARGINWIDTH="0" MARGINHEIGHT="0" onLoad="startBanner()">
<Form name="myForm" method="POST">
<input type=hidden name='changePurArea' value='N'>

<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0 >
<TR width="100%">
<TD width="0%" valign=top bgcolor="#0C517B">
	
			<a href="../Misc/ezSBUWelcomeWait.jsp" target="right"><IMG src="../../../../EzCommon/Images/Banner/images.jpg" border=0></a>
			<!--<IMG src="../../../../EzCommon/Images/Banner/mud-pie-logo.jpg" border=0  WIDTH=250 HEIGHT=83>-->
			<!-- <IMG src="../../../../EzCommon/Images/Banner/pbm_logo.jpg" border=0 WIDTH=250 HEIGHT=75> -->
			<!--<IMG src="../../../../EzCommon/Images/Banner/akrimax.gif" border=0 WIDTH=250 HEIGHT=80>-->

			<!--<IMG src="../../../../EzCommon/Images/eitny/logoheader.gif" border=0 width=100%> -->
		
</TD>

	<TD width="95%" valign=top background='../../../../EzCommon/Images/Banner/banner_extBKP.jpg'>
		<Table align=right  width="100%" height=100% border="0" cellspacing="0" cellpadding="5">
		<Tr>
			<Td align=center valign=top >
				<Font color='#FFFFFF' size=2  face="Tahoma"> <b> Welcome <i><%=fullName%></i> to Procurement Portal</b>
			</Td>
			<Td valign=top align=right>
				<Font color='#FFFFFF' size=2  face="Tahoma">
					
					
					<img src="../../../../EzCommon/Images/Banner/ic_logout.gif" border=no title='Logout' style="cursor:hand"><a  href="javascript:callFun('L')">logout</a>
					&nbsp;
				</Font>
			</Td>	
		</Tr>  
		<Tr>
	<%
			String showDisplayFrame = "N";
			if (catareaRows > 0)
			{
				String purGroupArea = "",purGroupCode = "";
				String purGroupDesc = "",domainType   = "";
				String companyCode  = "";
				String selectLabel  = "";
				String bannerLabel = "";
				/*if("3".equals(userType))
					bannerLabel = "Company Code";
				else*/
					bannerLabel = "Purchase Group";
				
				String selected = "";
				int selPAIndex = 0;
				int selVNIndex = 0;
				String colSpan = "";
				String selWidth= "";
				String colAlign= "";
				String colSpace= "";
				int soldtoRows = 0;
				if(retsoldto!=null)
					soldtoRows = retsoldto.getRowCount();
				if("3".equals(userType) || soldtoRows == 0)
				{
					colSpan = "colspan=3";
					selWidth= "width:30%";
					colAlign= "align=right"; 
					colSpace= "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				}	
				else		
				{
					colSpan = "";
					selWidth= "width:60%";
					colAlign= "align=left"; 
					colSpace= "";
				}
	%>	
				<Td width=40% valign=bottom <%=colAlign%> <%=colSpan%>>
				<Font color='#FFFFFF' size=2 face="Tahoma">
				<b><%=bannerLabel%>&nbsp;:&nbsp;</b></font>
				<Select name="CatalogArea" onChange="changePurArea1()" style="<%=selWidth%>">
	<%		
				for ( int i = 0 ; i < catareaRows; i++ )
				{
					domainType = retUserPurAreas.getFieldValueString(i,"ESKD_SUPP_CUST_FLAG");
					if("C".equals(domainType.trim())) 
						continue;
					purGroupArea	= retUserPurAreas.getFieldValueString(i,"ESKD_SYS_KEY");
					purGroupDesc 	= retUserPurAreas.getFieldValueString (i,"ESKD_SYS_KEY_DESC");
					purGroupCode	= (String)purGroupsHash.get(purGroupArea);
					companyCode	= (String)ccHash.get(purGroupArea);
					/*if("3".equals(userType))
						selectLabel  = companyCode;
					else*/	
						selectLabel  = purGroupCode+" --> "+purGroupDesc;
	
					
					if(purGroupArea.equals(purchaseArea))
					{
						selected = "selected";
						selPAIndex = i;
					}	
					else
						selected = "";
	%>
					<option <%=selected%> value="<%=purGroupArea%>"><%=selectLabel%></option>
	<%			
				}
	%>
				</select>
				</Font><%=colSpace%>
			</Td>

<%
			boolean noVendor = false;
			String retVendorCode = "";
			String retVendorName = "";
			String selVendorCode = "";
			String selVendorName = "";

			if(!"3".equals(userType))
			{
				if(retsoldto!=null)
				{
					if(soldtoRows > 0)
					{
%>					
						<Td width=45% valign=bottom align=left>
						<Font color='#FFFFFF' size=2 face="Tahoma"><b>Vendor&nbsp;:&nbsp;</b></font>
<%
						if(soldtoRows == 1)
						{
							selVendorCode = retsoldto.getFieldValueString(0,"EC_ERP_CUST_NO").trim();
							selVendorName = retsoldto.getFieldValueString(0,"ECA_NAME").trim();
%>
							<input type=hidden name='Vndr' value='<%=selVendorCode%>'>
							<input type=text class='tx' value='<%=selVendorCode+" --> "+selVendorName%>'>
<%
						}
						else
						{
%>
						
							<Select name="Vndr" onChange="changeVendor('N')" style="width:60%">
<%					
							for(int i=0;i<soldtoRows;i++)
							{
								retVendorCode = retsoldto.getFieldValueString(i,"EC_ERP_CUST_NO").trim();
								retVendorName = retsoldto.getFieldValueString(i,"ECA_NAME").trim();
								if((vendorCode.trim()).equals(retVendorCode.trim()))
								{
									selected = "selected";
									selVNIndex = i;
									selVendorCode = retVendorCode;
									selVendorName = retVendorName;
								}	
								else
									selected = "";
%>
								<option <%=selected%> value="<%=retVendorCode+"#"+retVendorName%>"><%=retVendorCode.trim()%> ---> <%=retVendorName%></option>
<%
							}
							if(selVNIndex == 0)
							{
								selVendorCode = retsoldto.getFieldValueString(0,"EC_ERP_CUST_NO").trim();
								selVendorName = retsoldto.getFieldValueString(0,"ECA_NAME").trim();
							}
							noVendor = false;
%>
							</Select>
<%
						}
%>
						</Td>
						<input type=hidden name="VENDOR_CODE" value="<%=selVendorCode%>">
						<input type=hidden name="VENDOR_NAME" value="<%=selVendorName%>">	
						<input type="hidden" name="selVNIndex" value="<%=selVNIndex%>">
<%
						showDisplayFrame = "Y";
					}
					else
					{
						noVendor = true;
					}
				}
				else
				{
					noVendor = true;
					showDisplayFrame = "N";
				}
				if(noVendor)
				{
%>
					<script>
						document.getElementById("home_mail").style.visibility="hidden"
						top.display.location.href='ezBlank.jsp?statement=Vendors not synchronized';
					</script>
<%
					showDisplayFrame = "N";
				}
			}
			else
			{
				showDisplayFrame = "Y";
			}
%>
			<input type="hidden" name="selPAIndex" value="<%=selPAIndex%>">
<%
		}
		else
		{
%>
			<script>
				document.getElementById("home_mail").style.visibility="hidden"
				top.display.location.href='ezBlank.jsp?statement=Purchase Groups not defined...Please contact Administrator';
			</script>
<%
			showDisplayFrame = "N";
		}
%>
	</Tr>
	<TR><TD colspan=2>&nbsp;</TD></TR>
	</Table>
</TD>
<TR>
</Table>
<input type="hidden" name="callPreWelcomePage">
</Form>
<Script>
<%
	if("Y".equals(showDisplayFrame))
	{
%>
		top.display.document.location.href="ezSBUWelcomeWait.jsp"
<%
	}
%>
</Script>
</BODY>
</HTML>