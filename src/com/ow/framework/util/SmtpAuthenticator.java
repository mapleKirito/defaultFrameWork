package com.ow.framework.util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

/**
 * smtp验证登录类
 */
public class SmtpAuthenticator extends Authenticator {
   String username=null;
   String password=null;

   public SmtpAuthenticator(String username,String password) {
       this.username=username;
       this.password=password;
   }

   public PasswordAuthentication getPasswordAuthentication() {
	return new  PasswordAuthentication(this.username,this.password);
   }
}