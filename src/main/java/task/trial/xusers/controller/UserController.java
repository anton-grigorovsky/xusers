package task.trial.xusers.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import task.trial.xusers.model.User;
import task.trial.xusers.service.SecurityService;
import task.trial.xusers.service.UserService;
import task.trial.xusers.validator.UserValidator;

import java.util.Date;


/**
 * Created by Антон on 04.08.2017.
 */
@Controller
public class UserController {
    private Date createDate;
    //private int isAdmin;
    private String password;

    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private UserValidator userValidator;

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String registration(Model model) {
        model.addAttribute("userForm", new User());

        return "registration";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String registration(@ModelAttribute("userForm") User userForm, BindingResult bindingResult, Model model) {
        userValidator.validate(userForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "registration";
        }

        userService.save(userForm);

        securityService.autoLogin(userForm.getUsername(), userForm.getConfirmPassword());

        return "redirect:/welcome";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(Model model, String error, String logout) {
        if (error != null) {
            model.addAttribute("error", "Username or password is incorrect.");
        }

        if (logout != null) {
            model.addAttribute("message", "Logged out successfully.");
        }

        return "login";
    }

    @RequestMapping(value = {"/", "/welcome"}, method = RequestMethod.GET)
    public String welcome(Model model, @RequestParam(required = false) String name) {
        model.addAttribute("user", new User());
        model.addAttribute("listUsers", this.userService.listUsers(name));
        return "welcome";
    }

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String admin(Model model, @RequestParam(required = false) String name) {
        model.addAttribute("user", new User());
        model.addAttribute("listUsers", this.userService.listUsers(name));
        return "admin";
    }

    @RequestMapping("/welcome")
    public String search(@RequestParam("name") String name, Model model) {
        model.addAttribute("user", new User());
        model.addAttribute("listUsers", this.userService.listUsers(name));
        return "welcome";
    }

    @RequestMapping(value = "/users/add", method = RequestMethod.POST)
    public String addUser(@ModelAttribute("user") User user){
        if(user.getId() == 0l){
            this.userService.save(user);
        }else {
            user.setCreateDate(createDate);
            //user.setIsAdmin(isAdmin);
            user.setPassword(password);
            this.userService.updateUser(user);
        }

        return "redirect:/welcome";
    }

    @RequestMapping("/remove/{id}")
    public String removeUser(@PathVariable("id") int id){
        this.userService.removeUser(id);

        return "redirect:/welcome";
    }

    @RequestMapping("edit/{id}")
    public String editUser(@PathVariable("id") int id, Model model){
        User user = this.userService.getUserById(id);
        //this.isAdmin = user.getIsAdmin();
        this.password = user.getPassword();
        this.createDate = user.getCreateDate();
        model.addAttribute("user", user);
        //model.addAttribute("listUsers", this.userService.listUsers());

        return "/welcome";
    }



}