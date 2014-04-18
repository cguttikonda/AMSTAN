function chkMand(ind)
{
	myForm=document.addForm;
	y=true
	if(isNaN(myForm.lowValue.length))
	{
		myForm.lowValue.value=funTrim(myForm.lowValue.value)
		valcount=false;
		if(myForm.lowValue.value =="")
		{

			if((myForm.paramIsDef.value== "Y") ||(myForm.paramType.value=="P" && myForm.paramLen.value=="1"))
			{
			}else
			{
				var All=myForm.paramMulti.value
				var values=All.split("¤");
				var lowVal=values[0].split("µ");

				for(s=0;s<lowVal.length;s++)
				{
					if(lowVal[s] != null && lowVal[s] !="N" && funTrim(lowVal[s]) !="")
					{
						valcount=true
						break;
					}
				}
			}
			if(valcount)
			{
				return true;
			}else
			{
				if(myForm.paramType.value =="P" && myForm.paramLen.value=="1")
				{
					alert("Please check From value for "+myForm.paramDesc.value)
				}else
				{
					alert("Please enter From value for "+myForm.paramDesc.value)
					myForm.lowValue[ind].focus()
				}
				
				return false;
			}


		}else
		{
			y=validate(myForm.paramDataType.value,myForm.lowValue,ind)
			return y
		}

	}else
	{
		myForm.lowValue[ind].value=funTrim(myForm.lowValue[ind].value)
		valcount=false;
		if(myForm.lowValue[ind].value =="")
		{

			if((myForm.paramIsDef[ind].value== "Y") ||(myForm.paramType[ind].value=="P" && myForm.paramLen[ind].value=="1"))
			{
			}else
			{
				var All=myForm.paramMulti[ind].value
				var values=All.split("¤");
				var lowVal=values[0].split("µ");

				for(s=0;s<lowVal.length;s++)
				{
					if(lowVal[s] != null && lowVal[s] !="N" && funTrim(lowVal[s]) !="")
					{
						valcount=true
						break;
					}
				}
			}
			if(valcount)
			{
				return true;
			}else
			{
				if(myForm.paramType[ind].value =="P" && myForm.paramLen[ind].value=="1")
				{
					alert("Please check From value for "+myForm.paramDesc[ind].value)
				}else
				{
					alert("Please enter From value for "+myForm.paramDesc[ind].value)
					myForm.lowValue[ind].focus()
				}
				return false;
			}


		}else
		{
			y=validate(myForm.paramDataType[ind].value,myForm.lowValue[ind],ind)
			return y
		}
	}
	return true
}
function validate(FType,FField,ind)
{

	if(FType=="NUMC" || FType=="INT")
	{
		y=verifyField(FField,ind)
		/*if(FType=="NUMC" && y)
		{
			INT1= -65536 to 65536 (2 Bytes)
			INT3=131072
			INT4=196608
		}*/
		return y;

	}else if(FType=="CHAR")
	{
		return true;
	}else if(FType.charAt(0)=='D')
	{
		dat=FField.value
		if(dat.length<10)
		{
			if(isNaN(document.addForm.paramDesc.length))
				alert("Please Enter Valid Date for "+document.addForm.paramDesc.value)
			else
				alert("Please Enter Valid Date for "+document.addForm.paramDesc[ind].value)
			return false;
		}
	}
	return true;
}
function verifyField(theField,forvalue)
{
	theField.value = funTrim(theField.value)
   if(theField.value !="")
   {
	if(theField.value < 0)
	{
		alert("Can not be less than 0");

		theField.value="";
		theField.focus();
		return false;
	}
	else if(isNaN(theField.value))
	{
		alert("Please Enter Valid Numbers");
		theField.value="";
		theField.focus();
		return false
	}
   }
	return true;
}

function setSelLow(obj,ind)
{
	pp2=""

	for(sel=0;sel<obj.length;sel++)
	{
		if(obj.options[sel].selected)
		{
			pp1=obj.options[sel].value
			pp2+=pp1+","
		}

	}
	if(isNaN(document.addForm.lowValue.length))
	document.addForm.lowValue.value=pp2
	else
	document.addForm.lowValue[ind].value=pp2
}

function ezOpenWindow(ind)
{

	myForm=document.addForm
	var paramLen=""
	var paramType=""
	var paramDataType=""
	var paramIsDef=""
	var paramMethod=""
	var lowValue=""
	var highValue=""
	var paramDesc=""
	var paramIsmand=""
	var paramMulti=""

	if(isNaN(myForm.paramLen.length))
	{
		paramLen=myForm.paramLen.value
		paramType=myForm.paramType.value
		paramDataType=myForm.paramDataType.value
		paramIsDef=myForm.paramIsDef.value
		paramMethod=myForm.paramMethod.value
		lowValue=myForm.lowValue.value
		highValue=myForm.highValue.value
		paramDesc=myForm.paramDesc.value
		paramIsmand=myForm.paramIsmand.value
		paramMulti=myForm.paramMulti.value

	}else
	{
		paramLen=myForm.paramLen[ind].value
		paramType=myForm.paramType[ind].value
		paramDataType=myForm.paramDataType[ind].value
		paramIsDef=myForm.paramIsDef[ind].value
		paramMethod=myForm.paramMethod[ind].value
		lowValue=myForm.lowValue[ind].value
		highValue=myForm.highValue[ind].value
		paramDesc=myForm.paramDesc[ind].value
		paramIsmand=myForm.paramIsmand[ind].value
		paramMulti=myForm.paramMulti[ind].value

	}

	str="ezAddValues.jsp?paramLen="+paramLen+"&paramMulti="+paramMulti+"&paramType="+paramType+"&paramDataType="+paramDataType+"&paramIsDef="+paramIsDef+"&paramMethod="+paramMethod+"&lowValue="+lowValue+"&highValue="+highValue+"&paramDesc="+paramDesc+"&paramIsmand="+paramIsmand+"&ind="+ind
	newWindow = window.open(str,"Mywin","resizable=no,left=160,top=150,height=300,width=450,status=no,toolbar=no,menubar=no,location=no")

}


function ezFormSubmit(type)
{

y=true
count =document.addForm.paramName.length

   if(eval(y))
   {
    	ezForm=document.addForm
	if(type == "1")
	{
		ezForm.action="ezChangeSaveReport.jsp"
		ezForm.submit()
	}
	else if(type=="2")
	{
		for(f=0;f<count;f++)
		{
			obj1=document.addForm.lowValue[f]
			obj2=document.addForm.highValue[f]
			if(obj1.value=="")
				obj1.value=" "
			if(obj2.value=="")
				obj2.value=" "

			if(eval(y))
			{
				obj3=document.addForm.paramIsmand[f]
				if(obj3.value=="X" || obj3.value=="L")
				y=chkMand(f)
			}
			else
			{
			break;
			return y
			}
		}
		if(eval(y))
		{
			if(ezForm.exeType.value=="A")
			{
				showConfirmDiv()
			}else
			{
				ezForm.action="ezSaveExecuteReport.jsp"
				ezForm.submit()
			}
		}

	}

    }
}

function ezBack()
{
      /*ezForm=document.addForm
	ezForm.action="ezChangeReport.jsp?system=<%=system%>&reportName=<%=reportName%>&repNo=<%=reportNo%>&sysDesc=<%=sysDesc%>"
      ezForm.submit()*/
      history.back(-1)
}

function setLowVal(obj,ind)
{

	if(obj.checked)
	{
		if(isNaN(document.addForm.lowValue.length))
			document.addForm.lowValue.value = "X";
		else
			document.addForm.lowValue[ind].value = "X";
	}
	else
	{
		if(isNaN(document.addForm.lowValue.length))
			document.addForm.lowValue.value = "µ";
		else
			document.addForm.lowValue[ind].value = "µ";
	}
}
function showConfirmDiv()
{
	var addrowsText="";
	addrowsText += '<br><Table align=center width="40%" style="background:red" border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0><tr><td align=center><Table align=center width="100%"><Tr><Th>Please select the Type of Execution </Th></Tr>'
	addrowsText += '<Tr><Td align="center"><input type="radio"  name="execTC" checked value="B">Back Ground<input type="radio"  name="execTC" value="O"> On-line</Td></Tr></Table><br>'
	addrowsText += '<Table align="center"><Tr><Td align=center>'
	addrowsText += '<img src="../../Images/Buttons/<%= ButtonDir%>/ok.gif" border="none" style="cursor:pointer;cursor:hand" onClick="HideNetDiv()"><img src="../../Images/Buttons/<%= ButtonDir%>/cancel.gif" border="none" style="cursor:pointer;cursor:hand" onClick="closeDiv()">&nbsp;&nbsp;'
	addrowsText += '</Td></Tr></Table></Td></Tr></Table>'
	var addRowsDiv=document.getElementById("ezAddRows");
	var lBoxes=document.getElementsByTagName("select");
	for(i=0;i<lBoxes.length;i++)
	{
		var obj=lBoxes[i]
		if((obj.id).indexOf("ListBoxDiv")>=0)
			obj.style.width="0%"
	}

	if(addRowsDiv==null)
	{
		ezDiv=document.createElement("DIV");
		with(ezDiv)
		{
				id="ezAddRows";
				style.position="absolute";
				style.zIndex=5;
				style.visibility="inherit";
				style.top="40%";
				style.left="0%";
				style.width="100%";

				innerHTML=addrowsText;
		}
		document.addForm.appendChild(ezDiv);
	}else{
		addRowsDiv.style.visibility="visible"

	}

}
function HideNetDiv()
{
	var addRowsDiv=document.getElementById("ezAddRows");
	addRowsDiv.style.visibility="hidden"
	var lBoxes=document.getElementsByTagName("select");
	for(i=0;i<lBoxes.length;i++)
	{
		var obj=lBoxes[i]
		if((obj.id).indexOf("ListBoxDiv")>=0)
			obj.style.width="auto"
	}
	ezForm.action="ezSaveExecuteReport.jsp"
	ezForm.submit()

}
function closeDiv()
{
	var addRowsDiv=document.getElementById("ezAddRows");
	addRowsDiv.style.visibility="hidden"
	var lBoxes=document.getElementsByTagName("select");
	for(i=0;i<lBoxes.length;i++)
	{
		var obj=lBoxes[i]
		if((obj.id).indexOf("ListBoxDiv")>=0)
			obj.style.width="auto"
	}
}


function setListBox(lBoxName,setValue)
{
	
	
	
	if(lBoxName.type == "hidden")
	{
		lBoxName.value = setValue
	}
	else
	{
	
		 //listBox
			for(i=0;i<lBoxName.length;i++)
			{
				if(lBoxName[i].value==setValue)
				{
					lBoxName.selectedIndex=i
					return
				}
			}
	}
}
