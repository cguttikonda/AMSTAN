<%
int ph1len = 3,ph2len=5,ph3len=8;
String[] stArr = {"USA","CAN","IND",null};
	int cntryCode=1000;
	String stsel;
	for (int i = 0;i<stArr.length;i++){
		if (country.equalsIgnoreCase(stArr[i])){
			cntryCode = i;
			break;
		}
	}
	switch (cntryCode){
		case 0:{
			ph1len = 3;ph2len=3;ph3len=4;
			%>
			<input type="hidden" name="ph1" value=10>
			<%@ include file="LBStatesUSA.jsp"%>
			<%
			break; }
		case 1:{
			%>
			<input type="hidden" name="ph1" value="variable">
			<%@ include file="LBStatesCAN.jsp"%>
			<%
			break;}
		case 2:{
			%>
			<input type="hidden" name="ph1" value="variable">
			<%@ include file="LBStatesIND.jsp"%>
			<%
			break;}
		default :{
			%>				
				<input type=text class = "InputBox" name="State" size="30" maxlength="64" value="<%=statePrev%>">
				<input type="hidden" name="maxZip" value="variable">
				<input type="hidden" name="ph1" value="variable">				
			<%
			break;}
	}
%>