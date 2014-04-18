function EzUserRoles(RoleCode,RoleDesc)
{
	this.RoleCode = RoleCode
	this.RoleDesc = RoleDesc
}
var userroles = new Array()
userroles[0] = new EzUserRoles("VP","Vice President")
userroles[1] = new EzUserRoles("PH","Purchase Head")
userroles[2] = new EzUserRoles("PP","Purchase Person")
userroles[3] = new EzUserRoles("DM","Distict Manager")
userroles[4] = new EzUserRoles("CM","Country Manager")
userroles[5] = new EzUserRoles("CU","Sales Customer")
userroles[6] = new EzUserRoles("LF","Logistic Facilitator")


//userroles[3] = new EzUserRoles("AG","Agent")
//userroles[4] = new EzUserRoles("AM","Area Manager")
//userroles[6] = new EzUserRoles("BP","Backend Processer")
//userroles[7] = new EzUserRoles("CP","Central Planner")
//userroles[10] = new EzUserRoles("HOSERVICE","Head Office Service")
//userroles[11] = new EzUserRoles("JV","JV")
//userroles[13] = new EzUserRoles("REGIONAL_BUSINESS_MANAGER","Regional Business Manager")
//userroles[14] = new EzUserRoles("REGIONALENGINEER","Regional Engineer")
//userroles[15] = new EzUserRoles("SE","Sales Executive")
//userroles[16] = new EzUserRoles("SBU","SBU Head")
