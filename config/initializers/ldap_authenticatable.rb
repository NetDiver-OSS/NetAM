require 'net/ldap'
require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class LdapAuthenticatable < Authenticatable
      def authenticate!
        if params[:admin]
          ldap = Net::LDAP.new
          ldap.host = '172.16.0.100'
          ldap.port = 389
          ldap.auth login, password

          if ldap.bind
            ldap_email = ldap.search(
                :base => 'ou=people,dc=svk,dc=gs',
                :filter => Net::LDAP::Filter.eq('uid', params[:admin][:uid])
            ).first[:mail].first.to_s

            admin = Admin.find_or_create_by(email: ldap_email)
            success!(admin)
          else
            return fail(:invalid_login)
          end
        end
      end

      def login
        "uid=#{params[:admin][:uid]},ou=people,dc=svk,dc=gs"
      end

      def password
        params[:admin][:password]
      end

    end
  end
end

Warden::Strategies.add(:ldap_authenticatable, Devise::Strategies::LdapAuthenticatable)
