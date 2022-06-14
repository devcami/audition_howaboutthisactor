package common.model.dto;

import java.sql.Date;

public class WorkAttachment {
	private int workAttachmentNo;
	private int workNo;
	private String originalFilename;
	private String renamedFilename;
	private Date regDate;
	
	public WorkAttachment() {
		super();
	}
	
	public WorkAttachment(int workAttachmentNo, int workNo, String originalFilename, String renamedFilename,
			Date regDate) {
		super();
		this.workAttachmentNo = workAttachmentNo;
		this.workNo = workNo;
		this.originalFilename = originalFilename;
		this.renamedFilename = renamedFilename;
		this.regDate = regDate;
	}

	public int getWorkAttachmentNo() {
		return workAttachmentNo;
	}

	public void setWorkAttachmentNo(int workAttachmentNo) {
		this.workAttachmentNo = workAttachmentNo;
	}

	public int getWorkNo() {
		return workNo;
	}

	public void setWorkNo(int workNo) {
		this.workNo = workNo;
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

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "WorkAttachment [workAttachmentNo=" + workAttachmentNo + ", workNo=" + workNo + ", originalFilename="
				+ originalFilename + ", renamedFilename=" + renamedFilename + ", regDate=" + regDate + "]";
	}

	
	
}
