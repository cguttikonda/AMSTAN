<%
//out.println(">>"+(String)session.getValue("SAPPRDCODE"));
%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>

<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<html>
<head>
	<title>Contact Info</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
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
			FONT-SIZE: 11px; COLOR: #800000; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;font-weight:bold
		}
		
		BODY {
			border-right:#FFFFFF 0px inset;
			border-top: #ffffff 0px inset;
			border-left: #ffffff 0px inset;
			border-bottom: #FFFFFF 0px inset;
			scrollbar-3dlight-color:#82b008;
			scrollbar-arrow-color:#FFFFFF;
			scrollbar-base-color:#82b008;
			scrollbar-darkshadow-color:#000000;
			scrollbar-highlight-color:#ffffff;
			scrollbar-shadow-color:#000000;
			Scrollbar-Track-Color :#eff6fc;
			BACKGROUND-COLOR:#FFFBFB;
		}
	</style>
</head>

<body scroll=no>
<form name="sbuForm">
<%
	String display_header = "Contact Information";
	
%>	
  
<%@ include file="ezDisplayHeader.jsp"%>
	
<br>		
	<TABLE align=center style="BORDER-RIGHT: #4374a6 1px solid; BORDER-TOP: #4374a6 1px solid; BORDER-LEFT: #4374a6 1px solid; BORDER-BOTTOM: #4374a6 1px solid" cellSpacing=0 cellPadding=0 width="80%"  height=60% border=0>
		<TR>
			<TD style="BACKGROUND-COLOR: #FFFFFF"  align=left >
				<img src="../../../../EzCommon/Images/Body/contact_us.jpg" >
			</TD>
			<TD style="BACKGROUND-COLOR: #FFFFFF"  align=left >
				<TABLE width="100%" align=left cellPadding=0 cellSpacing=0 >
				<tr>
					<TD style="BACKGROUND-COLOR:#FFFFFF">
										</TD>
					<TD style="BACKGROUND-COLOR: #FFFFFF" valign=bottom align=left>
						<TABLE  align=left cellPadding=0 cellSpacing=0 >
							<tr><td style="BACKGROUND-COLOR: #FFFFFF" align="Left">&nbsp;</th><th width="70%" align=left ><img src="../../Images/Others/1285.gif"><font color=green>Contact us </font></th><th width="15%"></td></tr>
							<tr><td style="BACKGROUND-COLOR: #FFFFFF" align="Left"></td><td style="BACKGROUND-COLOR: #FFFFFF" width="85%" align=left >American Standard</td><td style="BACKGROUND-COLOR: #FFFFFF" width="5%"></td></tr>
							<tr><td style="BACKGROUND-COLOR: #FFFFFF" align="Left"></td><td style="BACKGROUND-COLOR: #FFFFFF" width="85%" align=left>175 Middlesex Tpke. Ste. 1 | PO Box 9137</td><td style="BACKGROUND-COLOR: #FFFFFF"  width="5%"></td></tr>
							<tr><td style="BACKGROUND-COLOR: #FFFFFF" align="Left"></td><td style="BACKGROUND-COLOR: #FFFFFF" width="85%" align=left>Bedford, MA 01730</td><td style="BACKGROUND-COLOR: #FFFFFF" width="5%"></td></tr>
							<tr><td style="BACKGROUND-COLOR: #FFFFFF" align="Left">&nbsp;</td></Tr>
							<tr><td style="BACKGROUND-COLOR: #FFFFFF" align="Left"></td><td style="BACKGROUND-COLOR:#FFFFFF" align="left" width="85%" >Tel#  (781) 275-0850 | (800) 937-4688</td></tr>
							<tr><td style="BACKGROUND-COLOR: #FFFFFF" align="Left"></td><td style="BACKGROUND-COLOR:#FFFFFF" align="left" width="85%" >Fax#  (781) 533-0395</td></tr>
							<tr><td style="BACKGROUND-COLOR: #FFFFFF" align="Left"></td><td style="BACKGROUND-COLOR:#FFFFFF" align="left" width="85%" >Email: <a href="mailto:a@a.com">a@a.com</a></td></tr>
						</TABLE>
						<br><br><br><br><br><br><br><br><br><br><br><br>
						<TABLE align=left  cellPadding=0 cellSpacing=0 >
							<tr><td style="BACKGROUND-COLOR: #FFFFFF" align="Left"><font color=green>Visit Us at:</Font></td></tr>
							<tr><td style="BACKGROUND-COLOR: #FFFFFF" align="Left"><a href="http://www.conres.com" target="new">www.americanstandard-us.com</a></td></tr>
							<tr><td style="BACKGROUND-COLOR: #FFFFFF" align="Left">&nbsp;</td></tr>
						</Table>
									
					</TD>
				</tr>
							
				</table>
			</td>	
		</TR>
</TABLE>

<Div id="MenuSol">
</Div>
</form>

</body>
</html>