package mypage.model.dto;

import java.sql.Date;

public class PortAttachmentExt extends PortAttachment {
	
	private int workNo;

	public PortAttachmentExt() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PortAttachmentExt(int no, String memberId, String originalFilename, String renamedFilename,
			String attachType, Date regDate) {
		super(no, memberId, originalFilename, renamedFilename, attachType, regDate);
		// TODO Auto-generated constructor stub
	}

	public PortAttachmentExt(int workNo) {
		super();
		this.workNo = workNo;
	}

	public int getWorkNo() {
		return workNo;
	}

	public void setWorkNo(int workNo) {
		this.workNo = workNo;
	}

	@Override
	public String toString() {
		return "PortAttachmentExt [workNo=" + workNo + super.toString() +"]";
	}
	
	
	
	

}
