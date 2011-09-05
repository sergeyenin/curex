namespace :db do
  desc 'Delete data older than 3 days.'
  task :truncate_data => :environment do
    THREE_DAYS_AGO = Time.now - 60*60*24*3

    Listing.where("created_at < '#{THREE_DAYS_AGO}'").each do |listing|
      listing.destroy
    end

    User.where("created_at < '#{THREE_DAYS_AGO}'").each do |user|
      user.destroy
    end

  end
end