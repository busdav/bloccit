require 'random_data'

# Create Posts
50.times do
# #1
  Post.create!(
# #2
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
  )
end
posts = Post.all

# Create Comments
# #3
100.times do
  Comment.create!(
# #4
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

puts "#{Post.count}"
Post.find_or_create_by!(title: "David's Post", body: "This is written by me")
puts "#{Post.count}"

puts "#{Comment.count}"
post = Post.find_or_create_by!(title: "David's Post", body: "This is written by me")
Comment.find_or_create_by!(post: post, body: "This comment is written by me")
puts "#{Comment.count}"

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
