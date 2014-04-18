<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Reports/iChangeReport.jsp"%>
<%

ezc.ezbasicutil.EzDefaults def = new ezc.ezbasicutil.EzDefaults(Session);
java.util.ArrayList repDefaults =def.getDefaultKeys();
int repDefaultsCount =0;
if(repDefaults != null)
repDefaultsCount =repDefaults.size();


String reportDomain ="";
 String sysDesc =request.getParameter("sysDesc");
 String reportDesc ="";
 String reportType ="";
 String exeType = "";
 String visibility ="";
 String status ="";
%>

<html>
<head>
  <title>ezAddReport</title>

  <meta http-equiv="content-type"
 content="text/html; charset=ISO-8859-1">
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
     <script src="../../Library/JavaScript/ezTrim.js"></script>
     <script src="../../Library/JavaScript/ezSelSelect.js"></script>
  <script>
function checkIsDefault(obj,ind)
{
	myForm=document.addForm;
	//if(isNaN(myForm.paramIsDef.length))
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
	pCount = myForm.paramIsDef1.length;
	var retFlag=true;
	if (isNaN(pCount))
	{
		if(myForm.paramIsDef[i].value=="Y")
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

			/*if(chkFlag){
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
			}*/
			
			if(myForm.paramIsSel1[i].checked)
			{
				myForm.paramIsSel[i].value = "Y";
				chkFlag=false;
				selCount++
			}
			else
			{
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
		ezForm.action="ezChangeSaveReport.jsp"
		ezForm.submit();
	}
	else
	{
		if(chkAll())
    		{
    			ezForm.action="ezChangeReportFinal.jsp"
			ezForm.submit();
		}
	}


}


function ezBack()
{
     /* ezForm=document.addForm
      ezForm.action="ezListReport.jsp?system=<%=system%>&sysDesc=<%=sysDesc%>"
      ezForm.submit()*/
      history.back(-1)
}
function loadSelect(j)
{
	var one=j.split(",");
	obj =eval("document.addForm."+one[0]);

	var Length=obj.options.length;
	for(var k=0;k<Length;k++)
	{
		if(obj.options[k].value==one[1])
		{
			obj.options[k].selected=true
			 break;
		}
	}
 }

var selSelect = new Array();
function select1()
{

	<%
	if(ezRepInfoStruct != null)
   	{
		reportDesc =ezRepInfoStruct.getReportDesc();
		reportType =ezRepInfoStruct.getReportType();
		exeType = ezRepInfoStruct.getExecType();
        	visibility =ezRepInfoStruct.getVisibilityLevel();
        	status =ezRepInfoStruct.getReportStatus();
		reportDomain =ezRepInfoStruct.getBusinessDomain();


	%>

		//loadSelect("reportType,<%= reportType %>");
		loadSelect("exeType,<%=exeType%>");
		loadSelect("visibility,<%=visibility%>");
		loadSelect("status,<%=status%>");
	<%}%>

}

  </script>
</head>
<body onLoad="scrollInit();select1()" onresize="scrollInit()" scroll="no">
<form name="addForm" method="post">
<br>
  <Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
	<Tr align="center">
    		<Td class="displayheader">Edit Report</Td>
  	</Tr>
</Table>
<% if(ezRepInfoStruct != null)
   {
%>
  <Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
      <tbody>
        <tr>
	<th align="right">Name</th>
          <td align="left">
	  		<input type="hidden" name="system" value="<%=system%>">
			<input type="hidden" name="sysDesc" value="<%=sysDesc%>">
		        <input type="hidden"  name="reportType" value="<%=reportType%>">
			<input type="hidden" name="reportDomain" value="<%=reportDomain%>">
			<input type="hidden" name="reportName" value="<%=reportName%>"><%=reportName%>
			<%if ( retSelTabCount > 0 )
			  {
				ezRepSelTableRow=(EzReportSelectRow)ezRepSelTable.getRow(0);
			%>
			 	<input type="hidden" name="reportNo" value="<%=ezRepSelTableRow.getReportNo()%>">
			<%}%>
	</td>
          <th align="right">Description</th>
          <td align="left" colspan="3"><input type="text" name="reportDesc" class="InputBox" style="width:100%" value="<%=reportDesc%>"></td>

        </tr>
        <tr>
            <th align="right">Execution Type</th>
            <td align="left">
	       <select name="exeType" id=ListBoxDiv>
		    	<option value="A">Both</option>
		      <option value="O">On-Line</option>
      		<option value="B">Back Ground</option>
	       </select>
            </td>

            <th align="right">Visibility</th>
            <td align="left">
	  <select name="visibility" id=ListBoxDiv>
       	   <option value="A">All</option>
            <option value="I">Internal Users</option>
            <option value="B">Business users</option>
        </select>

             </td>
            <th align="right">Status</th>
            <td align="left">
	 		<select name="status" id=ListBoxDiv>
       		 <option value="A">Active</option>
       		 <option value="I">In Active</option>
      		 </select>

            </td>
          </tr>

    </tbody>
  </table>
<%}%>

  <%
  	if ( retSelTabCount > 0 )
	{%>
		<Div id="theads">
		<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
			<Tr align="center" valign="middle">
	        		<Th width="13%" >Name</Th>
	        		<Th width="42%" >Description</Th>
				<Th width="5%" Title="Select">S*</Th>
				<Th width="5%" Title="Hidden">H*</Th>
				<Th width="5%" Title="Mandatory">M*</Th>
				<Th width="5%" Title="Defaults">D*</Th>
				<Th width="25%" >Method</Th>
			</Tr>
		</Table>
		</Div>

		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
		<%
		String paramNo,paramName,paramDesc,paramIsSel,paramIshide,paramLen,paramType,paramDataType,paramIsmand,paramIsDef,paramMethod,chkDef,chkSel,chkHide,chkMand,mandDis="";


		for(int i=0;i<retSelTabCount;i++)
		{
		     ezRepSelTableRow=(EzReportSelectRow)ezRepSelTable.getRow(i);

			paramName=ezRepSelTableRow.getParameterName();
			paramNo=ezRepSelTableRow.getParamNo();
			paramDesc=ezRepSelTableRow.getParameterDesc();
			paramLen=ezRepSelTableRow.getLength();
			paramType=ezRepSelTableRow.getParameterType();
			paramDataType=ezRepSelTableRow.getDataType();
			paramIsmand=ezRepSelTableRow.getIsMandatory();
			paramIsDef =ezRepSelTableRow.getChkDefaults();
			paramIshide =ezRepSelTableRow.getIsHidden();
			paramIsSel=ezRepSelTableRow.getIsCustomer();
			paramMethod =ezRepSelTableRow.getMethodName();
			paramNo=ezRepSelTableRow.getParamNo();
			chkDef=("Y".equals(paramIsDef))?"checked":"";
			chkSel=("Y".equals(paramIsSel))?"checked":"";
			chkHide=("Y".equals(paramIshide))?"checked":"";
			chkMand=("X".equals(paramIsmand) || "L".equals(paramIsmand))?"checked":"";
			mandDis=("X".equals(paramIsmand))?"disabled":"";
			String TALow="";
			String TAHigh="";
			String TAMode="";
			String TAOpet="";
			String low="µ";
			String high="µ";
			String mod="µ";
			String opt="µ";
			String paramMulti="";
			String valReportNO,valParamNo,valLow,valHigh,valMode,valOp="";
			
			if("null".equals(paramDesc) || "".equals(paramDesc))
				paramDesc="";
			
			for(int k=0;k<retvalTabCount;k++)
			{
				ezRepValTableRow = (EzReportValuesRow)ezRepValTable.getRow(k);

				valReportNO =ezRepValTableRow.getReportNo();
				valParamNo=ezRepValTableRow.getParamNo();


				if(paramNo.equals(valParamNo))
				{


					valLow=ezRepValTableRow.getParameterValueLow();
					valHigh=ezRepValTableRow.getParameterValueHigh();
					valMode=ezRepValTableRow.getRetreivalMode();
					valOp=ezRepValTableRow.getOperator();

					valLow =(valLow == null || valLow=="")?"N":valLow;
					valHigh=(valHigh == null || valHigh == "")?"N":valHigh;
					valMode=(valMode == null || valMode =="")?"N":valMode;
					valOp=(valOp == null || valOp == "" )?"N":valOp;

					/*if("40".equals(valParamNo))
					out.println(paramIsDef+"---"+valParamNo +"--"+valLow+"--"+k+".");*/

					if("Y".equals(paramIsDef))
					{
						low=("µ".equals(low))?"":low;
						if(!"N".equals(valLow))
						low +=valLow+",";


					}else
					{
						low=("µ".equals(low) && !"N".equals(valLow))?valLow:low;
						high=("µ".equals(high) &&!"N".equals(valHigh))?valHigh:high;
						mod=("µ".equals(mod) && !"N".equals(valMode))?valMode:mod;
						opt=("µ".equals(opt) && !"N".equals(valOp))?valOp:opt;

						if("µ".equals(low) )
						{
							if(TALow.trim().length()==0)
							TALow=valLow+"µ";
							else
							TALow +=valLow+"µ";
							if(TAHigh.trim().length()==0)
							TAHigh=valHigh+"µ";
							else
							TAHigh+=valHigh+"µ";
							if(TAMode.trim().length()==0)
							TAMode=valMode+"µ";
							else
							TAMode+=valMode+"µ";

							if(TAOpet.trim().length()==0)
							TAOpet=valOp+"µ";
							else
							TAOpet+=valOp+"µ";
						}
					}
				}

			}
			paramMulti=TALow+"¤"+TAHigh+"¤"+TAMode+"¤"+TAOpet;

		%>

 		 <Tr align="center" valign="middle">


		 <label for="cb_<%=i%>">

		 	<Td width="13%" align="left"><input type="hidden" name="paramName" id="cb_<%=i%>" value="<%=paramName%>"><%=paramName%></Td>
	        	<Td width="42%" >
			<input type="hidden" name="paramNo" value="<%=paramNo%>">
			<input type="text" name="paramDesc" class="InputBox" style="width:100%" maxlength="128" value="<%=paramDesc%>">
			</Td>
			<Td width="5%" >
				<input type=checkbox name="paramIsSel1" <%=chkSel%> onClick="checkSelect()" id="cb_<%=i%>" value="<%=paramIsSel%>">
				<input type="hidden" name="paramIsSel" value="<%=paramIsSel%>">
			</Td>
			<Td width="5%" >
				<input type=checkbox name="paramIshide1" id="cb_<%=i%>" value="<%=paramIshide%>" <%=chkHide%> onClick="setHiddenFlag()">
				<input type="hidden" name="paramIshide" value="<%=paramIshide%>">
				<input type="hidden" name="paramLen" value="<%=paramLen%>" >
				<input type="hidden" name="paramType" value="<%=paramType%>" >
				<input type="hidden" name="paramDataType" value="<%=paramDataType%>" >
				<input type="hidden" name="lowValue" value="<%=low%>">
				<input type="hidden" name="highValue" value="<%=high%>">
				<input type="hidden" name="paramMulti" value="<%=paramMulti%>">
				<input type="hidden" name="paramMod" value="<%=mod%>">
				<input type="hidden" name="paramOpt" value="<%=opt%>">
			</Td>
			<Td width="5%" >
				<input type=checkbox name="paramIsmand1" id="cb_<%=i%>" value="<%= paramIsmand %>" <%=mandDis%> <%=chkMand%> onClick='checkIsMandLocal(this,"<%=i%>")'>
				<input type="hidden" name="paramIsmand" value="<%= paramIsmand %>">
			</Td>
			<Td width="5%" >
				<%
				if( ("P".equals(paramType) && "1".equals(paramLen)) ||  "DATS".equals(paramDataType))
				{}else{%>
			 		<input type=checkbox name="paramIsDef1" id="cb_<%=i%>" value="<%= paramIsDef %>"  <%=chkDef%> onClick='checkIsDefault(this,"<%=i%>")'>
				<%}%>
					<input type="hidden" name="paramIsDef" value="<%= paramIsDef %>">
			</Td>
			<Td width="25%" align="left">
				<%
				if( ("P".equals(paramType) && "1".equals(paramLen)) || "DATS".equals(paramDataType))
				{%>
				<input type="hidden" name="paramMethod" value="0">
<%				}else{
%>
					<select name="paramMethod" id=ListBoxDiv>
					<option value="0">Select Method</option>
<%
					String defVal="";
					for(int z=0;z<repDefaultsCount;z++)
					{
						defVal=(String)repDefaults.get(z);
						if(defVal.equals(paramMethod))
						{
%>
						<option selected value="<%=defVal%>"><%=defVal%></option>
<%
						}else{
%>
						<option value="<%=defVal%>"><%=defVal%></option>
<%
						}
					}
%>

					</select>

<%					}
%>
			</Td>
		</label>
		</Tr>


<%

		}

%>
	</Table>
	</div>

	<br>
  	<Div id="ButtonDiv" align = "center" style="position:absolute;top:86%;width:100%">
	<Table align="center">
	  <Tr>
	  	<Td align="center" class="blankcell">
		 	<a href='JavaScript:ezFormSubmit("1")'><img src="../../Images/Buttons/<%= ButtonDir%>/save.gif" alt="save" title="save" border="none"></a>
		         <a href='JavaScript:ezFormSubmit("2")'><img src="../../Images/Buttons/<%= ButtonDir%>/continue.gif" alt="Continue" title="Continue" border="none"></a>
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
  <% }else{%>
  <br><br>
  <Table  width="95%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
    		<Td class="displayheader">No Data has been retrieved.</Td>
  	</Tr>
</Table>

<%
  }  %>

  </form>
  </Body>
</html>
