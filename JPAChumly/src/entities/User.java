package entities;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.validator.constraints.Email;

@Entity
@Table(name="user")
public class User {

	public enum Role { ADMIN, USER }

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Size(min=2, max=20, message="Size.user.username")
	private String username;

	@Size(min=2, max=20, message="Size.user.password")
	private String password;

	@Email(message="Email.user.email")
	private String email;

	@Enumerated(EnumType.STRING)
	private Role role;

	@OneToOne(mappedBy="user", cascade={CascadeType.PERSIST, CascadeType.REMOVE})
	//@JoinColumn(name="id", referencedColumnName="user_id")
	private Profile profile;


	// would this delete other Users, or the just the row in the
	//  connection table???
	@OneToMany(/*cascade={CascadeType.PERSIST, CascadeType.REMOVE}*/)
	@LazyCollection(LazyCollectionOption.FALSE)
	@JoinTable( name="connection",
	            joinColumns=@JoinColumn(name="user_id"),
	            inverseJoinColumns=@JoinColumn(name="chum_id") )
	private List<User> connections;

	@ManyToMany( fetch=FetchType.EAGER, cascade={CascadeType.REMOVE} )
	@JoinTable( name="user_interest",
	            joinColumns=@JoinColumn(name="user_id"),
	            inverseJoinColumns=@JoinColumn(name="interest_id") )
	private List<Interest> interests;

	@OneToMany(cascade={CascadeType.PERSIST, CascadeType.REMOVE})
	@JoinColumn(name="user_id", referencedColumnName="id")
	private List<Availability> availabilities;

	public User() { }

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("User [id=");
		builder.append(id);
		builder.append(", username=");
		builder.append(username);
		builder.append(", role=");
		builder.append(role);
		builder.append("]");
		return builder.toString();
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Profile getProfile() {
		return profile;
	}

	public void setProfile(Profile profile) {
		this.profile = profile;

//		if(profile != null)
//			profile.setUser(this);
	}

	public int getId() {
		return id;
	}

	public List<User> getConnections() {
		return connections;
	}

	public void setConnections(List<User> connections) {
		this.connections = connections;
	}

//	public List<Message> getChumMessages() {
//		return chumMessages;
//	}
//
//	public void setChumMessages(List<Message> chumMessages) {
//		this.chumMessages = chumMessages;
//	}

//	public List<Message> getMessages() {
//		return messages;
//	}
//
//	public void setMessages(List<Message> messages) {
//		this.messages = messages;
//	}

	public List<Interest> getInterests() {
		return interests;
	}

	public void setInterests(List<Interest> interests) {
		this.interests = interests;
	}

	public List<Availability> getAvailabilities() {
		return availabilities;
	}

	public void setAvailabilities(List<Availability> availabilities) {
		this.availabilities = availabilities;
	}

//	public Boolean hasConnection(Integer id){
//		return true;
//	}

}
