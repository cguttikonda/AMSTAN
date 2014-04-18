<%!
// Start Declarations
public String replaceChar(char temp, String replace_with, String str) {
	String rStr = new String("");
	java.text.StringCharacterIterator iter = new java.text.StringCharacterIterator(str);
	for(char c = iter.first(); c!= java.text.CharacterIterator.DONE; c = iter.next()){
		if(c != temp){
			rStr = rStr + String.valueOf(c);
		}else{
			rStr = rStr + replace_with;
			continue;
		}
	}//end for
	return rStr;
}

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
//End Declarations
%>