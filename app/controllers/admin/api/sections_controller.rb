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
          labels: [
            _('Locked'),
            _('Activated'),
            _('Down'),
            _('Free IP'),
            _('DHCP')
          ],
          datasets: [
            {
              label: _('Locked'),
              backgroundColor: %w[#3B82F6 #10B981 #EF4444 #6B7280 #8B5CF6],
              data: [
                section.usages.locked.count,
                section.usages.actived.count,
                section.usages.down.count,
                NetAM::Network::Range.new(section.network).free_ips - section.usages.where(state: 0..3).count,
                section.usages.dhcp.count
              ]
            }
          ]
        }
      end
    end
  end
end
