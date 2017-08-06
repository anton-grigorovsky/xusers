package task.trial.xusers.service;

/**
 * Created by Антон on 04.08.2017.
 */
public interface SecurityService {

    String findLoggedInUsername();

    void autoLogin(String username, String password);
}