package mypage.model.dto;

public class ActorInfo {
	private String memberId;
	private int actorNo;
	private int age;
	private String education;
	private double height;
	private double weight;
	private String company;
	private String speciality;
	private String sns;	
	private PortAttachment attachment;
	
	public ActorInfo() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ActorInfo(String memberId, int actorNo, int age, String education, double height, double weight,
			String company, String speciality, String sns, PortAttachment attachment) {
		super();
		this.memberId = memberId;
		this.actorNo = actorNo;
		this.age = age;
		this.education = education;
		this.height = height;
		this.weight = weight;
		this.company = company;
		this.speciality = speciality;
		this.sns = sns;
		this.attachment = attachment;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getActorNo() {
		return actorNo;
	}

	public void setActorNo(int actorNo) {
		this.actorNo = actorNo;
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

	public PortAttachment getAttachment() {
		return attachment;
	}

	public void setAttachment(PortAttachment attachment) {
		this.attachment = attachment;
	}

	@Override
	public String toString() {
		return "ActorInfo [memberId=" + memberId + ", actorNo=" + actorNo + ", age=" + age + ", education=" + education
				+ ", height=" + height + ", weight=" + weight + ", company=" + company + ", speciality=" + speciality
				+ ", sns=" + sns + ", attachment=" + attachment + "]";
	}

	
}
