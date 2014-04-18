<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ include file="../../../Includes/JSPs/Purorder/iSchAgmntPrint.jsp"%>
<%
	
	//ezc.drl.util.EzCurrencyFormat myFormat = new ezc.drl.util.EzCurrencyFormat("Rs",false,false);
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
	
%>	

<HTML>
<HEAD>
<style>
td
{
	font-size:-3
	font-face:verdana
}
th
{
	font-size:-3
	font-face:verdana
}

</style>

<TITLE>Purchase Order</TITLE>
<script>
function fun1()
{
	
	document.form1.submit();
}
</script>
	</HEAD>
<BODY bgColor=#ffffff>

<TABLE width="100%" border=0>
  <TR>
    <TD align="left" width="60%">
	<FONT face="verdana" size=3><B>PURCHASE ORDER QUERY</B></FONT></TD>
    <Td align="right"><img src="../../Images/Logos/DRL_logo.jpg"></Td></TR>
</TABLE>

<table border=0 width="100%">

<tr>
<table>
	<td width="60%">
		<TABLE border=1 rules=none  width="100%" cellspacing=0 cellpading=0>
    			<TR><TD><FONT size=-3 face="verdana"><%=VENDORNAME %></FONT></TD></TR>
			<TR><TD><FONT size=-3 face="verdana"><%=ADDRESS1%>,<%=ADDRESS2%></FONT></TD></TR>
			<TR><TD><FONT size=-3 face="verdana"><%=ADDRESS3%><%=ADDRESS4%></FONT></TD></TR>
		</table>
	</td>
	<td width="40%">
		<TABLE  border=1 rules=none width="100%"  cellspacing=0 cellpading=0>
		  	<TR><TD width="30%"><FONT size=1 face="verdana">&nbsp;P.O.No</font></TD>
    			    <TD width="10%">:</TD>
		    	    <TD width="60%"><FONT size=-3 face="verdana">
				<%
					try { out.println(Long.parseLong(PONO)); } catch(Exception e){ }
				%>
				</font>
			</TD></TR>
		  	<TR><TD width="30%"><FONT size=1 face="verdana">&nbsp;Date</font></TD>
    			    <TD width="10%">:</TD>
	    		    <TD width="60%"><FONT size=-3 face="verdana"><%=PODATE%></font>
			</TD></TR>
		        <TR><td colspan=3>&nbsp;</td></tr>
		</TABLE>
	</td>
</tr>

<tr>
<td colspan=2>
	<TABLE border=0   width="100%" cellspacing=0 cellpading=0>
        	<TR>
	<TD width="100%"><p><FONT size=-3 face="verdana">			
	In acceptance of your above referred quotation,we are pleased to 
	request you to supply the following materials/services subject to 
	the terms &amp; conditions stated below and overleaf which shall 
	supersede all earlier negotiations and shall be binding on you.
	Please quote this Order No and attach a copy alongwith all future 
	correspondance in respect of the subject order which shall at all
	times hereafter be governed by the terms and conditions mentioned 
	above.</font></p>
	</TD></tr></table>
</td>

</tr>
</table>
<CENTER><FONT size=-1 face="verdana"><B>Released Delivery Schedule between <%=fromDate%> and <%=toDate%></B></FONT></CENTER>
<br>
<TABLE border=1  width="100%" frames="all" cellspacing=0 cellpadding=0 height="22%">
  <TR valign="top" height="1%">
          <Th width="6%" align="center" valign="top"><FONT size=-3 face="verdana">Line<br>Item</font></Th>
          <Th width="10%" align="center"><FONT size=-3 face="verdana">Material<br>Code</font></Th>
          <Th width="30%" align="center" valign="top"><FONT size=-3 face="verdana">Material Description</font></Th>
          <Th width="4%" align="center" valign="top"><FONT size=-3 face="verdana">UOM</font></Th>
          <Th width="15%" align="center" valign="top"><FONT size=-3 face="verdana">Delivery line #</font></Th>
          <Th width="15%" align="center" valign="top"><FONT size=-3 face="verdana">Quantity</font></Th>
          <Th width="20%" align="center" valign="top"><FONT size=-3 face="verdana">Delivery Date</font></Th>
</Tr>
 <tr valign="top" bgcolor=black><td colspan=6 valign="top"></td></tr>
 <%
 for(int count=0;count<poParams.getRowCount();count++)	
 {
 %>
  	<TR valign="top" align="center">
    	<TD width="6%" valign="top"><FONT size=-3 face="verdana"><%=count+1%></Font></TD>
   	<%
	String MATNO=poParams.getFieldValueString(count,"MATNO");
	try{
		int cmat=0;
		for(cmat=0;cmat<MATNO.length();cmat++)
		{ 
			if(! MATNO.substring(cmat,cmat+1).equals("0"))
			break;
		}
		MATNO=MATNO.substring(cmat,MATNO.length());
		}
		catch(Exception e){  }		


	%>
    	<TD width="10%" align="left" valign="top"><FONT size=-3 face="verdana"><%=MATNO%></Font></TD>
   	<TD width="30%" align="left" valign="top"><FONT size=-3 face="verdana"><%=poParams.getFieldValue(count,"MATDESC")%></Font></TD>
   	<TD width="4%" align="center" valign="top"><FONT size=-3 face="verdana"><%=poParams.getFieldValue(count,"UOM")%></Font></TD>
    	<TD width="15%" align="center" valign="top"><FONT size=-3 face="verdana">
	<%try{	out.println(new Double(poParams.getFieldValueString(count,"VA1")).intValue());
	}catch(Exception e){
		out.println(poParams.getFieldValueString(count,"VA1"));
	}
	%></Font></TD>
    	<TD width="15%" align="right" valign="top"><FONT size=-3 face="verdana"><%=poParams.getFieldValue(count,"QUANTITY")%></Font></TD>
    	<TD width="20%" align="center" valign="top"><FONT size=-3 face="verdana"><%=fd.getStringFromDate((Date)poParams.getFieldValue(count,"DELIVERDATE"),".",FormatDate.DDMMYYYY)%></Font></TD>
    	</TR>
<% } %>
</Table>

<Table align=right valign=top>
<Tr valign=top align=left>
	<Th valign=top align=right><font size="-3" face="verdana" align="right" colspan="1">
		Buyer
	</font>
	</Th>	
	<Th valign=top width="15%" align=left><font size="-3" face="verdana" align="left" colspan="1">
	<%=BUYER%>
	</font>
	</Th>		
</Tr>
</Table>
<Table>
	<Tr>
	<%@ include file="../../../Includes/JSPs/Purorder/iPoPrintSBU.jsp"%>
	</Tr>
    	</Table>
<br>
<TABLE border=1 rules=cols width="100%" frames="all" cellspacing=0 cellpading=0 height="6%">
<Tr valign="top">
	<Td width="55%"> 
            <table width="100%" cellspacing=0 cellpading=0>
               <tr valign="top" align="left"> 
                   <th colspan=1 width="38%"><font size="-3" face="verdana" height="20">Special Instructions</font></th>
                  <td bgcolor="black" colspan=1 height="10%" width="1%" ></td>
		<td bgcolor="white" colspan=1 height="10%" width="61%" ></td>
               </tr>

               <tr> 
                   <td  align="right" bgcolor="black" colspan=1 width="30%" height="1%"></td>
                   <td  align="right" colspan=4 bgcolor="white" width="70%" height="1%"></td>
                   <td  align="right" colspan=3 bgcolor="white" width="5%" height="1%"></td>
               </tr>

               <tr >
     	            <td width="25%">
 		 			&nbsp;
		    </td>
	       </tr>
            </table>
        </Td>

	<Td width="45%">
		<Table width="100%" cellspacing=0 cellpading=0>
		
                                     <Tr> 
               			<Td>&nbsp;</Td>
                                     </Tr>
		<Tr>
			<Td align="center">
			<FONT size=-3 face="verdana" align="right">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			for <b>Dr.Reddy's Laboratories Limited</b></font></Td>
		</Tr>
		<Tr>
			<Td>&nbsp;</Td>
		</Tr>
		<Tr>
			<Td align="center"><FONT size=-3 face="verdana" align="right">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			Authorised Signatory</font></Td>
		</Tr>
		<Tr>
			<Td>&nbsp;</Td>
		</Tr>
		
		</Table>
	</Td>
</Tr>
</Table><table border=0 width="100%" height="3%">
	<tr>
	    <td width="53%">
		<TABLE  width="100%" border=0 rules=none cellspacing=0 cellpading=0>
		    <tr align="left">
			<td><FONT size=-3 face="arial">Dr.Reddy's Laboratories Ltd 7-1-27 	
			Ameerpet Hyderabad 500 016 </font></td></tr>
			<tr><td><FONT size=-3 face="arial">Tel 040-3731946 Fax No 040-3745807</font></td></tr>
		   </tr>
		
		   <tr>
			<td width="10%"><FONT size=-17 face="arial">E-mail :ezcadmin@drreddys.com
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			Website : www.vikreta2drl.com</font></td>
		   </tr>
		</table>
	    </td>
	
	    <td width="47%">
		<TABLE border=1 rules=none cellspacing=0 cellpading=0   width="100%">
		    <tr>
			<td><FONT size=-3 face="arial">
			APGST No. PJT/06/1/2404/90-91 Valid From 01/06/1984</font></td>
		    </tr>
			
		    <tr>
			<td><FONT size=-3 face="arial">
			CST No. PJT/06/1/1757/90-91 Valid From 01/06/1984</font></td>
		    </tr>
		</table>
	    </td>
	</tr>
</table>
<Table align="left">
<Tr><td><a href="../../Htmls/TermsAndconditions.htm">Terms and conditions</a></tD>
<td><a href="JavaScript:fun1()">PO Conditions</a></tD>
</Tr>
</Table>
<%
	String text="";
	for(int i=0;i<headerText.getRowCount();i++)
	{
		if("".equals(text))
		{
			text=headerText.getFieldValueString(i);
		}
		else
		{
			text=text + "|||" + headerText.getFieldValueString(i);
		}
	}
%>		
		
<form action="ezPOHeaderText.jsp" name=form1>
<input type=hidden name="headerText" value="<%=text%>">
</form>
<Div id="MenuSol"></Div>
</BODY>
</HTML>
