<%@ page import="java.util.*"%>
<%
	

	Map ezStatesMap= new LinkedHashMap();
	Hashtable ezStates  = new Hashtable();
	Hashtable ezCountry = new Hashtable();
	
	ezStatesMap.put("AL","Alabama");
	ezStatesMap.put("AK","Alaska");
	ezStatesMap.put("AS","American Samoa");
	ezStatesMap.put("AZ","Arizona");
	ezStatesMap.put("AR","Arkansas");
	ezStatesMap.put("CA","California");
	ezStatesMap.put("CO","Colorado");
	ezStatesMap.put("CT","Connecticut");
	ezStatesMap.put("DE","Delaware");
	ezStatesMap.put("DC","District of Columbia");
	ezStatesMap.put("FL","Florida");
	ezStatesMap.put("GA","Georgia");
	ezStatesMap.put("GU","Guam");
	ezStatesMap.put("HI","Hawaii");
	ezStatesMap.put("ID","Idaho");
	ezStatesMap.put("IL","Illinois");
	ezStatesMap.put("IN","Indiana");
	ezStatesMap.put("IA","Iowa");
	ezStatesMap.put("KS","Kansas");
	ezStatesMap.put("KY","Kentucky");
	ezStatesMap.put("LA","Louisiana");
	ezStatesMap.put("ME","Maine");
	ezStatesMap.put("MD","Maryland");
	ezStatesMap.put("MA","Massachusetts");
	ezStatesMap.put("MI","Michigan");
	ezStatesMap.put("MN","Minnesota");
	ezStatesMap.put("MS","Mississippi");
	ezStatesMap.put("MO","Missouri");
	ezStatesMap.put("MT","Montana");
	ezStatesMap.put("NE","Nebraska");
	ezStatesMap.put("NV","Nevada");
	ezStatesMap.put("NH","New Hampshire");
	ezStatesMap.put("NJ","New Jersey");
	ezStatesMap.put("NM","New Mexico");
	ezStatesMap.put("NY","New York");
	ezStatesMap.put("NC","North Carolina");
	ezStatesMap.put("ND","North Dakota");
	ezStatesMap.put("MP","Northern Mariana Isl");
	ezStatesMap.put("OH","Ohio");
	ezStatesMap.put("OK","Oklahoma");
	ezStatesMap.put("OR","Oregon");
	ezStatesMap.put("PA","Pennsylvania");
	ezStatesMap.put("PR","Puerto Rico");
	ezStatesMap.put("RI","Rhode Island");
	ezStatesMap.put("SC","South Carolina");
	ezStatesMap.put("SD","South Dakota");
	ezStatesMap.put("TN","Tennessee");
	ezStatesMap.put("TX","Texas");
	ezStatesMap.put("UT","Utah");
	ezStatesMap.put("VT","Vermont");
	ezStatesMap.put("VI","Virgin Islands");
	ezStatesMap.put("VA","Virginia");
	ezStatesMap.put("WA","Washington");
	ezStatesMap.put("WV","West Virginia");
	ezStatesMap.put("WI","Wisconsin");
	ezStatesMap.put("WY","Wyoming");
	
	Set setStatesMap = ezStatesMap.entrySet(); 
	Iterator iStatesMap = setStatesMap.iterator();
	

	ezStates.put("AL","Alabama");
	ezStates.put("AK","Alaska");
	ezStates.put("AS","American Samoa");
	ezStates.put("AZ","Arizona");
	ezStates.put("AR","Arkansas");
	ezStates.put("CA","California");
	ezStates.put("CO","Colorado");
	ezStates.put("CT","Connecticut");
	ezStates.put("DE","Delaware");
	ezStates.put("DC","District of Columbia");
	ezStates.put("FL","Florida");
	ezStates.put("GA","Georgia");
	ezStates.put("GU","Guam");
	ezStates.put("HI","Hawaii");
	ezStates.put("ID","Idaho");
	ezStates.put("IL","Illinois");
	ezStates.put("IN","Indiana");
	ezStates.put("IA","Iowa");
	ezStates.put("KS","Kansas");
	ezStates.put("KY","Kentucky");
	ezStates.put("LA","Louisiana");
	ezStates.put("ME","Maine");
	ezStates.put("MD","Maryland");
	ezStates.put("MA","Massachusetts");
	ezStates.put("MI","Michigan");
	ezStates.put("MN","Minnesota");
	ezStates.put("MS","Mississippi");
	ezStates.put("MO","Missouri");
	ezStates.put("MT","Montana");
	ezStates.put("NE","Nebraska");
	ezStates.put("NV","Nevada");
	ezStates.put("NH","New Hampshire");
	ezStates.put("NJ","New Jersey");
	ezStates.put("NM","New Mexico");
	ezStates.put("NY","New York");
	ezStates.put("NC","North Carolina");
	ezStates.put("ND","North Dakota");
	ezStates.put("MP","Northern Mariana Isl");
	ezStates.put("OH","Ohio");
	ezStates.put("OK","Oklahoma");
	ezStates.put("OR","Oregon");
	ezStates.put("PA","Pennsylvania");
	ezStates.put("PR","Puerto Rico");
	ezStates.put("RI","Rhode Island");
	ezStates.put("SC","South Carolina");
	ezStates.put("SD","South Dakota");
	ezStates.put("TN","Tennessee");
	ezStates.put("TX","Texas");
	ezStates.put("UT","Utah");
	ezStates.put("VT","Vermont");
	ezStates.put("VI","Virgin Islands");
	ezStates.put("VA","Virginia");
	ezStates.put("WA","Washington");
	ezStates.put("WV","West Virginia");
	ezStates.put("WI","Wisconsin");
	ezStates.put("WY","Wyoming");
	
	
	
	ezCountry.put("AF","Afghanistan");
	ezCountry.put("AL","Albania");
	ezCountry.put("DZ","Algeria");
	ezCountry.put("VI","Amer.Virgin Is.");
	ezCountry.put("AD","Andorra");
	ezCountry.put("AO","Angola");
	ezCountry.put("AI","Anguilla");
	ezCountry.put("AQ","Antarctica");
	ezCountry.put("AG","Antigua/Barbuda");
	ezCountry.put("AR","Argentina");
	ezCountry.put("AM","Armenia");
	ezCountry.put("AW","Aruba");
	ezCountry.put("AU","Australia");
	ezCountry.put("AT","Austria");
	ezCountry.put("AZ","Azerbaijan");
	ezCountry.put("BS","Bahamas");
	ezCountry.put("BH","Bahrain");
	ezCountry.put("BD","Bangladesh");
	ezCountry.put("BB","Barbados");
	ezCountry.put("BY","Belarus");
	ezCountry.put("BE","Belgium");
	ezCountry.put("BZ","Belize");
	ezCountry.put("BJ","Benin");
	ezCountry.put("BM","Bermuda");
	ezCountry.put("BT","Bhutan");
	ezCountry.put("BO","Bolivia");
	ezCountry.put("BA","Bosnia-Herz.");
	ezCountry.put("BW","Botswana");
	ezCountry.put("BV","Bouvet Islands");
	ezCountry.put("BR","Brazil");
	ezCountry.put("IO","Brit.Ind.Oc.Ter");
	ezCountry.put("VG","Brit.Virgin Is.");
	ezCountry.put("BN","Brunei Daruss.");
	ezCountry.put("BG","Bulgaria");
	ezCountry.put("BF","Burkina-Faso");
	ezCountry.put("BI","Burundi");
	ezCountry.put("KH","Cambodia");
	ezCountry.put("CM","Cameroon");
	ezCountry.put("CA","Canada");
	ezCountry.put("CV","Cape Verde");
	ezCountry.put("KY","Cayman Islands");
	ezCountry.put("CF","Central Afr.Rep");
	ezCountry.put("TD","Chad");
	ezCountry.put("CL","Chile");
	ezCountry.put("CN","China");
	ezCountry.put("CX","Christmas Islnd");
	ezCountry.put("CC","Coconut Islands");
	ezCountry.put("CO","Colombia");
	ezCountry.put("KM","Comoros");
	//ezCountry.put("CD","Congo");
	ezCountry.put("CG","Congo");
	ezCountry.put("CK","Cook Islands");
	ezCountry.put("CR","Costa Rica");
	ezCountry.put("HR","Croatia");
	ezCountry.put("CU","Cuba");
	ezCountry.put("CY","Cyprus");
	ezCountry.put("CZ","Czech Republic");
	ezCountry.put("DK","Denmark");
	ezCountry.put("DJ","Djibouti");
	ezCountry.put("DM","Dominica");
	ezCountry.put("DO","Dominican Rep.");
	ezCountry.put("AN","Dutch Antilles");
	ezCountry.put("TP","East Timor");
	ezCountry.put("EC","Ecuador");
	ezCountry.put("EG","Egypt");
	ezCountry.put("SV","El Salvador");
	ezCountry.put("GQ","Equatorial Guin");
	ezCountry.put("ER","Eritrea");
	ezCountry.put("EE","Estonia");
	ezCountry.put("ET","Ethiopia");
	ezCountry.put("FK","Falkland Islnds");
	ezCountry.put("FO","Faroe Islands");
	ezCountry.put("FJ","Fiji");
	ezCountry.put("FI","Finland");
	ezCountry.put("FR","France");
	ezCountry.put("PF","Frenc.Polynesia");
	ezCountry.put("GF","French Guyana");
	ezCountry.put("TF","French S.Territ");
	ezCountry.put("GA","Gabon");
	ezCountry.put("GM","Gambia");
	ezCountry.put("GE","Georgia");
	ezCountry.put("DE","Germany");
	ezCountry.put("GH","Ghana");
	ezCountry.put("GI","Gibraltar");
	ezCountry.put("GR","Greece");
	ezCountry.put("GL","Greenland");
	ezCountry.put("GD","Grenada");
	ezCountry.put("GP","Guadeloupe");
	ezCountry.put("GU","Guam");
	ezCountry.put("GT","Guatemala");
	ezCountry.put("GN","Guinea");
	ezCountry.put("GW","Guinea-Bissau");
	ezCountry.put("GY","Guyana");
	ezCountry.put("HT","Haiti");
	ezCountry.put("HM","Heard/McDon.Isl");
	ezCountry.put("HN","Honduras");
	ezCountry.put("HK","Hong Kong");
	ezCountry.put("HU","Hungary");
	ezCountry.put("IS","Iceland");
	ezCountry.put("IN","India");
	ezCountry.put("ID","Indonesia");
	ezCountry.put("IR","Iran");
	ezCountry.put("IQ","Iraq");
	ezCountry.put("IE","Ireland");
	ezCountry.put("IL","Israel");
	ezCountry.put("IT","Italy");
	ezCountry.put("CI","Ivory Coast");
	ezCountry.put("JM","Jamaica");
	ezCountry.put("JP","Japan");
	ezCountry.put("JO","Jordan");
	ezCountry.put("KZ","Kazakhstan");
	ezCountry.put("KE","Kenya");
	ezCountry.put("KI","Kiribati");
	ezCountry.put("KW","Kuwait");
	ezCountry.put("KG","Kyrgyzstan");
	ezCountry.put("LA","Laos");
	ezCountry.put("LV","Latvia");
	ezCountry.put("LB","Lebanon");
	ezCountry.put("LS","Lesotho");
	ezCountry.put("LR","Liberia");
	ezCountry.put("LY","Libya");
	ezCountry.put("LI","Liechtenstein");
	ezCountry.put("LT","Lithuania");
	ezCountry.put("LU","Luxembourg");
	ezCountry.put("MO","Macau");
	ezCountry.put("MK","Macedonia");
	ezCountry.put("MG","Madagascar");
	ezCountry.put("MW","Malawi");
	ezCountry.put("MY","Malaysia");
	ezCountry.put("MV","Maldives");
	ezCountry.put("ML","Mali");
	ezCountry.put("MT","Malta");
	ezCountry.put("MH","Marshall Islnds");
	ezCountry.put("MQ","Martinique");
	ezCountry.put("MR","Mauretania");
	ezCountry.put("MU","Mauritius");
	ezCountry.put("YT","Mayotte");
	ezCountry.put("MX","Mexico");
	ezCountry.put("FM","Micronesia");
	ezCountry.put("UM","Minor Outl.Isl.");
	ezCountry.put("MD","Moldavia");
	ezCountry.put("MC","Monaco");
	ezCountry.put("MN","Mongolia");
	ezCountry.put("MS","Montserrat");
	ezCountry.put("MA","Morocco");
	ezCountry.put("MZ","Mozambique");
	ezCountry.put("MM","Myanmar");
	ezCountry.put("MP","N.Mariana Islnd");
	ezCountry.put("NA","Namibia");
	ezCountry.put("NR","Nauru");
	ezCountry.put("NP","Nepal");
	ezCountry.put("NL","Netherlands");
	ezCountry.put("NC","New Caledonia");
	ezCountry.put("NZ","New Zealand");
	ezCountry.put("NI","Nicaragua");
	ezCountry.put("NE","Niger");
	ezCountry.put("NG","Nigeria");
	ezCountry.put("NU","Niue Islands");
	ezCountry.put("NF","Norfolk Islands");
	ezCountry.put("KP","North Korea");
	ezCountry.put("NO","Norway");
	ezCountry.put("OM","Oman");
	ezCountry.put("PK","Pakistan");
	ezCountry.put("PW","Palau");
	ezCountry.put("PA","Panama");
	ezCountry.put("PG","Pap. New Guinea");
	ezCountry.put("PY","Paraguay");
	ezCountry.put("PE","Peru");
	ezCountry.put("PH","Philippines");
	ezCountry.put("PN","Pitcairn Islnds");
	ezCountry.put("PL","Poland");
	ezCountry.put("PT","Portugal");
	ezCountry.put("PR","Puerto Rico");
	ezCountry.put("QA","Qatar");
	ezCountry.put("RE","Reunion");
	ezCountry.put("RO","Romania");
	ezCountry.put("RW","Ruanda");
	ezCountry.put("RU","Russian Fed.");
	ezCountry.put("GS","S. Sandwich Ins");
	ezCountry.put("ST","S.Tome,Principe");
	ezCountry.put("SW","SWITZERLAND");
	ezCountry.put("AS","Samoa, America");
	ezCountry.put("SM","San Marino");
	ezCountry.put("SA","Saudi Arabia");
	ezCountry.put("SN","Senegal");
	ezCountry.put("SC","Seychelles");
	ezCountry.put("SL","Sierra Leone");
	ezCountry.put("SG","Singapore");
	ezCountry.put("SK","Slovakia");
	ezCountry.put("SI","Slovenia");
	ezCountry.put("SB","Solomon Islands");
	ezCountry.put("SO","Somalia");
	ezCountry.put("ZA","South Africa");
	ezCountry.put("KR","South Korea");
	ezCountry.put("ES","Spain");
	ezCountry.put("LK","Sri Lanka");
	ezCountry.put("KN","St Kitts&Nevis");
	ezCountry.put("SH","St. Helena");
	ezCountry.put("LC","St. Lucia");
	ezCountry.put("VC","St. Vincent");
	ezCountry.put("PM","St.Pier,Miquel.");
	ezCountry.put("SD","Sudan");
	ezCountry.put("SR","Suriname");
	ezCountry.put("SJ","Svalbard");
	ezCountry.put("SZ","Swaziland");
	ezCountry.put("SE","Sweden");
	ezCountry.put("CH","Switzerland");
	ezCountry.put("SY","Syria");
	ezCountry.put("TW","Taiwan");
	ezCountry.put("TJ","Tajikstan");
	ezCountry.put("TZ","Tanzania");
	ezCountry.put("TH","Thailand");
	ezCountry.put("TG","Togo");
	ezCountry.put("TK","Tokelau Islands");
	ezCountry.put("TO","Tonga");
	ezCountry.put("TT","Trinidad,Tobago");
	ezCountry.put("TN","Tunisia");
	ezCountry.put("TR","Turkey");
	ezCountry.put("TM","Turkmenistan");
	ezCountry.put("TC","Turksh Caicosin");
	ezCountry.put("TV","Tuvalu");
	ezCountry.put("US","USA");
	ezCountry.put("UG","Uganda");
	ezCountry.put("UA","Ukraine");
	ezCountry.put("GB","United Kingdom");
	ezCountry.put("UY","Uruguay");
	ezCountry.put("AE","Utd.Arab Emir.");
	ezCountry.put("UZ","Uzbekistan");
	ezCountry.put("VU","Vanuatu");
	ezCountry.put("VA","Vatican City");
	ezCountry.put("VE","Venezuela");
	ezCountry.put("VN","Vietnam");
	ezCountry.put("WF","Wallis,Futuna");
	ezCountry.put("WI","West Indies");
	ezCountry.put("EH","West Sahara");
	ezCountry.put("WS","Western Samoa");
	ezCountry.put("YE","Yemen");
	ezCountry.put("YU","Yugoslavia");
	ezCountry.put("ZM","Zambia");
	ezCountry.put("ZW","Zimbabwe");
	
%>
	
