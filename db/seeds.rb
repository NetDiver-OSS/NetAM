if Rails.env.test?
  emails = %w[sebastien@sdeu.fr vincent@fricouv.eu rigonkmalk@gmail.com]

  emails.each do |email|
    r = Random.urandom(128)
    User.create!({ email: email, password: r, password_confirmation: r })
  end
end
