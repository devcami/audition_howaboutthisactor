package board.model.dto;

import java.sql.Date;

public class Board {
	private int no;
	private String title;
	private String memberId;
	private String content;
	private int readCount;
	private Date regDate;
	
	public Board() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Board(int no, String title, String memberId, String content, int readCount, Date regDate) {
		super();
		this.no = no;
		this.title = title;
		this.memberId = memberId;
		this.content = content;
		this.readCount = readCount;
		this.regDate = regDate;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "Board [no=" + no + ", title=" + title + ", memberId=" + memberId + ", content=" + content
				+ ", readCount=" + readCount + ", regDate=" + regDate + "]";
	}
	
}
