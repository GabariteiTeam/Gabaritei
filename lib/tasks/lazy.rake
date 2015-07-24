namespace :db do

  task :lazy do
  	Rake::Task["db:drop"].invoke
  	Rake::Task["db:create"].invoke
  	Rake::Task["db:migrate"].invoke
  	Rake::Task["db:seed"].invoke
  end

end
