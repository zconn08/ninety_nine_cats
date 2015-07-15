class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, presence: true,
            inclusion: { in: ['PENDING', 'APPROVED', 'DENIED'] }
  validate :no_conflicting_approvals
  after_initialize do
    self.status ||= 'PENDING'
  end

  belongs_to :cat

  def no_conflicting_approvals
    unless overlapping_approved_requests.empty?
      all_conflicts = overlapping_approved_requests.map do |request|
        "ID: #{request.id}, Start: #{request.start_date}, End: #{request.end_date}"
      end.join("\n")

      errors[:base] << "Conflicting Approval Requests: #{all_conflicts}"
    end
  end

  def overlapping_requests
    all_reqs = CatRentalRequest.where("? IS NULL OR id != ?", id, id)
    all_reqs.select { |other| self.overlaps?(other) }
    # TODO write in SQL
  end

  def overlaps?(other)
    (self.start_date - other.end_date) * (other.start_date - self.end_date) >= 0 &&
    self.cat_id == other.cat_id
  end

  def overlapping_approved_requests
    overlapping_requests.select { |request| request.status == 'APPROVED' }
  end
end
