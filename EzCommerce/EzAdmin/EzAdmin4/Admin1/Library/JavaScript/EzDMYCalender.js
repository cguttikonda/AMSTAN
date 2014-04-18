<!-- Begin

//for current date

var curDate="";
var curMonth="";
var curYear="";

var DateFarmat = "";
var type=3;//if type=1 then dd.mm.yyyy
	   //if type=2 then dd-mm-yyyy
	   //if type=3 then dd/mm/yyyy

var formatDate=1;
	//if formatDate=1 then dd/mm/yyyy
	//if formatDate=2 then mm/dd/yyyy


if (type==1)
	DateFarmat = ".";
  else
	if (type==2)
	    DateFarmat = "-";
	  else
	  	DateFarmat = "/";
var Table_BgColor="#ffcc66";
var Td_BgColor=Table_BgColor;
var Table_In_BgColor=Table_BgColor;
	
var Td_TodayOverColor="#ff641e";
//var Txt_TodayOverColor="#000000";
var Td_TodayOutColor=Table_BgColor;
var Txt_TodayOutColor="#000000";

var Td_TodayCellOverColor="yellow";
var Txt_TodayCellOverColor=Td_TodayOverColor;
var Td_TodayCellOutColor=Txt_TodayOutColor;
var Txt_TodayCellOutColor=Table_BgColor;

var Td_CellOverColor=Td_TodayOverColor;
var Td_CellOutColor=Table_BgColor;

var Sun_Sat_TextColor=Td_TodayCellOverColor;

var Default_Top=50;
var Default_Left=250;

var CellWidth=20
var CellHeight=20
var DateTextSize="11px"
var DateTextWeight="normal"
var DateText_FontFamily="Arial";

var ListBox_StartYear=1950; 
var ListBox_EndYear=2050;

var DayHead_FontFamily="Arial";
var DayHead_FontSize="12px";
var DayHead_Color=Txt_TodayOutColor;
var DayHead_FontWeight="normal";

var DateText_FontColor=Txt_TodayOutColor



function HideDiv()
{
	ezDiv.style.visibility="hidden"
	ezDiv.innerHTML="";
}
function fSetSelectedToday(fieldName)
{
	tDate=curDate
	tMonth=curMonth
	tYear=curYear
	
	if (tMonth<10)
		tMonth = "0" + tMonth;
	if (tDate<10)
		tDate = "0" + tDate;
	tt=eval(fieldName)
	 //return Today's date
	 
	if (formatDate==1)
		tt.value=tDate+DateFarmat+tMonth+DateFarmat+tYear
	else
		tt.value=tMonth+DateFarmat+tDate+DateFarmat+tYear
	HideDiv()
}

function fSetSelectedDayToField(fieldName,myElement)
{
	if (myElement.id == "calCell") 
	{
		if (!isNaN(parseInt(myElement.children["calDateText"].innerText))) 
		{
			rDate=myElement.innerText
			rYear=document.frmCalendarSample.selYear.value
			rMonth=document.frmCalendarSample.selMonth.value
			if (rMonth<10)
				rMonth = "0" + rMonth;
			if (rDate<10)
				rDate = "0" + rDate;
			tt=eval(fieldName)
			
			//return selected date
			
			if (formatDate==1)
				tt.value=rDate+DateFarmat+rMonth+DateFarmat+rYear
			else
				tt.value=rMonth+DateFarmat+rDate+DateFarmat+rYear
			HideDiv()
		}
	}
}
function fSetSelectedTodayOver(myElement)
{
	myElement.style.background = Td_TodayOverColor;
	myElement.children["calTodayDateText"].color = DateText_FontColor;
}
function fSetSelectedTodayOut(myElement)
{
	myElement.style.background = Td_TodayOutColor;
	myElement.children["calTodayDateText"].color = Txt_TodayOutColor;
}
function fSetSelectedDay(myElement)
{
	sDate=myElement.innerText
	sYear=document.frmCalendarSample.selYear.value
	sMonth=document.frmCalendarSample.selMonth.value
	if (myElement.id == "calCell") 
	{
		if (!isNaN(parseInt(myElement.children["calDateText"].innerText))) 
		{
			if ((sDate==curDate) && (sMonth==(curMonth)) && (sYear==curYear)) 
			{
				myElement.style.background = Td_TodayCellOverColor;
				myElement.children["calDateText"].color=Txt_TodayCellOverColor;
			}
			else{
				myElement.style.background = Td_CellOverColor;
				
			}
		}
	}
}
function fSetSelectedDayOut(myElement)
{
	if (myElement.id == "calCell") 
	{
		if ((sDate==curDate) && (sMonth==(curMonth)) && (sYear==curYear)) 
		{
			myElement.style.background = Td_TodayCellOutColor;
			myElement.children["calDateText"].color=Txt_TodayCellOutColor;
		}	
		else{
			myElement.style.background = Td_CellOutColor;
			
		}
	}
}
function fClearField(fldObj)
{
	retField=eval(fldObj)
	retField.value=""   //clear the date field
	HideDiv()
}
function fGetDaysInMonth(iMonth, iYear) 
{
	var dPrevDate = new Date(iYear, iMonth, 0);
	return dPrevDate.getDate();
}
function fBuildCal(iYear, iMonth) 
{
	var aMonth = new Array();
	aMonth[0] = new Array(7);
	aMonth[1] = new Array(7);
	aMonth[2] = new Array(7);
	aMonth[3] = new Array(7);
	aMonth[4] = new Array(7);
	aMonth[5] = new Array(7);
	aMonth[6] = new Array(7);
	
	var dCalDate = new Date(iYear, iMonth-1, 1);
	var iDayOfFirst = dCalDate.getDay();
	var iDaysInMonth = fGetDaysInMonth(iMonth, iYear);
	var iVarDate = 1;
	var i, d, w;
	
	aDay = new Array()
	aDay[0] = "Sunday";
	aDay[1] = "Monday";
	aDay[2] = "Tuesday";
	aDay[3] = "Wednesday";
	aDay[4] = "Thursday";
	aDay[5] = "Friday";
	aDay[6] = "Saturday";
	
	aMonth[0][0] = "Sun";
	aMonth[0][1] = "Mon";
	aMonth[0][2] = "Tue";
	aMonth[0][3] = "Wed";
	aMonth[0][4] = "Thu";
	aMonth[0][5] = "Fri";
	aMonth[0][6] = "Sat";

	for (d = iDayOfFirst; d < 7; d++) 
	{
		aMonth[1][d] = iVarDate;
		iVarDate++;
	}
	for (w = 2; w < 7; w++) 
	{
		for (d = 0; d < 7; d++) 
		{
			if (iVarDate <= iDaysInMonth) 
			{
				aMonth[w][d] = iVarDate;
				iVarDate++;
			}
		}
	}
	return aMonth;
}

Months = new Array()
  Months[1]="January"
  Months[2]="February"
  Months[3]="March"
  Months[4]="April"
  Months[5]="May"
  Months[6]="June"
  Months[7]="July"
  Months[8]="August"
  Months[9]="September"
  Months[10]="October"
  Months[11]="November"
  Months[12]="December"

function showCal(fieldName,t1,l1,CD,CM,CY) 
{
	divToPopUp=document.getElementById("ezCalendar")
        
	if(divToPopUp==null || ezDiv.style.visibility=="hidden")
	{
		var top1=t1
		var left1=l1
		if((top1==null)||(left1==null))
		{
  			top1=Default_Top
    			left1=Default_Left		
		}
		if((CD!=null)&&(CM!=null)&&(CY!=null))
		{
			curDate=CD;
			curMonth=CM;
			curYear=CY;
		}else
		{
			var dateObj= new Date();
			curDate=dateObj.getDate();
			curMonth=dateObj.getMonth()+1;
			curYear=dateObj.getFullYear();;
		}
		
		var dCurDate = new Date();
			
		var text =""
		text +='<form name="frmCalendarSample">'
		text +="<Table  border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 align=center style='background:"+Table_BgColor+"'>"
		text +='<Tr>'
		text +="<Td align=center style='background:"+Td_BgColor+"'><Table  width=100% style='background:"+Table_BgColor+"'><Tr>"
		text +="<Td width=90% align=center style='background:"+Td_BgColor+"'>"
		text +='<nobr><select id=selMonth1 name=selMonth  onchange="fUpdateCal(document.frmCalendarSample.selYear.value,document.frmCalendarSample.selMonth.value)">'
		for(i=1;i<=12;i++)
		{
			if(i == curMonth)
				text +='<option value="'+i+'" selected>' +Months[i]+ '</option>'
		        else
				text +='<option value="'+i+'">' +Months[i]+ '</option>'
		}
		text +='</select>&nbsp;'
		text +='<Select id=selYear1  name=selYear   onchange="fUpdateCal(document.frmCalendarSample.selYear.value,document.frmCalendarSample.selMonth.value)">'
		for(i=ListBox_StartYear;i<ListBox_EndYear;i++)
		{
			if(i == curYear)
				text +='<option value="'+i+'" selected>' + i +'</option>'
		        else
				text +='<option value="'+i+'">' + i +'</option>'
		}
		text +='</Select></nobr>'
		text +="</Td><Td align=right valign=top style='background:"+Td_BgColor+"'><font id='close' color="+DateText_FontColor+"  style='CURSOR:Hand;FONT-FAMILY:"+DateText_FontFamily+";FONT-SIZE:" + DateTextSize + ";FONT-WEIGHT:" + DateTextWeight + "' onClick=HideDiv() alt='Close'>X</FONT></Td></Tr></Table></Td></Tr><Tr><Td style='background:"+Td_BgColor+"'>"
		var myMonth;
		myMonth = fBuildCal(curYear, curMonth)
		text +="<Table  border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 align=center  style='background:"+Table_BgColor+"'>"
		text +="<Tr>"
		for (p = 0; p <7; p++)
		{
			text +="<Td align='center' style='FONT-FAMILY:"+DayHead_FontFamily+";FONT-SIZE:"+DayHead_FontSize+";COLOR:"+DayHead_Color+";FONT-WEIGHT:"+DayHead_FontWeight+"'  style='background:"+Td_BgColor+"' title="+aDay[p]+">" + myMonth[0][p] + "</Td>"
		}
		text +="</Tr>"
		for (w = 1; w <7; w++)
		{
			text +='<Tr>'
			for (d = 0; d < 7; d++)
			{
				text +="<Td align='center' valign='top' width='" + CellWidth + "' height='" + CellHeight + "' id=calCell style='CURSOR:Hand' onMouseOver='fSetSelectedDay(this)' onMouseOut='fSetSelectedDayOut(this)' onClick='fSetSelectedDayToField("+ fieldName +",this)'  style='background:"+Td_BgColor+"'>"
				if (!isNaN(myMonth[w][d]))
				{
					text +="<font id='calDateText' color="+DateText_FontColor+"  style='CURSOR:Hand;FONT-FAMILY:"+DateText_FontFamily+";FONT-SIZE:" + DateTextSize + ";FONT-WEIGHT:" + DateTextWeight + "' >" + myMonth[w][d] + "</font>"
				} else {
					text +="<font id='calDateText'  color="+DateText_FontColor+"  style='CURSOR:Hand;FONT-FAMILY:"+DateText_FontFamily+";FONT-SIZE:" + DateTextSize + ";FONT-WEIGHT:" + DateTextWeight + "'> </font>"
				}
				text +="</Td>"
			}
			text +="</Tr>"
		}
		text +="</Tr>"
		text +="<Tr><Td align='center' style='background:"+Td_BgColor+"' colspan=7 width=100%>"

		text +="<Table  border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 align=center  style='background:"+Table_BgColor+"' width=100%><tr>"
		text +="<Td align='center' colspan=7 style='CURSOR:Hand;' onMouseOver='fSetSelectedTodayOver(this)' onMouseOut='fSetSelectedTodayOut(this)' onClick='fClearField("+ fieldName +")'  title='Clear'  style='background:"+Td_BgColor+"'>"
		text +="<font id='calTodayDateText'  color="+DateText_FontColor+"  style='CURSOR:Hand;FONT-FAMILY:"+DateText_FontFamily+";FONT-SIZE:" + DateTextSize + ";FONT-WEIGHT:" + DateTextWeight + "'> Clear</font>"
		text +="</Td><Td align='center' colspan=7 style='CURSOR:Hand;' onMouseOver='fSetSelectedTodayOver(this)' onMouseOut='fSetSelectedTodayOut(this)' onClick='fSetSelectedToday("+ fieldName +")' title='Today'  style='background:"+Td_BgColor+"'>"
		text +="<font id='calTodayDateText'  color="+DateText_FontColor+"  style='CURSOR:Hand;FONT-FAMILY:"+DateText_FontFamily+";FONT-SIZE:" + DateTextSize + ";FONT-WEIGHT:" + DateTextWeight + "'> Today&nbsp;:&nbsp;&nbsp;"+curDate+"&nbsp;/&nbsp;"+curMonth+"&nbsp;/&nbsp;"+curYear+"</font>"
		text +="</Td></Tr>"
		text +="</Table>"
		text +="</Td></Tr></Table>"
		text +="</Td></Tr></Table>"
		text +="</form>"
		ezDiv=document.createElement("DIV");
		with(ezDiv)
		{
			id="ezCalendar";
			style.position="absolute";
			innerHTML=text;
			ezDiv.zIndex=50;
			style.visibility="inherit";
			style.top=top1;
			style.left=left1;
		}
		document.body.appendChild(ezDiv);
		fUpdateCal(curYear, curMonth)
	}
}
function fUpdateCal(icurYear, icurMonth,myElement) 
{
	myMonth = fBuildCal(icurYear, icurMonth);
	for (w = 1; w < 7; w++) 
	{
		for (d = 0; d < 7; d++) 
		{
			calCell[((7*w)+d)-7].style.background = Table_In_BgColor;
			calDateText[((7*w)+d)-7].color = DateText_FontColor;
			calDateText[((7*w)+d)-7].style.cursor="hand";
			calCell[((7*w)+d)-7].style.cursor="hand";
			calCell[((7*w)+d)-7].title="";

			if (!isNaN(myMonth[w][d])) 
			{
				calDateText[((7*w)+d)-7].innerText = myMonth[w][d];
				calCell[((7*w)+d)-7].title=aDay[d]+",  "+Months[icurMonth]+" "+myMonth[w][d]+" , "+icurYear
				if ((d==0)||(d==6)) 
				{
					calDateText[((7*w)+d)-7].color = Sun_Sat_TextColor ;
				}
				if ((myMonth[w][d]==curDate) && (icurMonth==curMonth) && (icurYear==curYear)) 
				{
					calCell[((7*w)+d)-7].style.background = Td_TodayCellOutColor;
					calDateText[((7*w)+d)-7].color = Txt_TodayCellOutColor;
				}
			} else {
				calDateText[((7*w)+d)-7].innerText = " ";
				calDateText[((7*w)+d)-7].style.cursor="default";
				calCell[((7*w)+d)-7].style.cursor="default";
		        }
      		}
	}

}
// End -->
