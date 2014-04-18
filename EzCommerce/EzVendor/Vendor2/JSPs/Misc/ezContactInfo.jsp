
<%//@ include file="../../Library/Globals/errorPagePath.jsp" %>
<%@ page language="java" errorPage="ezErrorDisplay.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iContactInfo_Labels.jsp" %>

<html>
<head>
	<title>Contact Info</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %>
	<style>
		TH
		{
			background-color:#FFFFFF;FONT-SIZE: 13px; COLOR: #333333; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;
	
		}
		H4 {
			FONT-SIZE: 10px; COLOR: #333333; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif
		}
		p{
				FONT-SIZE: 10px; COLOR: #333333; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;background-color:#FFFFFF
	
		}
		TD
		{
			FONT-SIZE: 11px; COLOR: #00355D; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;font-weight:bold
		}
	</style>
</head>

<body scroll=no>
<form name="sbuForm">
<%
	
	String pageFrom = request.getParameter("PAGE");
		
	if(!"HOME".equals(pageFrom))
	{
		String display_header = conInfo_L;
%>
		<%@ include file="ezDisplayHeader.jsp"%>
<%
	}
%>
	
<br>		
	<TABLE align=center style="BORDER-RIGHT: #4374a6 1px solid; BORDER-TOP: #4374a6 1px solid; BORDER-LEFT: #4374a6 1px solid; BORDER-BOTTOM: #4374a6 1px solid" cellSpacing=0 cellPadding=0 width="60%"  height=70% border=0>
		<TR>
			<TD style="BACKGROUND-COLOR: #FFFFFF" width="40%" align=center valign=middle>
				<img src="../../../../EzCommon/Images/Body/contact_us.jpg">
			</TD>
			<TD style="BACKGROUND-COLOR: #FFFFFF" width="60%" align=left valign=middle>
				<TABLE width="100%" align=left cellPadding=0 cellSpacing=0 >
				<Tr>
					<td style="BACKGROUND-COLOR: #FFFFFF" >
						<TABLE width="100%" border=0 align=left cellPadding=0 cellSpacing=0 >
						<tr>
							<td style="BACKGROUND-COLOR: #FFFFFF" align="Left" width="100%">
								<img src="../../Images/Others/1285.gif">
								<font color=green><%=contactUs_L%></font>
							</td>
						</tr>
						<tr>
							<td style="BACKGROUND-COLOR: #FFFFFF" width="100%" align=left >&nbsp;&nbsp;&nbsp;Answerthink</td>
						</tr>
						<!--<tr>
							<td style="BACKGROUND-COLOR: #FFFFFF" width="100%" align=left>&nbsp;&nbsp;&nbsp;57 Seaview Blvd</td>
						</tr>-->
						<tr>
							<td style="BACKGROUND-COLOR: #FFFFFF" width="100%" align=left>&nbsp;&nbsp;&nbsp;United States: 877-423-4321</td>
						</tr>
						<tr>
							<td style="BACKGROUND-COLOR: #FFFFFF" width="100%" align=left>&nbsp;&nbsp;&nbsp;United Kingdom: 44-207-003-8150</td>
						</tr>
						<tr>
							<td style="BACKGROUND-COLOR: #FFFFFF" width="100%" align=left>&nbsp;&nbsp;&nbsp;India: 91 40 66544000</td>
						</tr>
						</TABLE>
					</td>
				</tr>	
				<!--
				<tr height=20><td style="BACKGROUND-COLOR:#FFFFFF">&nbsp;</td></tr>
				<tr>	
					<TD style="BACKGROUND-COLOR:#FFFFFF"  >
						<TABLE width="100%" cellPadding=0 cellSpacing=0 align=left border=0> 
						<tr>
							<td style="BACKGROUND-COLOR: #FFFFFF" align="Left" width="100%" colspan="2">
								<img src="../../Images/Others/email3.jpg">
								<font color=green>&nbsp;<%=uReachAt_L%> </Font>
							</td>
						</tr>
						<tr>
							<td style="BACKGROUND-COLOR:#FFFFFF" align="left" width="100%" >
								&nbsp;&nbsp;&nbsp;<a href="mailto:ezcommerce@answerthink.com">ezcommerce@answerthink.com</a>
							</td>
						</tr>
						</Table>
					</TD>
				</tr>
				-->
				<Tr><Td class='blankcell'>&nbsp;</Td></Tr>
				<Tr><Td class='blankcell'>&nbsp;</Td></Tr> 
<%
				if(!"HOME".equals(pageFrom))
				{
%>
					<tr>
						<TD style="BACKGROUND-COLOR:#FFFFFF">
							<TABLE width="100%" cellPadding=0 cellSpacing=0 align=left>
								<tr>
									<td style="BACKGROUND-COLOR: #FFFFFF" align="Left" width="100%" colspan="3">
										<img src="../../Images/Others/r_contact.jpg"><font color=green>&nbsp;Contact Persons:</Font>
									</td>
								</tr>
								<tr>
									<td style="BACKGROUND-COLOR:#FFFFFF" align="left">&nbsp;&nbsp;&nbsp;ezcommerce suite</td>
									<td style="BACKGROUND-COLOR:#FFFFFF" align="left">&nbsp;&nbsp;&nbsp;<a href='mailto:ezcommerce@answerthink.com'>ezcommerce@answerthink.com</a></td>
								</tr>
								<!--<tr>
									<td style="BACKGROUND-COLOR:#FFFFFF" align="left">&nbsp;&nbsp;&nbsp;Jason IM</td>
									<td style="BACKGROUND-COLOR:#FFFFFF" align="left">&nbsp;&nbsp;&nbsp;<a href='mailto:annie@kissusa.com'>jasoni@kissusa.com</a></td>
								</tr>
								<tr>
									<td style="BACKGROUND-COLOR:#FFFFFF" align="left">&nbsp;&nbsp;&nbsp;Grace Kim</td>
									<td style="BACKGROUND-COLOR:#FFFFFF" align="left">&nbsp;&nbsp;&nbsp;<a href='mailto:annie@kissusa.com'>gracek@kissusa.com</a></td>
								</tr>-->
							</Table>
						</TD>
					</tr>				
<%
				}
%>
				<tr height=40><td style="BACKGROUND-COLOR: #FFFFFF">&nbsp;</td></tr>
				<tr>
					<TD  style="BACKGROUND-COLOR: #FFFFFF" width="100%" align=center>
						<TABLE cellPadding=0 cellSpacing=0 >
							<tr><td style="BACKGROUND-COLOR: #FFFFFF" align="Left"><img src="../../Images/Others/email3.jpg"><font color=green><%=visitUs_L %>:</Font></td></tr>
							<tr><td style="BACKGROUND-COLOR: #FFFFFF" align="Left">&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www.answerthink.com" target="new">www.answerthink.com</a></td></tr>
							<!--<tr><td style="BACKGROUND-COLOR: #FFFFFF" align="Left">&nbsp;&nbsp;&nbsp;&nbsp;<a href="" target="new">&nbsp;</a></td></tr>
							<tr><td style="BACKGROUND-COLOR: #FFFFFF" align="Left">&nbsp;&nbsp;&nbsp;&nbsp;<a href="" target="new">&nbsp;</a></td></tr>-->
						</Table>
					</TD>
				</tr>
				</table>
			</td>	
		</TR>
</TABLE>

<%
	if("HOME".equals(pageFrom))
	{
%>
		<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
		<center>
<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();

			buttonName.add("Close");
			buttonMethod.add("window.close()");

			out.println(getButtonStr(buttonName,buttonMethod));	
%>
		</center>
		</div>
<%	
	}
%>

<Div id="MenuSol">
</Div>
</form>

</body>
</html>