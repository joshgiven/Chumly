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


@Controller
@SessionAttributes(names={"sessionUser"})
public class UserController {
	
	@Autowired
	UserDAO UDAO;
	
	@Autowired
	MessageDAO MDAO;
	
	@Autowired
	InterestDAO IDAO;

	@Autowired
	LocationDAO LDAO;
	
//	how to get session scope user
//	User sessionUser = (User)model.asMap().get("sessionUser");
	
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
		
		if(errors.getErrorCount()>0){
			return "index";
		}
				
		User u = UDAO.getUserByUsername(user.getUsername());	
		
		if( u != null && 
			u.getUsername().equals(user.getUsername()) && 
			u.getPassword().equals(user.getPassword())) {
			
			model.addAttribute("sessionUser", u);
			return "profile";
		}
		else{
			return "index";	
		}
	}
	
	@RequestMapping (method=RequestMethod.POST, path="getUpdateProfile.do")
	public String getUpdateProfile(Model model){
		return "updateProfile";
	}
	
	@RequestMapping (method=RequestMethod.GET, path="getUsersByInterest.do")
	public String searchByInterest(String interestName, Model model){
		
		List<User> users = UDAO.indexByInterest(interestName);
		
		model.addAttribute("users", users);
		
		return "results";
	}
	
	@RequestMapping (method=RequestMethod.GET, path="getOtherUserProfileInformation.do")
	public String getUpdateProfile(Integer id, Model model){
		User user = UDAO.show(id);
		model.addAttribute("user", user);
		return "otherUser";
	}
	
	@RequestMapping (method=RequestMethod.GET, path="userMessage.do")
	public String getUserMessage(Integer id, Model model){
		User recipient = UDAO.show(id);
		User sessionUser = (User)model.asMap().get("sessionUser");
		
		List<Message> messages = null;
		messages = MDAO.indexByConversation(recipient, sessionUser);
		
		model.addAttribute("sender", sessionUser);
		model.addAttribute("recipient", recipient);
		model.addAttribute("messages",messages);
		
		return "message";
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
