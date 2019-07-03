module CampusSolutions
  class MyFinancialAidFundingSources < UserSpecificModel

    include ClassLogger
    include Cache::CachedFeed
    include Cache::UserCacheExpiry
    include Cache::JsonAddedCacher
    include Cache::RelatedCacheKeyTracker
    include CampusSolutions::FinaidFeatureFlagged

    attr_accessor :aid_year

    def get_feed_internal
      if is_feature_enabled && (self.aid_year ||= FinancialAid::MyAidYears.new(@uid).default_aid_year)
        logger.debug "User #{@uid}; aid year #{aid_year}"
        funding_sources = CampusSolutions::FinancialAidFundingSources.new(user_id: @uid, aid_year: aid_year).get
        message = CampusSolutions::MessageCatalog.get_message(:financial_awards_coa)
        {
          awards: funding_sources.try(:[], :feed).try(:[], :awards),
          message: message.try(:[], :descrlong),
          errored: funding_sources.try(:[], :errored)
        }
      else
        {}
      end
    end

    def instance_key
      "#{@uid}-#{aid_year}"
    end

  end
end
