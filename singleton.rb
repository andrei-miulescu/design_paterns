class QffTiersRepository
  include Singleton
 
  def qff_tiers
    {tiers: frequent_flyer_tiers}
  end
  def frequent_flyer_tiers
    QantasFrequentFlyer::Tiers::CURRENT.tiers.map do |tier|
      if tier.respond_to? :range
        {min: tier.range.min, max: tier.range.max, value: tier.value}
      else
        {min: tier.start, max: nil, value: tier.value}
      end
    end
  end
end
