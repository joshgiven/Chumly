package data;

import java.util.Date;
import java.util.List;
import java.util.function.Predicate;

import entities.Message;
import entities.User;

public interface MessageDAO {
	public Message show(int id);
	public Message create(Message film);
	public Message update(int id, Message film);
	public boolean destroy(int id);

	public List<Message> indexBySender(User sender);
	public List<Message> indexByRecipient(User recipient);
	public List<Message> indexByDateRange(Date beginDate, Date endDate);
	public List<Message> indexByContainsText(String text);
	public <T> List<Message> indexBy(Predicate<T> filter);
}