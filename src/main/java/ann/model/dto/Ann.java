package ann.model.dto;

import java.sql.Date;

public class Ann {
	private int annNo;
	private String memberId;
	private int workNo;
	private String annArea;
	private Date annEndDate;
	private Date annRegDate;
	private int annPay;
	private String annGender;
	private int annAge;
	private double annHeight;
	private String annBody;
	private String annTitle;
	
	
	public Ann() {
		super();
	}
	
	public Ann(int annNo, String memberId, int workNo, String annArea, Date annEndDate, Date annRegDate, int annPay,
			String annGender, int annAge, double annHeight, String annBody, String annTitle) {
		super();
		this.annNo = annNo;
		this.memberId = memberId;
		this.workNo = workNo;
		this.annArea = annArea;
		this.annEndDate = annEndDate;
		this.annRegDate = annRegDate;
		this.annPay = annPay;
		this.annGender = annGender;
		this.annAge = annAge;
		this.annHeight = annHeight;
		this.annBody = annBody;
		this.annTitle = annTitle;
	}

	public int getAnnNo() {
		return annNo;
	}
	public void setAnnNo(int annNo) {
		this.annNo = annNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public int getWorkNo() {
		return workNo;
	}
	public void setWorkNo(int workNo) {
		this.workNo = workNo;
	}
	public String getAnnArea() {
		return annArea;
	}
	public void setAnnArea(String annArea) {
		this.annArea = annArea;
	}
	public Date getAnnEndDate() {
		return annEndDate;
	}
	public void setAnnEndDate(Date annEndDate) {
		this.annEndDate = annEndDate;
	}
	public Date getAnnRegDate() {
		return annRegDate;
	}
	public void setAnnRegDate(Date annRegDate) {
		this.annRegDate = annRegDate;
	}
	public int getAnnPay() {
		return annPay;
	}
	public void setAnnPay(int annPay) {
		this.annPay = annPay;
	}
	public String getAnnGender() {
		return annGender;
	}
	public void setAnnGender(String annGender) {
		this.annGender = annGender;
	}
	public int getAnnAge() {
		return annAge;
	}
	public void setAnnAge(int annAge) {
		this.annAge = annAge;
	}
	public double getAnnHeight() {
		return annHeight;
	}
	public void setAnnHeight(double annHeight) {
		this.annHeight = annHeight;
	}
	public String getAnnBody() {
		return annBody;
	}
	public void setAnnBody(String annBody) {
		this.annBody = annBody;
	}
	public String getAnnTitle() {
		return annTitle;
	}
	public void setAnnTitle(String annTitle) {
		this.annTitle = annTitle;
	}

	@Override
	public String toString() {
		return "Ann [annNo=" + annNo + ", memberId=" + memberId + ", workNo=" + workNo + ", annArea=" + annArea
				+ ", annEndDate=" + annEndDate + ", annRegDate=" + annRegDate + ", annPay=" + annPay + ", annGender="
				+ annGender + ", annAge=" + annAge + ", annHeight=" + annHeight + ", annBody=" + annBody + ", annTitle="
				+ annTitle + "]";
	}
	
}
