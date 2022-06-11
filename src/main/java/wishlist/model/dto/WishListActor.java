package wishlist.model.dto;

public class WishListActor {
	private String memberId;
	private int actorNo;
	
	public WishListActor() {
		super();
		// TODO Auto-generated constructor stub
	}

	public WishListActor(String memberId, int actorNo) {
		super();
		this.memberId = memberId;
		this.actorNo = actorNo;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getActorNo() {
		return actorNo;
	}

	public void setActorNo(int actorNo) {
		this.actorNo = actorNo;
	}

	@Override
	public String toString() {
		return "WishListActor [memberId=" + memberId + ", actorNo=" + actorNo + "]";
	}
	
	
}
