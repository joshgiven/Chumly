package entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.Size;

@Entity
@Table(name="profile")
public class Profile {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name="first_name")
	@Size(min=1, max=20, message="Size.profile.firstName")
	private String firstName;

	@Column(name="last_name")
	@Size(min=2, max=20, message="Size.profile.lastName")
	private String lastName;

	@Size(max=256, message="Size.profile.description")
	private String description;

	@Column(name="image_url")
	@Size(max=128, message="Size.profile.imageURL")
	private String imageURL;

	@OneToOne
	@JoinColumn(name="location_id")
	private Location location;

	@OneToOne
	@JoinColumn(name="user_id")
	private User user;

	public Profile() { }

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Profile [id=");
		builder.append(id);
		builder.append(", firstName=");
		builder.append(firstName);
		builder.append(", lastName=");
		builder.append(lastName);
		builder.append(", description=");
		builder.append(description.substring(0, 20));
		builder.append(", location=");
		builder.append(location);
		builder.append("]");
		return builder.toString();
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImageURL() {
		return imageURL;
	}

	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}

	public Location getLocation() {
		return location;
	}

	public void setLocation(Location location) {
		this.location = location;
	}

	public int getId() {
		return id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
