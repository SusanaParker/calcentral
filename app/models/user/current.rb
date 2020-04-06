module User
  class Current
    attr_reader :uid

    include User::Academics::AcademicsConcern
    include User::BCourses::Concern
    include User::Notifications::Concern
    include User::Tasks::Concern
    include User::Webcasts::Concern

    def initialize(uid)
      @uid = uid
    end

    def self.from_campus_solutions_id(campus_solutions_id)
      uid = User::Identifiers.lookup_ldap_uid(campus_solutions_id)
      new(uid)
    end

    def campus_solutions_id
      @campus_solutions_id ||= User::Identifiers.lookup_campus_solutions_id(uid)
    end

    def billing_items
      @billing_items ||= User::Finances::BillingItems.new(self)
    end

    def billing_summary
      @billing_summary ||= User::Finances::BillingSummary.new(self)
    end

    def user_attributes
      @user_attributes ||= User::UserAttributes.new(self)
    end

    def matriculated?
      !affiliations.matriculated_but_excluded? && affiliations.not_registered?
    end

    private

    def affiliations
      @affiliations ||= User::Affiliations.new(self)
    end
  end
end
