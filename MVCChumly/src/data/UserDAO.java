package data;

import java.util.List;
import java.util.function.Predicate;

import entities.Availability;
import entities.Interest;
import entities.InterestCategory;
import entities.Location;
import entities.User;
import entities.User.Role;

public interface UserDAO {
	public User show(int id);
	public User create(User film);
	public User update(int id, User film);
	public boolean destroy(int id);

	public List<User> index();
	public List<User> indexByRole(Role role);
	public List<User> indexByLocation(Location location);
	public List<User> indexByConnection(User connection);
	public List<User> indexByInterest(Interest interest);
	public List<User> indexByInterestCategory(InterestCategory category);
	public List<User> indexByAvailability(Availability availability);
	public <T> List<User> indexBy(Predicate<T> filter);
	
	
	public List<Availability> commonAvailability(User user, User other);
	public List<Interest> commonInterests(User user, User other);
	public List<InterestCategory> commonInterestCategories(User user, User other);

	public <T,R> List<R> commonBy(Predicate<T> test, User user, User other);
	
}
