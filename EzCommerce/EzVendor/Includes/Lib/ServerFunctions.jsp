<%!
// Start Declarations
public String adjustString(int total_length , String str) {
	char temp = '0';
	for (temp = '0'; temp <= '9'; temp++) {
		if (str.charAt(0) == temp) {
			int count = total_length - str.length();
			for (int i = 0; i < count; i++)
				str = '0' + str;
			return str;
		}
	}
		return str;	
}

// CheckString for the Date 
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

//End Declarations
%>