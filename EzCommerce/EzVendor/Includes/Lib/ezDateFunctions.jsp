<%!
/*
// Convert java.util.Date to java.util.GregorianCalendar
public java.util.GregorianCalendar getConvertedDate(java.util.GregorianCalendar inDate){
	if ( inDate != null )
		return ( new java.util.GregorianCalendar( inDate.get(inDate.YEAR) , inDate.get(inDate.MONTH), inDate.get(inDate.DATE) ) )	;
return null;
}
*/

// Convert java.util.Date to java.util.GregorianCalendar
public java.util.GregorianCalendar getConvertedDate(java.util.Date inDate){
	if ( inDate != null )
		return ( new java.util.GregorianCalendar( inDate.getYear() , inDate.getMonth(), inDate.getDate() ) )	;
	return null;
}

public String JSPformatDate(java.util.Date inDate, FormatDate formatDate ) {
	if ( inDate != null && inDate.getYear() < 9000 ) {
		return ( formatDate.getCorrectedStringFromDate ( new java.util.GregorianCalendar( inDate.getYear() , inDate.getMonth(), inDate.getDate() ) ));
	}
	return "  ";
}   

public java.lang.String checkString(java.lang.String instr) {
	java.lang.String month = null;
	java.lang.String rest = null;
	java.lang.String year = null;
	java.lang.String date  = null;
	if (instr.length() < 10) {
		month = instr.substring(0, instr.indexOf("/") + 1);
		rest = instr.substring(instr.indexOf("/") + 1, instr.length());
		date = rest.substring(0, rest.indexOf("/") + 1);
		year = rest.substring(rest.indexOf("/") + 1, rest.length());
		if (date.length() < 3)
			date = "0" + date;
		if (year.length() < 3) {
		    if (year.charAt(0) > '6')
			year = "19" + year;
		     else
			year = "20" + year;
		}
		if (month.length() < 3)
			month = "0" + month;
		if (rest.length() < 7)
			rest = "0" + rest;
		return month + date + year;	
	}
	return instr;
}

%>