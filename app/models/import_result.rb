class ImportResult < ActiveRecord::Base
  belongs_to :import
  enum status: [ :starting, :running, :finishing, :finished, :stalled, :aborted ]
  serialize :found_listing_keys
  serialize :removed_listing_keys
  serialize :snapshots
  
  def found_count_difference
    previous_run = self.import.import_results.where(['start_time < ?', self.start_time]).order("start_time DESC").limit(1).first
    previous_run.present? ? self.found_listing_keys.count - previous_run.found_listing_keys.count : nil
  end
end
