module PostsHelper
  def user_is_post_user_or_admin?(post)
       current_user && (current_user == post.user || current_user.admin?)
  end

  def user_is_moderator?
       current_user && current_user.moderator?
  end
end
