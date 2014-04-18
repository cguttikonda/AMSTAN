<%@ include file="../../Library/Globals/errorPagePath.jsp"%> 

<%
	String system = request.getParameter("system");
	String sysDesc =request.getParameter("sysDesc");
	String reportDomain =request.getParameter("reportDomain");

	String reportName= request.getParameter("reportName");
	String reportDesc= request.getParameter("reportDesc");
	String reportType= request.getParameter("reportType");
	String exeType= request.getParameter("exeType");
	String visibility= request.getParameter("visibility");
	String status= request.getParameter("status");
%>
<%@ include file="../../../Includes/JSPs/Reports/iAddReportNext.jsp"%>
<%
	ezc.ezbasicutil.EzDefaults def = new ezc.ezbasicutil.EzDefaults(Session); 
	java.util.ArrayList repDefaults =def.getDefaultKeys();

	int repDefaultsCount =0;
	if(repDefaults != null)
	repDefaultsCount =repDefaults.size();
%>
<html>
<head>
  <title>ezAddReport</title>
  <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">

<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
     <script src="../../Library/JavaScript/ezTrim.js"></script>
     <script src="../../Library/JavaScript/ezSelSelect.js"></script>
  <script>
function checkIsDefault(obj,ind)
{
	myForm=document.addForm;

	if(obj.checked)
	{
		if(isNaN(myForm.paramIsDef.length) && ind=="0")
			myForm.paramIsDef.value="Y"
		else
			myForm.paramIsDef[ind].value="Y"

	}
	else
	{
		if(isNaN(myForm.paramIsDef.length) && ind=="0")
			myForm.paramIsDef.value="N"
		else
			myForm.paramIsDef[ind].value="N"

	}

}
function chkMethod()
{
	myForm=document.addForm;
	pCount = myForm.paramIsDef.length;
	var retFlag=true;
	if (isNaN(pCount))
	{
		if(myForm.paramIsDef.value=="Y")
		{
			if(myForm.paramMethod.selectedIndex==0)
			{
				alert("Please Select Method")
				myForm.paramMethod.focus()
				retFlag=false
			}
		}
	}else
	{
		for ( i = 0 ; i < pCount; i++ )
		{
			if(myForm.paramIsDef[i].value=="Y")
			{
				if(myForm.paramMethod[i].selectedIndex==0)
				{
					alert("Please Select Method")
					myForm.paramMethod[i].focus()
					retFlag=false
					break;

				}
			}
		}
	}
	
	return retFlag

}
function checkIsMandLocal(obj,ind)
{
	myForm=document.addForm;
	if(obj.checked)
	{
		if(isNaN(myForm.paramIsmand.length) && ind=="0")
		myForm.paramIsmand.value="L"
		else
		myForm.paramIsmand[ind].value="L"
	}
	else
	{
		if(isNaN(myForm.paramIsmand.length) && ind=="0")
		myForm.paramIsmand.value="N"
		else
		myForm.paramIsmand[ind].value="N"
	}
}

function checkSelect()
{
	myForm=document.addForm;
	selCount=0;
	pCount = myForm.paramIsSel.length;
	var chkFlag=true;
	if(isNaN(pCount))
	{
		if(myForm.paramIsSel1.checked)
		{
			myForm.paramIsSel.value = "Y";
			chkFlag=false;
			selCount++
		}else
		{
			myForm.paramIsSel1.checked=false;
			myForm.paramIsSel.value = "N";
		}

	}else
	{
		for ( i = 0 ; i < pCount; i++ )
		{

			if(chkFlag){
				if(myForm.paramIsSel1[i].checked){
				myForm.paramIsSel[i].value = "Y";
						chkFlag=false;
					selCount++
				}
			}else{
				if(myForm.paramIsSel1[i].checked)
						selCount++
				myForm.paramIsSel1[i].checked=false;
				myForm.paramIsSel[i].value = "N";
			}


		}
	}
	if(selCount>1)
	{

		alert("Only one parameter can be selected");
		return false;
	}else if(selCount==0)
	{
		alert("Atleast select one parameter");
		return false;
	}else
	{
		return true;
	}
}
function setHiddenFlag()
{
	myForm=document.addForm;
	if(isNaN(myForm.paramIshide1.length))
	{
		if(myForm.paramIshide1.checked)
		{
			myForm.paramIshide.value = "Y";
		}
		else
			myForm.paramIshide.value = "N";
	}else
	{
		for ( i = 0 ; i < myForm.paramIshide1.length; i++ )
		{
			if(myForm.paramIshide1[i].checked)
			{
				myForm.paramIshide[i].value = "Y";

			}
			else
				myForm.paramIshide[i].value = "N";
		}
	}
}

function chkAll()
{
	y="true"
	setHiddenFlag()

	y=checkSelect()

	if(eval(y))
		y=chkMethod()

	if(eval(y))
	{
		return true
	}else
	{

		return false
	}

}


function ezFormSubmit(type)
{

    	ezForm=document.addForm
	if(type=="1")
	{
		ezForm.action="ezAddSaveReport.jsp"
		ezForm.submit();
	}else
	{
		if(chkAll())
    		{
    			ezForm.action="ezAddReportFinal.jsp"
			ezForm.submit();
		}
	}


}

function ezBack()
{
     /* ezForm=document.addForm
      ezForm.action="ezAddReport.jsp"
      ezForm.submit()*/
      history.back(-1)
}

  </script>


<Title>Add Reports</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<body onLoad="scrollInit()" onresize="scrollInit()" scroll="no">
<form name=addForm method=post action="ezAddReportFinal.jsp">
<br>
<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
    	<Td class="displayheader">Add Report</Td>
  	</Tr>
	</Table>
 <table width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<tbody>
	<tr>
		<th align="right">System</th>
		<td align="left"><input type="hidden" name="system" value="<%=system%>"><input type="hidden" name="sysDesc" value="<%=sysDesc%>"><%=sysDesc%></td>
		<th align="right">Domain</th>
		<td align="left"><input type="hidden" name="reportDomain" value="<%=reportDomain%>">
<%
		if("1".equals(reportDomain))
		{
			out.println("Sales");

		}else if("2".equals(reportDomain))
		{
			out.println("Vendor");

		}else if("3".equals(reportDomain))
		{
			out.println("Service");

		}else if("4".equals(reportDomain))
		{
			out.println("ReverseAuction");
		}

%>
	     </Td>
  		<th align="right">Type</th>
           	 <td align="left"><input type="hidden" name="reportType" value="<%=reportType%>">
<%
			if("1".equals(reportType))
			{
				out.println("Local");
			}else if("2".equals(reportType))
			{
				out.println("Back End");
			}
%>
         	</td>
	</tr>
        <tr>
	  <th align="right">Name</th>
          <td align="left"><input type="hidden" name="reportName" value="<%=reportName%>"><%=reportName%></td>
          <th align="right">Description</th>
          <td align="left" colspan="3"><input type="hidden" name="reportDesc" value="<%=reportDesc%>"><%=reportDesc%></td>
        </tr>
        <tr>

            <th align="right">Execution Type</th>
            <td align="left"><input type="hidden" name="exeType" value="<%=exeType%>">
<%
		if("O".equals(exeType))
		{
			out.println("On-Line");
		}else if("B".equals(exeType))
		{
			out.println("Back Ground");
		}else if("A".equals(exeType))
		{
			out.println("Both");
		}
%>
            </td>

            <th align="right">Visibility</th>
            <td align="left"><input type="hidden" name="visibility" value="<%=visibility%>">
<%
		if("I".equals(visibility))
		{
			out.println("Internal Users");
		}else if("B".equals(visibility))
		{
			out.println("Business users");
		}else if("A".equals(visibility))
		{
			out.println("ALL");
		}
%>
             </td>
            <th align="right">Status</th>
            <td align="left"><input type="hidden" name="status" value="<%=status%>">
<%
		if("A".equals(status)){
			out.println("Active");
		}else if("I".equals(status)){
			out.println("In Active");
		}
%>
            </td>
          </tr>

    </tbody>
  </table>


		<!--<Div id="theads">
		<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="95%">
		-->
	<%
		if(RetParam != null && !RetParam.isError())
		{
			String param = null;
			String paramtype = null;
			if ( paramRows > 0 )
			{
	%>
			<Div id="theads">
			    <Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
				<Tr align="center" valign="middle">
				<Th width="13%" >Name</Th>
	        		<Th width="42%" >Description</Th>
				<Th width="5%" Title="Select">S*</Th>
				<Th width="5%" Title="Hidden">H*</Th>
				<Th width="5%" Title="Method">M*</Th>
				<Th width="5%" Title="Defaults">D*</Th>
				<Th width="25%" >Method</Th>
	        		</Tr>
			  </table>
		</Div>

		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
				String paramName,paramDesc,paramLen,paramType,paramDataType,paramIsmand="";
			      for ( int i = 0 ; i < paramRows; i++ )
				{
					paramName=RetParam.getFieldValueString(i,"SELNAME");
					paramDesc=RetParam.getFieldValueString(i,"LOW");
					paramDesc=paramDesc.trim();
					paramLen=RetParam.getFieldValueString(i,"OPTION");
					paramLen=(paramLen.trim().length() ==0)?"0":paramLen;
					paramType=RetParam.getFieldValueString(i,"KIND");
					paramDataType=RetParam.getFieldValueString(i,"HIGH");
					paramIsmand=RetParam.getFieldValueString(i,"SIGN");

					if("null".equals(paramDesc) || "".equals(paramDesc))
						paramDesc="";
%>
	 		 <Tr align="center" valign="middle">
		        	<Td width="13%" align="left"><input type="hidden" name="paramName" value="<%=paramName%>"><%=paramName%></Td>
	      	  	<Td width="42%" ><input type="text" name="paramDesc" maxlength="128" class="InputBox" style="width:100%" value="<%=paramDesc%>"></Td>
				<Td width="5%" ><input type=checkbox name="paramIsSel1" onClick="checkSelect()" value="N"></Td>
				<Td width="5%" ><input type=checkbox name="paramIshide1" onClick="setHiddenFlag()">
					<input type="hidden" name="paramIsSel" value="N">
					<input type="hidden" name="paramIshide" value="N">
					<input type="hidden" name="paramLen" value="<%=paramLen%>" >
					<input type="hidden" name="paramType" value="<%=paramType%>" >
					<input type="hidden" name="paramDataType" value="<%=paramDataType%>" >
					<input type="hidden" name="paramMulti" value="NµNµNµNµNµNµNµNµNµNµN¤NµNµNµNµNµNµNµNµNµNµN¤NµNµNµNµNµNµNµNµNµNµN¤NµNµNµNµNµNµNµNµNµNµN">
					<input type="hidden" name="lowValue" value="µ">
					<input type="hidden" name="highValue" value="µ">
					<input type="hidden" name="paramOpt" value="EQ">
					<input type="hidden" name="paramMod" value="I" >
				</Td>
				<Td width="5%" >
				<% if("X".equals(paramIsmand)){%>
					<input type=checkbox name="paramIsmand1" value="<%= paramIsmand %>" disabled checked>
					<input type="hidden" name="paramIsmand" value="<%= paramIsmand %>">

				<%}else{%>
					<input type=checkbox name="paramIsmand1" value="N" onClick='checkIsMandLocal(this,"<%=i%>")'>
					<input type="hidden" name="paramIsmand" value="N">
				<%}%>
				</Td>
				<Td width="5%" >
				<%
				if( ("P".equals(paramType) && "1".equals(paramLen)) ||  "DATS".equals(paramDataType))
				{}else{%>
			 		<input type=checkbox name="paramIsDef1"  onClick='checkIsDefault(this,"<%=i%>")'>
				<%}%>
					<input type="hidden" name="paramIsDef" value="N">
			</Td>
				<Td width="25%" >
<%
				if( ("P".equals(paramType) && "1".equals(paramLen)) || "DATS".equals(paramDataType))
				{
%>
				<input type="hidden" name="paramMethod" value="0">
				<%
				}else{
%>
					<select name="paramMethod" id=ListBoxDiv>
					<option value="0">Select Method</option>
<%
					String defVal="";
					for(int z=0;z<repDefaultsCount;z++)
					{
						defVal=(String)repDefaults.get(z);
%>
						<option value="<%=defVal%>"><%=defVal%></option>
<%
					}
%>

					</select>

				<%}%>
			</Td>

			</Tr>
<%
			}//End for
%>
		</Table>
	</div>

	<br>
	<Div id="ButtonDiv" align = "center" style="position:absolute;top:87%;width:100%">
	<Table>
	<Tr>
		<Td align="center" class="blankcell">
		 	<a href='JavaScript:ezFormSubmit("1")'><img src="../../Images/Buttons/<%= ButtonDir%>/save.gif" alt="save" title="save" border="none"></a>
		         <a href='JavaScript:ezFormSubmit("2")'><img src="../../Images/Buttons/<%= ButtonDir%>/continue.gif" alt="next" title="next" border="none"></a>
			 <a href="JavaScript:ezBack()"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" alt="back" title="back" border="none"></a>
		</Td>
	</Tr>
	   <Tr>
	  	<Td align="center" class="blankcell">
			<% String space ="&nbsp;&nbsp;&nbsp;&nbsp;";%>
			<font color="red">S*=Select <%= space %> H*=Hidden <%= space %> M*=Mandatory <%= space %> D*=Default Values</font>
		</Td>
	   </Tr>

	</Div>
			
<%
			}else
			{
%>
		<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr align="center">
    		<Td class="displayheader">Report Does Not Exist.</Td>
	  	</Tr>
		</Table>
<%
			}
		}else
		{
			if (RetParam.isError())
			{
%>

				<Table  align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
				<Tr>
				<Td align="center">
<%
				String errorMessages[]  =  RetParam.getErrorMessages();
				out.println("the following error(s) occurred : ");
				for (int i = 0; i < errorMessages.length; i++)
				{
					if (errorMessages[i] != null)
						out.println(errorMessages[i].trim());
				}
%>
				</Td></Tr></Table>
<%
			}
		}
	%>
</form>
</body>
</html>
