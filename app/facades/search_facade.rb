class SearchFacade
  attr_reader :search_params

  def initialize(search_params)
    @search = Search.new(search_params)
  end

  def base_properties
    @base_properties ||= Story.where(prepare_filters)
  end

  def property_ids
    @property_ids ||= base_properties.pluck(:id)
  end

  def filtered_space_ids
    @filtered_space_ids ||= Space.where(property_id: @filtered_property_ids).pluck(:id)
  end

  def filtered_property_ids
    @filtered_property_ids = property_ids
    apply_space_filters!
    apply_property_tags!
    @filtered_property_ids
  end

  def apply_property_tags!
    if @search.property_tag_ids.any?
      # raise    @search.property_tag_ids.inspect
      @filtered_property_ids = Tagging.for_properties.where(taggable_id: @filtered_property_ids,
                                                            tag_id:      @search.property_tag_ids
      ).inject({}) { |hash, tagging|
        hash[tagging.taggable_id] ||= []; hash[tagging.taggable_id] << tagging.tag_id;hash
      }.select { |k, v| v.size >=  @search.property_tag_ids.size}.keys.uniq
    end
  end

  def apply_space_filters!
    # this order is important
    apply_space_tags!
    apply_space_category!
  end

  def apply_space_tags!
    if @search.space_tag_ids.any?
      @filtered_space_ids = Tagging.for_spaces.where(taggable_id: filtered_space_ids,
                                                     tag_id:      @search.space_tag_ids
      ).inject({}) { |hash, tagging|
        hash[tagging.taggable_id] ||= []; hash[tagging.taggable_id] << tagging.tag_id;hash
      }.select { |k, v| v.size >=  @search.space_tag_ids.size}.keys.uniq
    end
  end

  def apply_space_category!
    if @search.space_category_id.present?
      conditions = { category_id: @search.space_category_id }
      conditions.merge!(id: @filtered_space_ids) if @filtered_space_ids
      @filtered_property_ids = Space.where(conditions).pluck(:property_id).uniq
    elsif @filtered_space_ids
      @filtered_property_ids = Space.where(id: @filtered_space_ids).pluck(:property_id).uniq
    end

  end

  def filtered_properties
    base_properties.where(id: filtered_property_ids).includes(:translations, :images, category: :translations, city: [:translations, country: :translations])
  end

  def properties
    filtered_properties.paginate(:page => @search.page, per_page: 10)
  end

  def prepare_filters
    filter = {}
    filter.merge!(city_id: @search.city_id) if @search.city_id.present?
    filter.merge!(category_id: @search.category_id) if @search.category_id.present?
    filter
  end

  def city
    @city ||= City.find(@search.city_id) if @search.city_id
  end

  def center_latitude
    city.try(:latitude) || properties.first.try(:latitude)
  end

  def center_longitude
    city.try(:longitude) || properties.first.try(:longitude)
  end
end
