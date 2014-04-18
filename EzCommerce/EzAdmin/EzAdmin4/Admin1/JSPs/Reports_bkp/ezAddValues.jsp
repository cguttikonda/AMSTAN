<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%     
String[][] operatorList = {
{"EQ","="},
{"GT",">"},
{"LT","<"},
{"NE","!="},
{"LE","<="},
{"GE",">="},
{"BT","BT"}};
int operatorListC=operatorList.length;

String[][] modeList = {
{"I","Include"},
{"E","Exclude"}};
int modeListC=modeList.length;

      String paramLen=request.getParameter("paramLen");
      String paramType=request.getParameter("paramType");
      String paramDataType=request.getParameter("paramDataType");
      String paramIsDef=request.getParameter("paramIsDef");
      String paramMethod=request.getParameter("paramMethod");
      String lowValue=request.getParameter("lowValue");
      String highValue=request.getParameter("highValue");
      String paramDesc=request.getParameter("paramDesc");
      String paramIsmand= request.getParameter("paramIsmand");
      String ParamMulti=request.getParameter("paramMulti");
      String paramIndex =request.getParameter("ind");
      //out.println(ParamMulti);
      
%>     
   
<html>
<head>
<title>Multiple Values</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>  
<script src="../../Library/JavaScript/ezTrim.js"></script>
<script language="JavaScript" src="../../Library/JavaScript/EzDMYCalender.js"></script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script>
var docPath=""
if (document.all)
	docPath=eval("parent.opener.document")
else
docPath=opener.document
function verifyField(theField,ind)
{
	theField.value = funTrim(theField.value)
	if(theField.value == "")
	{
		//theField.value="0"
	}
	else
	{
		if(theField.value < 0)
		{
			alert("<Quantity Can Not be Less than Zero");
			theField.value="";
			theField.focus();
			return false;
		}
		else if(isNaN(theField.value))
		{
			alert("Please Enter valid Quantity");
			theField.value="";
			theField.focus();
			return false;
		}
	}
	return true;
}
function getParamValues()
{
	var args=new Array();
	var All="<%=ParamMulti %>"
	var values=All.split("¤");
	var lowVal=values[0].split("µ");
	var highVal=values[1].split("µ");
	var mode=values[2].split("µ");
	var operator=values[3].split("µ");
	myForm = document.f1
	for(var i=0;i<10;i++)
	{
		Tlow=(lowVal[i] == null || lowVal[i]=="N")?"":lowVal[i]
		THigh=(highVal[i] == null || highVal[i] == "N")?"":highVal[i]
		TMode=(mode[i] == null || mode[i] =="N")?"":mode[i]
		TOpet=(operator[i] == null || operator[i] == "N" )?"":operator[i]
		myForm.lowValue[i].value=Tlow
		myForm.highValue[i].value=THigh
		var Length=myForm.ParamRetMode[i].options.length
		for(var k=0;k<Length;k++)
		{
			if(myForm.ParamRetMode[i].options[k].value==TMode)
			{
				myForm.ParamRetMode[i].options[k].selected=true
				break;
			}
		}
		Length=myForm.ParamOperator[i].options.length
		for(var k=0;k<Length;k++)
		{

			if(myForm.ParamOperator[i].options[k].value==TOpet)
			{
				myForm.ParamOperator[i].options[k].selected=true
				break;
			}
		}
	}
}
function setParamValues()
{
    myForm = document.f1
    var TALow="";
    var TAHigh="";
    var TAMode="";
    var TAOpet="";
    for(var i=0;i<10;i++)
    {
        lowVal=myForm.lowValue[i].value
        highVal=myForm.highValue[i].value
        mode=myForm.ParamRetMode[i].options[myForm.ParamRetMode[i].options.selectedIndex].value
        operator=myForm.ParamOperator[i].options[myForm.ParamOperator[i].options.selectedIndex].value
        lowVal =(lowVal == null || lowVal=="")?"N":lowVal
        highVal=(highVal == null || highVal == "")?"N":highVal
        mode=(mode == null || mode =="")?"N":mode
        operator=(operator == null || operator == "" )?"N":operator

        if(TALow=="")
            TALow=lowVal+"µ";
        else
            TALow +=lowVal+"µ";

        if(TAHigh=="")
            TAHigh=highVal+"µ";
        else
            TAHigh+=highVal+"µ";

        if(TAMode=="")
            TAMode=mode+"µ";
        else
            TAMode+=mode+"µ";
        if(TAOpet=="")
            TAOpet=operator+"µ";
        else
            TAOpet+=operator+"µ";
    }
    total=TALow+"¤"+TAHigh+"¤"+TAMode+"¤"+TAOpet
    parent.opener.document.addForm.paramMulti["<%=paramIndex%>"].value=total
   // parent.opener.document.getElementById("Multi[<%=paramIndex%>]").innerHTML="View"

    window.close()
}
</script>
</head>
<body  onLoad="getParamValues();scrollInit()" onResize="scrollInit()" scroll="no">
<form name="f1" >

<Table width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
 <tr>
    <th align="center" class="displayheader">
        Please Enter values for <%=paramDesc%>
    </th>
</tr>
</table>

<div id="theads">
<Table id="tabHead" width="89%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<tr>
    <th width=20%>Retrieving Mode</th>
    <th width=20%>Operator</th>
    <th width=30%>From</th>
    <th width=30%>To</th>
</tr>
</Table>
</div>
<div id="InnerBox1Div">
<Table id="InnerBox1Tab" width=100%  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<%
   for(int i=0;i<10;i++)
   {
%>
    <Tr>


    <Td width="20%">
     <select name="ParamRetMode" id=ListBoxDiv>
<%for(int mo=0;mo<modeListC;mo++){%>
		<option value="<%=modeList[mo][0]%>"><%=modeList[mo][1]%></option>
<%}%>
    </Select>
        </Td>
        <Td width="20%">
            <select name="ParamOperator" id=ListBoxDiv>
	    <%for(int op=0;op<operatorListC;op++){%>
			<option value="<%=operatorList[op][0]%>"><%=operatorList[op][1]%></option>
		<%}%>
            </Select>
        </Td>
    <Td width=30% nowrap>
       <% 	if(paramDataType.startsWith("D"))
		{%>
	        <input type="Text" name="lowValue" class=InputBox size="10" maxlength="10" readonly>
      	  <a href="javascript:showCal('document.f1.lowValue[<%=i%>]',50,250)"> <img border=no style="cursor:hand" src="../../Library/JavaScript/calender.gif" alt = "Calender" align="middle" ></a>
		<%}else{%>
	        <input type="Text" name="lowValue" class=InputBox  style = "width:100%" maxlength="<%=paramLen%>" onBlur='verifyField(this,"<%=paramDataType%>")'>
		<%}%>

    </Td>
    <Td width=30% nowrap>
	  <% if("S".equals(paramType))
		{
			if(paramDataType.startsWith("D"))
			{%>
		         <input type="Text" name="highValue" class=InputBox size="10" maxlength="10" readonly>
           		<a href="javascript:showCal('document.f1.highValue[<%=i%>]',50,250)"> <img border=no style="cursor:hand" src="../../Library/JavaScript/calender.gif" alt = "Calender" align="middle" ></a>
          		<%}else{%>
              	<input type="Text" name="highValue" class=InputBox  style = "width:100%" maxlength="<%=paramLen%>"  onBlur='verifyField(this,"<%=paramDataType%>")'>
            	<%}
		}else{%>
              <input type="hidden" name="highValue" value="O">
		<%}%>
   </Td>
    </Tr>
    <%}%>
</table>
</div>
<div align = "center" id="ButtonDiv" style="position:absolute;top:90%;width:100%">
	<img src="../../Images/Buttons/<%= ButtonDir%>/ok.gif" border="none"  title="" onClick='setParamValues()' style="cursor:hand" onMouseover=";window.status=' '; return true" >
	<a href='JavaScript:window.close()'><img src="../../Images/Buttons/<%= ButtonDir%>/cancel.gif" border=" title=""></a>
</div>
</form>
</body>
</html>
