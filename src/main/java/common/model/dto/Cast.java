package common.model.dto;

public class Cast {
	private int castNo;
	private int workNo;
	private String castRole;
	private String castName;
	private String castContents;
	
	public Cast() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Cast(int castNo, int workNo, String castRole, String castName, String castContents) {
		super();
		this.castNo = castNo;
		this.workNo = workNo;
		this.castRole = castRole;
		this.castName = castName;
		this.castContents = castContents;
	}

	public int getCastNo() {
		return castNo;
	}

	public void setCastNo(int castNo) {
		this.castNo = castNo;
	}

	public int getWorkNo() {
		return workNo;
	}

	public void setWorkNo(int workNo) {
		this.workNo = workNo;
	}

	public String getCastRole() {
		return castRole;
	}

	public void setCastRole(String castRole) {
		this.castRole = castRole;
	}

	public String getCastName() {
		return castName;
	}

	public void setCastName(String castName) {
		this.castName = castName;
	}

	public String getCastContents() {
		return castContents;
	}

	public void setCastContents(String castContents) {
		this.castContents = castContents;
	}

	@Override
	public String toString() {
		return "Cast [castNo=" + castNo + ", workNo=" + workNo + ", castRole=" + castRole + ", castName=" + castName
				+ ", castContents=" + castContents + "]";
	}

	
	
}
