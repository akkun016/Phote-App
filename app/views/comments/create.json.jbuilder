json.content  @comment.content
json.user_id  @comment.user.id
json.user_name  @comment.user.username
json.time  time_ago_in_words(@comment.created_at)
json.post_id  @comment.post.id
json.id  @comment.id
json.image  @comment.user.image.url
json.images  @comment.user.image?