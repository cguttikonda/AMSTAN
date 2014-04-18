<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<script>
function news(id)
{
	attach=window.open("../News/ezNewsPopup.jsp?newsid="+id,"UserWindow1","width=700,height=200,left=150,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
}
</script>
<% 
	String loadPage 	= request.getParameter("loadPage");
	if(loadPage == null || "".equals(loadPage.trim()))
		loadPage = "Y";
	if("Y".equals(loadPage))
	{
%>
		<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
		<%@ include file="../../../Includes/JSPs/Labels/iSBUWelcome_Labels.jsp"%>
		<%@ page import ="ezc.ezparam.*,java.util.*,ezc.ezutil.*,ezc.ezvendorapp.params.*,ezc.ezpurchase.params.*,ezc.messaging.params.*" %>
		<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page"></jsp:useBean>
		<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="page"></jsp:useBean>
		<jsp:useBean id="Manager" class="ezc.client.EzMessagingManager" scope="session" />
		<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
		<%@ include file="../../../Includes/Lib/Address.jsp"%>
<%
		String userRole		= (String) session.getValue("USERROLE");
		String userType		= (String) session.getValue("UserType");
		java.util.Hashtable alertsHashtable = new java.util.Hashtable();
		if("PH".equals(userRole)){
%>
			<%@include file="../../../Includes/JSPs/Misc/iPurMgrWelcome.jsp"%>
			
<%
		}else{
%>
			<%@include file="../../../Includes/JSPs/Misc/iSBUWelcome.jsp"%>			
<%
		}
%>
		<html>
		<head>
			<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
		<style>
			a{
			   color: #00385D;
			   text-decoration:none;
			   font-weight:bold
			}

			a:link{
			   color: #00385D;
			   text-decoration:none;
			   font-weight:bold
			}

			a:hover{
			   color: #00385D;
			   text-decoration:underline;
			   font-weight:bold
			}

			a:visited{
				color: #00385D;  
			}
		</style>
		</head>
		<body scroll=no>
<%

		String display_header= chLastLogin_L;
%>
		<%@ include file="ezDisplayHeader.jsp" %>
		<form>
		<Div id='inputDiv' style='position:absolute;background-color:#FFFFFF;top:15%;width:100%;height:70%;align:center' align=center>
		<center>
		<Table width="60%" height="60%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
		<Tr>
			<Td height="5" style="background-color:'#F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
			<Td height="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
			<Td height="5" style="background-color:'#F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
		</Tr>
		<Tr height=250px>
			<Td width="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
			<Td style="background-color:'#F3F3F3'" valign=middle>
			
				<Table border="0" align="center" valign=middle width="100%" cellpadding=10 cellspacing=10 class=welcomecell>
<%
				for(int i=1;i<=alertsHashtable.size();i++)
				{
					if(userType.equals("3") && (i==1 || i==2 || i==4))
						continue;
%>		
					<Tr>
						<Td width="10%" style='background:##F3F3F3'>&nbsp;</Td>
						<Td colspan=2 style='background:##F3F3F3;font-size=11px;color:#00385D;font-weight:bold;' width='45%'>
							<%=alertsHashtable.get("KEY"+i)%>
						</Td>
						<Td width="10%" style='background:##F3F3F3'>&nbsp;</Td>
					</Tr>
<%			
				}
				if(userType.equals("3"))
				{
%>
					<Tr>
						<Td width="10%" style='background:##F3F3F3'>&nbsp;</Td>
						<Td style='background:##F3F3F3;font-size=11px;color:#00385D;font-weight:bold;align:left' align=left>
							<a href='../Purorder/ezBankDet.jsp'><%=bankDet_L%></a>
						</Td>
						<Td style='background:##F3F3F3;font-size=11px;color:#00385D;font-weight:bold;' align=right>
							<a href='../Purorder/ezVendbal.jsp'><%=vendBal_L%></a>
						</Td>
						<Td width="10%" style='background:##F3F3F3'>&nbsp;</Td>
					</Tr>	
<%
				}
%>
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
		</center>
		</Div>

					<%@ include file="../News/ezNews.jsp"%>
				
		
		<Div id="MenuSol"></Div>
		</body>
		</html>
<%
	}
%>

