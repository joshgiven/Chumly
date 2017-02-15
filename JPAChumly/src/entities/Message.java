package entities;

import java.sql.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Size;

@Entity
@Table(name="message")
public class Message {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name="message")
	@Size(max=256, message="Size.message.text")
	private String text;

	@Column(name="timestamp")
	//@Past(message="Past.message.timeStamp")
	private Date timeStamp;
	@ManyToOne(fetch=FetchType.EAGER, cascade={CascadeType.REMOVE})
	@JoinColumn(name="sender_id")
	private User sender;
	
	@OneToMany(fetch=FetchType.EAGER)
	@JoinTable( name="message_chum",
	            joinColumns=@JoinColumn(name="message_id"),
	            inverseJoinColumns=@JoinColumn(name="chum_id"))
	private List<User> recipients;

	public Message() { }

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Message [id=");
		builder.append(id);
		builder.append(", sender=");
		builder.append(sender);
		builder.append(", timeStamp=");
		builder.append(timeStamp);
		builder.append(", text=");
		builder.append(text.substring(0,20));
		builder.append("]");
		return builder.toString();
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Date getTimeStamp() {
		return timeStamp;
	}

	public void setTimeStamp(Date localDate) {
		this.timeStamp = localDate;
	}

	public User getSender() {
		return sender;
	}

	public void setSender(User sender) {
		this.sender = sender;
	}

	public int getId() {
		return id;
	}

	public List<User> getRecipients() {
		return recipients;
	}

	public void setRecipients(List<User> recipients) {
		this.recipients = recipients;
	}


}
