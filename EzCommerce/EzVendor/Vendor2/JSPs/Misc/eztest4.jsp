<%
String sessionId = "";
//out.println(session.getId());
%>
<html>
<head>
<link rel="stylesheet" href="legendcss.css" type="text/css"/>   
<style>
td
{
font-size:13pt;
}
</style>
<script>
function validate()
{	
	/*if(document.myForm.title.value=="")
	{
		alert("please select your title");
		document.myForm.title.focus();
		return ;
	}
	else if(document.myForm.name.value=="")
	{
		alert("please enter your name");
		document.myForm.name.focus();
		return ;
	}
	else if(document.myForm.shno.value=="")
	{
		alert("please enter your street/house no");
		document.myForm.shno.focus();
		return ;
	}
	else if(document.myForm.pcode.value=="")
	{
		alert("please enter your postal code ");
		document.myForm.pcode.focus();
		return ;
	}
	else if(document.myForm.region.value=="")
	{
		alert("please select your region  ");
		document.myForm.region.focus();
		return ;
	}
	else if(document.myForm.teleno.value=="")
	{
		alert("please enter your telephone number  ");
		document.myForm.teleno.focus();
		return ;
	}
	else if(document.myForm.mobno.value=="")
	{
		alert("please enter your mobile number   ");
		document.myForm.mobno.focus();
		return ;
	}
	else if(document.myForm.exciseno.value=="")
	{
		alert("please enter your excise number  ");
		document.myForm.exciseno.focus();
		return ;
	}
	else if(document.myForm.exciseregno.value=="")
	{
		alert("please enter your excise registration no   ");
		document.myForm.exciseregno.focus();
		return ;
	}
	else if(document.myForm.exciserange.value=="")
	{
		alert("please enter your excise range  ");
		document.myForm.exciserange.focus();
		return ;
	}
	else if(document.myForm.excisediv.value=="")
	{
		alert("please enter your excise divsion   ");
		document.myForm.excisediv.focus();
		return ;
	}
	else if(document.myForm.PANno.value=="")
	{
			alert("please enter your PAN number   ");
			document.myForm.PANno.focus();
			return ;
	}
	else if(document.myForm.VATRno.value=="")
	{
			alert("please enter your VAT registration no   ");
			document.myForm.VATRno.focus();
			return ;
	}
	else if(document.myForm.bcountry.value=="")
	{
			alert("please enter your bank country  ");
			document.myForm.bcountry.focus();
			return ;
	}
	else if(document.myForm.bankkey.value=="")
	{
			alert("please enter your bank key  ");
			document.myForm.bankkey.focus();
			return ;
	}
	else if(document.myForm.baccount.value=="")
	{
			alert("please enter your bank account  ");
			document.myForm.baccount.focus();
			return ;
	}
	else if(document.myForm.acholder.value=="")
	{
			alert("please enter your account holder name  ");
			document.myForm.acholder.focus();
			return ;
	}
	else if(document.myForm.firstname.value=="")
	{
			alert("please enter your first name  ");
			document.myForm.firstname.focus();
			return ;
	}
	else if(document.myForm.lastname.value=="")
	{
			alert("please enter your last name   ");
			document.myForm.lastname.focus();
			return ;
	}
	else
	{
	*/
		
		document.myForm.action="ezSave.jsp";
		document.myForm.submit();
	//}
	
}
function maxLength(field,maxChars)
{
	if(field.value.length >= maxChars) 
	{
		event.returnValue=false;
		return false;
	}
}  
function maxLengthPaste(field,maxChars)
{
	event.returnValue=false;
	if((field.value.length +  window.clipboardData.getData("Text").length) > maxChars) 
	{
		return false;
	}
event.returnValue=true;
}
</script>
</head>
<%
TreeMap tm = new TreeMap();
	// Put elements to the map
	
	tm.put("AP", "Andhra Pradesh");
	tm.put("ARP", "Arunachal Pradesh");
	tm.put("AS", "Assam");
	tm.put("BH", "Bihar");
	tm.put("CH", "Chhattisgarh");
	tm.put("GOA", "Goa");
	tm.put("GJ", "Gujarat");
	tm.put("HY", "Haryana	");
	tm.put("HP", "Himachal Pradesh");
	tm.put("JK", "Jammu and Kashmir");
	tm.put("JH", "Jharkhand");
	tm.put("KA", "Karnataka");
	tm.put("KL", "Kerala");
	tm.put("MP", "Madhya Pradesh");
	tm.put("MH", "Maharashtra");
	tm.put("MN", "Manipur	");
	tm.put("MG", "Meghalaya");
	tm.put("MZ", "Mizoram	");
	tm.put("NG", "Nagaland");
	tm.put("OR", "Orissa");
	tm.put("PN", "Punjab");
	tm.put("RJ", "Rajasthan");
	tm.put("SK", "Sikkim");
	tm.put("TN", "Tamil Nadu");
	tm.put("TI", "Tripura");
	tm.put("UP", "Uttar Pradesh");
	tm.put("UT", "Uttarakhand");
	tm.put("WB", "West Bengal");
	// Get a set of the entries
	Set set = tm.entrySet();
	// Get an iterator
	Iterator it = set.iterator();
%>
<body>

<form name="myForm">

 <h1 align="center"><i>Vendor Registration</i></h1>
  <div id="tabs-1">
  <fieldset>
  <legend>Address:</legend>
  <table align="center">
   <Tr>
      	<Td>Title:</Td>
      	<Td><select name="title">
      	<option value="" selected>--select--</option>
     	<option value="MR">MR</option>
     	<option value="MS">MS</option>
     	<option value="MRS">MRS</option>
   
     	</select></Td>
  
   	<Td>Name:</Td>
   	<Td><input type="text" name="name"></Td>
   </Tr>
   <Tr>
      	<Td>Street/House No:</Td>
      	<Td><input type="text" name="shno"></Td>
  
      	<Td>Postal Code:</Td>
      	<Td><input type="text" name="pcode"></Td>
   </Tr>
   <Tr>
        	<Td>Country</Td>
        	<Td><select name="country"><option value="India" selected >India</option></select</Td>
  
        	<Td>Region:</Td>
        	<Td><select name="region">
        	<option value="">--select Region--</option>
        	
  <%
  while(it.hasNext()) 
  {
  	Map.Entry me = (Map.Entry)it.next();
  %>	
  	
  	<option value='<%=me.getKey()%>'><%=me.getValue()%></option>
  <%
  
  }
  
  %>
        	</Td>
   </Tr>
   
   
   <Tr>
      	<Td>Telephone No:</Td>
      	<Td><input type="text" name="teleno"></Td>
   <Td>Mobile No:</Td>
         <Td><input type="text" name="mobno"></Td>

      	<Td>Fax</Td>
      	<Td><input type="text" name="fax"></Td>
   </Tr>
   <Tr>
         <Td>E-mail</Td>
         <Td><input type="text" name="email"></Td>
   </Tr>
   
</fieldset>	    
  </table>
   
  </div>
  <br>
  <div id="tabs-2">
   <fieldset>
  <legend>Excise Details:</legend>
  <table align="center">
      <Tr>
         	<Td>Excise No:</Td>
         	<Td><input type="text" name="exciseno"></Td>
         </Tr>
         <Tr>
            	<Td>Excise Reg No:</Td>
            	<Td><input type="text" name="exciseregno"></Td>
         </Tr>
         <Tr>
            	<Td>Excise Range:</Td>
            	<Td><input type="text" name="exciserange"></Td>
         </Tr>
         <Tr>
            	<Td>Excise Division :</Td>
            	<Td><input type="text" name="excisediv"></Td>
         </Tr>
         <Tr>
            	<Td>PAN No:</Td>
            	<Td><input type="text" name="PANno"></Td>
         </Tr>
   </table>
       
   </feildset>
  </div>
  <br>
  <div id="tabs-3">
     <fieldset>
  <legend>Control  Details:</legend>
  	<table align="center">
       <Tr>
               	<Td>VAT Reg No:</Td>
               	<Td><input type="text" name="VATRno"></Td>
         </Tr>
       </table>
   </feildset>
  </div>
  <br>
  <div id="tabs-4">
    <fieldset>
  <legend>Bank Details:</legend>
  <table align="center">
    <Tr>
               	<Td>Country</Td>
               	<Td><input type="text" name="bcountry"></Td>
            </Tr>
            <Tr>
               	<Td>Bank Key</Td>
               	<Td><input type="text" name="bankkey"></Td>
            </Tr>
            <Tr>
               	<Td>Bank Account</Td>
               	<Td><input type="text" name="baccount"></Td>
            </Tr>
            <Tr>
               	<Td>A/C holder</Td>
               	<Td><input type="text" name="acholder"></Td>
         </Tr>
   </table>
   </feildset align="center">
  </div>
  <br>
  <div id="tabs-5">
       <fieldset>
  <legend>Personal Details:</legend>
  <table align="center">
         <Tr>
	               	<Td>First Name:</Td>
	               	<Td><input type="text" name="firstname"></Td>
	            </Tr>
	            <Tr>
	               	<Td>Last Name:</Td>
	               	<Td><input type="text" name="lastname"></Td>
	            </Tr>
	            <Tr>
	               	<Td>Region:</Td>
	               	<Td><input type="text" name="reg"></Td>
         </Tr>
  </table>       
   </feildset>
  </div>
</div>
<br>
<br>
  <div id="tabs-5">
       <fieldset>
  <legend>Attach Documents :</legend>
  <table align="center">
         <Tr>
		<Td><input type="button" name="attachDoc" value="Click here to Attach Documents" onClick="window.open('../css/ezAttachFile.jsp?sessionId=<%=session.getId()%>','popuppage','left=510,top=180,width=400,height=360,statusbar=yes');"></Td>
		<Td><textarea name="bulletins" rows="5" cols="73"  onKeyPress='return maxLength(this,"1000");' onpaste='return maxLengthPaste(this,"1000");' readonly></textarea></Td>
	 </Tr>
  </table>       
   </feildset>
  </div>
</div>
 <div>
 <br>
 <center><input type="button" value="submit"  onClick="validate()"
  <Td><input type="button" name="attachfile" onClick="window.open('../css/ezAttachFile.jsp?sessionId=<%=session.getId()%>','popuppage','left=510,top=180,width=400,height=360,statusbar=yes');" value="Attach Related Documents "></Td>
 </center>
 </div>
 </center>
 </form>
</body>
</html>