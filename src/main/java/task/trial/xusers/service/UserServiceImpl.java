package task.trial.xusers.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import task.trial.xusers.dao.RoleDao;
import task.trial.xusers.dao.UserDao;
import task.trial.xusers.model.Role;
import task.trial.xusers.model.User;

import java.util.*;

/**
 * Created by Антон on 04.08.2017.
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private RoleDao roleDao;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;


    @Override
    public void save(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        Set<Role> roles = new HashSet<>();
        roles.add(roleDao.getOne(1L));
        user.setCreateDate(new Date());
        user.setRoles(roles);

        userDao.save(user);
    }

    @Override
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    @Transactional
    public List<User> listUsers(String name) {

        List<User> listUsers = this.userDao.findAll();
        List<User> list = new ArrayList<>();
        if(name==null||name.trim().equals(""))
            return listUsers;
        else {

            listUsers.stream().filter(user -> user.getFirstName().toLowerCase().contains(name.toLowerCase())||
            user.getLastName().toLowerCase().contains((name.toLowerCase()))).forEach(list::add);


            return list;
        }
    }

    @Override
    public User getUserById(long id) {
        User user = this.userDao.findOne(id);
        //if(user.getRoles().size()>1) user.setIsAdmin(1);

        return user;
    }


    @Override
    public void updateUser(User user) {

        Set<Role> roles = new HashSet<>();
        roles.add(roleDao.getOne(1L));
        if(user.getIsAdmin()==1) roles.add(roleDao.getOne(2L));
        user.setRoles(roles);
        this.userDao.save(user);
    }

    @Override
    public void removeUser(long id) {
        this.userDao.delete(id);
    }
}