package controllers;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import data.InterestDAO;
import data.LocationDAO;
import data.MessageDAO;
import data.UserDAO;
import entities.Interest;
import entities.Location;
import entities.Message;
import entities.Profile;
import entities.User;
import entities.User.Role;

@Controller
@SessionAttributes(names = { "sessionUser" })
public class UserController {

	@Autowired
	UserDAO udao;

	@Autowired
	MessageDAO mdao;

	@Autowired
	InterestDAO idao;

	@Autowired
	LocationDAO ldao;

	private static String VIEW_ADMIN_HOME     = "adminhome";
	private static String VIEW_CREATE_PROFILE = "createprofile";
	private static String VIEW_INDEX          = "index";
	private static String VIEW_MESSAGE        = "message";
	private static String VIEW_NEW_USER       = "newuser";
	private static String VIEW_OTHER_USER     = "otheruser";
	private static String VIEW_PROFILE        = "profile";
	private static String VIEW_RESULTS        = "results";
	private static String VIEW_UPDATE_PROFILE = "updateprofile";


	@ModelAttribute(name = "sessionUser")
	public User sessionUserFactory() {
		return new User();
	}

	@ModelAttribute(name = "user")
	public User defaultUserFactory() {
		return new User();
	}

	@ModelAttribute(name = "profile")
	public Profile defaultProfileFactory() {
		return new Profile();
	}

	@RequestMapping(path = "home.do", method = RequestMethod.GET)
	public String welcome(Model model) {
		String quote = addQuote();
		model.addAttribute("quote", quote);
		if(model.containsAttribute("sessionUser")) {
			User u = (User) model.asMap().get("sessionUser");
			if(u != null && u.getUsername() != null) {
				return VIEW_PROFILE;
			}
		}
		return VIEW_INDEX;
	}

	@RequestMapping(method = RequestMethod.GET, path = "logout.do")
	public String logout(Model model) {
		String quote = addQuote();
		model.addAttribute("quote", quote);
		model.asMap().remove("sessionUser");
		return VIEW_INDEX;
	}
	
	@RequestMapping(method = RequestMethod.GET, path = "admin.do")
	public String adminHome(Model model) {
		User sessionUser = (User) model.asMap().get("sessionUser");
		if(sessionUser == null || sessionUser.getRole() != Role.ADMIN ) {
			return "redirect:home.do";
		}
		
		model.addAttribute("categories", idao.indexCategories());
		model.addAttribute("users", udao.index());
		
		return VIEW_ADMIN_HOME;
	}

	@RequestMapping(method = RequestMethod.POST, path = "login.do")
	public String login(@Valid User user, Errors errors, Model model) {
		String quote = addQuote();
		model.addAttribute("quote", quote);
		if (errors.hasErrors()) {
			return VIEW_INDEX;
		}

		User u = udao.getUserByUsername(user.getUsername());
		if (u != null) {
			if (u.getPassword().equals(user.getPassword())) {
				if (u.getRole() == Role.ADMIN) {
					model.addAttribute("sessionUser", u);
					model.addAttribute("categories", idao.indexCategories());
					model.addAttribute("users", udao.index());
					return "redirect:admin.do";
				}

				model.addAttribute("sessionUser", u);
				return "redirect:home.do";
			} 
			else {
				// bad password
				errors.rejectValue("password", "error.password",
						"Invalid password");
				return VIEW_INDEX;
			}
		}
		else {
			// bad username
			errors.rejectValue("username", "error.username",
					"The username you entered is not associated with an account, please try another");
			return VIEW_INDEX;
		}
	}

	@RequestMapping(method = RequestMethod.GET, path = "getUpdateProfile.do")
	public String getUpdateProfile(Model model) {
		List<Interest> interests = idao.index();
		model.addAttribute("interests", interests);
		return VIEW_UPDATE_PROFILE;
	}

	@RequestMapping(method = RequestMethod.GET, path = "getUsersByInterest.do")
	public String searchByInterest(String interest, Model model) {

		List<User> users = udao.indexByInterest(interest);

		model.addAttribute("interest", interest);
		model.addAttribute("users", users);

		return VIEW_RESULTS;
	}

	@RequestMapping(method = RequestMethod.POST, path = "deleteProfile.do")
	public String deleteProfile(Model model) {
		User sessionUser = (User) model.asMap().get("sessionUser");
		udao.destroy(sessionUser.getId());
		//return VIEW_INDEX;
		return "redirect:home.do";
	}

	@RequestMapping(method = RequestMethod.GET, path = "getOtherUserProfileInformation.do")
	public String getUpdateProfile(Integer id, Model model) {
		User user = udao.show(id);
		model.addAttribute("user", user);
		return VIEW_OTHER_USER;
	}

	@RequestMapping(method = RequestMethod.GET, path = "messageUser.do")
	public String getUserMessage(Integer id, Model model) {
		User sessionUser = (User) model.asMap().get("sessionUser");
		if(sessionUser == null) {
			return "redirect:home.do";
		}

		User recipient = udao.show(id);
		//User sessionUser = (User) model.asMap().get("sessionUser");

		List<Message> messages = null;
		messages = mdao.indexByConversation(recipient, sessionUser);

		model.addAttribute("sender", sessionUser);
		model.addAttribute("recipient", recipient);
		model.addAttribute("messages", messages);

		return VIEW_MESSAGE;
	}

	@RequestMapping(method = RequestMethod.POST, path = "updateProfileDescription.do")
	public String updateProfileDescription(String description, Integer id, Model model) {
		User sessionUser = udao.updateUserProfileDescription(description, id);
		model.addAttribute("sessionUser", sessionUser);

		return "redirect:home.do#tab_update";
	}

	@RequestMapping(method = RequestMethod.POST, path = "updateCorrespondence.do")
	public String updateCorrespondence(
			@ModelAttribute(name="sessionUser") User sessionUser, 
			RedirectAttributes redirectAttributes) {
		//User sessionUser = mdao.updateUserProfileDescription(description, id);
		//model.addAttribute("sessionUser", sessionUser);
		List<User> corres = mdao.indexByMessageHistory(sessionUser);
		redirectAttributes.addFlashAttribute("correspondents", corres);

		return "redirect:home.do#tab_messages";
	}
	
	
	
	@RequestMapping(method = RequestMethod.POST, path = "addMessage.do")
	public String addMessage(Integer sessionId, Integer recipientId, String message, Model model) {
		User sessionUser = udao.show(sessionId);
		User recipient = udao.show(recipientId);

		Message newMessage = new Message();

		if (newMessage.getRecipients() == null) {
			List<User> recipients = new ArrayList<>();
			newMessage.setRecipients(recipients);
		}

		newMessage.getRecipients().add(recipient);
		newMessage.setSender(sessionUser);
		newMessage.setText(message);
		newMessage.setTimeStamp(new Date(new java.util.Date().toInstant().toEpochMilli()));

		newMessage = mdao.create(newMessage);

		return "redirect:messageUser.do?id=" + recipientId;
	}

	@RequestMapping(method = RequestMethod.GET, path = "connectToUser.do")
	public String addInterest(Integer userId, Integer sessionId, Model model) {
		User sessionUser = udao.show(sessionId);
		User friend = udao.show(userId);
		//List<User> connections = null;

		if(sessionUser.getConnections() == null) {
			sessionUser.setConnections(new ArrayList<>());
		}
		sessionUser.getConnections().add(friend);

		if(friend.getConnections() == null) {
			friend.setConnections(new ArrayList<>());
		}
		friend.getConnections().add(sessionUser);
		
		udao.updateConnection(sessionId, sessionUser);
		udao.updateConnection(userId, friend);

		model.addAttribute("user", friend);
		model.addAttribute("sessionUser", sessionUser);

		return VIEW_OTHER_USER;
	}

	@RequestMapping(method = RequestMethod.GET, path = "createUser.do")
	public String createUser(Model model) {
		model.addAttribute("sessionUser", new User());
		return VIEW_NEW_USER;
	}

	@RequestMapping(method = RequestMethod.POST, path = "makeUser.do")
	public String makeUser(@Valid User user, Errors errors, Model model) {
		if(errors.hasErrors()) {
			return VIEW_NEW_USER;
		}
		
		if(udao.getUserByEmail(user.getEmail()) != null) {
			errors.rejectValue("email", "error.email",
					"A user with this email address already exists");
			return VIEW_NEW_USER;
		}
		
		if(udao.getUserByUsername(user.getUsername()) != null) {
			errors.rejectValue("username", "error.username",
					"A user with this username already exists");
			return VIEW_NEW_USER;
		}
		
		Profile profile = new Profile();
		user.setProfile(profile);
		User sessionUser = udao.create(user);
		
		model.addAttribute("sessionUser", sessionUser);
		//model.addAttribute("locations", ldao.index());
		//model.addAttribute("location", ldao.mapByState());

		//return VIEW_CREATE_PROFILE;
		return "redirect:editProfile.do";
	}

	@RequestMapping(method = RequestMethod.GET, path = "editProfile.do")
	public String editProfileForm(/*Integer id, */ Model model) {
		User sessionUser = (User) model.asMap().get("sessionUser");
		if(sessionUser == null) {
			return "redirect:home.do";
		}
		
		model.addAttribute("locations", ldao.index());
		model.addAttribute("location", ldao.mapByState());
		//model.addAttribute("sessionUser", sessionUser);
		return VIEW_CREATE_PROFILE;
	}
	
	@RequestMapping(method = RequestMethod.POST, path = "updateProfile.do")
	public String updateProfile(Integer id, Integer locationId, @Valid Profile profile, Errors errors, Model model) {
		if(id == null) {
			User sessionUser = (User) model.asMap().get("sessionUser");
			if(sessionUser != null) {
				id = sessionUser.getId();
			}
		}
		
		if(id == null || locationId == null || profile == null) {
			// ???
			return "redirect:home.do";
		}
		
//		System.out.println(id);
//		System.out.println(profile);
//		System.out.println(locationId);
		
		if(errors.hasErrors()) {
			return VIEW_CREATE_PROFILE;
		}
		
		Location location = ldao.show(locationId);
		if(location == null) {
			errors.rejectValue("locationId", "locationId", "invalid location");
			return VIEW_CREATE_PROFILE;
		}
		
		profile.setLocation(location);
		profile.setUser(udao.show(id));
		
		User sessionUser = udao.show(id);
		sessionUser.setProfile(profile);
		sessionUser = udao.updateUserProfile(sessionUser.getId(), sessionUser);
		model.addAttribute("sessionUser", sessionUser);

		return "redirect:home.do";
		//return "redirect:editProfile.do";
	}

	@RequestMapping(method = RequestMethod.GET, path = "searchInterest.do")
	public String searchInterest(String name, Model model, RedirectAttributes redirectAttributes) {

		List<Interest> interests = idao.indexByContainsText(name);
		//model.addAttribute("interests", interests);
		//return VIEW_PROFILE;

		redirectAttributes.addFlashAttribute("interests", interests);
		return "redirect:home.do#tab_interests";
	}

	@RequestMapping(method = RequestMethod.POST, path = "addInterest.do")
	public String addInterest(Integer id, Model model, Integer userId) {
		if(id == null || userId == null) {
			// dunno what to do here...
			return "redirect:home.do#tab_interests";
		}
		
		User sessionUser = udao.show(userId);
		Interest interest = idao.show(id);
		
		if(sessionUser.getInterests() == null) {
			sessionUser.setInterests(new ArrayList<>());
		}
		sessionUser.getInterests().add(interest);
		
		sessionUser = udao.updateInterest(userId, sessionUser);
		model.addAttribute("sessionUser", sessionUser);

		return "redirect:home.do#tab_interests";
	}

	@RequestMapping(method = RequestMethod.POST, path = "deleteUser.do")
	public String deleteUser(Integer id, Integer sessionId, Model model) {
		udao.destroy(id);
		if (sessionId != null) {
			model.addAttribute("categories", idao.indexCategories());
			model.addAttribute("users", udao.index());
			return "adminhome";
		}
		return "redirect:home.do";
	}

	@RequestMapping(method = RequestMethod.POST, path = "createInterest.do")
	public String createInterest(Integer id, String interest, Model model) {
		User sessionUser = (User) model.asMap().get("sessionUser");
		if(sessionUser == null || sessionUser.getRole() != Role.ADMIN ) {
			return "redirect:home.do";
		}
		
		idao.create(id, interest);

		model.addAttribute("categories", idao.indexCategories());
		model.addAttribute("users", udao.index());
		return "redirect:admin.do";
	}
	
	public String addQuote(){
		List<String> quotes = new ArrayList<>();
		quotes.add("There is nothing better than a friend, unless it is a friend with chocolate.-Linda Grayson");
		quotes.add("It is one of the blessings of old friends that you can afford to be stupid with them.-Ralph Waldo Emerson");
		quotes.add("It is more fun to talk with someone who doesn’t use long, difficult words but rather short, easy words like ‘What about lunch?’-A.A. Milne, Winnie-the-Pooh.");
		quotes.add("Friends are people who know you really well and like you anyway.-Greg Tamblyn");
		quotes.add("It’s the friends you can call up at 4 a.m. that matter.-Marlene Dietrich");
		quotes.add("A true friend sticks with you through thick and thin no matter what.");
		quotes.add("Friends give you a shoulder to cry on. But best friends are ready with a shovel to hurt the person that made you cry.");
		quotes.add("Friends are like snowflakes, none of them are the same!");
		quotes.add("Lots of people want to ride with you in the limo, but what you want is someone who will take the bus with you when the limo breaks down.-Oprah Winfrey");
		quotes.add("When a friend is in trouble, don’t annoy him by asking if there is anything you can do. Think up something appropriate and do it.");
		quotes.add("A friend is someone who is there for you when she would rather be somewhere else.");
		quotes.add("Friends never make assumptions about you. They never expect a reason to go out with you. In fact friends only expect you to be you.");
		quotes.add("A friend knows the song in my heart and sings it to me when my memory fails.");
		quotes.add("Sometimes me think, ‘What is friend?’ Then me say, ‘Friend is someone to share the last cookie with.’-Cookie Monster");
		quotes.add("A road to a friend’s house is never long.");
		quotes.add("One measure of friendship consists not in the number of things friends can discuss, but in the number of things they need no longer mention.-Clifton Fadiman");
		quotes.add("Friends are the most important ingredient in this recipe of life.");
		quotes.add("Some people come into our lives and quickly go. Some stay for awhile and leave footprints on our hearts. And we are never, ever the same.");
		quotes.add("A friend will bail you out of jail a best friend will be sitting next to you saying “that was great”!");
		quotes.add("Only your real friends tell you when your face is dirty.");
		quotes.add("Your friend is the person who knows all about you, and still likes you.");
		quotes.add("Who finds a faithful friend, finds a treasure.");
		quotes.add("True friendship is when two friends can walk in opposite directions, yet remain side by side.");
		quotes.add("Side by side or miles apart, dear friends are always close to the heart.");
		quotes.add("A real friend is one who walks in when the rest of the world walks out.");
		quotes.add("There are big ships and small ships. But the best ship of all is friendship.");
		quotes.add("Friendship doubles your joys, and divides your sorrows.");
		int i = (int) Math.floor(Math.random() * (quotes.size()));
		String quote = quotes.get(i);
		
		return quote;
	}
}
