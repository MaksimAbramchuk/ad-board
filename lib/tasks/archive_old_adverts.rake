namespace :db do
  task :archive => :environment do
    Advert.archive_old_adverts
    p "Succesfull"
  end
end
