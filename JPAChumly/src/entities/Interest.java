package entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="interest")
public class Interest {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private InterestCategory category;
	
	public Interest() { }

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Interest [id=");
		builder.append(id);
		builder.append(", name=");
		builder.append(name);
		builder.append(", category=");
		builder.append(category);
		builder.append("]");
		return builder.toString();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public InterestCategory getCategory() {
		return category;
	}

	public void setCategory(InterestCategory category) {
		this.category = category;
	}

	public int getId() {
		return id;
	}
	
}
