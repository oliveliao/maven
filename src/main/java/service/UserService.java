package service;

import org.springframework.stereotype.Service;
import pojo.bo.UserBo;
import pojo.bo.user.LoginBo;
import pojo.vo.UserVo;
import java.util.List;


public interface UserService {
    //用户登录
    public UserVo login(LoginBo loginBo) throws Exception;
    //查询列表
    public List<UserVo> findList(UserBo userBo) throws Exception;
    //查询实体
    public UserVo get(int id) throws Exception;
    //更新实体
    public void update(int id,UserBo userBo) throws Exception;
}
