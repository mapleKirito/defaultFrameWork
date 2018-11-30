package com.ow.framework.data.po;

/**
 * 客户信息类
 * @author Administrator
 *
 */
public class EcAgentUpdate extends AbstractBean{
	//客户编号
	private String partyNo;
	//会员编号
	private String agentId;
	//类型 1: 修改客户基本信息,2:修改客户联系方式,3:修改客户联系地址
	private String type;
	//email
	private String agentEmail;
	//姓名
	private String agentName;
	//性别
	private String agentGender;
	//生日
	private String agentBirthday;
	//证件类型
	private String characterType;
	//证件号
	private String characterNum;
	//手机
	private String agentMobile;
	//座机
	private String agentPhone;
	//邮编
	private String agentPstalcode;
	//居住省
	private String agentProv;
	//居住市/县
	private String agentRegion;
	//地址
	private String agentAddress;
	
	public EcAgentUpdate() {
		super();
		// TODO Auto-generated constructor stub
	}

	public EcAgentUpdate(String partyNo, String agentId, String type, String agentEmail,
			String agentName, String agentGender, String agentBirthday,
			String characterType, String characterNum, String agentMobile,
			String agentPhone, String agentPstalcode, String agentProv,
			String agentRegion, String agentAddress) {
		super();
		this.partyNo = partyNo;
		this.agentId = agentId;
		this.type = type;
		this.agentEmail = agentEmail;
		this.agentName = agentName;
		this.agentGender = agentGender;
		this.agentBirthday = agentBirthday;
		this.characterType = characterType;
		this.characterNum = characterNum;
		this.agentMobile = agentMobile;
		this.agentPhone = agentPhone;
		this.agentPstalcode = agentPstalcode;
		this.agentProv = agentProv;
		this.agentRegion = agentRegion;
		this.agentAddress = agentAddress;
	}

	public String getPartyNo() {
		return partyNo;
	}

	public void setPartyNo(String partyNo) {
		this.partyNo = partyNo;
	}

	public String getAgentId() {
		return agentId;
	}

	public void setAgentId(String agentId) {
		this.agentId = agentId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getAgentEmail() {
		return agentEmail;
	}

	public void setAgentEmail(String agentEmail) {
		this.agentEmail = agentEmail;
	}

	public String getAgentName() {
		return agentName;
	}

	public void setAgentName(String agentName) {
		this.agentName = agentName;
	}

	public String getAgentGender() {
		return agentGender;
	}

	public void setAgentGender(String agentGender) {
		this.agentGender = agentGender;
	}

	public String getAgentBirthday() {
		return agentBirthday;
	}

	public void setAgentBirthday(String agentBirthday) {
		this.agentBirthday = agentBirthday;
	}

	public String getCharacterType() {
		return characterType;
	}

	public void setCharacterType(String characterType) {
		this.characterType = characterType;
	}

	public String getCharacterNum() {
		return characterNum;
	}

	public void setCharacterNum(String characterNum) {
		this.characterNum = characterNum;
	}

	public String getAgentMobile() {
		return agentMobile;
	}

	public void setAgentMobile(String agentMobile) {
		this.agentMobile = agentMobile;
	}

	public String getAgentPhone() {
		return agentPhone;
	}

	public void setAgentPhone(String agentPhone) {
		this.agentPhone = agentPhone;
	}

	public String getAgentPstalcode() {
		return agentPstalcode;
	}

	public void setAgentPstalcode(String agentPstalcode) {
		this.agentPstalcode = agentPstalcode;
	}

	public String getAgentProv() {
		return agentProv;
	}

	public void setAgentProv(String agentProv) {
		this.agentProv = agentProv;
	}

	public String getAgentRegion() {
		return agentRegion;
	}

	public void setAgentRegion(String agentRegion) {
		this.agentRegion = agentRegion;
	}

	public String getAgentAddress() {
		return agentAddress;
	}

	public void setAgentAddress(String agentAddress) {
		this.agentAddress = agentAddress;
	}
	
}
