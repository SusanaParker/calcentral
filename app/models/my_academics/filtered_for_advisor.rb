module MyAcademics
  class FilteredForAdvisor < UserSpecificModel
    include Cache::CachedFeed
    include Cache::JsonifiedFeed
    include Cache::UserCacheExpiry
    include MergedModel

    # Advisors do not see Course Website (aka CanvasSites) data.
    def self.providers
      [
        CollegeAndLevel,
        GpaUnits,
        Semesters,
        Exams,
        AcademicPlan,
        AdvisorLinks,
        StudentLinks,
        Graduation,
        Teaching
      ]
    end

    def get_feed_internal
      feed = {}
      handling_provider_exceptions(feed, self.class.providers) do |provider|
        provider.new(@uid).merge feed
      end
      feed
    end

  end
end
