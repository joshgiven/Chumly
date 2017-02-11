package entities;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="user")
public class User {

	public enum Role { ADMIN, USER }

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String username;

	private String password;

	private String email;

	@Enumerated(EnumType.STRING)
	private Role role;

	@OneToOne( mappedBy="user"
			, cascade={CascadeType.PERSIST, CascadeType.REMOVE} 
	)
	private Profile profile;

	@OneToMany( /*cascade={CascadeType.PERSIST, CascadeType.REMOVE}*/ )
	@JoinTable( name="connection",
	            joinColumns=@JoinColumn(name="user_id"),
	            inverseJoinColumns=@JoinColumn(name="chum_id") )
	private List<User> connections;

//	@OneToMany
//	@JoinTable(name="message_chum",
//	joinColumns=@JoinColumn(name="message_id"),
//	inverseJoinColumns=@JoinColumn(name="chum_id"))
//	private List<Message> chumMessages;
//
	@OneToMany(mappedBy="recipients")
	private List<Message> messages;


//	private List<Group> groups;

	@ManyToMany( /*cascade={CascadeType.PERSIST, CascadeType.REMOVE}*/ )
	@JoinTable( name="user_interest",
	            joinColumns=@JoinColumn(name="user_id"),
	            inverseJoinColumns=@JoinColumn(name="interest_id") )
	private List<Interest> interests;

	@OneToMany( mappedBy="user" , cascade={CascadeType.PERSIST, CascadeType.REMOVE} )
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

	public Profile getProfile() {
		return profile;
	}

	public void setProfile(Profile profile) {
		this.profile = profile;
		
		if(profile != null)
			profile.setUser(this);
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
//
	public List<Message> getMessages() {
		return messages;
	}

	public void setMessages(List<Message> messages) {
		this.messages = messages;
	}

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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
