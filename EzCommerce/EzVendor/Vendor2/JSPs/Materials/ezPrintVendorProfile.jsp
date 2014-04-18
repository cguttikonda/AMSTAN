<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iVendorProfile_Labels.jsp"%>
<%@ include file="../../../Includes/JSPs/Materials/iGetVendorProfile.jsp"%>

<html>
<head>
<Title>Vendor Profile</Title>
<script src="../../Library/JavaScript/ezCountriesAndStates.js"></script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>

<script>
function funcPrint()
{
	document.getElementById("printdiv").style.visibility="hidden";
	window.print();
}



</script>

</head>
<body>
<Table width="50%" align=center border=0>
<tr><td class=displayheader align=center>
<font size='3'><%=vendProf_L%></font>
</td>
</tr>
</table>
<br>
<center>
<Table width="96%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<tr>
<th align="left" colspan=2><center><b><%=compDet_L%></b></center></th>
</tr>
<tr>
<th align="left" width="40%"><%=compName_L%></th>
<td width="60%"><%=companyName%>&nbsp;</td>
</tr>
<tr>
<th align="left" width="40%" > <%=address_L%> </th>
<td width="60%" ><%=address1%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%" >&nbsp;</th>
<td width="60%" ><%=address2%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%" ><%=city_L%> </th>
<td width="60%" ><%=city%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%" ><%=state_L%> </th>
<td width="60%" ><%=state%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%" ><%=country_L%>  </th>
<td width="60%" ><%=country%>
&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%"><%=zip_L%> </th>
<td width="60%" ><%=zipcode%>&nbsp;</td>
</tr>
<tr>
<th align="left" width="40%"><%=contPers_L%> </th>
<td width="60%" ><%=contactPerson%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%"><%=desig_L%> </th>
<td width="60%" ><%=designation%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%" ><%=phone_L%>1  </th>
<td width="60%" ><%=phone1%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%"><%=phone_L%>2</th>
<td width="60%"><%=phone2%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%"><%=fax_L%> </th>
<td width="60%"><%=fax%>&nbsp;</td>
</tr>
<tr>
<th align="left" width="40%"><%=email_L%>  </th>
<td  width="60%" ><%=email%>&nbsp;
</td>
</tr>

<tr>
<th align="left" colspan=2><center><b><%=tradDet_L%></b></center></th>
</tr>
<tr>
<th align="left" width="40%"><%=salesTax_L%></td>
<td  width="60%" ><%=salestax%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%"><%=centralExcise_L%> </th>
<td width="60%" ><%=cexcise%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%"><%=drugLicense_L%> </th>
<td width="60%"><%=druglic%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%"><%=dmfNo_L%> </th>
<td width="60%" ><%=dmfno%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%"><%=totalProdCap_L%> </th>
<td  width="60%" ><%=prodCapacity%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%"><%=totalProdCap_L%></th>
<td  width="60%" ><%=turnOver%>&nbsp;</td>
</tr>

<tr>
<th align="left" colspan=2><center><b><%=mfgSite1_L%></b></center></th>
</tr>

<tr>
<th align="left" width="40%" ><%=address_L%> </th>
<td  width="60%"><%=man1address1%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%" >&nbsp;</th>
<td  width="60%" ><%=man1address2%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%" ><%=city_L%></th>
<td width="60%" ><%=man1city%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%" ><%=state_L%> </th>
<td width="60%" ><%=man1state%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%" ><%=country_L%></th>
<td width="60%" >
     	<script>
		    for(var i=0;i<CountryArr.length;i++)
		    {
		 	if(CountryArr[i].key=='<%=man1country%>')
		 	{
		 		document.write(CountryArr[i].value);
		 	}
		     }
	</script>
&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%"><%=zip_L%> </th>
<td width="60%" ><%=man1zipcode%>&nbsp;</td>
</tr>


<tr>
<th align="left" width="40%" ><%=phone_L%>1  </th>
<td width="60%" ><%=man1phone1%>&nbsp;</tr>

<tr>
<th align="left" width="40%" ><%=phone_L%>2</th>
<td width="60%"><%=man1phone2%>&nbsp;</th>
</tr>

<tr>
<th align="left" width="40%" ><%=fax_L%> </th>
<td width="60%"><%=man1fax%>&nbsp;</td>
</tr>

<tr>
<th align="left" colspan=2><center><b><%=mfgSite2_L%></b></center></th></tr>
<tr>
<th align="left" width="40%" > <%=address_L%> </th>
<td width="60%" ><%=man2address1%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%" >&nbsp;</th>
<td width="60%" ><%=man2address2%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%" ><%=city_L%> </th>
<td width="60%" ><%=man2city%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%" ><%=state_L%></th>
<td width="60%" ><%=man2state%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%" ><%=country_L%></th>
<td width="60%" >
    	<script>
		    for(var i=0;i<CountryArr.length;i++)
		    {
		 	if(CountryArr[i].key=='<%=man2country%>')
		 	{
		 		document.write(CountryArr[i].value);
		 	}
		     }
	</script>
&nbsp;</td>
</tr>


<tr>
<th align="left" width="40%"><%=zip_L%> </th>
<td width="60%" ><%=man2zipcode%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%" ><%=phone_L%>1</th>
<td width="60%" ><%=man2phone1%>&nbsp;</tr>

<tr>
<th align="left" width="40%"  ><%=phone_L%>2</th>
<td width="60%"><%=man2phone2%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%" ><%=fax_L%>
<td width="60%"><%=man2fax%>&nbsp;</td>
</tr>
</table>

<!-- added by suresh -->
<p style="page-break-before:always" />
<table width="96%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<tr>
<th align="left" colspan=2><center><b><%=mfgSite3_L%></b></center></th>
</tr>

<tr>
<th align="left" width="40%" > <%=address_L%></th>
<td width="60%" ><%=man3address1%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%" >&nbsp;</th>
<td width="60%" ><%=man3address2%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%"><%=city_L%></th>
<td width="60%" ><%=man3city%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%" ><%=state_L%></th>
<td width="60%" ><%=man3state%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%" ><%=country_L%></th>
<td width="60%" >
    	<script>
		    for(var i=0;i<CountryArr.length;i++)
		    {
		 	if(CountryArr[i].key=='<%=man3country%>')
		 	{
		 		document.write(CountryArr[i].value);
		 	}
		     }
	</script>
&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%"><%=zip_L%> </th>
<td width="60%" ><%=man3zipcode%>&nbsp;</td>
</tr>


<tr>
<th align="left" width="40%" ><%=phone_L%>1 </th>
<td width="60%" ><%=man3phone1%>&nbsp;
</tr>

<tr>
<th align="left" width="40%"><%=phone_L%>2</th>
<td width="60%"><%=man3phone2%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%" ><%=fax_L%> </tr>
<td width="60%"><%=man3fax%>&nbsp;</td>
</tr>

<tr>
<th align="left" colspan=2><center><b><%=compDet_L%></b></center></th>
</tr>
<%  ezc.ezbasicutil.EzReplace rep = new ezc.ezbasicutil.EzReplace(); %>
<tr>
<th align="left" width="40%"><%=organogram_L%></th>
<td width="60%" ><%=rep.setNewLine(organogram)%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%"><%=detOfComp_L%></th>
<td width="60%" ><%=rep.setNewLine(companyDetails)%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%"><%=bankerDet_L%></th>
<td width="60%" ><%=rep.setNewLine(bankerDetails)%>&nbsp;
</td>
</tr>

<tr>
<th align="left" width="40%"><%=productsOffered_L%></th>
<td width="60%" ><%=rep.setNewLine(prodsOffered)%>&nbsp;</td>
</tr>

<tr>
<th align="left" width="40%"><%=newDevelopments_L%> </th>
<td width="60%" ><%=rep.setNewLine(newDevelopments)%>&nbsp;</td>
</tr>

</table>
</center>
<br>

<center>
<div id="printdiv">
<!--
<img src="../../Images/Buttons/<%=ButtonDir%>/print.gif"  border="none" valign=bottom style="cursor:hand" onClick="window.print()">
<img src="../../Images/Buttons/<%=ButtonDir%>/cancel.gif"  border="none" valign=bottom style="cursor:hand" onClick="window.close()">
-->
<%
		
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Print");
		buttonMethod.add("funcPrint()");
		
		buttonName.add("Cancel");
		buttonMethod.add("window.close()");
		out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
</center>

<Div id="MenuSol"></Div>
</body></html>
