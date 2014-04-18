<!-- Begin
/**
 * @(#) ezCalender.js V1.2	July 19,2002
 *
 * Copyright (c) 2002 EzCommerce Inc. All Rights Reserved.
 * @ author Krishna Prasad V
 *
 **/
 

//=====================user can change following part============//
//========== variable declaration==================//
var curDate="";
var curMonth="";
var curYear="";

var cfdate="";
var cfmonth="";
var cfyear="";

/*var DateFarmat = "";

var type=1;//if type=1 then dd.mm.yyyy	
	   //if type=2 then dd-mm-yyyy	
	   //if type=3 then dd/mm/yyyy	
	   
var formatDate=1;

	//if formatDate=1 then dd/mm/yyyy
	//if formatDate=2 then dd/yyyy/mm
	//if formatDate=3 then mm/dd/yyyy
	//if formatDate=4 then mm/yyyy/dd
	//if formatDate=5 then yyyy/mm/dd
	//if formatDate=6 then yyyy/dd/mm
	
if (type==1)
	DateFarmat = ".";
  else	
	if (type==2)
	    DateFarmat = "-";
	  else
	  	DateFarmat = "/";
*/	  	

var ListBox_StartYear=1950; 
var ListBox_EndYear=2050;
	  	
var Default_Top=50;
var Default_Left=250;

var CellWidth=20
var CellHeight=20


	  	
//========== variable declaration for tool tip==================//
	aDay = new Array()
	aDay[0] = "Sunday";
	aDay[1] = "Monday";
	aDay[2] = "Tuesday";
	aDay[3] = "Wednesday";
	aDay[4] = "Thursday";
	aDay[5] = "Friday";
	aDay[6] = "Saturday";
	
	aDayShort = new Array()
	aDayShort[0] = "Sun";
	aDayShort[1] = "Mon";
	aDayShort[2] = "Tue";
	aDayShort[3] = "Wed";
	aDayShort[4] = "Thu";
	aDayShort[5] = "Fri";
	aDayShort[6] = "Sat";
	
	var todaytxt = "Today";
	var clear = "Clear";

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

//==========end variable declaration for tool tip==================//	
	
function HideDiv()
{
	ezDiv.style.visibility="hidden"
	ezDiv.innerHTML="";
	//Following code is to display back previously hided list boxes
	listBoxIds=document.getElementsByTagName("select")
	if(listBoxIds!=null)
	{
	   for(i=0;i<listBoxIds.length;i++)
	   {
	     if(listBoxIds[i].id=="CalendarDiv")
	     listBoxIds[i].style.visibility="visible"
	   }  
	} 
}

function fSetClearToday(fieldName)
{
	retField=eval(fieldName)
	 				//return empty date value
	retField.value=""
	HideDiv()
}
function fSetSelectedToday(fieldName)
{

	var tDate=curDate
	var tMonth=curMonth
	var tYear=curYear

	if (tMonth<10)
		tMonth = "0" + tMonth;
	if (tDate<10)
		tDate = "0" + tDate;
	returnDate(fieldName,tDate,tMonth,tYear);
	HideDiv()
}
function returnDate(fieldName,rd,rm,ry)
{
	retField=eval(fieldName)
	
	var retDateStr="";
	//for sales globalization
	for(i=0;i<3;i++)
	{
		if(dFormat[i] == "DD")
			retDateStr=retDateStr+rd+DateFarmat
		if(dFormat[i] == "MM")
			retDateStr=retDateStr+rm+DateFarmat
		if(dFormat[i] == "YY")
			retDateStr=retDateStr+ry+DateFarmat
	}
	retDateStr=retDateStr.substring(0,10);
	retField.value=retDateStr
	
	
	/*
	if (formatDate==1)
		retField.value=rd+DateFarmat+rm+DateFarmat+ry
	else
		retField.value=rm+DateFarmat+rd+DateFarmat+ry
	*/
}
function fSetSelectedDayToField(fieldName,myElement)
{
	if (myElement.id == "calCell") 
	{
		if (!isNaN(eval(myElement.children["calDateText"].innerText))) 
		{
			rDate=myElement.innerText
			rYear=document.frmCalendarSample.selYear.value
			rMonth=document.frmCalendarSample.selMonth.value
			
			if (rMonth<10)
				rMonth = "0" + rMonth;
			if (rDate<10)
				rDate = "0" + rDate;
			returnDate(fieldName,rDate,rMonth,rYear);
			HideDiv()
		}
	}
}
function fSetSelectedTodayOver(myElement)
{
	myElement.className = "cal_td_todat_over";
	myElement.children["calTodayDateText"].className = "cal_font_today_over";
}
function fSetSelectedTodayOut(myElement)
{
	myElement.className = "cal_td_today";
	myElement.children["calTodayDateText"].className = "cal_font_today";
}
function fSetSelectedDay(myElement)
{
	sDate=myElement.innerText
	sYear=document.frmCalendarSample.selYear.value
	sMonth=document.frmCalendarSample.selMonth.value
	
	if (myElement.id == "calCell") 
	{
		if (!isNaN(eval(myElement.children["calDateText"].innerText))) 
		{
			if ((sDate==cfdate) && (sMonth==(cfmonth)) && (sYear==cfyear)) 
			{
				myElement.className = "cal_td_today_date_over";
				myElement.children["calDateText"].className="cal_font_today_dates_over";
			}
			else{
				myElement.className = "cal_td_over";
				if(myElement.children["calDateText"].className=="cal_font_sun_sat_dates")
					myElement.children["calDateText"].className="cal_font_sun_sat_dates_over";
				else
					myElement.children["calDateText"].className="cal_font_dates_over";
			}
		}
	}
}
function fSetSelectedDayOut(myElement)
{
	sDate=myElement.innerText
	sYear=document.frmCalendarSample.selYear.value
	sMonth=document.frmCalendarSample.selMonth.value
	//alert(eval(cfdate)+"       " +eval(cfmonth)+"      "+eval(cfyear)) 
	if (myElement.id == "calCell") 
	{
		if ((sDate==eval(cfdate)) && (sMonth==eval(cfmonth)) && (sYear==eval(cfyear))) 
		{
			myElement.className = "cal_td_today_date";
			myElement.children["calDateText"].className="cal_font_todat_dates";
		}	
		else{
			myElement.className = "cal_td";
			if(myElement.children["calDateText"].className=="cal_font_sun_sat_dates_over")
				myElement.children["calDateText"].className="cal_font_sun_sat_dates";
			else
				myElement.children["calDateText"].className="cal_font_dates";
			
		}
	}
}
function fGetDaysInMonth(iMonth, iYear) 
{
	var dPrevDate = new Date(iYear, iMonth, 0);
	return dPrevDate.getDate();
}
function fBuildCal(iYear, iMonth) 
{
	
	var dCalDate = new Date(iYear, iMonth-1, 1);
	var iDayOfFirst = dCalDate.getDay();
	var iDaysInMonth = fGetDaysInMonth(iMonth, iYear);
	var iVarDate = 1;
	var i, d, w;

	var aMonth = new Array();
	aMonth[0] = new Array(7);
	aMonth[1] = new Array(7);
	aMonth[2] = new Array(7);
	aMonth[3] = new Array(7);
	aMonth[4] = new Array(7);
	aMonth[5] = new Array(7);
	aMonth[6] = new Array(7);

		aMonth[0][0] = aDayShort[0];
		aMonth[0][1] = aDayShort[1];
		aMonth[0][2] = aDayShort[2];
		aMonth[0][3] = aDayShort[3];
		aMonth[0][4] = aDayShort[4];
		aMonth[0][5] = aDayShort[5];
		aMonth[0][6] = aDayShort[6];

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
function showCal(fieldName,t1,l1,CD,CM,CY)  
{
	divToPopUp=document.getElementById("ezCalendar")
        
        if(divToPopUp==null || ezDiv.style.visibility=="hidden")
	{	
		//Following code is to hide list boxes whose id is listBoxDiv
	
		listBoxIds=document.getElementsByTagName("select")
		if(listBoxIds!=null)
		{
	 		 for(i=0;i<listBoxIds.length;i++)
	   		{
			     if(listBoxIds[i].id=="CalendarDiv")
			     listBoxIds[i].style.visibility="hidden"
	     		   } 
		}  
		var top1=t1
		var left1=l1
		if((top1==null)||(left1==null))
		{
  			top1=Default_Top
    			left1=Default_Left		
		}
		if((CD!=null)&&(CD!='<%=cDate%>')&&(CM!=null)&&(CM!='<%=cMonth%>')&&(CY!=null)&&(CY!='<%=cYear%>'))
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

		curField=eval(fieldName);
		var fieldValue="";
		if (curField)
			fieldValue=curField.value;
			
		if(fieldValue != "")
		{
		
			var sdc=0;
			var edc=2;
			
				for(dt=0;dt<3;dt++)
				{
					if(dFormat[dt] == "DD")
					{
						cfdate=fieldValue.substring(sdc,edc);
						sdc=parseInt(sdc)+parseInt(3);
						edc=parseInt(edc)+parseInt(3);
					}
					else
						if(dFormat[dt] == "MM")
						{
							cfmonth=fieldValue.substring(sdc,edc);
							sdc=parseInt(sdc)+parseInt(3);
							edc=parseInt(edc)+parseInt(3);
						}
						else
							if(dFormat[dt] == "YY")
							{
								edc=parseInt(edc)+parseInt(2);
								cfyear =fieldValue.substring(sdc,edc);
								sdc=parseInt(sdc)+parseInt(5);
								edc=parseInt(edc)+parseInt(5);
							 }
					
					
				}
				//alert("dd->"+cfdate+" mm ->"+cfmonth+" yy-> "+cfyear)
		
			/*if (formatDate==1)
			{
				cfdate =fieldValue.substring(0,2);
				cfmonth=fieldValue.substring(3,5);
				cfyear =fieldValue.substring(6,10);
			}else{
				cfmonth=fieldValue.substring(0,2);
				cfdate =fieldValue.substring(3,5);
				cfyear =fieldValue.substring(6,10);
			}*/
		
		}else{
			cfdate =curDate;
			cfmonth=curMonth;
			cfyear =curYear;
		}

		var text =""
		text +='<form name="frmCalendarSample">'
		text +="<TABLE border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 align=center class=cal_table>"
		text +='<tr>'
		text +="<td align=center class=cal_td><table width=100% class=cal_table><tr>"
		text +="<td width=90% align=center class=cal_td>"
		text +='<nobr><select id=selMonth1 name=selMonth  onchange="fUpdateCal(document.frmCalendarSample.selYear.value,document.frmCalendarSample.selMonth.value,'+fieldName+')">'
		for(i=1;i<=12;i++)
		{
			if(i == cfmonth)
				text +='<option value="'+i+'" selected>' +Months[i]+ '</option>'
		        else
				text +='<option value="'+i+'">' +Months[i]+ '</option>'
		}
		text +='</select>&nbsp;'
		text +='<Select id=selYear1  name=selYear   onchange="fUpdateCal(document.frmCalendarSample.selYear.value,document.frmCalendarSample.selMonth.value,'+fieldName+')">'
		for(i=ListBox_StartYear;i<ListBox_EndYear;i++)
		{
			if(i == cfyear)
				text +='<option value="'+i+'" selected>' + i +'</option>'
		        else
				text +='<option value="'+i+'">' + i +'</option>'
		}
		text +='</Select></nobr>'
		text +="</td><td align=right valign=top class=cal_td><font id='close' class='cal_font_close'  onClick=HideDiv() alt='Close'>X</FONT></td></tr></table></td></tr><tr><td class=cal_td>"
		var myMonth;
		myMonth = fBuildCal(curYear, curMonth)
		text +="<TABLE border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 align=center  class=cal_table>"
		text +="<tr>"
		for (p = 0; p <7; p++) 
		{	
			text +="<td align='center'  class='cal_td_weeknames'  title="+aDay[p]+">" + myMonth[0][p] + "</td>"
		}
		text +="</tr>"
		for (w = 1; w <7; w++) 
		{
			text +='<tr>'
			for (d = 0; d < 7; d++) 
			{
				text +="<td align='center' valign='top' width='" + CellWidth + "' height='" + CellHeight + "' id=calCell  onMouseOver='fSetSelectedDay(this)' onMouseOut='fSetSelectedDayOut(this)' onClick='fSetSelectedDayToField("+ fieldName +",this)'  class=cal_td>"
				if (!isNaN(myMonth[w][d])) 
				{
					text +="<font id='calDateText' class=cal_font_dates>" + myMonth[w][d] + "</font>"
				} else {
					text +="<font id='calDateText'  class=cal_font_empty_dates> </font>"
				}
				text +="</td>"
			}
			text +="</tr>"
		}
		text +="</tr><td align='center'  class=cal_td colspan=7>"
		text +="<TABLE border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 align=center width=100% class=cal_table>"
		text +="<Tr><td align='center'  onMouseOver='fSetSelectedTodayOver(this)' onMouseOut='fSetSelectedTodayOut(this)' onClick='fSetClearToday("+ fieldName +")' title='"+clear+"'  class=cal_td_today>"
		text +="<font id='calTodayDateText'  class=cal_font_today>"+clear
		text +="</font></td>"
		text +="<td  align='center' onMouseOver='fSetSelectedTodayOver(this)' onMouseOut='fSetSelectedTodayOut(this)' onClick='fSetSelectedToday("+ fieldName +")' title='"+ todaytxt +"'  class=cal_td_today>"
		text +="<font id='calTodayDateText'  class=cal_font_today> "+ todaytxt +"&nbsp;:&nbsp;&nbsp;"
		var dispToday="";
		
		for(dt=0;dt<3;dt++)
		{
			if(dFormat[dt] == "DD")
				dispToday=dispToday+curDate+DateFarmat
			if(dFormat[dt] == "MM")
				dispToday=dispToday+curMonth+DateFarmat
			if(dFormat[dt] == "YY")
				dispToday=dispToday+curYear+DateFarmat
		}
		text +=dispToday.substring(0,10);
				
		text +="</font></td></tr>"
		text +="</table>"
		text +="</td></tr>"
		text +="</table>"
		
		text +="</td></tr></table>"
		text +="</form>"

		ezDiv=document.createElement("DIV");
		with(ezDiv)
		{
			id="ezCalendar";
			style.position="absolute";
			style.zIndex=50;
			style.visibility="inherit";
			style.top=top1;
			style.left=left1;
			innerHTML=text;
		}
		document.body.appendChild(ezDiv);
		fUpdateCal(cfyear, cfmonth,fieldName)
	}
}
function fUpdateCal(icurYear, icurMonth,fieldName) 
{
	myMonth = fBuildCal(icurYear, icurMonth);
	
	for (w = 1; w < 7; w++) 
	{
		for (d = 0; d < 7; d++) 
		{
			calCell[((7*w)+d)-7].className="cal_td";
			calCell[((7*w)+d)-7].title="";
			calDateText[((7*w)+d)-7].className="cal_font_dates";
			if (!isNaN(myMonth[w][d])) 
			{
				calDateText[((7*w)+d)-7].innerText = myMonth[w][d];
				calCell[((7*w)+d)-7].title=aDay[d]+",  "+Months[eval(icurMonth)]+" "+myMonth[w][d]+" , "+icurYear
				if ((d==0)||(d==6)) 
				{
					calDateText[((7*w)+d)-7].className = "cal_font_sun_sat_dates";
				}
				if ((eval(myMonth[w][d])==eval(cfdate)) && (eval(icurMonth)==eval(cfmonth)) && (eval(icurYear)==eval(cfyear))) 
				{
					
					calCell[((7*w)+d)-7].className = "cal_td_today_date";
					calDateText[((7*w)+d)-7].className = "cal_font_todat_dates";
				}
			} else {
				calDateText[((7*w)+d)-7].innerText = " ";
				calDateText[((7*w)+d)-7].className="cal_font_empty_dates";
				calCell[((7*w)+d)-7].className="cal_td";
		        }
      		}
	}
	
}
// End -->