package com.ow.framework.util;

public class ContractNumber {
	public static int isContractNum(String key){
		char[] chararray = key.toCharArray();
		int b=0;
		for(int i=0;i<chararray.length;i++){
			if(chararray[i]>=48 && chararray[i]<=57){
				b = i;
				break;
			}
		}
		return b;
	}
	/*public static void main(String[] args) {
		System.out.println((char)57);
	}*/
}
