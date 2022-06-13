package wishlist.model.dto;

public class WishListAnn {
	private String memberId;
	private int annNo;
	
	public WishListAnn() {
		super();
		// TODO Auto-generated constructor stub
	}

	public WishListAnn(String memberId, int annNo) {
		super();
		this.memberId = memberId;
		this.annNo = annNo;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getAnnNo() {
		return annNo;
	}

	public void setAnnNo(int annNo) {
		this.annNo = annNo;
	}

	@Override
	public String toString() {
		return "WishListAnn [memberId=" + memberId + ", annNo=" + annNo + "]";
	}
	
	
}
