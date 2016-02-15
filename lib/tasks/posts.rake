namespace :posts do
  desc 'Import posts from YAML'
  task import: :environment do
    File.open("#{Rails.root}/tmp/posts/list.yml", 'r') do |file|
      YAML.load(file).each do |image_name, data|
        puts image_name
        post = Post.new

        post.created_at = data['created_at']
        post.title      = data['title']
        post.lead       = data['lead']
        post.body       = data['body']
        post.image      = Pathname.new("#{Rails.root}/tmp/posts/images/#{image_name}").open
        post.save!
      end
    end
  end
end
