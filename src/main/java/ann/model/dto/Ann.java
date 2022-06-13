package ann.model.dto;

import java.sql.Date;

import com.oreilly.servlet.MultipartRequest;

import common.model.dto.Work;

public class Ann {
	private int annNo;
	private String memberId;
	private int workNo;
	private String annTitle;
	private String annArea;
	private Date annEndDate;
	private Date annRegDate;
	private String annPay;
	private String annGender; // '남' '여' '무관'
	private String annAge;	  // ~10세 11~17세 18~25세 26세~35세 36세~45세 45세~ 연령무관
	private String annHeight; // ~110 111~150 151~160 161~170 171~180 180~ 신장무관
	private String annBody;   // 마름 보통 통통 체형무관
	private int annNop;
	private String isClose;
	private String hasTO;
	private Work work;
	
	
	public Ann() {
		super();
	}


	public Ann(int annNo, String memberId, int workNo, String annTitle, String annArea, Date annEndDate,
			Date annRegDate, String annPay, String annGender, String annAge, String annHeight, String annBody,
			int annNop, String isClose, String hasTO, Work work) {
		super();
		this.annNo = annNo;
		this.memberId = memberId;
		this.workNo = workNo;
		this.annTitle = annTitle;
		this.annArea = annArea;
		this.annEndDate = annEndDate;
		this.annRegDate = annRegDate;
		this.annPay = annPay;
		this.annGender = annGender;
		this.annAge = annAge;
		this.annHeight = annHeight;
		this.annBody = annBody;
		this.annNop = annNop;
		this.isClose = isClose;
		this.hasTO = hasTO;
		this.work = work;
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


	public String getAnnTitle() {
		return annTitle;
	}


	public void setAnnTitle(String annTitle) {
		this.annTitle = annTitle;
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


	public String getAnnPay() {
		return annPay;
	}


	public void setAnnPay(String annPay) {
		this.annPay = annPay;
	}


	public String getAnnGender() {
		return annGender;
	}


	public void setAnnGender(String annGender) {
		this.annGender = annGender;
	}


	public String getAnnAge() {
		return annAge;
	}


	public void setAnnAge(String annAge) {
		this.annAge = annAge;
	}


	public String getAnnHeight() {
		return annHeight;
	}


	public void setAnnHeight(String annHeight) {
		this.annHeight = annHeight;
	}


	public String getAnnBody() {
		return annBody;
	}


	public void setAnnBody(String annBody) {
		this.annBody = annBody;
	}


	public Work getWork() {
		return work;
	}


	public void setWork(Work work) {
		this.work = work;
	}

	

	public int getAnnNop() {
		return annNop;
	}


	public void setAnnNop(int annNop) {
		this.annNop = annNop;
	}


	public String getIsClose() {
		return isClose;
	}


	public void setIsClose(String isClose) {
		this.isClose = isClose;
	}

	
	public String getHasTO() {
		return hasTO;
	}


	public void setHasTO(String hasTO) {
		this.hasTO = hasTO;
	}


	@Override
	public String toString() {
		return "Ann [annNo=" + annNo + ", memberId=" + memberId + ", workNo=" + workNo + ", annTitle=" + annTitle
				+ ", annArea=" + annArea + ", annEndDate=" + annEndDate + ", annRegDate=" + annRegDate + ", annPay="
				+ annPay + ", annGender=" + annGender + ", annAge=" + annAge + ", annHeight=" + annHeight + ", annBody="
				+ annBody + ", annNop=" + annNop + ", isClose=" + isClose + ", hasTO=" + hasTO + ", work=" + work + "]";
	}


	

	
	
}
