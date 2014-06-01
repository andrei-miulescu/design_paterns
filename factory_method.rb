module Qff
  class StrategyFactory
    def self.get_strategy strategy_code, base_points_value = 0
      case strategy_code.to_s
        when 'points_per_dollar'
          Qff::Strategies::PointsPerDollar.new(base_points_value)
        when 'points_per_booking'
          Qff::Strategies::PointsPerBooking.new(base_points_value)
        when 'noop'
          Qff::Strategies::NoOp.new
        else
          raise(ArgumentError, "No QFF strategy for code #{strategy_code}")
      end
    end
    def self.all_strategies
      [ Qff::Strategies::NoOp, Qff::Strategies::PointsPerDollar, Qff::Strategies::PointsPerBooking ]
    end
  end
end
