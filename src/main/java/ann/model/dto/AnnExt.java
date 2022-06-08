package ann.model.dto;

import java.sql.Date;

import common.model.dto.Work;

public class AnnExt extends Ann {
	private Work work;

	public AnnExt() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AnnExt(int annNo, String memberId, int workNo, String annArea, Date annEndDate, Date annRegDate, int annPay,
			String annGender, int annAge, double annHeight, String annBody, String annTitle) {
		super(annNo, memberId, workNo, annArea, annEndDate, annRegDate, annPay, annGender, annAge, annHeight, annBody,
				annTitle);
		// TODO Auto-generated constructor stub
	}

	public AnnExt(Work work) {
		super();
		this.work = work;
	}

	public Work getWork() {
		return work;
	}

	public void setWork(Work work) {
		this.work = work;
	}

	@Override
	public String toString() {
		return "AnnExt [work=" + work + "]";
	}
	
	
}
