package mypage.model.dto;

public class PortfolioWork {
	private int no;
	private String memberId;
	private String title;
	private String period;
	private String myrole;
	private String videolink;
	private PortAttachment attachment;
	
	public PortfolioWork() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PortfolioWork(int no, String memberId, String title, String period, String myrole, String videolink,
			PortAttachment attachment) {
		super();
		this.no = no;
		this.memberId = memberId;
		this.title = title;
		this.period = period;
		this.myrole = myrole;
		this.videolink = videolink;
		this.attachment = attachment;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPeriod() {
		return period;
	}

	public void setPeriod(String period) {
		this.period = period;
	}

	public String getMyrole() {
		return myrole;
	}

	public void setMyrole(String myrole) {
		this.myrole = myrole;
	}

	public String getVideolink() {
		return videolink;
	}

	public void setVideolink(String videolink) {
		this.videolink = videolink;
	}

	public PortAttachment getAttachment() {
		return attachment;
	}

	public void setAttachment(PortAttachment attachment) {
		this.attachment = attachment;
	}


	@Override
	public String toString() {
		return "PortfolioWork [no=" + no + ", memberId=" + memberId + ", title=" + title + ", period=" + period
				+ ", myrole=" + myrole + ", videolink=" + videolink + ", attachment=" + attachment + "]";
	}
	
	
	

	
	
}
