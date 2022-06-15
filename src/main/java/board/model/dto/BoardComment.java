package board.model.dto;

import java.sql.Date;

public class BoardComment {
	
	private int no;
	private int board_no; 
	private String memberId;
	private String content;
	private int commentRef;  // 댓글 null, 대댓글인 경우 참조댓글 no
	private Date regDate;
	
	public BoardComment() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BoardComment(int no, int commentLevel, String member_id, String content, int boardNo, int commentRef,
			Date regDate) {
		super();
		this.no = no;
		this.memberId = member_id;
		this.content = content;
		this.board_no = boardNo;
		this.commentRef = commentRef;
		this.regDate = regDate;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getBoardNo() {
		return board_no;
	}
	public void setBoardNo(int boardNo) {
		this.board_no = boardNo;
	}
	public int getCommentRef() {
		return commentRef;
	}
	public void setCommentRef(int commentRef) {
		this.commentRef = commentRef;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "BoardComment [no=" + no + ", memberId=" + memberId + ", content="
				+ content + ", boardNo=" + board_no + ", commentRef=" + commentRef + ", regDate=" + regDate + "]";
	}
	
	
	
}
