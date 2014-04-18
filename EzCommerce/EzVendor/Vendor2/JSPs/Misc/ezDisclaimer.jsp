<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%
	String siteAdd	    	= "www.Answerthink.com";
	String compNameDesc 	= "Answerthink";
%>
<html>
<head>
<style>
.control1
{
    COLOR: black;
    FONT-FAMILY: Verdana, Arial;
    FONT-SIZE: 11px;
    TEXT-DECORATION: none
}
</style>
<title><%=(String)session.getValue("TITLE")%></title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script>
function ezHref(event)
{
	document.location.href = event
}
function quit(event)
{
	document.myForm.target = "_parent";
	document.myForm.action = event;
	document.myForm.submit();
}
</script>
<script src="../../Library/JavaScript/ezStatus.js"></script>
</head>

<body scroll=no onLoad="showBanner()">
<Div style='position:absolute;width:100%;top:0%;left:0%'>
<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0 >
<TR>
	<TD width='20%'>
		<IMG src="../../../../EzCommon/Images/Banner/ezc_logof.jpg" border=0  WIDTH=250 HEIGHT=83>
		<!--<IMG src="../../../../EzCommon/Images/Banner/mud-pie-logo.jpg" border=0  WIDTH=250 HEIGHT=83>-->
		<!--<IMG src="../../../../EzCommon/Images/Banner/pbm_logo.jpg" border=0 WIDTH=250 HEIGHT=75>-->
		<!--<IMG src="../../../../EzCommon/Images/Banner/akrimax.gif" border=0 WIDTH=250 HEIGHT=83>-->
		<!--<IMG src="../../../../EzCommon/Images/eitny/logoheader.gif" border=0 width=100%>-->
	</TD>
	<TD width='80%'>
		<IMG src="../../../../EzCommon/Images/Banner/banner_ext1.jpg" border=0%>
	</TD>
</TR>
</TABLE>
</Div>

<Div style='position:relative;width:100%;top:20%;left:0%'>
<form  method="post" name="myForm" target="_parent">
<Table align=center leftMargin=5 topMargin=0 marginwidth="5" marginheight="0" border=0>
<Caption><font size=2 face=verdana><b>PLEASE READ THIS DISCLAIMER AND NOTICE</b></font></Caption>
<Tr>
<Td align=center>
<textarea name="disclaimer" cols="105" rows="25" readonly="readonly" class="control1" border=0>

1. This website is owned by and under the control of <%=compNameDesc%>. Access to and use of this website
    and its content, services, materials, information, databases and systems are subject to these disclaimers
    and notices, and applicable laws and regulations (including all export and import laws, regulations and
    restrictions), all of which are subject to change and revision  from time to time without prior notice.

2.  <%=compNameDesc%>  may

    (a) Supplement or make changes to these disclaimers and notices and other rules or access and use
         procedures, documentation, security procedures and standards for equipment, or

    (b) Change the type and location of <%=compNameDesc%> system equipment, facilities or software, or

    (c) Modify or withdraw any particular service or product referred to in this Website or any <%=compNameDesc%>
          database, material, service or system.

3. <%=compNameDesc%> reserves the right to terminate access to this website or take other actions it
    reasonably believes necessary to comply with the law or to protect its rights, members or customers.

4. Any access or attempt to access or use this Website for any unauthorized or illegal purpose is strictly
    prohibited.

5. This website is provided without charge as a convenience to visitors to be used for the purposes of
    information and communication. While <%=compNameDesc%> has taken care in preparing and compiling
    the information from sources believed to be reliable, <%=compNameDesc%> makes no guarantee as to,
    and assumes no responsibility for, the correctness, sufficiency or completeness of such information,
    material or recommendations. <%=compNameDesc%> does not represent or endorse the accuracy or
    reliability of any of the information or content, distributed through, or linked, downloaded or accessed
    from this  website, nor the quality of any information displayed, obtained by you as a result of your use of
    this website or any of the service, database, materials or system. You hereby acknowledge that any
    reliance upon any information or materials shall be at your sole risk.

6. <%=compNameDesc%> reserves the right, in its sole discretion and without any obligation, to correct any
    error or omissions in any portion of this website or any <%=compNameDesc%> service, database, materials
    or system at any  time, with or without notice to you.

7. Without <%=compNameDesc%> prior written consent, which consent may be given or withheld in <%=compNameDesc%>
     sole discretion, you should not:

    (a) Resell, sublicense, rent, lease or otherwise publicly distribute any information, services or database,
         or any part or parts thereof or information contained therein, or any access thereto;

    (b) Use your access to this website or information, services, database or system to export or re-export
         technical data in violation of New York,USA export control laws and regulations;

    (c) Use this website or any <%=compNameDesc%> information, services, database or system which you
         access in violation of, or post any information to any <%=compNameDesc%> owned or licensed database
         which violates, any federal or state law, including data privacy laws and communication regulations
         and tariffs, or which infringes the intellectual property rights or misuses proprietary information of a
         third party or is made in furtherance of an illegal or fraudulent scheme or activity;

    (d) Copy or transfer any <%=compNameDesc%> information, service, database or documentation, except
         as permitted by <%=compNameDesc%>; or

    (e) Modify, adapt, reverse engineer, decompile, disassemble,translate or convert any portion of <%=compNameDesc%> 
    	  databases or system, or the selection, coordination or arrangement of products or
         services in any <%=compNameDesc%> database.

8. Any information, including but not limited to remarks, suggestions, ideas, graphics or other submissions,
    communicated to <%=compNameDesc%> through this Website is deemed non-confidential and is the
    exclusive property of <%=compNameDesc%>. <%=compNameDesc%> is entitled to use any information or
    ideas submitted for any purpose without restriction and without compensation or acknowledgement of its
    source.

9.  <%=compNameDesc%> agree that the sales orders updated through this E-Business portal are in 
    agreement with the customer agreement entered with <%=compNameDesc%>.	    

10. Except as otherwise identified, the trademarks including names, logos, slogans and service marks
    appearing at this website,whether registered or unregistered, are the property of <%=compNameDesc%> or
    <%=compNameDesc%> affiliates. Such marks are not to be copied, reproduced, published or in any way
    used without the written permission of <%=compNameDesc%> or the identified owner of the trademark.
    Except as otherwise identified, the copyright in the content of this website is owned by <%=compNameDesc%>
    . No part of this website may be published,stored or transmitted in any form or means without
    the express written permission of <%=compNameDesc%>. You may download content displayed on this
    website for non-commercial, personal use only and must retain all copyright and other proprietary notices
    contained in the content.

11. No person may establish hyperlinks either to this website or away from this website without the prior
     written consent of an appropriate <%=compNameDesc%> officer,which consent may be given or withheld
     in <%=compNameDesc%> sole discretion.In its sole discretion, <%=compNameDesc%> reserves the right to
     remove a hyperlink to this website or away from this website at any time and for any reason.

     All Hyperlinks approved shall be to the home page of this Website.

12. <%=compNameDesc%> advises you to exercise discretion while browsing this website. In addition,
     hyperlinks on this website may direct you to sites containing information that some people may find
     offensive or inappropriate. Such linked websites may not be under the control of <%=compNameDesc%>
     and <%=compNameDesc%> does not make any representations concerning any such websites which you
     may access via a hyperlink from this website, and accordingly <%=compNameDesc%> is not responsible
     for the accuracy, copyright compliance, legality, legitimacy or decency of material contained in websites
     which may be accessible via a hyperlink to or from this website or for the hyperlink itself.

     <%=compNameDesc%> is providing these hyperlinks to you only as a convenience and the inclusion of any
     hyperlink on this website is not and should not imply any endorsement by <%=compNameDesc%> of such
     linked websites.

13. All information or content on or obtained through this website are provided "as is" and without warranty
     of any kind, and you hereby waive all other warranties relating thereto,including but not limited to any
     warranty of merchantability, fitness for a particular purpose or warranty against interference or
     infringement. <%=compNameDesc%> does not warrant that any information,content or other material will
     meet your requirements, that the operation of any service,database, material or other product or any
     third party services, programs, systems or data used with or through or provided by <%=compNameDesc%>
     , or any part thereof,will be uninterrupted or error free or that any defects in such
     information, services, systems, databases or materials will be or can be corrected. In no event shall
     <%=compNameDesc%> have any liability to you (including liability to any person or persons whose claim
     or claims are based on or derived from a right or rights claimed by you) with respect to any and all
     claims at any and all times arising from or related to the subject matter of this website, in contract, tort,
     strict liability or otherwise. Some jurisdictions may not allow the exclusion of implied warranties, so
     some of the above exclusions may not apply to you.

14. You assume the responsibility to take adequate precautions against damages to your systems or
     operations which could be caused by defects or deficiencies in this website, any <%=compNameDesc%>
     information, service, system, database or material,or part thereof. You also acknowledge that electronic
     communications and databases are subject to errors, tampering and break-ins and that while <%=compNameDesc%> will implement reasonable security precautions to attempt to prevent such occurrences,
     <%=compNameDesc%> does not guarantee that such events will not take place. Your installation and
     inputs, as well as third party systems and procedures, may influence the output and errors in any order
     or electronic transmission or communication, and can result in substantial errors in output, including
     incorrect information, orders and agreements. In addition, errors may be introduced into information or
     orders in the course of their transmission over electronic networks. You shall implement and take
     responsibility for appropriate review and confirmation procedures to verify and confirm orders or other
     transactions in which you participate using <%=compNameDesc%> website, information, services,
     databases, systems or other  material.

15. You also are solely responsible for ensuring that any posting made by or for you to this website or any
     <%=compNameDesc%> information, service, system or database does not contain any virus or other
     computer software code or routine designed to disable, erase,impair or otherwise damage the website or
     any system,software or data of <%=compNameDesc%> or any other user of the <%=compNameDesc%>
     information, services, databases, materials or system. You hereby agree to indemnify,defend and hold
     <%=compNameDesc%> and its members, employees, agents, representatives, licensors and suppliers
     harmless from  any liability, claim, cost or damage arising out of any claim or suit by any such user
     caused by such virus or code or subroutine.

16. Neither <%=compNameDesc%> nor its members, employees, agents, representatives, licensors or
     suppliers shall in any event be liable to you or to any third party for any lost profits, revenues, business
     opportunities or business advantages whatsoever,nor for any direct, indirect, special, consequential,
     indirect or incidental losses, damages or expenses directly or indirectly relating to the use or misuse of
     this website, or with respect to any other hyperlinked website, or any <%=compNameDesc%> information,
     content or other material or software used therewith, the use or failure, non-compliance or limited
     availability of any information, content, or service provided by <%=compNameDesc%> through this
     website, any information provided in the <%=compNameDesc%> system or any obligation under or subject
     matter of this website, whether such claim is based upon breach of contract, breach of warranty,
     negligence, gross negligence, strict liability in tort or any other theory of relief, or whether or not
     <%=compNameDesc%> is informed in advance of the possibility of such damages.

17. If any part or parts of these disclaimers and notices are held to be invalid, the remaining parts will
     continue to be valid and enforceable. Nothing in these disclaimers and notices affects any statutory rights
     of consumers that cannot be waived or limited by contract. The use by you of this Website, the <%=compNameDesc%> 
      information, content, services or other materials,and any and all other matters between
     <%=compNameDesc%> and you related hereto,shall be governed by applicable New York State, USA Laws and the 
     New York,USA courts will have exclusive jurisdiction over any disputes under these provisions.

18. You agree to comply with all applicable export laws,regulations and restrictions. Information <%=compNameDesc%>
      places on or makes available through this website may contain references or cross
     references to <%=compNameDesc%> or third party products, programs and services that are not
     announced or available in your country. Such references do not imply that either <%=compNameDesc%>
     or such third party intends to announce or make available such products, programs or services in your
     country.

19. This website may contain other proprietary notices and copyright information, the terms of which must be
     observed and followed. Any rights not expressly granted herein are reserved.

20. Limitation of liability
     Under no circumstances, including, but not limited to, negligence, shall <%=compNameDesc%>, its
     subsidiary and parent companies or affiliates be liable for any direct, indirect, incidental, special or
     consequential damages that result from the use of, or the inability to use, <%=compNameDesc%>
     materials. You specifically acknowledge and agree that <%=compNameDesc%> is not liable for any
     defamatory, offensive or illegal conduct of any user. If you are dissatisfied with any <%=compNameDesc%>
      material, or with any of <%=compNameDesc%> terms and conditions, your sole and exclusive
     remedy is to discontinue using this site. If the user  has any questions regarding this Website or its
     contents, or these disclaimers and notices, contact the webmaster at www.answerthink.com

     All Rights Reserved.
     
</textarea> 
</td>
</tr>
</table>
<br>

<center>
<%
		
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Accept");
		buttonMethod.add("ezHref(\"ezPutDisclaimerStamp.jsp\")");
		
		buttonName.add("EXTRA_CELL");
		buttonMethod.add("_");
		
		buttonName.add("Quit");
		buttonMethod.add("quit(\"ezLogout.jsp\")");
		out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</Div>
<Div id="MenuSol"></Div>
</body>
</html>
