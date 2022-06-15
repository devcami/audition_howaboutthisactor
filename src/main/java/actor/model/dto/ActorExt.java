package actor.model.dto;

public class ActorExt extends Actor{

	private int attahcount;

	public int getAttahcount() {
		return attahcount;
	}

	public void setAttahcount(int attahcount) {
		this.attahcount = attahcount;
	}

	@Override
	public String toString() {
		return "ActorExt [attahcount=" + attahcount + ", toString()=" + super.toString() + "]";
	}
	
}
