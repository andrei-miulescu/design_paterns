
module Searches
  class SearchContextBuilder
      SEARCH_PARAMS = [
        :checkIn,
        :checkOut,
        :adults,
        :children,
        :infants
      ]
      attr_reader :context
      def initialize(options = {})
        @context = options.dup
      end
      def with_saved_search cookies
        saved_search? ? populate_search!(cookies) : refresh_search!(cookies)
        self
      end
      def with_location cookies
        if cookies[:location].present?
          context[:location] = cookies[:location]
        end
        self
      end
      private
      def saved_search?
        context['fresh_search'].nil?
      end
      def refresh_search! cookies
        SEARCH_PARAMS.each do |key|
          cookies.delete key
        end
      end
      def populate_search! cookies
        SEARCH_PARAMS.each do |key|
          if context[key].blank? && cookies[key].present?
            context[key] = cookies[key]
          end
        end
      end
      attr_reader :options
  end
end
