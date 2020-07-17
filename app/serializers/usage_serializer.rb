class UsageSerializer < ActiveModel::Serializer
  attributes :id, :ip_used, :fqdn, :description, :state
end
