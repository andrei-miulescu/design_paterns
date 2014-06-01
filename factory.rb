module BookingInventory
  module Common
    module Factories
      class CancellationLineItemFactory
        def make(change_request, reversible_line_items, booking)
          line_items = []
          if change_request.new_nights.empty?
            cancellation = ::BookingInventory::Local::BookingCancellationService.new(reversible_line_items, booking)
            line_items   += cancellation.perform
          end
          line_items
        end
      end
    end
  end
end
