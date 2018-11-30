// JavaScript Document

//按Ctrl+Enter)提交表单
function BigPressKey(eventobject)
{
	if(event.ctrlKey && window.event.keyCode==13)
	{
		if(CheckBigClass())  this.document.BigClass.submit();
	}
}

//小类新闻中按(Ctrl+Enter)提交表单
function SPressKey(eventobject)
{
	if(event.ctrlKey && window.event.keyCode==13)
	{
		if(CheckSClass())  this.document.SmallClass.submit();
	}
}

//小类新闻中按(Ctrl+Enter)提交表单
function SpPressKey(eventobject)
{
	if(event.ctrlKey && window.event.keyCode==13)
	{
		if(CheckSpecial())  this.document.Special.submit();
	}
}

//下拉分页
function MM_jumpMenu(targ,selObj,restore){ 		//v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}

// 显示无模式对话框
function ShowDialog(url, width, height) {
	var arr = window.showModalDialog(url, window, "dialogWidth:" + width + "px;dialogHeight:" + height + "px;help:no;scroll:no;status:no");
	ShowDialog = arr;
}

/*****************************************************  
 *  函数名：DateCheck()
 *  作  用：检查字符中是否在指定的大小范围内和是否含有非法字符
 *	参  数：date: 要检查的字符；
 *          minum:  字符最小的长度
 *  		maxnum: 字符最大的长度
 *  返回值：True:   数据不在指定范围内或含有非法字符
 *			False:  数据在指定范围内且不含有非法字符
 ******************************************************
*/
function DateCheck(date,minnum,maxnum)
{
	if (date.length < minnum || date.length > maxnum ){
		window.alert("输入数据的长度不能少于 " + minnum + " 位并且不能大于 " + maxnum + " 位!");
		return true;
	}

	 a = date.indexOf("'");
	 b = date.indexOf("|");
	 c = date.indexOf("\"");
	 
	 if (a != -1||b != -1 ||c != -1){
	   window.alert("您的输入含有特殊字符，请重新输入！");
	   return true;
	  	}
	return false;
}


/*****************************************************  
 *  函数名：	IsNum()
 *  作  用：检查字符是否是纯数字
 *	参  数：str: 要检查的字符；  
 *  返回值：True:   是数字
 *			False:  不是纯数字
 ******************************************************
*/
function IsNum(str)
{
	return !/\D/.test(str)
}


/*****************************************************  
 *  函数名：	IsStr()
 *  作  用：检查字符是否是字符
 *	参  数：str: 要检查的字符  
 *  返回值：True:   是字符
 *			False:  不是纯字符
 ******************************************************
*/
function IsStr(str){      
　  if (/[^\x00-\xff]/g.test(str))
	{
		return false;
	}
　　else 
	{
		return true;
	}
}


/*****************************************************  
 *  函数名：IsEmail()
 *  作  用：检查Email地址是否合法
 *	参  数：date: 要检查的Email地址  
 *  返回值：True: Email 地址合法
 *          False:Email 地址不合法
 *****************************************************
*/
function IsEmail(vEMail)
{
	var regInvalid=/(@.*@)|(\.\.)|(@\.)|(\.@)|(^\.)/;
	var regValid=/^.+\@(\[?)[a-zA-Z0-9\-\.]+\.([a-zA-Z]{2,3}|[0-9]{1,3})(\]?)$/;
	return (!regInvalid.test(vEMail)&&regValid.test(vEMail));
}


/*****************************************************  
 *  函数名：CheckBigClass()
 *  作  用：检查大类信息
 *	参  数：无 
 *  返回值：True: 验证通过
 *          False: 验证没有通过
 ******************************************************
*/
function CheckBigClass(){
    var CheckBigClass = false;
	var BigClassID = document.BigClass.BigClassID.value;
	if (BigClassID=="")
	{
	   alert("请输入大类排序!");
	   document.BigClass.BigClassID.focus();
	   return false;
	 }
	
	if(!IsNum(BigClassID))
	{
		alert("您输入的大类排序不是整数!");
		document.BigClassID.focus();
		document.BigClass.BigClassID.value = "";
		return false;
	}
	
	if(DateCheck(BigClassID,1,4))
	{
		document.BigClass.BigClassID.focus();
		document.BigClass.BigClassID.value = "";
		return false;
	}
	
	var BigClassName = document.BigClass.BigClassName.value;
	if (BigClassName=="")
	{
	   alert("请输入大类标题!");
	   document.BigClass.BigClassName.focus();
	   return false;
	 }
	
	if(DateCheck(BigClassName,1,30))
	{
		document.BigClass.BigClassName.focus();
		document.BigClass.BigClassName.value = "";
		return false;
	}
	
	var BigClassInfo = document.BigClass.BigClassInfo.value;
	if (BigClassInfo=="")
	{
	   alert("请输入大类的说明!");
	   document.BigClass.BigClassInfo.focus();
	   return false;
	 }
	
	if(DateCheck(BigClassInfo,1,200))
	{
		document.BigClass.BigClassInfo.focus();
		return false;
	}
  	return true;
}


/*****************************************************  
 *  函数名：CheckSClass()
 *  作  用：检查小类信息
 *	参  数：无 
 *  返回值：True: 验证通过
 *          False: 验证没有通过
 ******************************************************
*/
function CheckSClass(){
    var CheckSClass = false;
	var BigClassID = document.SmallClass.BigClassID.value;
	if (BigClassID=="")
	{
	   alert("请选择大类!");
	   document.SmallClass.BigClassID.focus();
	   return false;
	 }
	
	
	var SClassName = document.SmallClass.SClassName.value;
	if (SClassName=="")
	{
	   alert("请输入小类标题!");
	   document.SmallClass.SClassName.focus();
	   return false;
	 }
	
	if(DateCheck(SClassName,2,30))
	{
		document.SmallClass.SClassName.focus();
		document.SmallClass.SClassName.value = "";
		return false;
	}
	
	var SClassInfo = document.SmallClass.SClassInfo.value;
	if (SClassInfo=="")
	{
	   alert("请输入小类的说明!");
	   document.SmallClass.SClassInfo.focus();
	   return false;
	 }
	
	if(DateCheck(SClassInfo,1,200))
	{
		document.SmallClass.SClassInfo.focus();
		return false;
	}
  	return true;
}


/*****************************************************  
 *  函数名：CheckSpecial()
 *  作  用：检查专题信息
 *	参  数：无 
 *  返回值：True: 验证通过
 *          False: 验证没有通过
 ******************************************************
*/
function CheckSpecial(){
    var CheckSpecial = false;
	var SpecialName = document.Special.SpecialName.value;
	if (SpecialName=="")
	{
	   alert("请输入专题名称!");
	   document.Special.SpecialName.focus();
	   return false;
	 }
	
	if(DateCheck(SpecialName,1,30))
	{
		document.Special.SpecialName.focus();
		document.Special.SpecialName.value = "";
		return false;
	}
	
	var SpecialInfo = document.Special.SpecialInfo.value;
	if (SpecialInfo=="")
	{
	   alert("请输入专题的说明!");
	   document.Special.SpecialInfo.focus();
	   return false;
	 }
	
	if(DateCheck(SpecialInfo,1,200))
	{
		document.Special.SpecialInfo.focus();
		return false;
	}
  	return true;
}



/*****************************************************  
 *  函数名：CheckNews()
 *  作  用：检查新闻表单信息
 *	参  数：无 
 *  返回值：True: 验证通过
 *          False: 验证没有通过
 ******************************************************
*/
function CheckNews(){
    var CheckNews = false;
	var BigClassID = document.AddNews.BigClassID.value;
	var SClassID = document.AddNews.SClassID.value;
	/*var SpecialID = document.AddNews.SpecialID.value;*/
	if (BigClassID=="")
	{   
	   alert("新闻类别不能为空!");
	   document.AddNews.BigClassID.focus();
	   return false;
	 }
	
	if (BigClassID!="" && SClassID=="")
	{
	   alert("请选择新闻小类!");
	   document.AddNews.SClassID.focus();
	   return false;
	 }
	
	
	var NewsTitle = document.AddNews.NewsTitle.value;
	if (NewsTitle=="")
	{
	   alert("请输入新闻标题!");
	   document.AddNews.NewsTitle.focus();
	   return false;
	 }

	if(DateCheck(NewsTitle,2,60))
	{
		document.AddNews.NewsTitle.focus();
		document.AddNews.NewsTitle.value = "";
		return false;
	}
	
	return true;
}


/*****************************************************  
*  函数名：CheckConfig()
*  作  用：系统参数设置表单数据验证
*	参  数：无 
*  返回值：True: 验证通过
*          False: 验证没有通过
*****************************************************
*/
function CheckConfig()
{
	var LoginCheck = false;
	
	var Text1 = document.Config.Text1.value;
	
	if (!IsNum(Text1) || Text1=='')
	{
	   alert("请设置为(1-999)之间的整数!");
	   document.Config.Text1.focus();
	   return false;
	}

	var Text6 = document.Config.Text6.value;
	
	if (!IsNum(Text6) || Text6=='' || Text6%5!=0)
	{
	   alert("请设置为5的倍数!");
	   document.Config.Text6.focus();
	   return false;
	}
	
	var Text7 = document.Config.Text7.value;
	if (!IsNum(Text7) || Text7 == '' || Text7%5!=0)
	{
		alert("请设置为5的倍数!");
		document.Config.Text7.focus();
		return false;
	}	
	
	
	var Text8 = document.Config.Text8.value;
	if (!IsNum(Text8) || Text8=='' || Text8%5!=0)
	{
	   alert("请设置为5的倍数!");
	   document.Config.Text8.focus();
	   return false;
	}

	var Text9 = document.Config.Text9.value;
	if (!IsNum(Text9) || Text9 == '' || Text9%5!=0)
	{
	   alert("请设置为5的倍数!");
	   document.Config.Text9.focus();
	   return false;
	}
	
	var Text14 = document.Config.Text14.value;
	if (!IsNum(Text14) || Text14=='' || Text14%5!=0)
	{
	   alert("请设置为5的倍数!");
	   document.Config.Text14.focus();
	   return false;
	}
	
	var Text15 = document.Config.Text15.value;
	if (!IsNum(Text15) || Text15 == '' || Text15%5!=0)
	{
	   alert("请设置为5的倍数!");
	   document.Config.Text15.focus();
	   return false;
	}
	
	var Text16 = document.Config.Text16.value;
	if (!IsNum(Text16) || Text16=='' || Text16%5!=0)
	{
	   alert("请设置为5的倍数!");
	   document.Config.Text16.focus();
	   return false;
	}

	var Text17 = document.Config.Text17.value;
	if (!IsNum(Text17) || Text17 == '' || Text17%5!=0)
	{
	   alert("请设置为5的倍数!");
	   document.Config.Text17.focus();
	   return false;
	}

	 return true;
}
 

/*****************************************************  
 *  函数名：CheckUser()
 *  作  用：检查用户表单信息
 *	参  数：无 
 *  返回值：True: 验证通过
 *          False: 验证没有通过
 ******************************************************
*/
function CheckUser(){
    var CheckUser = false;
	var AdminName = document.User.AdminName.value;
	if (AdminName=="")
	{
	   alert("用户名不能为空!");
	   document.User.AdminName.focus();
	   return false;
	 }

	if(DateCheck(AdminName,3,16))
	{
		document.User.AdminName.focus();
		document.User.AdminName.value = "";
		return false;
	}
	
	var AdminPwd = document.User.AdminPwd.value;
	if (AdminPwd=="")
	{
	   alert("请输入管理员密码!");
	   document.User.AdminPwd.focus();
	   return false;
	 }

	if(DateCheck(AdminPwd,4,16))
	{
		document.User.AdminPwd.focus();
		document.User.AdminPwd.value = "";
		return false;
	}
	
	var AdminPwd2 = document.User.AdminPwd2.value;
	if (AdminPwd2=="")
	{
	   alert("请再输入一次新密码!");
	   document.User.AdminPwd2.focus();
	   return false;
	 }
	
	if(DateCheck(AdminPwd2,4,16))
	{
		document.User.AdminPwd.focus();
		document.User.AdminPwd.value = "";
		return false;
	}
	
	if (AdminPwd != AdminPwd2) 
	{
		alert("你两次输入的密码不一致，请重输入！");
		document.User.AdminPwd.focus();	
		document.User.AdminPwd.value = "";
		document.User.AdminPwd2.value = "";
		return false;
	}
	
	var UserName = document.User.UserName.value;
	if (UserName=="")
	{
	   alert("真实姓名不能为空!");
	   document.User.UserName.focus();
	   return false;
	 }

	if(DateCheck(UserName,2,16))
	{
		document.User.UserName.focus();
		document.User.UserName.value = "";
		return false;
	}
	
	var UserEmail = document.User.UserEmail.value;
	if (UserEmail=="")
	{
	   alert("请输入电子邮件!");
	   document.User.UserEmail.focus();
	   return false;
	 }
	
		
	if(!IsEmail(UserEmail ))
	{
		alert("请输入正确的电子邮箱！");
		document.User.UserEmail .focus();
		document.User.UserEmail .value = "";
		return false;
	}
	
	var UserQQ = document.User.UserQQ.value;
	if (UserQQ != "") 
	{
		if(!IsNum(UserQQ))
		{
			alert("您输入的QQ不是纯数字,如果没有QQ请不要填写!");
			document.User.UserQQ.focus();
			document.User.UserQQ.value = "";
			return false;
		}
		if(DateCheck(UserQQ,4,10))
		{
			document.User.UserQQ.focus();
			document.User.UserQQ.value = "";
			return false;
		}
	}
}


/*****************************************************  
 *  函数名：CheckEditUser()
 *  作  用：检查用户表单信息
 *	参  数：无 
 *  返回值：True: 验证通过
 *          False: 验证没有通过
 ******************************************************
*/
function CheckEditUser(){
    var CheckEditUser = false;
	var AdminPwd = document.User.AdminPwd.value;
	if (AdminPwd!="")
	{
		if(DateCheck(AdminPwd,4,16))
		{
			document.User.AdminPwd.focus();
			document.User.AdminPwd.value = "";
			return false;
		}
		
		var AdminPwd2 = document.User.AdminPwd2.value;
		if (AdminPwd2=="")
		{
		   alert("请再输入一次新密码!");
		   document.User.AdminPwd2.focus();
		   return false;
		 }
		
		if(DateCheck(AdminPwd2,4,16))
		{
			document.User.AdminPwd.focus();
			document.User.AdminPwd.value = "";
			return false;
		}
		
		if (AdminPwd != AdminPwd2) 
		{
			alert("你两次输入的密码不一致，请重输入！");
			document.User.AdminPwd.focus();	
			document.User.AdminPwd.value = "";
			document.User.AdminPwd2.value = "";
			return false;
		}
		
	}


	
	var UserName = document.User.UserName.value;
	if (UserName=="")
	{
	   alert("真实姓名不能为空!");
	   document.User.UserName.focus();
	   return false;
	 }

	if(DateCheck(UserName,3,16))
	{
		document.User.UserName.focus();
		document.User.UserName.value = "";
		return false;
	}
	
	var UserEmail = document.User.UserEmail.value;
	if (UserEmail=="")
	{
	   alert("请输入电子邮件!");
	   document.User.UserEmail.focus();
	   return false;
	 }
	
		
	if(!IsEmail(UserEmail ))
	{
		alert("请输入正确的电子邮箱！");
		document.User.UserEmail .focus();
		document.User.UserEmail .value = "";
		return false;
	}
	
	var UserQQ = document.User.UserQQ.value;
	if (UserQQ != "") 
	{
		if(!IsNum(UserQQ))
		{
			alert("您输入的QQ不是纯数字,如果没有QQ请不要填写!");
			document.User.UserQQ.focus();
			document.User.UserQQ.value = "";
			return false;
		}
		if(DateCheck(UserQQ,4,10))
		{
			document.User.UserQQ.focus();
			document.User.UserQQ.value = "";
			return false;
		}
	}
}



/*****************************************************  
 *  函数名：CheckPerson()
 *  作  用：检查用户表单信息
 *	参  数：无 
 *  返回值：True: 验证通过
 *          False: 验证没有通过
 ******************************************************
*/
function CheckPerson(){
    var CheckPerson = false;
	var UserName = document.User.UserName.value;
	if (UserName=="")
	{
	   alert("真实姓名不能为空!");
	   document.User.UserName.focus();
	   return false;
	 }

	if(DateCheck(UserName,3,16))
	{
		document.User.UserName.focus();
		document.User.UserName.value = "";
		return false;
	}
	
	var UserEmail = document.User.UserEmail.value;
	if (UserEmail=="")
	{
	   alert("请输入电子邮件!");
	   document.User.UserEmail.focus();
	   return false;
	 }
	
		
	if(!IsEmail(UserEmail ))
	{
		alert("请输入正确的电子邮箱！");
		document.User.UserEmail .focus();
		document.User.UserEmail .value = "";
		return false;
	}
	
	var UserQQ = document.User.UserQQ.value;
	if (UserQQ != "") 
	{
		if(!IsNum(UserQQ))
		{
			alert("您输入的QQ不是纯数字,如果没有QQ请不要填写!");
			document.User.UserQQ.focus();
			document.User.UserQQ.value = "";
			return false;
		}
		if(DateCheck(UserQQ,4,10))
		{
			document.User.UserQQ.focus();
			document.User.UserQQ.value = "";
			return false;
		}
	}
}



/*****************************************************  
 *  函数名：CheckModPwd()
 *  作  用：修改密码表单数据验证
 *	参  数：无 
 *  返回值：True: 验证通过
 *          False: 验证没有通过
 *****************************************************
*/
function CheckModPwd()
{
	var OldPwd = document.User.OldPwd.value;
	if (OldPwd == "") {
	alert("请输入你的旧密码!");
	document.User.OldPwd.focus();
		return false;
	}
	
	if(DateCheck(OldPwd,4,16)){
		document.User.OldPwd.focus();
		document.User.OldPwd.value = "";
		return false;
	}
	
	var AdminPwd = document.User.AdminPwd.value;
	if (AdminPwd == "") {
	alert("新密码不能为空！");
	document.User.AdminPwd.focus();	
		return false;
	} 
	
	if(DateCheck(AdminPwd,4,16)){
		document.User.AdminPwd.focus();
		document.User.AdminPwd.value = "";
		return false;
	}
	
	var AdminPwd2 = document.User.AdminPwd2.value; 
	if (AdminPwd2 == "") {
	alert("请确认新密码！");
	document.User.AdminPwd2.focus();		
		return false;
      }
	  
	if(DateCheck(AdminPwd2,4,16)){
		document.User.AdminPwd2.focus();
		document.User.AdminPwd2.value = "";
		return false;
	}
	 
	if (AdminPwd != AdminPwd2) {
	alert("你两次输入的密码不一致，请重输入！");
	document.User.AdminPwd.focus();	
	document.User.AdminPwd.value = "";
	document.User.AdminPwd2.value = "";
		return false;
	}
	 
  return true;
  }    
 
 
 
 
/*****************************************************  
 *  函数名：LoginCheck()
 *  作  用：登录表单数据验证
 *	参  数：无 
 *  返回值：True: 验证通过
 *          False: 验证没有通过
 *****************************************************
*/
 function LoginCheck()
 {
	var LoginCheck = false;
	var User = document.form.User.value;
	if (User == "") {
	alert("请输入你的用户名!");
	document.form.User.focus();
		return false;
	}
	
	if(DateCheck(User,3,16)){
		document.form.User.focus();
		document.form.User.value = "";
		return false;
	}
	
	var Pwd = document.form.Pwd.value;
	if (Pwd == "") {
	alert("请输入你的密码!");
	document.form.Pwd.focus();
		return false;
	}
	
	if(DateCheck(Pwd,4,16)){
		document.form.Pwd.focus();
		document.form.Pwd.value = "";
		return false;
	}
	
	var VerifyCode = document.form.VerifyCode.value;
	if (VerifyCode == "" || VerifyCode.length != 4) {
	alert("请输入正确的验证码!");
	document.form.VerifyCode.focus();
		return false;
	}
  return true;
  }  



