package notice.model.dto;

import java.util.List;

public class NoticeExt extends Notice {
	private int attachCount;
	private int commentCount;
	private List<Attachment> attachments;

	
	public int getAttachCount() {
		return attachCount;
	}

	public void setAttachCount(int attachCount) {
		this.attachCount = attachCount;
	}
	
	public int getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}


	public List<Attachment> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<Attachment> attachments) {
		this.attachments = attachments;
	}

	
	@Override
	public String toString() {
		return "BoardExt [attachCount=" + attachCount + "attachments=" + attachments + "toString()=" + super.toString() + "]";
	}

	
	
}
