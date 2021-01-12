# frozen_string_literal: true

class RackOccupationValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add(:rack_anchor, :length, message: _('is higher than Rackspace unit')) if record.rack_anchor > record.cabinet.unit_height - record.device.rack_height
  end
end
