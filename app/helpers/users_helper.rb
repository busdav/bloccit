module UsersHelper

    def show_user_posts(user)
        if user.posts.any?
            "<h2>Posts</h2>".html_safe
            # render @user.posts  
        else
            '<div class="media-body">'.html_safe
                "<%= @user.name %> has not submitted any posts yet.".html_safe
            "</div>".html_safe
        end
    end

    def show_user_comments(user)
        if user.comments.any?
            "<h2>Comments</h2>".html_safe
            render @user.comments  
        else
            '<div class="media-body">'.html_safe
                "<%= @user.name %> has not submitted any comments yet.".html_safe
            "</div>".html_safe
        end
    end
    
    def show_user_favorited_posts(user)
        if user.favorite_posts.any?
            "<h2>Favorited Posts</h2>".html_safe
            render @user.favorite_posts  
        else
            '<div class="media-body">'.html_safe
                "<%= @user.name %> has not favorited any posts yet.".html_safe
            "</div>".html_safe
        end
    end    
end



