package common.model.dto;

import java.util.List;

public class Work {
	private int workNo;
	private String workField;
	private String title;
	private String production;
	private String director;
	private String description;
	private List<WorkAttachment> attachments;
	private Cast cast;

	public Work() {
		super();
	}

	public Work(int workNo, String workField, String title, String production, String director, String description,
			List<WorkAttachment> attachments, Cast cast) {
		super();
		this.workNo = workNo;
		this.workField = workField;
		this.title = title;
		this.production = production;
		this.director = director;
		this.description = description;
		this.attachments = attachments;
		this.cast = cast;
	}

	public int getWorkNo() {
		return workNo;
	}

	public void setWorkNo(int workNo) {
		this.workNo = workNo;
	}

	public String getWorkField() {
		return workField;
	}

	public void setWorkField(String workField) {
		this.workField = workField;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getProduction() {
		return production;
	}

	public void setProduction(String production) {
		this.production = production;
	}

	public String getDirector() {
		return director;
	}

	public void setDirector(String director) {
		this.director = director;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<WorkAttachment> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<WorkAttachment> attachments) {
		this.attachments = attachments;
	}

	public Cast getCast() {
		return cast;
	}

	public void setCast(Cast cast) {
		this.cast = cast;
	}

	@Override
	public String toString() {
		return "Work [workNo=" + workNo + ", workField=" + workField + ", title=" + title + ", production=" + production
				+ ", director=" + director + ", description=" + description + ", attachments=" + attachments + ", cast="
				+ cast + "]";
	}

	
	
}