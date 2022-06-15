package board.model.dto;

import java.sql.Date;

public class Report {
	
	private int no;
	private String memberId;
	private String reportContent;
	private int annNo;
	private int actor_no;
	private int boardNo;
	private int commentNo;
	private Date reportDate;
	private String reportStatus;
	
	public Report() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Report(int no, String memberId, String reportContent, int annNo, int actor_no, int boardNo, int commentNo,
			Date reportDate, String reportStatus) {
		super();
		this.no = no;
		this.memberId = memberId;
		this.reportContent = reportContent;
		this.annNo = annNo;
		this.actor_no = actor_no;
		this.boardNo = boardNo;
		this.commentNo = commentNo;
		this.reportDate = reportDate;
		this.reportStatus = reportStatus;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getReportContent() {
		return reportContent;
	}

	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}

	public int getAnnNo() {
		return annNo;
	}

	public void setAnnNo(int annNo) {
		this.annNo = annNo;
	}

	public int getActor_no() {
		return actor_no;
	}

	public void setActor_no(int actor_no) {
		this.actor_no = actor_no;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

	public Date getReportDate() {
		return reportDate;
	}

	public void setReportDate(Date reportDate) {
		this.reportDate = reportDate;
	}

	public String getReportStatus() {
		return reportStatus;
	}

	public void setReportStatus(String reportStatus) {
		this.reportStatus = reportStatus;
	}

	@Override
	public String toString() {
		return "Report [no=" + no + ", memberId=" + memberId + ", reportContent=" + reportContent + ", annNo=" + annNo
				+ ", actor_no=" + actor_no + ", boardNo=" + boardNo + ", commentNo=" + commentNo + ", reportDate="
				+ reportDate + ", reportStatus=" + reportStatus + "]";
	}

	
	
	
	
	
}
