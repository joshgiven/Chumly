package entities;

import java.sql.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="message")
public class Message {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name="message")
	private String text;

	@Column(name="timestamp")
	private Date timeStamp;

	@ManyToOne
	@JoinColumn(name="sender_id")
	private User sender;
	
	@OneToMany
	@JoinTable(name="message_chum",
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

	public void setTimeStamp(Date timeStamp) {
		this.timeStamp = timeStamp;
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
