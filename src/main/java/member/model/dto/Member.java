package member.model.dto;

import java.sql.Date;

public class Member {
	
	private String memberId;
	private String password;
	private String memberName;
	private String email;
	private MemberRole memberRole; // 배우 및 아티스트 P 제작사 및 캐스팅 담당자 D 
	private String phone;
	private String gender;
	private Date birthday;
	private Date enrollDate;
    private String genre;
	
	
	public Member() {
		super();
	}


	public Member(String memberId, String password, String memberName, String email, MemberRole memberRole,
			String phone, String gender, Date birthday, Date enrollDate, String genre) {
		super();
		this.memberId = memberId;
		this.password = password;
		this.memberName = memberName;
		this.email = email;
		this.memberRole = memberRole;
		this.phone = phone;
		this.gender = gender;
		this.birthday = birthday;
		this.enrollDate = enrollDate;
		this.genre = genre;
	}


	public String getMemberId() {
		return memberId;
	}


	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getMemberName() {
		return memberName;
	}


	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public MemberRole getMemberRole() {
		return memberRole;
	}


	public void setMemberRole(MemberRole memberRole) {
		this.memberRole = memberRole;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public String getGender() {
		return gender;
	}


	public void setGender(String gender) {
		this.gender = gender;
	}


	public Date getBirthday() {
		return birthday;
	}


	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}


	public Date getEnrollDate() {
		return enrollDate;
	}


	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}


	public String getGenre() {
		return genre;
	}


	public void setGenre(String genre) {
		this.genre = genre;
	}


	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", password=" + password + ", memberName=" + memberName + ", email="
				+ email + ", memberRole=" + memberRole + ", phone=" + phone + ", gender=" + gender + ", birthday="
				+ birthday + ", enrollDate=" + enrollDate + ", address=" + ", genre=" + genre + "]";
	}



}

