package mypage.model.dto;

public class ActorInfoExt extends ActorInfo {
	private int applyAnnNo;

	public ActorInfoExt() {
		super();
	}

	public ActorInfoExt(String memberId, String actorName, int actorNo, String birth, int age, String education,
			double height, double weight, String company, String phone, String email, String speciality, String sns,
			int attachNo, PortAttachment attachment) {
		super(memberId, actorName, actorNo, birth, age, education, height, weight, company, phone, email, speciality, sns,
				attachNo, attachment);
	}
	
	public ActorInfoExt(ActorInfo actorInfo, int applyNo) {
		
	}
	
	public int getApplyAnnNo() {
		return applyAnnNo;
	}

	public void setApplyAnnNo(int applyAnnNo) {
		this.applyAnnNo = applyAnnNo;
	}

	@Override
	public String toString() {
		return "ActorInfoExt [applyAnnNo=" + applyAnnNo + "]";
	}
	
	
}
