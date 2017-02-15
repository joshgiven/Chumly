package data;

import java.util.Date;
import java.util.List;

import entities.Message;
import entities.User;

public interface MessageDAO {
	public Message show(int id);
	public Message create(Message message);
	public Message update(int id, Message message);
	public boolean destroy(int id);

	public List<Message> indexByConversation(User recipient, User sender);
	public List<Message> indexBySender(User sender);
	public List<Message> indexByRecipient(User recipient);
	public List<Message> indexByDateRange(Date beginDate, Date endDate);
	public List<Message> indexByContainsText(String text);
	
	public List<User> indexByMessageHistory(User user);
}
