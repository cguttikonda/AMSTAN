<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iVendorAddress_Labels.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iGetInfo.jsp"%>

<html>
<head>

<script language="JavaScript">
function checkAll() {
	var entAllReqFlds_L = '<%=entAllReqFlds_L%>';
	var form = document.forms[0]
	for (i = 0; i < form.elements.length; i++) {
		var name = form.elements[i].name;
		var name1 = name.charAt(0);
		if (form.elements[i].type == "text" && form.elements[i].value == "" && name1 != "Z"){ 
			alert(entAllReqFlds_L);
			document.returnValue = false;
			break;
		}else{
			document.returnValue = true;
		}//End if
	}//End for
}//end function
</script>

<title>Get Customer Information</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../../../newpurchase1/Library/Styles/Theme1.css">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %></head>
<body>
<table width="60%" border="0" align="center">
  <tr align="center"> 
    <td class="displayheader"><%=vendAddInfo_L%></td>
  </tr>
</table>
<p align="center"><%=entAddMod_L%></p>
<form method="post" action="." name="updateinfo">
  <table width="60%" border="0" align="center">
    <tr> 
      <th width="100%" height="16" class="labelcell" colspan="2"><%=compInfo_L%></th>
    </tr>
    <tr> 
      <td width="51%" height="3" class="labelcell"><%=compName_L%>*:</td>
      <td width="49%" height="3"> 
        <input type="text" class=InputBox  name="Company" value = "<%=ret.getFieldValueString(0,"ECA_NAME")%>" size="24" maxlength="24" >
      </td>
    </tr>
    <tr> 
      <td width="51%" class="labelcell"><%=contactName_L%>*:</td>
      <td width="49%"> 
        <input type="text" class=InputBox  name="ConactFirst" size="24" value = "<%=ret.getFieldValueString(0,EC_NAME_X)%>" maxlength="24">
      </td>
    </tr>
    <tr> 
      <td width="51%" class="labelcell"><%=email_L%>*:</td>
      <td width="49%"> 
        <input type="text" class=InputBox  name="Email" value = "<%=ret.getFieldValueString(0,EC_EMAIL_X)%>"  size="24" maxlength="24">
      </td>
    </tr>
    <tr> 
      <td width="51%" class="labelcell"><%=phone_L%>*:</td>
      <td width="49%"> <%
String Phone = ret.getFieldValueString(0,EC_PHONE_X);
//System.out.println("Phone number: " + Phone + "End Phone");

if(Phone != null)
{
	Phone.trim();
	out.println("<input type=\"text\" name=\"Phone\" value=\""+ Phone+"\" size=\"24\" maxlength=\"10\" >");
}
else
{
	out.println("<input type=\"text\" name=\"Phone\" value=\"\" size=\"24\" maxlength=\"10\" >");
}

/*
if(Phone != null){
String Phone1 = Phone.substring(0,3);
String Phone2 = Phone.substring(3,6);
String Phone3 = Phone.substring(6,10);
			out.println("<input type=\"text\" name=\"Phone1\" value=\""+ Phone1+"\" size=\"3\" maxlength=\"3\" >");
			out.println("-");
			out.println("<input type=\"text\" name=\"Phone2\" value=\""+ Phone2+"\" size=\"3\" maxlength=\"3\" >");
			out.println("-");
			out.println("<input type=\"text\" name=\"Phone3\" value=\""+ Phone3+"\" size=\"4\" maxlength=\"4\" >");
}else{
			out.println("<input type=\"text\" name=\"Phone1\" value=\"\" size=\"3\" maxlength=\"3\" >");
			out.println("-");
			out.println("<input type=\"text\" name=\"Phone2\" value=\"\" size=\"3\" maxlength=\"3\" >");
			out.println("-");
			out.println("<input type=\"text\" name=\"Phone3\" value=\"\" size=\"4\" maxlength=\"4\" >");
}
*/
%> 
	</td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0">
    <tr> 
      <td valign="top" class="blankcell"> 
        <table width="60%" border="0" hspace="15" align="center">
          <tr> 
            <th colspan="2"><%=bankAdd_L%></th>
          </tr>
          <tr> 
            <td width="46%" class="labelcell" height="10"><%=bankAdd_L%>*:</td>
            <td width="54%">Bank of America</td>
          </tr>
          <tr> 
            <td width="46%" class="labelcell" height="10"><%=street_L%></td>
            <td width="54%">North First Street</td>
          </tr>
          <tr> 
            <td width="46%" class="labelcell" height="10"><%=bankAccNo_L%></td>
            <td width="54%">121223424</td>
          </tr>
          <tr> 
            <td width="46%" class="labelcell" height="10"><%=state_L%></td>
<%
String Name1 = null;
String InitialValue1 = null;
String Type1 = null;
String Data1 = null;
String Align1 = null;
String width1 = null;
String Select_Value1 = null;

// Bill To State
	Name1 = "BillState";
	Object UserTypes1[] = 
			{"Alabama","Alaska","Alberta","American Samoa","Arizona","Arkansas","California","Colorado", "Connecticut","Delaware","District Of Columbia","Florida","Georgia","Guam","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Manitoba","Maryland","Massachusetts","Michigan","Minnesota", "Mississippi","Missouri","Montana","Nebraska","Nevada","New Brunswick","New Hampshire","New Jersey",  "New Mexico","New York","Newfoundland","North Carolina","North Dakota","Northwest Territories","Nova Scotia","Ohio","Oklahoma","Ontario","Oregon","Palau","Pennsylvania","Province du Quebec","Puerto Rico","Rhode Island","Saskatchewan","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virgin Islands","Virginia", "Washington","West Virginia","Wisconsin","Wyoming","Yukon Territory"};

	Object TypeValues1[] = 
			{"AL","AK","AB","AS","AZ","AR","CA","CO","CT","DE","DC","FL","GA","GU","HI","ID",
			 "IL","IN","IA","KS","KY","LA","ME","MB","MD","MA","MI","MN","MS","MO","MT","NE",
			 "NV","NB","NH","NJ","NM","NY","NF","NC","ND","NT","NS","OH","OK","ON","OR","PW",
			 "PA","PQ","PR","RI","SK","SC","SD","TN","TX","UT","VT","VI","VA","WA","WV","WI",
			 "WY","YT"};
	width1 = "30%";
	Select_Value1 = ret.getFieldValueString(0,EC_STATE_X);
	if( Select_Value1 != null && !Select_Value1.equals("null"))
	{
		insertList (out , Name1 , UserTypes1 , TypeValues1 , width1 , Select_Value1);
	}
	else
	{
		insertList (out , Name1 , UserTypes1 , TypeValues1 , width1 , "AL");
	}
%> 
	</tr>
    	<tr> 
            <td width="46%" height="10" class="labelcell"><%=accType_L%></td>
            <td width="54%">&nbsp; </td>
        </tr>
        </table>
      </td>
    </tr>
  </table>
  <div align="center"><br>
    <input type="reset" name="Submit2" value="Update">
    </div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
