def set_current_user
  session[:user_id] = Fabricate(:user).id
end

def set_admin_user
  session[:user_id] = Fabricate(:admin).id
end

