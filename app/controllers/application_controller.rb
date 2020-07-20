class ApplicationController < ActionController::Base
  before_action :admin_exist
  before_action :authenticate_user!, except:[:install]
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def install
    render :install
  end

  private

  def admin_exist
    if User.where(admin: true).empty?
      setup
    end
#
#    puts '== Administrator Creator =='
#
#    print 'Email: '
#    email = STDIN.gets.chomp
#    print 'Password: '
#    password = STDIN.noecho(&:gets).chomp
#
#    @user = User.new(
#        {
#            email: email,
#            password: password,
#            password_confirmation: password,
#            admin: true
#        }
#    )
#    if @user.save
#      puts 'Creation successful'
#    else
#      warn 'Creation failed !'
#      exit 1
#    end

    puts '== Administrator Creator =='
  end
end
