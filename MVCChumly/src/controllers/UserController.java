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

import data.InterestDAO;
import data.LocationDAO;
import data.MessageDAO;
import data.UserDAO;
import entities.Interest;
import entities.Message;
import entities.Profile;
import entities.User;

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

	// how to get session scope user
	// User sessionUser = (User)model.asMap().get("sessionUser");

	@ModelAttribute(name = "sessionUser")
	public User sessionUserFactory() {
		return new User();
	}

	@ModelAttribute(name = "user")
	public User defaultUserFactory() {
		return new User();
	}

	@RequestMapping(path = "home.do", method = RequestMethod.GET)
	public String welcome() {
		return "index";
	}

	@RequestMapping(method = RequestMethod.POST, path = "login.do")
	public String login(@Valid User user, Errors errors, Model model) {
		if (errors.hasErrors()) {
			return "index";
		}

		User u = udao.getUserByUsername(user.getUsername());

		// System.out.println("User: " + user + " pw: "+ user.getPassword());
		// System.out.println("U from DB: " + u + " pw: "+ u.getPassword());

		if (u != null) {
			if (u.getPassword().equals(user.getPassword())) {
				model.addAttribute("sessionUser", u);
				return "profile";
			} else {
				return "index";
			}
		} else {
			return "index";
		}

		// if (u.getUsername() == user.getUsername() && u.getPassword() ==
		// user.getPassword() && u.getRole() == Role.ADMIN) {
		// model.addAttribute("sessionUser", u);
		//
		// //need to insert admin page
		// return "profile";
		// }
		// else if(u.getUsername() == user.getUsername() && u.getPassword() ==
		// user.getPassword()) {
		// model.addAttribute("sessionUser", u);
		// return "profile";
		// }
		// else {
		// return "index";
		// }
	}

	@RequestMapping(method = RequestMethod.GET, path = "getUpdateProfile.do")
	public String getUpdateProfile(Model model) {
		List<Interest> interests = idao.index();
		model.addAttribute("interests", interests);
		// User sessionUser = (User)model.asMap().get("sessionUser");
		// model.addAttribute("user", sessionUser);
		return "updateprofile";
	}

	@RequestMapping(method = RequestMethod.GET, path = "getUsersByInterest.do")
	public String searchByInterest(String interest, Model model) {

		List<User> users = udao.indexByInterest(interest);

		model.addAttribute("users", users);

		return "results";
	}

	@RequestMapping(method = RequestMethod.POST, path = "deleteProfile.do")
	public String deleteProfile(Model model) {
		User sessionUser = (User) model.asMap().get("sessionUser");
		udao.destroy(sessionUser.getId());
		return "index";
	}

	@RequestMapping(method = RequestMethod.GET, path = "getOtherUserProfileInformation.do")
	public String getUpdateProfile(Integer id, Model model) {

		User user = udao.show(id);
		model.addAttribute("user", user);
		return "otheruser";
	}

	@RequestMapping(method = RequestMethod.GET, path = "messageUser.do")
	public String getUserMessage(Integer id, Model model) {

		User recipient = udao.show(id);

		User sessionUser = (User) model.asMap().get("sessionUser");

		List<Message> messages = null;
		messages = mdao.indexByConversation(recipient, sessionUser);
		System.out.println(messages.size());

		model.addAttribute("sender", sessionUser);
		model.addAttribute("recipient", recipient);
		model.addAttribute("messages", messages);

		return "message";
	}

	@RequestMapping(method = RequestMethod.POST, path = "updateProfileDescription.do")
	public String updateProfileDescription(String description, Integer id, Model model) {
		User sessionUser = udao.updateUserProfileDescription(description, id);
		model.addAttribute("sessionUser", sessionUser);

		return "profile";
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

		List<Message> messages = mdao.indexByConversation(recipient, sessionUser);

		model.addAttribute("sender", sessionUser);
		model.addAttribute("recipient", recipient);
		model.addAttribute("messages", messages);

		return "message";
	}

	// NEED TO WRITE
	@RequestMapping(method = RequestMethod.POST, path = "updateInterest.do")
	public String addInterest(String interest, Model model) {
		User sessionUser = (User) model.asMap().get("sessionUser");

		return "profile";
	}

	@RequestMapping(method = RequestMethod.GET, path = "connectToUser.do")
	public String addInterest(Integer userId, Integer sessionId, Model model) {
		// User sessionUser = (User) model.asMap().get("sessionUser");
		User sessionUser = udao.show(sessionId);

		System.out.println(sessionUser.getId());
		User friend = udao.show(userId);
		List<User> connections = null;
		System.out.println(sessionUser.getConnections().size());

		if (sessionUser.getConnections().isEmpty()) {
			connections = new ArrayList<>();
			sessionUser.setConnections(connections);
		}

		sessionUser.getConnections().add(friend);
		friend.getConnections().add(sessionUser);
		udao.updateConnection(sessionId, sessionUser);
		udao.updateConnection(userId, friend);
		System.out.println(sessionUser.getConnections().size());

		model.addAttribute("user", friend);

		return "otheruser";
	}

	@RequestMapping(method = RequestMethod.GET, path = "createUser.do")
	public String createUser(Model model) {

		model.addAttribute("location", ldao.mapByState());
		model.addAttribute("", idao.mapByCategory());

		return "newuser";
	}
	@RequestMapping(method = RequestMethod.POST, path = "makeUser.do")
	public String makeUser(User user, Profile profile, Model model) {
		
		User sessionUser = udao.create(user);				
		sessionUser.setProfile(profile);		
		sessionUser= udao.updateUserProfile(sessionUser.getId(), sessionUser);
				
		model.addAttribute("sessionUser", sessionUser);
		
		return "profile";
	}

}
