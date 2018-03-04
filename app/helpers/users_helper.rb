module UsersHelper
    def posts_for_user?(user)
        user.posts.any? 
    end
    
    def comments_for_user?(user)
        user.comments.any? 
    end
    
    def favorite_posts_for_user?(user)
        user.favorite_posts.any? 
    end    
end
