package mypage.model.dto;

public class PortfolioWorkExt extends PortfolioWork {
	
	private PortAttachment attach1;
	private PortAttachment attach2;
	private PortAttachment attach3;
	
	public PortfolioWorkExt() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	public PortfolioWorkExt(PortAttachment attach1, PortAttachment attach2, PortAttachment attach3) {
		super();
		this.attach1 = attach1;
		this.attach2 = attach2;
		this.attach3 = attach3;
	}


	public PortAttachment getAttach1() {
		return attach1;
	}


	public void setAttach1(PortAttachment attach1) {
		this.attach1 = attach1;
	}


	public PortAttachment getAttach2() {
		return attach2;
	}


	public void setAttach2(PortAttachment attach2) {
		this.attach2 = attach2;
	}


	public PortAttachment getAttach3() {
		return attach3;
	}


	public void setAttach3(PortAttachment attach3) {
		this.attach3 = attach3;
	}



	@Override
	public String toString() {
		return "PortAttachmentExt [attach1=" + attach1 + ", attach2=" + attach2 + ", attach3=" + attach3 + super.toString() + "]";
	}
	
	
}
