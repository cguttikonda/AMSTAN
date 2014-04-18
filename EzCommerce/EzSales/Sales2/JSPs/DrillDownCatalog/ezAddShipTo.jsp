<%@ page import ="java.util.*,ezc.ezutil.*,ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="ezCountryStateList.jsp" %>
<%
	String display_header = "Add ShipTo";
%>
<Html>
<Head>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
	
<script>
	function funSave()
	{
		var companyNameObj = document.myForm.companyname;
		var addr1Obj       = document.myForm.addr1;
		var cityObj        = document.myForm.city;
		var pinObj         = document.myForm.pin;
		var stateListObj   = document.myForm.stateList;
		var stateInputObj  = document.myForm.stateInput;
		var emailObj       = document.myForm.email;
		var temp           = document.myForm.stateList.value
		var sel            = document.myForm.country.value;
		if(companyNameObj.value=="")
		{
			alert("Please enter company name");
			companyNameObj.focus();
			return false;
		}
		if(addr1Obj.value=="")
		{
			alert("Please enter address");
			addr1Obj.focus();
			return false;
		}
		if(cityObj.value=="")
		{
			alert("Please enter city");
			cityObj.focus();
			return false;
		}
		if(sel=="US" && stateListObj.value=="-")
		{
			alert("Please select a state");
			stateListObj.focus();
			return false;
		}
		if(sel!="US" && stateInputObj.value=="")
		{
			alert("Please enter state");
			stateInputObj.focus();
			return false;
		}	
		if(pinObj.value=="")
		{
			alert("Please enter zip / postal code");
			pinObj.focus();
			return false;
		}					
		if((emailObj.value!="") && (!echeck(emailObj.value)))
		{
			emailObj.value="";
			emailObj.focus();
			return false;
		}
		if(document.myForm.stateInput.value!=null && document.myForm.stateInput.value!="" && sel!="US")
          		temp =document.myForm.stateInput.value
          	
          	document.myForm.selState.value=temp;
		document.myForm.action="ezAddSaveShipTo.jsp";
		document.myForm.submit();
	}
	function echeck(str) 
	{
		var at="@"
		var dot="."
		var lat=str.indexOf(at)
		var lstr=str.length
		var ldot=str.indexOf(dot)
			if (str.indexOf(at)==-1)
			{
				alert("Please enter valid email-ID")
				return false
			}
			if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr)
			{
				alert("Please enter valid email-ID")
				return false
			}
			if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr)
			{
				alert("Please enter valid email-ID")
				return false
			}
			if (str.indexOf(at,(lat+1))!=-1)
			{
				alert("Please enter valid email-ID")
				return false
			}
	           	if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot)
	           	{
				alert("Please enter valid email-ID")
				return false
		        }
			if (str.indexOf(dot,(lat+2))==-1)
			{
				alert("Please enter valid email-ID")
				return false
		        }
			if (str.indexOf(" ")!=-1)
			{
				alert("Please enter valid email-ID")
				return false
		        }
	 		return true					
	}
	function onlyNumbers(evt)
	{
		var e = event || evt; // for trans-browser compatibility
		var charCode = e.which || e.keyCode;

		if (charCode > 31 && (charCode < 48 || charCode > 57))
			return false;

		return true;
	}
        function selectState()
        {
          	var sel = document.myForm.country.value;
          	
          	if(sel=="US")
          	{
		    document.getElementById("ListBoxDiv1").style.display="block";
		    document.getElementById("stateId").style.display="None";
		}
		else
		{
		    document.getElementById("stateId").style.display="block";
		    document.getElementById("ListBoxDiv1").style.display="None";
		}
	}  	
          
</script>
</Head>
<Body scroll=no>
<Form  name="myForm" method="post">
<input type="hidden" name="selState">
<%@ include file="../Misc/ezDisplayHeader.jsp"%> 
<Br>

	<Table align="center" width="50%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
		 <tr>
			 <th align="right">* Company Name</th> 
			 <td><input type="text" class="inputbox" name="companyname" size=40 maxlength=30> </td>
		 </tr>
		 <tr>
			 <th align="right">* Address1</th> 
			 <td><input type="text" class="inputbox" name="addr1" size=40 maxlength=60> </td>
		 </tr>
		 <tr>
			 <th align="right">Address2</th> 
			 <td><input type="text" class="inputbox" name="addr2" size=40 maxlength=60> </td>
		 </tr>
		 <tr>
			 <th align="right">* City </th> 
			 <td><input type="text" class="inputbox" name="city" size=40 maxlength=40> </td>
		 </tr>
		 <tr>
			 <th align="right">* State / Province </th>

			 <td>
			 	<select name="stateList" id ="ListBoxDiv1" style="width:58%">
			 	<option value="-">Select State</option>
			 	
<%
				Enumeration enum1S =  ezStates.keys();
				String enum1Key=null;
				String enum1Desc=null;
				
				while(enum1S.hasMoreElements())
				{
					enum1Key = (String)enum1S.nextElement();
					enum1Desc = (String)ezStates.get(enum1Key);
%>
					<option value="<%=enum1Key%>"><%=enum1Desc%></Option>
<%
				}
%>									
			 	</select>
			 	
			 	<input type="text" id="stateId" class="inputbox" style="display:none" name="stateInput" size=40>
			 </td>	 	
	
		 </tr>
		  <tr>
			 <th align="right">Country </th> 
			 <td>
			 	<select name="country" onChange="selectState()" style="width:58%">
<%

				Enumeration enum2S =  ezCountry.keys();
				String enum2Key=null;
				String enum2Desc=null;
				
				while(enum2S.hasMoreElements())
				{
					enum2Key = (String)enum2S.nextElement();
					enum2Desc = (String)ezCountry.get(enum2Key);
					if("US".equals(enum2Key))
					{
%>					<option value="<%=enum2Key%>" selected><%=enum2Desc%></Option>
<%	                        	}
					else
					{
%>					<option value="<%=enum2Key%>"><%=enum2Desc%></Option>
<%					}
				}
%>
			 	</select>
			 		 	 
			 </td>	
			 
		 </tr>
		 <tr>
			 <th align="right">* Zip / Postal Code </th>
			 <td><input type="text" class="inputbox" name="pin" size=40 maxlength=10> </td>
		 </tr>
		 <tr>
			 <th align="right">Phone </th>
			 <td><input type="text" class="inputbox" name="phone" size=40 maxlength=20 onkeypress="return onlyNumbers();"> </td>
		 </tr>
		 <tr>
			 <th align="right">Email </th>
			 <td><input type="text" class="inputbox" name="email" size=40 maxlength=50> </td>
		 </tr>
		<!--
		<tr>
			 <th align="right">Fax </th>
			 <td><input type="text" class="inputbox" name="fax" size=40 maxlength=20 onkeypress="return onlyNumbers();"> </td>
		 </tr>
		-->
		 <tr ><td colspan=2 align=center valign="middle" style="background:transparent"> &nbsp; </td></tr>
		 <tr ><td colspan=2 align=center valign="middle" style="background:transparent"><font size=2><b> * Indicates a required field </b></font></td></tr>
	</table>
	
	<div id="buttonDiv" align="center" style="visibility:visible;position:absolute;top:86%;width:100%">
	<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Save");
		buttonMethod.add("funSave()");	
		buttonName.add("Back");
		buttonMethod.add("history.go(-1)");	
		out.println(getButtonStr(buttonName,buttonMethod));
	%>
	</div>
</Form>
</Body>
</Html>