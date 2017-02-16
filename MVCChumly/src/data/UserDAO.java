package data;

import java.util.List;
import java.util.function.Predicate;

import entities.Availability;
import entities.Interest;
import entities.InterestCategory;
import entities.Location;
import entities.Profile;
import entities.User;
import entities.User.Role;

public interface UserDAO {
	public User show(int id);
	public User create(User user);
	public User updateUser(int id, User user);
	public User updateUserProfile(int id, User user);
	public User getUserByUsername(String username);
	public User getUserByEmail(String email);
	public User updateUserProfileDescription(String description, Integer id);
	public boolean destroy(int id);
	public User updateInterest(int id, User user);

	public List<User> index();
	public List<User> indexByRole(Role role);
	public List<User> indexByLocation(Location location);
	public List<User> indexByConnection(User connection);
	public List<User> indexByInterestId(int id);
	public List<User> indexByInterest(Interest interest);
	public List<User> indexByInterest(String interestName);
	public List<User> indexByInterestCategory(InterestCategory category);
	public List<User> indexByAvailability(Availability availability);
	public List<User> indexBy(Predicate<User> filter);
	
	
	public List<Availability> commonAvailability(User user, User other);
	public List<Interest> commonInterests(User user, User other);
	public List<InterestCategory> commonInterestCategories(User user, User other);
	User updateConnection(int id, User user);	
}
