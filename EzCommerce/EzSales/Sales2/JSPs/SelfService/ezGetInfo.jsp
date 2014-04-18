<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/SelfService/iGetInfo.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iAcCopy_Lables.jsp"%>
<html>
<head>
<title>Get Customer Information</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>

<script language="JavaScript">
function isDigit(s)
{
	if ( s >= 0 && s <= 9 )return true;
	return false;
}

function checkDigit(inp)
{
	var len = inp.length;
	for( i=0; i < len; i++)
	{
		if ( !isDigit( inp.charAt(i) ) )
		{
			return false;
		}
	}
	return true;
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
} //end trim

function checkAll()
{

	var form = document.forms[0]
	for (i = 0; i < form.elements.length; i++)
	{
		var name = form.elements[i].name;
		if ( name == 'BillAddress2' ||  name == 'Phone'|| name == 'shipAddr1'|| name == 'shipAddr2'|| name == 'webAddr' || name == 'billToState' ) continue;
		var name1 = name.charAt(0);
		var val=trim(form.elements[i].value)
		if ((form.elements[i].type == "text") &&( val == "")&&(i!=5 && i!=11))
		{	alert("<%=entAllFields_A%>");
			document.returnValue = false;
			form.elements[i].focus();
			bflag= true;
			break;
		}
		else{			
			document.returnValue = true;		
		}//End if
	}//End for
      if(document.returnValue==true)
	{
			document.updateinfo.submit();	
	}

}//end function


var ezCountryName = new Array();

<%
Enumeration keys=null;
ResourceBundle crb=null;
crb=ResourceBundle.getBundle("COUNTRIES");
keys = crb.getKeys();


String countryKey=null;
if(keys!=null)
{
	int cCount=0;
	while(keys.hasMoreElements())
	{
		countryKey=(String)keys.nextElement();
%>
		ezCountryName[<%=cCount%>]=new ezCountryNameList('<%=crb.getString(countryKey)%>','<%=countryKey.trim()%>');
<%
	cCount++;
	}
}
%>

function ezCountryNameList(cDesc,cCode)
{
	this.code=cCode;
	this.desc=cDesc;
}
ezSortColumns(0,ezCountryName.length-1)


function  ezSortColumns(lo,hi)
{
   if( hi > lo )
    {
      left=lo; right=hi;
      median=ezCountryName[left].desc;
      while(right >= left)
       {
             while(ezCountryName[left].desc < median)
              left++;
             while(ezCountryName[right].desc > median)
              right--;

		if(left > right) break;

         	temp1=ezCountryName[left].desc;
		temp2=ezCountryName[left].code;
         	ezCountryName[left].desc=ezCountryName[right].desc;
		ezCountryName[left].code=ezCountryName[right].code;

         	ezCountryName[right].desc=temp1; //swap
		ezCountryName[right].code=temp2; //swap
         	left++;
         	right--;
       }
       ezSortColumns(lo, right);// divide and conquer
       ezSortColumns(left,hi);
    }
    return
 }

function gotoHome()
{
	document.location.replace("../Misc/ezWelcome.jsp");
}
function fldFocus()
{
//if(document.updateinfo.BillAddress1 != null)
	//document.updateinfo.BillAddress1.focus();

}
</script>
</head>
<body onLoad="fldFocus()" scroll="auto">
<form method="post" action="ezUpdateInfo.jsp" name="updateinfo">
<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" class="displayheaderback" align=center width="100%"><%=caddr_L%></td>
</tr>
</table>
<%
if(retCount >0)
{
%>

<table border="0" align="center">
  <tr align="center">
      <td class="blankcell"><%=plzinfomod_L%>.[* indicates Mandatory]</td>
  </tr>
</table>
<DIV id="tabHead" style="position:absolute;overflow:auto;width:100%;height:60%;zindex:5">
        <table width="55%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
           <tr>
	     <th width="40%" align="left"><%=comp_L%>*</th>
      	     <td width="60%" height="3">
               <input type="text" name="billCompany" value = "<%=CompName%>" size="24" maxlength="60" readonly class=tx>
             </td>
          </tr>
          <tr>
            <th width="40%" align="left"> <%=addr_L%>*</th>
            <td width="60%">
              <input type="text" class=InputBox name="BillAddress1" value="<%=addrLine2%>" size="32" maxlength="30">
            </td>
          </tr>
          <tr>
            <th><font size="3">&nbsp;</font></th>
            <td width="60%">
              <input type="text"  class=InputBox name="BillAddress2" value = "<%=addrLine3%>" size="32" maxlength="30">
            </td>
          </tr>
          <tr>
            <th width="40%" align="left"><%=city_L%>*</th>
            <td width="60%">
              <input type="text"  class=InputBox name="BillCity" size="32" value = "<%=City%>" maxlength="30">
            </td>
          </tr>
	<tr>
            <th width="40%" align="left"><%=state_L%></th>
	    <td width="60%" >
		<input type="text"  class=InputBox name="billToState" size="3" value = "<%=State%>" maxlength="3">
	   </td>
	</Tr>
          <tr>
            <th width="40%" align="left"><%=zip_L%></th>
            <td width="60%">
		<input type=text name=BillZip  class=InputBox size=12 maxlength=10 value=<%=Zip%>>
 </td>
          </tr>
          <tr>
            <th  width="40%" align="left"><%=coun_L%>*</th>
            <td width="60%">
		<select name="BillCountry">
			   <option  value=" ">-Select Country-</option>
			  <script>

			for(var i=0; i < ezCountryName.length;i++)
			{

				if(ezCountryName[i].code=="<%=Country%>")
					document.write("<option value="+ezCountryName[i].code+" selected>"+ezCountryName[i].desc+"</option>");
				else
					document.write("<option value="+ezCountryName[i].code+">"+ezCountryName[i].desc+"</option>");
			}
			</script>

	      </select>
            </td>
          </tr>
  <tr>
            <th  width="40%" align="left">Phone</th>
            <td width="60%">
              <input type="text" class=InputBox  name="Phone" size="35" value = "<%=phone%>" maxlength="35">
            </td>
          </tr>
     <tr>

     <tr>
            <th  width="40%" align="left">Ship To Address</th>
            <td width="60%">
              <input type="text" class=InputBox  name="shipAddr1" size="35" value = "<%=shipAddr1%>" maxlength="35">
            </td>
          </tr>
     <tr>
            <th  width="40%" align="left">&nbsp;</th>
            <td width="60%">
              <input type="text" class=InputBox  name="shipAddr2" size="35" value = "<%=shipAddr2%>" maxlength="35">
            </td>
          </tr>
     <tr>
            <th  width="40%" align="left">Web Address</th>
            <td width="60%">
              <input type="text" class=InputBox  name="webAddr" size="35" value = "<%=webAddr%>" maxlength="35">
		<input type="hidden" value="<%=defPartnNum%>" name="defSold">
            </td>
          </tr>
        </table>
</div>
 <DIV id="buttonDiv" style="position:absolute;top:90%;width:100%;" align=center>
  <%
 	buttonName = new java.util.ArrayList();
 	buttonMethod = new java.util.ArrayList();
 	buttonName.add("Submit");
 	buttonMethod.add("checkAll()");
 	buttonName.add("Back");
 	buttonMethod.add("gotoHome()");
 	out.println(getButtonStr(buttonName,buttonMethod));
 %>
</div>
<%
	} else {
%>
	<p align="center"> <%=noaddrup_L%>.
	<br><br>
	<center>
<%	
	 	buttonName = new java.util.ArrayList();
	 	buttonMethod = new java.util.ArrayList();
	 	buttonName.add("Back");
	 	buttonMethod.add("gotoHome()");
	 	out.println(getButtonStr(buttonName,buttonMethod));
%>
	</center>
<%
	}
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
