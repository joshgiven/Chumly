package controllers;

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
import entities.Message;
import entities.User;
import entities.User.Role;



@Controller
@SessionAttributes(names={"sessionUser"})
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

	
	//@ModelAttribute(name="sessionUser")
	@ModelAttribute(name="command")
	public User sessionUserFactory() {
		return new User();
	}

	@RequestMapping(path="home.do", method=RequestMethod.GET)
	public String welcome() {
		return "index";
	}
	
	@RequestMapping (method=RequestMethod.POST, path="login.do")
	public String login(@Valid User user, Errors errors, Model model){
		if(errors.hasErrors()) {
			return "index";
		}
		
		User u = udao.getUserByUsername(user.getUsername());
		
//		System.out.println("User: " + user  + " pw: "+ user.getPassword());
//		System.out.println("U from DB: " + u  + " pw: "+ u.getPassword());
		
		if (u != null){
			if(u.getPassword().equals(user.getPassword())){
				model.addAttribute("sessionUser", u);
				return "profile";
			}
			else{
				return "index";
			}
		}
		else{
			return "index";
		}

//		if (u.getUsername() == user.getUsername() && u.getPassword() == user.getPassword() && u.getRole() == Role.ADMIN) {
//			model.addAttribute("sessionUser", u);
//			
//			//need to insert admin page
//			return "profile";
//		} 
//		else if(u.getUsername() == user.getUsername() && u.getPassword() == user.getPassword()) {
//			model.addAttribute("sessionUser", u);
//			return "profile";
//		}
//		else {
//			return "index";
//		}
	}

	@RequestMapping(method = RequestMethod.POST, path = "getUpdateProfile.do")
	public String getUpdateProfile(Model model) {
		return "updateProfile";
	}

	@RequestMapping(method = RequestMethod.GET, path = "getUsersByInterest.do")
	public String searchByInterest(String interestName, Model model) {

		List<User> users = udao.indexByInterest(interestName);
		System.out.println(users);

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
		return "otherUser";
	}

	@RequestMapping(method = RequestMethod.GET, path = "userMessage.do")
	public String getUserMessage(Integer id, Model model) {
		User recipient = udao.show(id);
		User sessionUser = (User) model.asMap().get("sessionUser");

		List<Message> messages = null;
		messages = mdao.indexByConversation(recipient, sessionUser);

		model.addAttribute("sender", sessionUser);
		model.addAttribute("recipient", recipient);
		model.addAttribute("messages", messages);

		return "message";
	}

}
