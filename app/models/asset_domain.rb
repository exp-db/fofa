class AssetDomain < ActiveRecord::Base
  self.table_name="asset_domains"
  belongs_to :target

  acts_as_taggable

  filterrific(
      default_filter_params: { :sorted_by => 'desc:updated_at'},
      available_filters: [
          :q,
          :sorted_by,
      ]
  )

  scope :q, lambda { |query|
            query = query.to_s
            return nil if query.blank?
            query = query.downcase
            where("domain LIKE ? ", "%#{query}%")
          }

  scope :sorted_by, lambda { |sort_option|
                    direction,field=sort_option.split(':')
                    direction = (direction =~ /desc$/) ? 'desc' : 'asc'
                    order("#{field}"=> direction)
                  }
end
