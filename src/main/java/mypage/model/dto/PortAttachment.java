package mypage.model.dto;

import java.sql.Date;

public class PortAttachment {
	private int no;
	private String memberId;
	private String originalFilename;
	private String renamedFilename;
	private String attachType;
	private Date regDate;
	
	public PortAttachment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PortAttachment(int no, String memberId, String originalFilename, String renamedFilename, String attachType,
			Date regDate) {
		super();
		this.no = no;
		this.memberId = memberId;
		this.originalFilename = originalFilename;
		this.renamedFilename = renamedFilename;
		this.attachType = attachType;
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

	public String getOriginalFilename() {
		return originalFilename;
	}

	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}

	public String getRenamedFilename() {
		return renamedFilename;
	}

	public void setRenamedFilename(String renamedFilename) {
		this.renamedFilename = renamedFilename;
	}

	public String getAttachType() {
		return attachType;
	}

	public void setAttachType(String attachType) {
		this.attachType = attachType;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "PortAttachment [no=" + no + ", memberId=" + memberId + ", originalFilename=" + originalFilename
				+ ", renamedFilename=" + renamedFilename + ", attachType=" + attachType + ", regDate=" + regDate + "]";
	}
	
	
	
}
