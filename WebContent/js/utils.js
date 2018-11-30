function getSerialNO(sn){
	var snNO =  "" ;
	var snLen = (sn + "").length ;
	for(var i = 0; i < 8 - snLen; i ++) {
		snNO += "0" ;
	}
	snNO = snNO + sn ;
	return snNO ;
}
