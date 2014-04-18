
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
%>
