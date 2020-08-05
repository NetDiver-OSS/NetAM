# frozen_string_literal: true

class UsageSerializer < ActiveModel::Serializer
  attributes :id, :ip_used, :fqdn, :description, :state
end
