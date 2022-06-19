package mypage.model.dto;

public class ActorInfo {
	private String memberId;
	private String actorName;
	private int actorNo;
	private String birth;
	private int age;
	private String education;
	private double height;
	private double weight;
	private String company;
	private String phone;
	private String email;
	private String speciality;
	private String sns;	
	private int attachNo;
	private PortAttachment attachment;  // 배우 프로필 사진
	
	public ActorInfo() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ActorInfo(String memberId, String actorName, int actorNo, String birth, int age, String education,
			double height, double weight, String company, String phone, String email, String speciality, String sns,
			int attachNo, PortAttachment attachment) {
		super();
		this.memberId = memberId;
		this.actorName = actorName;
		this.actorNo = actorNo;
		this.birth = birth;
		this.age = age;
		this.education = education;
		this.height = height;
		this.weight = weight;
		this.company = company;
		this.phone = phone;
		this.email = email;
		this.speciality = speciality;
		this.sns = sns;
		this.attachNo = attachNo;
		this.attachment = attachment;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getActorName() {
		return actorName;
	}

	public void setActorName(String actorName) {
		this.actorName = actorName;
	}

	public int getActorNo() {
		return actorNo;
	}

	public void setActorNo(int actorNo) {
		this.actorNo = actorNo;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public double getHeight() {
		return height;
	}

	public void setHeight(double height) {
		this.height = height;
	}

	public double getWeight() {
		return weight;
	}

	public void setWeight(double weight) {
		this.weight = weight;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSpeciality() {
		return speciality;
	}

	public void setSpeciality(String speciality) {
		this.speciality = speciality;
	}

	public String getSns() {
		return sns;
	}

	public void setSns(String sns) {
		this.sns = sns;
	}

	public int getAttachNo() {
		return attachNo;
	}

	public void setAttachNo(int attachNo) {
		this.attachNo = attachNo;
	}

	public PortAttachment getAttachment() {
		return attachment;
	}

	public void setAttachment(PortAttachment attachment) {
		this.attachment = attachment;
	}

	@Override
	public String toString() {
		return "ActorInfo [memberId=" + memberId + ", actorName=" + actorName + ", actorNo=" + actorNo + ", birth="
				+ birth + ", age=" + age + ", education=" + education + ", height=" + height + ", weight=" + weight
				+ ", company=" + company + ", phone=" + phone + ", email=" + email + ", speciality=" + speciality
				+ ", sns=" + sns + ", attachNo=" + attachNo + ", attachment=" + attachment + "]";
	}

	

}
