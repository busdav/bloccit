module UsersHelper
    def posts_or_comments_for_user?(user)
        user.posts.any? || user.comments.any?
    end
end
