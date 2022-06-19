package notice.model.dto;

import java.util.List;

public class NoticeExt extends Notice {
	private int attachCount;
	private int commentCount;

	
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

	
	@Override
	public String toString() {
		return "BoardExt [attachCount=" + attachCount + "toString()=" + super.toString() + "]";
	}

	
	
}
