require 'io/console'

namespace :netam do
  namespace :manage do
    desc 'Manage administrator of NetAM instance'
    task :admins do
      unless User.where(admin: true).empty?
        warn "You already have administrator !"
        exit 1
      end

      puts '== Administrator Creator =='

      print "Email: "
      email = STDIN.gets.chomp
      print "Password: "
      password = STDIN.noecho(&:gets).chomp

      @user = User.new(
        {
          email: email,
          password: password,
          password_confirmation: password,
          admin: true
        }
      )
      if @user.save
        puts "Creation successful"
      else
        warn "Creation failed !"
        exit 1
      end

      puts '== Administrator Creator =='
    end
  end
end
