<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iProductSearch_Lables.jsp"%>

<html>
<head>


<title>Product Search</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%></head>
<script LANGUAGE="JavaScript">
function gotoHome()
{
	document.location.href="../Misc/ezWelcome.jsp";
}
function isDigit (c)
{   return ((c >= "0") && (c <= "9"))
}

function isInteger (s)
{
   var i;

   /**
      if (isEmpty(s))
       if (isInteger.arguments.length == 1) return defaultEmptyOK;
       else return (isInteger.arguments[1] == true);
   **/

    // Search through string's characters one by one
    // until we find a non-numeric character.
    // When we do, return false; if we don't, return true.

    for (i = 0; i < s.length; i++)
    {
        // Check that current character is number.
        var c = s.charAt(i);

        if (!isDigit(c)) return false;
    }

    // All characters are numbers.
    return true;
}
function ezBack(flg)
{	
	if(flg=="DVC")
	{
		document.forms[0].action="../DrillDownCatalog/ezDrillDownVendorCatalog.jsp"
		document.forms[0].submit();
	}	
	else
	{
		document.forms[0].action="../ShoppingCart/ezViewCart.jsp"
		document.forms[0].submit();
	}	
}
function trim( inputStringTrim)
{
	fixedTrim = "";
	lastCh = " ";
	for( x=0;x < inputStringTrim.length; x++)
	{
   		ch = inputStringTrim.charAt(x);
		if ((ch != " ") || (lastCh != " "))
		{ fixedTrim += ch; }
		lastCh = ch;
	}
	if (fixedTrim.charAt(fixedTrim.length - 1) == " ")
	{
		fixedTrim = fixedTrim.substring(0, fixedTrim.length - 1);
	}
	return fixedTrim
}
function checkDesc()
{
	var pdesc = document.forms[0].ProdDesc1.value;
	pdesc = trim(pdesc);
	
	if ( pdesc == '')
	{

		alert('<%=prodDescNotEmpty_A%>');
		document.forms[0].ProdDesc1.focus();
		return ;
	}
	else 
	{
		document.forms[0].ProdDesc.value=document.forms[0].ProdDesc1.value
		document.forms[0].SearchType.value=document.forms[0].SearchTypeDc.value
		if(document.forms[0].sType[1].checked)
		{
			
			document.forms[0].action="ezRunProductSearch.jsp"
			document.forms[0].submit();
		
		}
		else
		{
			
			document.forms[0].action="ezProductNoSearch.jsp?MatNo="+document.forms[0].ProdDesc1.value
			document.forms[0].submit();
		}
	}
		
}


function checkPrice()
{
	var pdesc = document.forms[0].ProdDesc.value;
	var pfrom = document.forms[0].ProdFrom.value;
	var pto = document.forms[0].ProdTo.value;
	pdesc = trim(pdesc);
	pfrom = trim(pfrom);
	pto = trim(pto);

	if ( pdesc == '')
	{
		alert('<%=prodDescNotEmpty_A%>');
		document.forms[0].ProdDesc.focus();
		document.returnValue = false;
		return;
	}
	else
	{
		document.returnValue = true;
	}

	if ( pfrom == '' || !isInteger(pfrom) )
	{
		alert('<%=rangeBeNum_A%>');
		document.forms[0].ProdFrom.focus();
		document.returnValue = false;
		return;
	}
	else
	{
		document.returnValue = true;
	}

	if ( pto == '' || !isInteger(pto) )
	{
		alert('<%=rangeBeNum_A%>');
		document.forms[0].ProdTo.focus();
		document.returnValue = false;
		return;
	}
	else
	{
		document.returnValue = true;
	}

}


function checkSpec()
{
	var pdesc = document.forms[0].ProdDesc2.value;
	var pspec = document.forms[0].ProdSpec.value;
	pdesc = trim(pdesc);
	pspec = trim(pspec);
	if ( pdesc == '')
	{
		alert('<%=prodDescNotEmpty_A%>');
		document.forms[0].ProdDesc2.focus();
		return ;
	}
/*	else
	{
		
		document.forms[0].ProdDesc.value=document.forms[0].ProdDesc2.value;
		document.forms[0].SearchType.value=document.forms[0].SearchTypeSp.value
		document.forms[0].action="ezRunProductSearch.jsp"
		document.forms[0].submit();
	}
*/

	else if ( pspec == '')
	{
		alert('<%=specNoEmpty_A%>');
		document.forms[0].ProdSpec.focus();
		return ;
	}
	else
	{
		
		document.forms[0].ProdDesc.value=document.forms[0].ProdDesc2.value;
		document.forms[0].SearchType.value=document.forms[0].SearchTypeSp.value
		document.forms[0].action="ezRunProductSearch.jsp"
		document.forms[0].submit();
	}
}
function setFocus()
{
	document.Search.ProdDesc1.focus();
}

</script>
<body  scroll=no onLoad=setFocus()>
<form method="post" name="Search" action="javaScript:checkDesc();">
<input type="hidden" name="SearchType" >
<input type="hidden" name="ProdDesc" >
<input type="hidden" name="SearchTypeDc" value="DESC">
<input type="hidden" name="from"  value="<%=request.getParameter("from")%>">
<input type="hidden" name="CatalogDescription"  value="<%=request.getParameter("CatalogDescription")%>">
<input type="hidden" name="GroupDesc"  value="<%=request.getParameter("GroupDesc")%>">
<input type="hidden" name="ProductGroup"  value="<%=request.getParameter("ProductGroup")%>">
<input type="hidden" name="FavGroup"  value="<%=request.getParameter("FavGroup")%>">
<input type="hidden" name="back"  value="<%=request.getParameter("back")%>">


<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
	<td colspan=2 height="35" class="displayheader" align=center width="100%"><%=prodSearch_L%></td>
</tr>
<tr>
	<td >&nbsp;</td>
	<td class="graytxt"  align="center">Please specify the search criterion</td>
</tr>
</table>
<br>
<table width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=0  >
  <tr>
    <th width="40%" height="22" align="left"><input type="radio" name="sType" checked>Product No</th>
    <td  width="60%" height="22" rowspan="2" align="left">
    <table width="100%">
     <tr>
     <td colspan=2 width=50%>
    	<input type="text" name="ProdDesc1" class=InputBox size="20" maxlength="100">
    	
     </td>
     <td  width="50%" height="22" rowspan="2" align="left">
	<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Go");
		buttonMethod.add("checkDesc()");
		out.println(getButtonStr(buttonName,buttonMethod));
	%>
     </td>
     </tr>
     </table>
    </td>
    
  </tr>
  <tr>
    <th width="40%" align="left"><input type="radio" name="sType">Product Description</th>
  </tr>
</table>
<center>
<%
  		buttonName = new java.util.ArrayList();
  		buttonMethod = new java.util.ArrayList();
  		
  		String flg = request.getParameter("backFlg");
 		if(flg!=null && !"null".equals(flg))
		{
			flg = flg.trim();
			buttonName.add("Back");
			buttonMethod.add("ezBack(\""+flg+"\")");  			
		}
		else
		{
			buttonName.add("Back");
			buttonMethod.add("gotoHome()");
		}
	
  		out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

