# frozen_string_literal: true

module Admin
  module API
    class SectionsController < ApplicationController
      # /usages
      def usages
        render json: last_viewers(Section.find(params[:id]))
      end

      # /status
      def status
        render json: NetAM::ScannerLauncher.status(params[:jid])
      end

      private

      def last_viewers(section)
        {
          data: [
            {
              name: _('Locked'),
              value: section.usages.locked.count,
              itemStyle: { color: '#3B82F6' }
            },
            {
              name: _('Activated'),
              value: section.usages.actived.count,
              itemStyle: { color: '#10B981' }
            },
            {
              name: _('Down'),
              value: section.usages.down.count,
              itemStyle: { color: '#EF4444' }
            },
            {
              name: _('Free IP'),
              value: NetAM::Network::Range.new(section.network).free_ips - section.usages.where(state: 0..3).count,
              itemStyle: { color: '#6B7280' }
            },
            {
              name: _('DHCP'),
              value: section.usages.dhcp.count,
              itemStyle: { color: '#8B5CF6' }
            }
          ]
        }
      end
    end
  end
end
