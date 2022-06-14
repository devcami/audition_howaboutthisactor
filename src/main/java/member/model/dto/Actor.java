package member.model.dto;

import java.sql.Date;

public class Actor {

	private String member_id;
	private String actor_no;
	private String actor_age;
	private String actor_education;
	private String actor_height;
	private String actor_weight;
	private String actor_company;
	private String actor_speciality;
	private String actor_sns;
	private String actor_photo;
	
	
	public Actor() {
		super();
		// TODO Auto-generated constructor stub
	}


	public Actor(String member_id, String actor_no, String actor_age, String actor_education, String actor_height,
			String actor_weight, String actor_company, String actor_speciality, String actor_sns, String actor_photo) {
		super();
		this.member_id = member_id;
		this.actor_no = actor_no;
		this.actor_age = actor_age;
		this.actor_education = actor_education;
		this.actor_height = actor_height;
		this.actor_weight = actor_weight;
		this.actor_company = actor_company;
		this.actor_speciality = actor_speciality;
		this.actor_sns = actor_sns;
		this.actor_photo = actor_photo;
	}


	public String getMember_id() {
		return member_id;
	}


	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}


	public String getActor_no() {
		return actor_no;
	}


	public void setActor_no(String actor_no) {
		this.actor_no = actor_no;
	}


	public String getActor_age() {
		return actor_age;
	}


	public void setActor_age(String actor_age) {
		this.actor_age = actor_age;
	}


	public String getActor_education() {
		return actor_education;
	}


	public void setActor_education(String actor_education) {
		this.actor_education = actor_education;
	}


	public String getActor_height() {
		return actor_height;
	}


	public void setActor_height(String actor_height) {
		this.actor_height = actor_height;
	}


	public String getActor_weight() {
		return actor_weight;
	}


	public void setActor_weight(String actor_weight) {
		this.actor_weight = actor_weight;
	}


	public String getActor_company() {
		return actor_company;
	}


	public void setActor_company(String actor_company) {
		this.actor_company = actor_company;
	}


	public String getActor_speciality() {
		return actor_speciality;
	}


	public void setActor_speciality(String actor_speciality) {
		this.actor_speciality = actor_speciality;
	}


	public String getActor_sns() {
		return actor_sns;
	}


	public void setActor_sns(String actor_sns) {
		this.actor_sns = actor_sns;
	}


	public String getActor_photo() {
		return actor_photo;
	}


	public void setActor_photo(String actor_photo) {
		this.actor_photo = actor_photo;
	}


	@Override
	public String toString() {
		return "Actor [member_id=" + member_id + ", actor_no=" + actor_no + ", actor_age=" + actor_age
				+ ", actor_education=" + actor_education + ", actor_height=" + actor_height + ", actor_weight="
				+ actor_weight + ", actor_company=" + actor_company + ", actor_speciality=" + actor_speciality
				+ ", actor_sns=" + actor_sns + ", actor_photo=" + actor_photo + "]";
	}


	public int getTotalContents() {
		// TODO Auto-generated method stub
		return 0;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
